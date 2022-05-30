actor {
    var proposal = "";

    public query func get() : async Text {
        return proposal;
    };

    public func set(newProposal : Text) : async () {
        proposal := newProposal;
    };
}