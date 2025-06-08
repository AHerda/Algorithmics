fn main() {
    println!("Hello, world!");
}

fn lcs_of_3(str1: &str, str2: &str, str3: &str) -> String {
    let str1: Vec<char> = str1.chars().collect();
    let str2: Vec<char> = str2.chars().collect();
    let str3: Vec<char> = str3.chars().collect();

    let mut m = vec![vec![vec![0; str3.len() + 1]; str2.len() + 1]; str1.len() + 1];

    for i in 0..str1.len() {
        for j in 0..str2.len() {
            for k in 0..str3.len() {
                if str1[i] == str2[j] && str2[j] == str3[k] {
                    m[i + 1][j + 1][k + 1] = m[i][j][k] + 1;
                } else {
                    m[i + 1][j + 1][k + 1] =
                        max_of_three(m[i + 1][j][k + 1], m[i + 1][j + 1][k], m[i][j + 1][k + 1]);
                }
            }
        }
    }

    let mut i = str1.len();
    let mut j = str2.len();
    let mut l = str3.len();
    let mut lcs_chars = Vec::new();

    while i > 0 && j > 0 && l > 0 {
        if str1[i - 1] == str2[j - 1] && str1[i - 1] == str3[l - 1] {
            lcs_chars.push(str1[i - 1]);
            i -= 1;
            j -= 1;
            l -= 1;
        } else if m[i - 1][j][l] >= m[i][j - 1][l] && m[i - 1][j][l] >= m[i][j][l - 1] {
            i -= 1;
        } else if m[i][j - 1][l] >= m[i - 1][j][l] && m[i][j - 1][l] >= m[i][j][l - 1] {
            j -= 1;
        } else {
            l -= 1;
        }
    }

    lcs_chars.reverse();
    lcs_chars.iter().collect()
}
// dodaj backtrackong, odzyskiwanie

fn max_of_three(a: usize, b: usize, c: usize) -> usize {
    std::cmp::max(std::cmp::max(a, b), c)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_lcs_of_3_basic_case() {
        let str1 = "abc";
        let str2 = "abc";
        let str3 = "abc";
        let result = lcs_of_3(str1, str2, str3);
        assert_eq!(result, "abc");
    }

    #[test]
    fn test_lcs_of_3_empty_strings() {
        let str1 = "";
        let str2 = "";
        let str3 = "";
        let result = lcs_of_3(str1, str2, str3);
        assert_eq!(result, "");
    }

    #[test]
    fn test_lcs_of_3_no_common_characters() {
        let str1 = "abc";
        let str2 = "def";
        let str3 = "ghi";
        let result = lcs_of_3(str1, str2, str3);
        assert_eq!(result, "");
    }

    #[test]
    fn test_lcs_of_3() {
        let str1 = "aaaaaaaaaabbcjj";
        let str2 = "bbbbbbbbbbaaaac";
        let str3 = "ccccccccccccbbbbbbbbbbbbbaaaa";
        let result = lcs_of_3(str1, str2, str3);
        assert_eq!(result, "aaaa");
    }
}
