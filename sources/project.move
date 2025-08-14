module MyModule::SecureIdentity {

    use aptos_framework::signer;
    use std::string;

    /// Struct representing a user's secure identity.
    struct Identity has key {
        name: string::String,
        dob: string::String, // Date of Birth
    }

    /// Function to register a new identity for the caller.
    public fun register_identity(user: &signer, name: string::String, dob: string::String) {
        let addr = signer::address_of(user);
        assert!(!exists<Identity>(addr), 1); // Prevent re-registration

        let identity = Identity { name, dob };
        move_to(user, identity);
    }

    /// Function to view identity details for a given address.
    public fun view_identity(addr: address): (string::String, string::String) acquires Identity {
        let identity = borrow_global<Identity>(addr);
        (identity.name, identity.dob)
    }
}
