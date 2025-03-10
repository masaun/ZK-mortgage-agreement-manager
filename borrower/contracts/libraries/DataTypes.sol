pragma solidity ^0.8.17;

//import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";


library DataTypes {

    struct EmploymentVerificationLetterProofAndPublicInput {
        bytes proof;
        bytes32[] publicInput;
    }

    struct FICOCreditScoreProofAndPublicInput {
        bytes proof;
        bytes32[] publicInput;
    }

    struct MortgageAffordabilityProofAndPublicInput {
        bytes proof;
        bytes32[] publicInput;
    }

    // struct PublicInput { /// @dev - Only publicInput is stored into here.
    //     bytes32[] publicInput;
    // }

    //enum InterestRateMode { NONE, STABLE, VARIABLE }
}