pragma solidity ^0.8.17;

import "../circuits/crates/bid_smt_init/contract/bid_smt_init/plonk_vk.sol";

contract Auction {
    UltraVerifier public verifier;

    // poseidon([0])
    bytes32 merkleRoot =
        0x3eccb13f85ca90f76a52d1756be63877ce16cb755e20028c0adfb14581733416;

    constructor(UltraVerifier _verifier) {
        verifier = _verifier;
    }

    function bid(
        bytes calldata proof,
        bytes32[] calldata y
    ) public view returns (bool) {
        // verify proof and update merkleRoot
        bool proofResult = verifier.verify(proof, y);
        require(proofResult, "Proof is not valid");
        return proofResult;
    }
}
