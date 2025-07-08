# 🧠 Minimal Proxy Clone Factory

This project demonstrates how to deploy and interact with **minimal proxy clones** (EIP-1167) in Solidity. Minimal proxies allow you to create lightweight instances of a logic contract with **shared code and independent storage**, significantly reducing gas costs compared to deploying full copies.

---

## ✨ What This Project Does

✅ Provides a `LogicContract` with simple state:

- `owner` — initialized once.
- `value` — a uint256 that can be updated by the owner.

✅ Provides a `CloneFactory` contract that:

- Deploys minimal proxy clones via OpenZeppelin’s `Clones` library.
- Automatically calls `initialize()` to set the owner.
- Keeps track of all deployed clones.

---

## 🧩 Contracts Overview

### LogicContract.sol
This is the **master implementation**. All clones delegate their calls to this logic.  

Functions:
- `initialize(address _owner)`: Sets the clone’s owner (only once).
- `setValue(uint256)`: Allows the owner to set the stored value.
- `getValue()`: Returns the current value.

---

### CloneFactory.sol
This factory contract creates minimal proxy clones pointing to `LogicContract`.  

Functions:
- `createClone()`: Deploys a new clone and initializes it with the caller as owner.
- `getCloneCount()`: Returns how many clones have been deployed.
- `clones(uint256)`: Returns the address of a clone by index.

---

## 🛠️ How To Deploy and Test

You can use Remix or Hardhat to test.  

1️⃣ **Deploy `LogicContract`**
- Compile and deploy `LogicContract.sol`.
- Copy the deployed address.

2️⃣ **Deploy `CloneFactory`**
- Compile and deploy `CloneFactory.sol`, passing the `LogicContract` address to the constructor.

3️⃣ **Create a Clone**
- In the factory contract, call `createClone()`.
- This will deploy a new minimal proxy and initialize it.

4️⃣ **Retrieve Clone Address**
- Call `clones(0)` to get the first clone’s address.

5️⃣ **Load the Clone**
- In Remix, click “At Address” with the clone’s address.
- Interact with the clone as if it were a full contract:
  - `getValue()` (should be 0).
  - `setValue(123)` (only works for the owner).
  - `getValue()` again (should now be 123).

---

## 🚀 Why Use Minimal Proxies?

Minimal proxies reduce gas by:
- Storing only a tiny piece of bytecode that forwards calls.
- Reusing the same logic contract for all clones.
- Keeping each clone’s storage separate.

They are widely used in upgradeable contracts and factory patterns (OpenZeppelin, Uniswap V3 pools, etc).

---

## 🧠 Learning Goal

This project helps you:
✅ Understand delegatecall-based proxies.
✅ Deploy lightweight clone contracts.
✅ Manage clone initialization safely.

---

## 📂 Files

- `LogicContract.sol` – Base logic contract.
- `CloneFactory.sol` – Factory that creates minimal proxy clones.

---

## 💡 Further Reading

- [EIP-1167: Minimal Proxy Contract](https://eips.ethereum.org/EIPS/eip-1167)
- [OpenZeppelin Clones](https://docs.openzeppelin.com/contracts/4.x/api/proxy#Clones)
