# Exploring Cairo

## Discovering new languages, makes you rethink your beliefs, rethink your systems, opens you to new paradigms and keeps you sharp.

https://www.cairo-lang.org/ && https://github.com/starkware-libs/cairo

## Raison d'être  
Cairo is a programming language for writing provable programs.


## Notes

- Cairo is more than a programming language - it's an entire CPU architecture whose instruction set is known as CASM (Cairo assembly). Cairo programs compile to an intermediate representation called Sierra (Safe IntermediatE RepResentAtion), which in turn compiles to CASM.

- Cairo is a language for creating STARK-provable programs for general computation. Cairo powers Starknet and StarkEx, scaling applications on Mainnet, including dYdX, Sorare, ImmutableX, and more.

- Cairo is the native smart contract language for Starknet, a permissionless decentralized Validity-Rollup.

- written in Rust

- Turing-complete STARK-friendly CPU architecture.

- Tooling takes inspiration from Rust and Foundry

- Toolchain has a dedicated test runner

- It's more widely known as the smart contract language of Starknet than for its ZK (zero-knowledge) properties

- Cairo's package manager is Scarb

- They have additional tooling for build onchain games

- Cairo has 'disassembler' called Thoth, a disassembler is a computer program that translates machine language (also known as low-level or native code) into assembly language

- Starkli, a CLI to interact with Starknet

- A contract Verifier, that allows to verify Starknet classes on a block explorer

- Cairo has a first-party VS-code extension

- Cairo has a local testnet for development

- Cairo has tool named 'Katana', a Starknet sequencer designed to support both local development and production deployments

- Sierra

- CASM (Cairo Assembly)

- It has almost the same language features of Rust (Enums, error handling,variables, basic types, functions, comments, and control flow, etc.)

- Cairo allows to return values from loops, with the break `<value>` syntax. ( I love that)

- Testing: unit tests are right next to the source code, by convention. For integration tests, create a tests directory at the top level of our project directory, next to src. Scarb knows to look for integration test files in this directory.

### Types system notes

- felt types, or field elements. They're called so, because they belond to a finite field*.

- In Cairo, if you don't specify the type of a variable or argument, its type defaults to a field element, represented by the keyword felt252. In the context of Cairo, when we say “a field element” we mean an integer in the range `0 ≤ x < P` , where P is a very large prime number currently equal to 2251+17⋅2192+1. When adding, subtracting, or multiplying, if the result falls outside the specified range of the prime number, an overflow (or underflow) occurs, and an appropriate multiple of P is added or subtracted to bring the result back within the range (i.e., the result is computed modP ).

- The ArrayTrait

