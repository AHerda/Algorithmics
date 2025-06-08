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
    if pattern.is_empty() || text.is_empty() || pattern.len() > text.len() {
        return false;
    }

    let pbytes = pattern.as_bytes();
    let tbytes = text.as_bytes();

    let d: u64 = 256;
    let q: u64 = 101; // A prime number for modulus

    let mut hpattern: u64 = 0;
    let mut htext: u64 = 0;
    let mut h: u64 = 1;

    for _ in 0..pattern.len() - 1 {
        h = (h * d) % q;
    }
    for i in 0..pattern.len() {
        hpattern = update_hash(d, hpattern, pbytes[i], q);
        htext = update_hash(d, htext, tbytes[i], q);
    }

    for i in 0..=text.len() - pattern.len() {
        if htext == hpattern && &text[i..i + pattern.len()] == pattern {
            return true;
        }

        if i < text.len() - pattern.len() {
            let tmp = (htext + q - (h * tbytes[i] as u64 % q)) % q;
            htext = update_hash(d, tmp, tbytes[i + pattern.len()], q);
        }
    }

    false
}

//rolling hash dodaj

fn update_hash(d: u64, hash: u64, val: u8, q: u64) -> u64 {
    (d * hash + val as u64) % q
}
