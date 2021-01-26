# abtc_contracts
Contracts of ABTC.

## POW

About POW algorithm, we use `keccak256` as our hash algorithm, it is the standard sha3 on Ethereum. There are no miner machines that support `keccak256`, so it is equal to everyone who only has a PC.

We use **Bitcoin**'s difficulty algorithm, which fit below:

```
target = lastTarget * actualTime / expectTime;
```

While expected time is 30 minutes, which means 3 blocks.

## Miner

Developers can write her/his own miner using ethereum-based API.
