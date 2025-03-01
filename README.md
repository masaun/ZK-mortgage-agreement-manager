# ZK Sonic in Noir

# Installations

## Installation - Smart contract
- Install libraries
  (NOTE: Before this installation, all folders should be removed under the ./lib directory)
```shell
forge install OpenZeppelin/openzeppelin-contracts
forge install 0xnonso/foundry-noir-helper
```

<br>

## ZK circuit - Generate (Prove) an Ultraplonk proof in Noir

- 1/ Move to the `./circuits` directory:
```shell
cd circuits
```

- 2/ Create the `Prover.toml` file by coping the example file (`Prover.example.toml`) in the `./circuits` directory.
```shell
cp Prover.example.toml Prover.toml
```

- 3/ Write the `input data` should be written in the `Prover.toml`.
  - [NOTE]: `"Boolean"` type data should be written in a string number (True: `"0"` / False: `"1"`).
```toml
return = ""
x = ""
y = ""
```


- 2/ Run the `build.sh` to run ZK circuit
```shell
sh build.sh
```

- 3/ The UltraVerifier contract (`contract.sol`) and `proof` and `vk` in Noir would be generated under the `./circuits/target`.


<br>

## ZK circuit - Test
- Run the `circuit_test.sh` to test the ZK circuit. 
```shell
cd circuits
sh circuit_test.sh
```

<br>

## Smart Contract - Compile

- Compile the smart contracts
```shell
sh ./buildContract.sh
```

<br>

## Smart Contract - Script on Sonic Testnet / Electroneum Testnet

- Run the script of the `Starter.s.sol`, which is the test file of the `Starter.sol` on Sonic Testnet.
```shell
sh ./script/starter-script.sh
```

<br>

- Run the script of the `Starter.s.sol`, which is the test file of the `Starter.sol` on Electroneum Testnet.
```shell
sh ./script/electroneum-testnet/starter-script.sh
```

<br>

- Run the script of the `Verify.s.sol`, which is the test file of the `UltraVerifier.sol` on Sonic Testnet.
```shell
sh ./script/verify-script.sh
```

<br>

- Run the script of the `Verify.s.sol`, which is the test file of the `UltraVerifier.sol` on Electroneum Testnet.
```shell
sh ./script/electroneum-testnet/verify-script.sh
```

<br>

## Smart Contract - Test on Local Network / Sonic Testnet / Electroneum Testnet

- Run the test of the `Starter.t.sol`, which is the test file of the `Starter.sol` on Local Network.
```shell
sh ./test/runningTest_1.sh
```

<br>

- Run the test of the `StarterOnSonicTestnet.t.sol`, which is the test file of the `Starter.sol` on Sonic Testnet.
```shell
sh ./test/runningTest_Sonic-Testnet.sh
```

<br>

- Run the test of the `StarterOnElectroneumTestnet.t.sol`, which is the test file of the `Starter.sol` on Electroneum Testnet.
```bash
sh ./test/electroneum-testnet/runningTest_Electroneum-Testnet.sh
```


<br>



<br>

## Smart Contract - Deployment (on `Sonic Testnet`)

- NOTE: Each Smart Contract has been deployed on `Sonic Testnet`. See the `"Deployed-smart contracts onSonic Testnet"` paragraph above in this README.

- 1/ Create the `.env` file by coping the example file (`.env.example`) in the root directory.
  - Then, you should add a private key of your deployer address to the `SONIC_BLAZE_TESTNET_PRIVATE_KEY` /or the `ELECTRONEUM_TESTNET_PRIVATE_KEY`.
```shell
cp .env.example .env
```

- 2/ Deploy all contracts on Sonic Testnet by running the `script/DeploymentAllContracts.s.sol` 
```bash
sh ./script/deployment.sh
``
Or, directly executing the following command:
```bash
/// [NOTE]: Execute the following at the root directory.

forge script script/DeploymentAllContracts.s.sol --broadcast --private-key <SONIC_BLAZE_TESTNET_PRIVATE_KEY> \
    ./circuits/target/contract.sol:UltraVerifier \
    ./Starter.sol:Starter --skip-simulation
```

<br>

- 2/ Deploy all contracts on Electroneum Testnet by running the `script/DeploymentAllContracts.s.sol` 
```bash
sh ./script/electroneum-testnet/deployment/deployment-on-electroneum-testnet.sh
``
Or, directly executing the following command:
```bash
/// [NOTE]: Execute the following at the root directory.

forge script script/electroneum-testnet/deployment/DeploymentAllContracts.s.sol --broadcast --private-key ${ELECTRONEUM_TESTNET_PRIVATE_KEY} \
    ./circuits/target/contract.sol:UltraVerifier \
    ./Starter.sol:Starter --skip-simulation --legacy
```

