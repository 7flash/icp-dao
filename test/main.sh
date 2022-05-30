function deploy(wasm) {
    let canister = call ic.provisional_create_canister_with_cycles(record { settings = null; amount = null });
    call ic.canister_status(canister);
    assert _.module_hash == (null : opt blob);
    call ic.install_code(
        record {
            arg = encode();
            wasm_module = wasm;
            mode = variant { install };
            canister_id = canister.canister_id;
        }
    );
    canister
};

identity owner;

let canister = deploy(file "../.dfx/local/canisters/thirdone/thirdone.wasm");

let status = call ic.canister_status(canister);
assert status.settings ~= record { controllers = vec { owner } };

let id = canister.canister_id;

call ic.stop_canister(canister);
call ic.delete_canister(canister);