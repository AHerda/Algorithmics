use rand::Rng;

const BITS: u64 = 16;

fn random_bits() -> u64 {
    let mut rng = rand::rng();
    let mut result = 0;
    for i in 0..BITS {
        result |= if rng.random() { 1 << i } else { 0 };
    }
    result
}

fn is_success(x: u64) -> bool {
    return x.count_ones() == 0
}

fn cond_exp_bits(prefix: u64, prefix_len: u64) -> f64 {
    if prefix.count_ones() != 0 {
        0.0
    } else {
        2f64.powi(-((BITS - prefix_len) as i32))
    }
}

fn derandomized_bits() -> u64 {
    let mut x: u64 = 0;

    for i in 0..BITS {
        let c0 = cond_exp_bits(x, i + 1);
        x |= 1 << i;
        let c1 = cond_exp_bits(x, i + 1);

        if c1 <= c0 {
            x &= !(1 << i);
        }
    }

    x
}

fn main() {
    let iterations = 1_000_000;

    let accuracy = (0..iterations).into_iter().fold((0, 0), |acc, _| {
        let x = if is_success(random_bits()) { 1 } else { 0 };
        let y = if is_success(derandomized_bits()) { 1 } else { 0 };
        (acc.0 + x as u32, acc.1 + y as u32)
    });

    println!("iterations = {}", iterations);
    println!("random       = {}%", accuracy.0 as f64 / iterations as f64 * 100.);
    println!("derandomized = {}%", accuracy.1 as f64 / iterations as f64 * 100.);
}
