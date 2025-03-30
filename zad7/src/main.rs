use std::hash::{Hash, DefaultHasher, Hasher};

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

//function RabinKarp(string s[1..n], string pattern[1..m])
// hpattern := hash(pattern[1..m]);
// for i from 1 to n-m+1
//     hs := hash(s[i..i+m-1])
//     if hs = hpattern
//         if s[i..i+m-1] = pattern[1..m]
//             return i
// return not found
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

fn hash(text: &str) -> u64 {
    let mut s = DefaultHasher::new();
    text.hash(&mut s);
    s.finish()
}
