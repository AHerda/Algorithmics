use std::hash::{DefaultHasher, Hash, Hasher};

fn main() {
    let texts = vec!["ababcabcabababd", "ababcabcababab", "ababd"];
    let pattern = "ababd";

    for text in texts {
        if rk(text, pattern) {
            println!("Wzorzec '{}' istnieje w tekście '{}'", pattern, text);
        } else {
            println!("Wzorzec '{}' nie istnieje w tekście '{}'", pattern, text);
        }
    }
}

fn rk(text: &str, pattern: &str) -> bool {
    let hpattern = hash(pattern);
    for i in 0..=text.len() - pattern.len() {
        let hs = hash(&text[i..i + pattern.len()]);
        if hs == hpattern {
            if &text[i..i + pattern.len()] == pattern {
                return true;
            }
        }
    }
    false
}

//rolling hash dodaj

fn hash(text: &str) -> u64 {
    let mut s = DefaultHasher::new();
    text.hash(&mut s);
    s.finish()
}
