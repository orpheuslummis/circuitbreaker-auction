use dep::std;
use dep::std::option::Option;
use dep::ecrecover;
use dep::smt_bn254;

unconstrained
fn u8_to_field(array: [u8; 32]) -> Field {
    let mut field: Field = 0;

    for i in 0..32 {
        // only take the last 20 bytes of the hash
        field = (field * 256) + (array[i] as Field);
    }

    field
}

fn main(
    old_root: pub Field,
    old_siblings: [Field; smt_bn254::TREE_DEPTH],
    address: Field,
    hashed_bid: [u8; 32],
    bid: Field
) -> pub Field {
    let old_leaf = [address, u8_to_field(hashed_bid)];
    smt_bn254::verify(
        old_leaf,
        [Option::none(), Option::none()],
        old_siblings,
        old_root
    );

    let digest = std::hash::keccak256(bid.to_le_bytes(32), 32);
    assert_eq(digest, hashed_bid);

    let smt_entry = [address, bid];
    smt_bn254::add(smt_entry, old_root, old_siblings)
}

