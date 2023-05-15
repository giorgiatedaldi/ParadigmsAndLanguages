// Write a Rust function
// Given an array of positive integers values...
// How many times does the maximum change?
// Like counting the skyscrapers' tops
// … which can be seen, looking from left to right
// Implement it using the imperative paradigm
fn max_change(elements: [i32; 6]) -> i32
{
    let mut max = -1;
    let mut changes = 0;

    for n in elements
    {
        if n > max {
            changes += 1;
            max = n;
        }

    }
    changes
}

fn main() {
    let elements = [3, 6, 7, 2, 1, 5];

    let changes = max_change(elements);
    println!("{}", changes);
    
}