- `Option<Box<@T>>`, which means it returns an option to a Box type (Cairo's smart-pointer type) 

- while it's almost entirely like Rust, they do `array!` and not `vec!` . the macro will return an immutable array.

- Cairo spans, are conceptually equivalent to Go's slices.

- Cairo provides in its core library a dictionary-like type. The `Felt252Dict<T>` data type represents a collection of key-value pairs where each key is unique and associated with a corresponding value.

- Cairo has a `Destruct<T>` trait, that behaves like Rust's Drop trait. And is executed when a binding goes out of scope. It does not replace the Drop trait and it not tied to memory management. For example, it's used for the `Felt252Dict<T>` type run the dictionary squashing and check for illegal tampering

- `Nullable<T>` is a smart pointer type that can either point to a value or be null in the absence of value. The difference with Option is that the wrapped value is stored inside a `Box<T>` data type.

- The `Box<T>` type is a smart pointer that allows us to use a dedicated boxed_segment memory segment for our data, and access this segment using a pointer that can only be manipulated in one place at a time

- Structs must implement either the `Drop` or `Destruct` traits. It can't be both.

- Cairo has the concept of Snapshots, the `@` syntax. a snapshot is an immutable view of a value at a certain point in time. 

- `ByteArray` (const []u8) serves as String.

- Types can't be implemented. Only Traits can be implemented.

### Error handling notes

- Pattern matching over enums, Option and Result enum.
- The `?` operator

### Memory management notes

- Cairo uses an immutable memory model, meaning that once a memory cell is written to, it can't be overwritten but only read from. To reflect this immutable memory model, variables in Cairo are immutable by default. However, the language abstracts this model and gives you the option to make your variables mutable. 

### Build system notes

- Cairo plans to be able to compile to MILR. MLIR (Multi-Level Intermediate Representation) is a common IR that also supports hardware specific operations. It's related to LLVM.

## Claims

Cairo lets you write provable programs without requiring a deep understanding of the underlying ZK concepts. From onchain gaming to provable ML, Cairo makes building trustless applications possible.

Cairo is the first Turing-complete language for creating provable programs for general computation.


## Resources


*finite field: (short version) finite set of numbers that can do addition, subtraction, multiplication, and division without error.
When it comes to cryptography, their properties are wanted, as their division algebra always checks out. Always returns an integer (closure). Always absolute precision.

https://en.wikipedia.org/wiki/Finite_field  
These are properties needed for mission critical math. Results don't truncate, nor round, nor get imprecise.
All arithmetic operations can be done perfectly over finite fields.

- https://book.cairo-lang.org/title-page.html
- https://docs.starknet.io/
- https://www.cairo-lang.org/

## Instructions

Requirements: Docker or Rust toolchain >=1.80.0 + Cairo toolchain >= 2.8.4 with Sierra >= 1.6.0


#### With Docker

clone my repository

```shell
git clone git@github.com:Neal-C/exploring_cairo.git
cd exploring_cairo
```

build and run with Docker

```shell
docker build -t neal-c-cairo:latest .
```

```shell
docker run --name neal-c-cairo neal-c-cairo:latest
```


### With local install

Requirements: Rust toolchain >=1.80.0, Cairo toolchain >= 2.8.4 with Sierra >= 1.6.0

clone my repository

```shell
git clone git@github.com:Neal-C/exploring_cairo.git
cd exploring_cairo
```

build:  
```bash
scarb build
```

test:  
```bash
scarb test
```

run:  
```bash
cd flex_cairo
```

```bash
scarb cairo-run
```

# Cairo & Starknet contracts

STARK is a proof system. It uses cutting-edge cryptography to provide polylogarithmic verification resources and proof size, with minimal and post-quantum-secure assumptions.

Starknet contracts are programs specifically designed to run within the Starknet OS. The Starknet OS is a Cairo program itself, which means that any operation executed by the Starknet OS can be proven and succinctly verified.

## Notes 

- ZK-STARK is an acronym for Zero-Knowledge Scalable Transparent Argument of Knowledge

- ZK-STARKs, invented by StarkWare, enforce the integrity and privacy of computations on blockchains, using novel cryptographic proofs and modern algebra. ZK-STARKs allow blockchains to move computations to a single off-chain STARK prover and then verify the integrity of those computations using an on-chain STARK Verifier.

- Storage variables are not stored contiguously but in different locations in the contract's storage.

- Storage nodes and Storage paths.

- Functions that are not defined with the `#[external(v0)]` attribute or inside a block annotated with the `#[abi(embed_v0)]` attribute are private functions (also called internal functions). They can only be called from within the contract.

- Contracts' constraints and concepts (like view, internal, public functions), somewhat maps 1 to 1 with Solidity.

- An entrypoint can be marked as `view`, but might still modify the contract's state when invoked along with a transaction, if the contract uses low-level calls whose immutability is not enforced by the compiler.

- L1-Handlers, functions that can only be triggered by the sequencer after receiving a message from the L1 network whose payload contains an instruction to call a contract.

- Starknet contracts interact with other contracts, through a concept called "dispatcher pattern". As of Starknet 0.13.2, error handling in contract calls is not yet available. This means that if a contract call fails, the entire transaction will fail. This will change in the future, allowing safe dispatchers to be used on Starknet.

- There's the concept of `execution context` like in Solidity's `msg.sender` and `tx.sender` to be aware of. In Starknet's case, it's the built-in `get_caller_address()` function.

- The concept of Starknet Components allow lego-like building blocks for contracts.

- There's an OpenZeppelin ecosystem for Starknet contracts.

- Starknet contracts are upgradable.

- Starknet separates contracts into classes and instances, making it simple to upgrade a contract's logic without affecting its state.

- A contract class is the definition of the semantics of a contract. It includes the entire logic of a contract: the name of the entry points, the addresses of the storage variables, the events that can be emitted, etc. Each class is uniquely identified by its class hash. A class does not have its own storage: it's only a definition of logic.

- Classes are typically identified by a class hash. When declaring a class, the network registers it and assigns a unique hash used to identify the class and deploy contract instances from it.
A contract instance is a deployed contract corresponding to a class, with its own storage.

- Starknet supports L1-L2 messaging. A crucial feature of a Layer 2 is its ability to interact with Layer 1. Starknet has its own L1-L2 messaging system, which is different from its consensus mechanism and the submission of state updates on L1. Messaging is a way for smart-contracts on L1 to interact with smart-contracts on L2 (or the other way around), allowing us to do "cross-chain" transactions.
On Starknet, it's important to note that the messaging system is asynchronous and asymmetric.
The crucial component of the L1-L2 Messaging system is the StarknetCore contract. It is a set of Solidity contracts deployed on Ethereum that allows Starknet to function properly. One of the contracts of StarknetCore is called StarknetMessaging and it is the contract responsible for passing messages between Starknet and Ethereum. StarknetMessaging follows an interface with functions allowing to send message to L2, receiving messages on L1 from L2 and canceling messages.


- Randomness and VRF: the oracle of starknet is 'Pragma'. Pragma, an oracle on Starknet provides a solution for generating random numbers using VRFs.

### Types system notes

- The Store trait
- Starket smart contracts bring 2 new types that aren't in Cairo: `Map<K,V>` and `Vec<T>`

### Memory management notes

- A storage node is a special kind of struct that can contain storage-specific types, such as Map, Vec, or other storage nodes, as members. Unlike regular structs, storage nodes can only exist within contract storage and cannot be instantiated or used outside of it. You can think of storage nodes as intermediate nodes involved in address calculations within the tree representing the contract's storage space.

- The Storage and underlying zk lower-level concepts are abstracted away from the developer. Language allows data access with dot notation, however it is compiled to very carefully checked storage pointer access, or storage pointer read operations.

- Storage nodes have Storage paths 

- A Storage path, is a like digging through deeply nested JSON. Where each property is a pointer that can be calculated. Until we find the property we want.

example: `my_thing.layer_1.layer_2.layer_3.property.read()`

The storage path calculates the pointer of layer_1, from which, it can calc the pointer of layer_2, and so on. Until it finds the property and operates on it.

addresses are calculated from hashes of variable names ASCII codes. ( `h(sn_keccak(variable_name))`)

- sn_keccak stands for starknet keccak. It's a truncated keccak hash.

- The `Array<T>` type is a memory type and cannot be directly stored in contract storage. For storage, use the `Vec<T>` type, which is a `phantom type` designed specifically for contract storage. However, `Vec<T>` has limitations: it can't be instantiated as a regular variable, used as a function parameter, or included as a member in regular structs. To work with the full contents of a `Vec<T>`, you'll need to copy its elements to and from a memory `Array<T>`.

## Resources

- https://voyager.online/
- https://starkscan.co/

