module MyModule::AcademicLeaderboard {
    use aptos_framework::signer;
    use std::vector;
    
    struct Leaderboard has store, key {
        top_score: u64,
        top_student: address,
    }
    
    public fun initialize(creator: &signer) {
        move_to(creator, Leaderboard {
            top_score: 0,
            top_student: signer::address_of(creator),
        });
    }
    
    public fun submit_score(student: &signer, score: u64) acquires Leaderboard {
        let leaderboard = borrow_global_mut<Leaderboard>(signer::address_of(student));
        if (score > leaderboard.top_score) {
            leaderboard.top_score = score;
            leaderboard.top_student = signer::address_of(student);
        }
    }
}
