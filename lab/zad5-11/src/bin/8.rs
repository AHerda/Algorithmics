fn main() {
    println!("Wartość oczekiwana E(lcs(x, y)) = {}", expected());
}

fn lcs(str1: &str, str2: &str) -> usize {
    let str1: Vec<char> = str1.chars().collect();
    let str2: Vec<char> = str2.chars().collect();
    let mut m = vec![vec![0; str2.len() + 1]; str1.len() + 1];

    for i in 0..str1.len() {
        for j in 0..str2.len() {
            if str1[i] == str2[j] {
                m[i + 1][j + 1] = m[i][j] + 1;
            } else {
                m[i + 1][j + 1] = std::cmp::max(m[i + 1][j], m[i][j + 1]);
            }
        }
    }
    return m[str1.len()][str2.len()];
}

fn u8_as_str(i: u8) -> String {
    format!("{:05b}", i)
}

fn expected() -> f64 {
    let all_s: Vec<u8> = (0..2u8.pow(5)).collect();
    let mut sum = 0;
    let mut index = 0;

    for i in 0..all_s.len() {
        for j in 0..all_s.len() {
            sum += lcs(&u8_as_str(all_s[i]), &u8_as_str(all_s[j]));
            index += 1;
        }
    }

    sum as f64 / index as f64
}
