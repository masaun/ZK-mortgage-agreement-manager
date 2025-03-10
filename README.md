# ZK Mortgage Agreement Manager

## Tech Stack
- `ZK circuit`: Written in [`Noir`](https://noir-lang.org/docs/) powered by [Aztec](https://aztec.network/)) 
- Smart Contract: Written in Solidity (Framework: Foundry)
- Blockchain: [`Sonic`](https://docs.soniclabs.com/sonic/build-on-sonic/getting-started) (Testnet)

<br>

## Overview

- This is the ZK Mortgage Agreement Manager, which is the Zero-Knowledge based mortgage loan agreement management system that consists of the ZK circuits and the smart contracts.

- In the real estate space, when a borrower would borrow a mortgage loan to buy a house via a real estate agency, the following scenario will be proceeded:
  - 1/ A borrower will submit some financial documents (i.e. `Employment verification letter`) to a real estate agency for showing their finantial profile (i.e `income`, `tax returns`, etc). 
  - 2/ Also, the real estate company would ask a credit score provider (i.e. `FICO`) the borrower's `credit score` and retrieve it as the borrower's finantial profile.
  - 3/ The real estate company would send these finantial profile (i.e. `income`, `credit score`) to a lender (i.e. Bank, Morgage Loan company, etc) as a morgage loan request.
  - 4/ Once the borrower's morgage loan request would be approved by the lender, the mortgage agreement would be created through the real estate agency (or the lender).

- The problem of the general mortgage loan process via a real estate agency above is that the real estate agency (and the lender) can see all of the borrower's informations, which includes the sensitive informations or/and unnecessity informations. 
  - This project (`ZK Mortgage Agreement Manager`) can resolve these problem by the combination of the ZK circuits and the smart contracts as a privacy-preserving way.
  - By using this project (`ZK Mortgage Agreement Manager`), a borrower can submit a mortgate loan request to a lender via a real estate agency **without revealing their sensitive informations or/and unnecessity informations**.


<br>

## Deployed-smart contracts on [`Sonic` Testnet](https://docs.soniclabs.com/sonic/build-on-sonic/getting-started)

| Contract Name | Descripttion | Deployed-contract addresses on Sonic Testnet |
| ------------- |:-------------:| -----:|
| UltraVerifier (for the EmploymentVerificationLetterProof) | The UltraPlonk Verifer contract for the EmploymentVerificationLetterProof (`./employer/contracts/circuit/plonk_vk.sol`), which is generated based on ZK circuit in Noir (`./circuits/src/main.nr`). FYI: To generated this contract, the way of the [Noir's Solidity Verifier generation](https://noir-lang.org/docs/how_to/how-to-solidity-verifier) was used. | [0x621dbc8010E0d5Aa2b11a5103c9833eC94a70E39](https://testnet.sonicscan.org/address/0x621dbc8010e0d5aa2b11a5103c9833ec94a70e39) |
| EmploymentVerificationLetterProofVerifier | The smart contract that enable to validate whether or not a EmploymentVerificationLetterProof-submitted is valid. | [0xEd1324385Fe64c83687C3f9576F3210c6B8E309E](https://testnet.sonicscan.org/address/0xed1324385fe64c83687c3f9576f3210c6b8e309e) |
| UltraVerifier (for the FICOCreditScoreProof) | The UltraPlonk Verifer contract for the EmploymentVerificationLetterProof (`./FICO/contracts/circuit/plonk_vk.sol`), which is generated based on ZK circuit in Noir (`./circuits/src/main.nr`). FYI: To generated this contract, the way of the [Noir's Solidity Verifier generation](https://noir-lang.org/docs/how_to/how-to-solidity-verifier) was used. | [0xEa8EB5CFf49241B39950c31f788AEF8E0d4Df1c1](https://testnet.sonicscan.org/address/0xEa8EB5CFf49241B39950c31f788AEF8E0d4Df1c1) |
| FICOCreditScoreProofVerifier | The smart contract that enable to validate whether or not a EmploymentVerificationLetterProof-submitted is valid. | [0x20a414abEcFe31DD27Aa7FcCC353a505E976D277](https://testnet.sonicscan.org/address/0x20a414abEcFe31DD27Aa7FcCC353a505E976D277) |
| UltraVerifier (for the MortgageAffordabilityProof) | The UltraPlonk Verifer contract for the EmploymentVerificationLetterProof (`./borrower/contracts/circuit/plonk_vk.sol`), which is generated based on ZK circuit in Noir (`./circuits/src/main.nr`). FYI: To generated this contract, the way of the [Noir's Solidity Verifier generation](https://noir-lang.org/docs/how_to/how-to-solidity-verifier) was used. | [0x2317106a73E00fc66AB25aD50979CFf140075b2b](https://testnet.sonicscan.org/address/0x2317106a73E00fc66AB25aD50979CFf140075b2b) |
| MortgageAffordabilityProofVerifier | The smart contract that enable to validate whether or not a MortgageAffordabilityProof-submitted is valid. | [0x7a2E68d1d1bB79dBc945801A02Bd6e17d0842457](https://testnet.sonicscan.org/address/0x7a2E68d1d1bB79dBc945801A02Bd6e17d0842457) |
| MortgageAgreementManager | The smart contract that enable a borrower to create a request of the mortgage agreement /w three ZK proofs (`EmploymentVerificationLetterProof`, `FICOCreditScoreProof`, `MortgageAffordabilityProof`) and enable a lender to accept these request | [0x0A95E7Fc5c292eCe47893E63A1380f08a061814A](https://blockexplorer.thesecurityteam.rocks/address/0x0A95E7Fc5c292eCe47893E63A1380f08a061814A) |



<br>

<hr>

# Installations

## Installation - Smart contract
- Install libraries
  (NOTE: Before this installation, all folders should be removed under the ./lib directory)
```shell
forge install OpenZeppelin/openzeppelin-contracts
forge install 0xnonso/foundry-noir-helper
```

<br>

## ZK circuit - Generate (Prove) an Ultraplonk Proof in Noir

There are three ZK circuits in total. For three ZK circuits in the three directory (`./employer/circuits`, `./FICO/circuits`, `./borrower/circuits`) respectively, the following installation should be done: 

- 1/ Move to the `./circuits` directory:
```shell
cd circuits
```

- 2/ Create the `Prover.toml` file by coping the example file (`Prover.example.toml`) in the `./circuits` directory.
```shell
cp Prover.example.toml Prover.toml
```

- 3/ Write the `input data` should be written in the `Prover.toml`.


- 4/ Run the `build.sh` to run ZK circuit
```shell
sh build.sh
```

- 5/ The UltraVerifier contract (`contract.sol`) and `proof` and `vk` in Noir would be generated under the `./circuits/target`.
  - The UltraVerifier contract (`contract.sol`) is automatically copied to the `/contracts/circuit` as the `plonk_vk.sol`


<br>

## ZK circuit - Test
- Run the `circuit_test.sh` to test the ZK circuit in the `./employer/circuits`. 
```shell
cd employer/circuits
sh circuit_test.sh
```

- Run the `circuit_test.sh` to test the ZK circuit in the `./FICO/circuits`. 
```shell
cd FICO/circuits
sh circuit_test.sh
```

- Run the `circuit_test.sh` to test the ZK circuit in the `./borrower/circuits`. 
```shell
cd borrower/circuits
sh circuit_test.sh
```


<br>

## Smart Contract - Compile

There are three components of the smart contracts in total. For three type of the smart contracts in the three directory (`./employer/contracts`, `./FICO/contracts`, `./borrower/contracts`) respectively, the following installation should be done: 

- Compile the smart contracts
```shell
cd employer or FICO or borrower
sh ./buildContract.sh
```

<br>

## Smart Contract - Test on Local Network / Sonic Testnet

There are three components of the smart contract tests in total. For three components of the smart contracts in the three directory (`./employer/test`, `./FICO/test`, `./borrower/test`) respectively, the following installation should be done: 

- Run the test of the `EmploymentVerificationLetterProofVerifier.t.sol`, which is the test file of the `EmploymentVerificationLetterProofVerifier.sol` on Local Network.
```bash
cd employer
sh ./test/runningTest_EmploymentVerificationLetterProofVerifier.sh
```

<br>

- Run the test of the `EmploymentVerificationLetterProofVerifierOnSonicTestnet.t.sol`, which is the test file of the `EmploymentVerificationLetterProofVerifier.sol` on Sonic Testnet.
```shell
cd employer
sh ./test/sonic-testnet/runningTest_EmploymentVerificationLetterProofVerifierOnSonicTestnet.sh
```

<br>

- Run the test of the `FICOCreditScoreProofVerifier.t.sol`, which is the test file of the `EFICOCreditScoreProofVerifier.sol` on Local Network.
```bash
cd FICO
sh ./test/runningTest_FICOCreditScoreProofVerifier.sh
```

<br>

- Run the test of the `FICOCreditScoreProofVerifierOnSonicTestnet.t.sol`, which is the test file of the `FICOCreditScoreProofVerifier.sol` on Sonic Testnet.
```shell
cd FICO
sh ./test/sonic-testnet/runningTest_EmploymentVerificationLetterProofVerifierOnSonicTestnet.sh
```

<br>

- Run the test of the `MortgageAffordabilityProofVerifier.t.sol`, which is the test file of the `MortgageAffordabilityProofVerifier.sol` on Local Network.
```bash
cd borrower
sh ./test/runningTest_MortgageAffordabilityProofVerifier.sh
```

<br>

- Run the test of the `MortgageAffordabilityProofVerifierOnSonicTestnet.t.sol`, which is the test file of the `MortgageAffordabilityProofVerifier.sol` on Sonic Testnet.
```shell
cd borrower
sh ./test/sonic-testnet/runningTest_MortgageAffordabilityProofVerifierOnSonicTestnet.sh
```

<br>

- Run the test of the `MortgageAgreementManagerOnSonicTestnet.t.sol`, which is the test file of the `MortgageAgreementManager.sol` on Sonic Testnet.  
  (NOTE: This test is still in progress)
```shell
cd borrower
sh ./test/sonic-testnet/runningTest_MortgageAgreementManagerOnSonicTestnet.sh
```

<br>

## Smart Contract - Script on Sonic Testnet

- Run the script of the `EmploymentVerificationLetterProofVerifier.s.sol`, which is the test file of the `EmploymentVerificationLetterProofVerifier.sol` on Sonic Testnet.
```shell
cd employer
sh ./script/sonic-testnet/runningScript_EmploymentVerificationLetterProofVerifier.sh
```

<br>

- Run the script of the `FICOCreditScoreProofVerifier.s.sol`, which is the test file of the `UltraVerifier.sol` on Sonic Testnet.
```shell
cd FICO
sh ./script/sonic-testnet/runningScript_FICOCreditScoreProofVerifier.sh
```

<br>

- Run the script of the `MortgageAffordabilityProofVerifier.s.sol`, which is the test file of the `UltraVerifier.sol` on Sonic Testnet.
```shell
cd borrower
sh ./script/sonic-testnet/runningScript_MortgageAffordabilityProofVerifier.sh
```

<br>

## Smart Contract - Deployment (on `Sonic Testnet`)

- NOTE: Each Smart Contract has been deployed on `Sonic Testnet`. See the `"Deployed-smart contracts onSonic Testnet"` paragraph above in this README.

- 1/ Create the `.env` file by coping the example file (`.env.example`) in the root directory.
  - Then, you should add a private key of your deployer address to the `SONIC_BLAZE_TESTNET_PRIVATE_KEY` /or the `ELECTRONEUM_TESTNET_PRIVATE_KEY`.
```shell
cd employer or FICO or borrower
cp .env.example .env
```

- 2/ Deploy all contracts on Sonic Testnet by running the `script/DeploymentAllContracts.s.sol` 
```bash
cd employer
sh ./script/sonic-testnet/deployment/deployment-on-sonic-testnet.sh

cd FICO
sh ./script/sonic-testnet/deployment/deployment-on-sonic-testnet.sh

cd borrower
sh ./script/sonic-testnet/deployment/deploymentScript_MortgageAffordabilityProofVerifier.sh
sh ./script/sonic-testnet/deployment/deploymentScript_MortgageAgreementManager.sh
```

<br>


## References and Resources

- Noir:
  - Doc: https://noir-lang.org/docs/getting_started/quick_start
  - `noir-starter` (for Foundry): https://github.com/AztecProtocol/noir-starter/tree/main/with-foundry


- Sonic: 
  - Block Explorer (on Sonic Testnet): https://testnet.sonicscan.org/
  - Doc (icl. RPC, etc): https://docs.soniclabs.com/sonic/build-on-sonic/getting-started
  - Fancet: https://testnet.soniclabs.com/account
