
fn max_change(elements: [i32; 6]) -> i32 {
    let (_, count) = elements.iter()
        .fold((0, 0), |(max, count), &n| {
            if n > max {
                (n, count + 1)
            } else {
                (max, count)
            }
        });
    count
}

fn main() {
    let elements = [3, 6, 7, 2, 1, 5];

    let changes = max_change(elements);
    println!("{}", changes);
    
}
