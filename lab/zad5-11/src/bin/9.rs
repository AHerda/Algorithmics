fn main() {
    println!("Hello, world!");
}

fn find_all_substrings(x: &str) -> Vec<(usize, isize)> {
    let start = "ATG";
    let special = vec!["TAA", "TGA", "TAG"];
    let mut result = Vec::new();
    let mut in_seq = false;
    let mut seq_start = 0;
    let mut u_len = -3;

    for i in 0..=x.len() - 3 {
        if x[i..i + 3] == *start {
            println!("Znaleziono start!! {i}");
            u_len = -3;
            in_seq = true;
            seq_start = i;
        } else if in_seq && special.iter().any(|e| **e == x[i..i + 3]) && u_len >= 0 {
            u_len += 1;
            println!("przerwano {i}");
            if u_len >= 30 {
                result.push((seq_start, u_len));
                println!("Znaleziono koniec! {}", u_len);
            }

            in_seq = false;
            u_len = -3;
            seq_start = 0;
        } else if in_seq {
            u_len += 1;
        }
    }
    result
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_valid_sequence() {
        let sequence = "ATGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAATTGTAAAA";
        let result = find_all_substrings(sequence);
        assert_eq!(result, vec![(0, 47)]);
    }

    #[test]
    fn test_valid_sequences() {
        let sequence = "ATGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAATTGTAAAATGTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTGA";
        let result = find_all_substrings(sequence);
        assert_eq!(result, vec![(0, 47), (54, 30)]);
    }

    #[test]
    fn test_no_valid_sequence() {
        let sequence = "ATGAAAAAATAG";
        let result = find_all_substrings(sequence);
        assert!(result.is_empty());
    }
}