<br>

<hr>

# Noir with Foundry

This example uses Foundry to deploy and test a verifier.

## Getting Started

Want to get started in a pinch? Start your project in a free Github Codespace!

[![Start your project in a free Github Codespace!](https://github.com/codespaces/badge.svg)](https://codespaces.new/noir-lang/noir-starter)

In the meantime, follow these simple steps to work on your own machine:

Install [noirup](https://noir-lang.org/docs/getting_started/noir_installation) with

1. Install [noirup](https://noir-lang.org/docs/getting_started/noir_installation):

   ```bash
   curl -L https://raw.githubusercontent.com/noir-lang/noirup/main/install | bash
   ```

2. Install Nargo:

   ```bash
   noirup
   ```

3. Install foundryup and follow the instructions on screen. You should then have all the foundry
   tools like `forge`, `cast`, `anvil` and `chisel`.

```bash
curl -L https://foundry.paradigm.xyz | bash
```

4. Install foundry dependencies by running `forge install 0xnonso/foundry-noir-helper --no-commit`.

5. Install `bbup`, the tool for managing Barretenberg versions, by following the instructions
   [here](https://github.com/AztecProtocol/aztec-packages/blob/master/barretenberg/bbup/README.md#installation).

6. Then run `bbup`.

## Generate verifier contract and proof

### Contract

The deployment assumes a verifier contract has been generated by nargo. In order to do this, run:

```bash
cd circuits
nargo compile
bb write_vk -b ./target/with_foundry.json
bb contract
```

A file named `contract.sol` should appear in the `circuits/target` folder.

### Test with Foundry

We're ready to test with Foundry. There's a basic test inside the `test` folder that deploys the
verifier contract, the `Starter` contract and two bytes32 arrays correspondent to good and bad
solutions to your circuit.

By running the following command, forge will compile the contract with 5000 rounds of optimization
and the London EVM version. **You need to use these optimizer settings to suppress the "stack too
deep" error on the solc compiler**. Then it will run the test, expecting it to pass with correct
inputs, and fail with wrong inputs:

```bash
forge test --optimize --optimizer-runs 5000 --evm-version cancun
```

#### Testing On-chain

You can test that the Noir Solidity verifier contract works on a given chain by running the
`Verify.s.sol` script against the appropriate RPC endpoint.

```bash
forge script script/Verify.s.sol --rpc-url $RPC_ENDPOINT  --broadcast
```

If that doesn't work, you can add the network to Metamask and deploy and test via
[Remix](https://remix.ethereum.org/).

Note that some EVM network infrastructure may behave differently and this script may fail for
reasons unrelated to the compatibility of the verifier contract.

### Deploy with Foundry

This template also has a script to help you deploy on your own network. But for that you need to run
your own node or, alternatively, deploy on a testnet.

#### (Option 1) Run a local node

If you want to deploy locally, run a node by opening a terminal and running

```bash
anvil
```

This should start a local node listening on `http://localhost:8545`. It will also give you many
private keys.

Edit your `.env` file to look like:

```
ANVIL_RPC=http://localhost:8545
LOCALHOST_PRIVATE_KEY=<the private key you just got from anvil>
```

#### (Option 2) Prepare for testnet

Pick a testnet like Sepolia or Goerli. Generate a private key and use a faucet (like
[this one for Sepolia](https://sepoliafaucet.com/)) to get some coins in there.

Edit your `.env` file to look like:

```env
SEPOLIA_RPC=https://rpc2.sepolia.org
LOCALHOST_PRIVATE_KEY=<the private key of the account with your coins>
```

#### Run the deploy script

You need to source your `.env` file before deploying. Do that with:

```bash
source .env
```

Then run the deployment with:

```bash
forge script script/Starter.s.sol --rpc-url $ANVIL_RPC --broadcast --verify
```

Replace `$ANVIL_RPC` with the testnet RPC, if you're deploying on a testnet.

## Developing on this template

This template doesn't include settings you may need to deal with syntax highlighting and
IDE-specific settings (i.e. VScode). Please follow the instructions on the
[Foundry book](https://book.getfoundry.sh/config/vscode) to set that up.

It's **highly recommended** you get familiar with [Foundry](https://book.getfoundry.sh) before
developing on this template.
