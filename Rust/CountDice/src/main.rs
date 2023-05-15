// Throw a pair of dice a thousand times
// Count the occurrences of each result
// How many times we got 2?
// How many times we got 3? … 12?
// Finally, show the counts
// Use an array of (at least) 11 ints, for counting

fn rand_int(nmin: i32, nmax: i32, seed: u32) -> (i32, u32) {
    let mut seed : u32 = seed;
    // From "Xorshift RNGs" by George Marsaglia
    seed ^= seed << 13;
    seed ^= seed >> 17;
    seed ^= seed << 5;
    let range = (nmax + 1 - nmin) as u32;
    let val = nmin + (seed % range) as i32;
    (val, seed)
}

fn time_seed() -> u32 {
    use std::time::SystemTime as st;
    let now = st::now().duration_since(st::UNIX_EPOCH).unwrap();
    now.as_millis() as u32
}

fn main() {
    let mut occurrences = [0;11];
    let mut seed = time_seed();
    for _i in 1..1001
    {
        let first = rand_int(1, 6, seed);
        seed = first.1;
        let second = rand_int(1, 6, seed);
        seed = first.1;
        let sum = first.0 + second.0;
        occurrences[(sum - 2) as usize] += 1;
    }
    for element in occurrences {
        println!("the value is: {}", element);
    }
}

