pragma solidity ^0.8.17;

//import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";


library DataTypes {

    struct EmploymentVerificationLetterProofAndPublicInput {
        //bytes proof;
        //bytes32[] publicInput;
        bytes32 merkleRoot;
        bytes32 annualSalary;
        bytes32 nullifier;
        bool isNullifier;
    }

    struct FICOCreditScoreProofAndPublicInput {
        //bytes proof;
        //bytes32[] publicInput;
        bytes32 merkleRoot;
        bytes32 creditScore;
        bytes32 nullifier;
        bool isNullifier;
    }

    struct MortgageAffordabilityProofAndPublicInput {
        //bytes proof;
        //bytes32[] publicInput;
        bytes32 merkleRoot;
        bytes32 nullifier;
        bool isNullifier;
    }

    struct MortgageAgreement {
        address borrower;
        address lender;
        bytes employmentVerificationLetterProof;
        bytes32[] employmentVerificationLetterPublicInputs;
        bytes ficoCreditScoreProof;
        bytes32[] ficoCreditScorePublicInputs;
        bytes mortgageAffordabilityProof;
        bytes32[] mortgageAffordabilityPublicInputs;
        bool isAccepted;
    }

    // struct PublicInput { /// @dev - Only publicInput is stored into here.
    //     bytes32[] publicInput;
    // }

    //enum InterestRateMode { NONE, STABLE, VARIABLE }
}