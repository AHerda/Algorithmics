use std::collections::{HashMap, HashSet};

fn main() {
    let texts = vec!["ababcabcabababd", "ababcabcababab", "ababd"];
    let pattern = "ababd";

    for text in texts {
        if pattern_exists(text, pattern) {
            println!("Wzorzec '{}' istnieje w tekście '{}'", pattern, text);
        } else {
            println!("Wzorzec '{}' nie istnieje w tekście '{}'", pattern, text);
        }
    }
}

fn build_dfs(pattern: &str) -> Vec<HashMap<char, usize>> {
    let m = pattern.len();
    let alphabet: HashSet<char> = pattern.chars().collect();
    let pattern: Vec<char> = pattern.chars().collect();
    let mut lpf = 0;
    let mut dfs = vec![HashMap::new(); m + 1];

    for &c in &alphabet {
        dfs[0].insert(c, 0);
    }
    dfs[0].insert(pattern[0], 1);

    for i in 1..=m {
        for &c in &alphabet {
            let next_state = *dfs[lpf].get(&c).unwrap_or(&0);
            dfs[i].insert(c, next_state);
        }

        if i < m {
            dfs[i].insert(pattern[i], i + 1);
            lpf = *dfs[lpf].get(&pattern[i]).unwrap_or(&0);
        }
    }

    dfs
}

fn pattern_exists(text: &str, pattern: &str) -> bool {
    let m = pattern.len();
    let dfs = build_dfs(pattern);

    let mut state = 0;

    for c in text.chars() {
        state = *dfs[state].get(&c).unwrap_or(&0);
        if state == m {
            return true;
        }
    }
    false
}
