pragma solidity ^0.8.17;

interface IEmploymentVerificationLetterProofVerifier {
    function verifyEqual(bytes calldata proof, bytes32[] calldata publicInputs) external view returns (bool);
}