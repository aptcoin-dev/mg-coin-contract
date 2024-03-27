#!/bin/zsh
truffle-flattener contracts/AptCoin.sol > AptCoin.flatten.sol
truffle-flattener contracts/AptCoinMultiSigWallet.sol > AptCoinMultiSigWallet.flatten.sol
