use dep::std;
use dep::ecrecover;
use dep::smt_bn254;

unconstrained
fn u8_to_field(array: [u8; 32]) -> Field {
    let mut field: Field = 0;
    for i in 0..32 {
        field = (field * 256) + (array[i] as Field);
    }
    field
}

fn main(
    old_root: pub Field,
    old_siblings: [Field; smt_bn254::TREE_DEPTH],
    pub_key_x: [u8; 32],
    pub_key_y: [u8; 32],
    signature: [u8; 64],
    hashed_bid: [u8; 32]
) -> pub Field {
    let address = ecrecover::ecrecover(pub_key_x, pub_key_y, signature, hashed_bid);
    let smt_entry = [address, u8_to_field(hashed_bid)];
    std::println(f"address: {address}, hash: {smt_entry[1]}");
    smt_bn254::add(smt_entry, old_root, old_siblings)
}

