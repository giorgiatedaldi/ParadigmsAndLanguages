fn get_phone_number(name: String, phone_book: &[(String, i32)]) -> Result<i32, String> {
    for &(ref n, p) in phone_book {
        if n == &name {
            return Ok(p);
        }
    }
    Err(format!("No phone number found for {}", name))
}

fn main() {
    let phone_book = vec![
        ("Gio".to_string(), 123456),
        ("Dadde".to_string(), 234567),
        ("Gesso".to_string(), 345678),
    ];
    
    match get_phone_number("Gio".to_string(), &phone_book) {
        Ok(number) => println!("The phone number is {}", number),
        Err(error) => println!("Error: {}", error),
    }

    match get_phone_number("Pippo".to_string(), &phone_book) {
        Ok(number) => println!("The phone number is {}", number),
        Err(error) => println!("Error: {}", error),
    }
}
