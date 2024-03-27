"use strict"

var AptCoin = artifacts.require("./AptCoin.sol");
const theBN = require("bn.js")

/**
 * AptCoin contract tests 2
 */
contract('AptCoin2', function(accounts) {
  const BIG = (v) => new theBN.BN(v)

  const owner = accounts[0];
  const admin = accounts[1];
  const vault = accounts[2];
  const minter = accounts[0];

  const user1 = accounts[4];
  const user2 = accounts[5];
  const user3 = accounts[6];
  const user4 = accounts[7];
  const user5 = accounts[8];

  let coin, OneAptCoinInMinunit, NoOfTokens, NoOfTokensInMinunit;

  const bnBalanceOf = async addr => await coin.balanceOf(addr);
  const bnReserveOf = async addr => await coin.reserveOf(addr);
  const bnAllowanceOf = async (owner, spender) => await coin.allowance(owner, spender);

  const balanceOf = async addr => (await coin.balanceOf(addr)).toString();
  const reserveOf = async addr => (await coin.reserveOf(addr)).toString();
  const allowanceOf = async (owner, spender) => (await coin.allowance(owner,spender)).toString();


  before(async () => {
    coin = await AptCoin.deployed();
    NoOfTokensInMinunit = await coin.totalSupply();
    OneAptCoinInMinunit = await coin.getOneAptCoin();
    NoOfTokens = NoOfTokensInMinunit.div(OneAptCoinInMinunit)
  });

  const clearUser = async user => {
    await coin.setReserve(user, 0, {from: admin});
    await coin.transfer(vault, await bnBalanceOf(user), {from: user});
  };

  beforeEach(async () => {
    await clearUser(user1);
    await clearUser(user2);
    await clearUser(user3);
    await clearUser(user4);
    await clearUser(user5);
  });

  it("reserve and then approve", async() => {
    assert.equal(await balanceOf(user4), "0");

    const OneAptTimesTwoInMinunit = OneAptCoinInMinunit.mul(BIG(2))
    const OneAptTimesTwoInMinunitStr = OneAptTimesTwoInMinunit.toString()

    const OneAptTimesOneInMinunit = OneAptCoinInMinunit.mul(BIG(1))
    const OneAptTimesOneInMinunitStr = OneAptTimesOneInMinunit.toString()

    // send 2 Apt to user4 and set 1 Apt reserve
    coin.transfer(user4, OneAptTimesTwoInMinunit, {from: vault});
    coin.setReserve(user4, OneAptCoinInMinunit, {from: admin});
    assert.equal(await balanceOf(user4), OneAptTimesTwoInMinunitStr);
    assert.equal(await reserveOf(user4), OneAptCoinInMinunit.toString());

    // approve 2 Apt to user5
    await coin.approve(user5, OneAptTimesTwoInMinunit, {from:user4});
    assert.equal(await allowanceOf(user4, user5), OneAptTimesTwoInMinunitStr);

    // transfer 2 Apt from user4 to user5 SHOULD NOT BE POSSIBLE
    try {
      await coin.transferFrom(user4, user5, OneAptTimesTwoInMinunit, {from: user5});
      assert.fail();
    } catch(exception) {
      assert.isTrue(exception.message.includes("revert"));
    }

    // transfer 1 Apt from user4 to user5 SHOULD BE POSSIBLE
    await coin.transferFrom(user4, user5, OneAptTimesOneInMinunit, {from: user5});
    assert.equal(await balanceOf(user4), OneAptTimesOneInMinunitStr);
    assert.equal(await reserveOf(user4), OneAptTimesOneInMinunitStr); // reserve will not change
    assert.equal(await allowanceOf(user4, user5), OneAptTimesOneInMinunitStr); // allowance will be reduced
    assert.equal(await balanceOf(user5), OneAptTimesOneInMinunitStr);
    assert.equal(await reserveOf(user5), "0");

    // transfer .5 Apt from user4 to user5 SHOULD NOT BE POSSIBLE if balance <= reserve
    const halfAptInMinunit = OneAptCoinInMinunit.div(BIG(2));
    try {
      await coin.transferFrom(user4, user5, halfAptInMinunit, {from: user5});
      assert.fail();
    } catch(exception) {
      assert.isTrue(exception.message.includes("revert"));
    }
  })

  it("only minter can call mint", async() => {
      const OneAptTimesTenInMinunit = OneAptCoinInMinunit.mul(BIG(10))
      const OneAptTimesTenInMinunitStr = OneAptTimesTenInMinunit.toString()

      assert.equal(await balanceOf(user4), "0");

      await coin.mint(user4, OneAptTimesTenInMinunit, {from: minter})

      const totalSupplyAfterMintStr = (await coin.totalSupply()).toString()
      assert.equal(totalSupplyAfterMintStr, OneAptTimesTenInMinunit.add(NoOfTokensInMinunit).toString())
      assert.equal(await balanceOf(user4), OneAptTimesTenInMinunitStr);

      try {
          await coin.mint(user4, OneAptTimesTenInMinunit, {from: user4})
          assert.fail();
      } catch(exception) {
          assert.equal(totalSupplyAfterMintStr, OneAptTimesTenInMinunit.add(NoOfTokensInMinunit).toString())
          assert.isTrue(exception.message.includes("revert"));
      }
  })

  it("cannot mint above the mint cap", async() => {
      const OneAptTimes100BilInMinunit = 
              OneAptCoinInMinunit.mul(BIG(100000000000))

      assert.equal(await balanceOf(user4), "0");


      try {
          await coin.mint(user4, OneAptTimes100BilInMinunit, {from: minter})
          assert.fail();
      } catch(exception) {
          assert.isTrue(exception.message.includes("revert"));
      }
  })
});
