# abtc_contracts
Contracts of ABTC.

## POW

About POW algorithm, we use `keccak256` as our hash algorithm, it is the standard sha3 on Ethereum. There are no miner machines that support `keccak256`, so it is equal to everyone who only has a PC.

We use **Bitcoin**'s difficulty algorithm, which fit below:

```
target = lastTarget * actualTime / expectTime;
```

While expected time is 60 minutes, which means 6 blocks.

## Miner

Users could use [Desktop-Miner](https://github.com/Algorithmic-Bitcoin/abtc-miner-electron) to participate ABTC journey. Developers can write her/his own miner using ethereum-based API.

## Pool

We forked [ESD](https://www.emptyset.finance/)'s pool code, and change it more fairer and securer.

Here are some changes from ESD's original code:

|                         | ABTC's Pool                                          | ESD's Pool                                       |
| ----------------------- | ---------------------------------------------------- | ------------------------------------------------ |
| Epoch                   | Use POW's height, every 50 blocks is 1 epoch         | Bot to increase epoch every 8 hours              |
| POOL_EXIT_LOCKUP_EPOCHS | 4                                                    | 5                                                |
| emergencyWithdraw       | No, no one can withdraw your balance except yourself | Yes, DAO can withdraw pool's  balances to itself |

## Denotion

Please denote ABTC to us at `0x276Fd60790e458df29D972cc8D83783350Bc0cc0`, which will be used for the early community promotion.
