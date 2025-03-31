fn main() {
    let coefficients = vec![1.0, -3.0, 2.0];
    let x = 2_f64;
    let result = horner(&coefficients, x);
    println!("The result of the polynomial evaluation is: {}", result);
}

fn horner(coefficients: &[f64], x: f64) -> f64 {
    let mut result = coefficients[0];

    for &coeff in &coefficients[1..] {
        result = result * x + coeff;
    }

    result
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_horner() {
        let coefficients = vec![1.0, -3.0, 2.0];

        for x in -10..=10 {
            let x = x as f64;
            let result = horner(&coefficients, x);
            assert_eq!(result, (x - 1.0) * (x - 2.0)); // The polynomial is (x - 1)(x - 2)
        }
    }

    #[test]
    fn test_horner_negative() {
        let coefficients = vec![1.0, 3.0, 2.0]; // Coefficients for x^2 + 3x + 2 = (x + 1)(x + 2)

        for x in -10..=10 {
            let x = x as f64;
            let result = horner(&coefficients, x);
            assert_eq!(result, (x + 1.0) * (x + 2.0)); // The polynomial is (x + 1)(x + 2)
        }
    }

    #[test]
    fn test_horner_zero() {
        let coefficients = vec![0.0, 0.0, 0.0]; // Coefficients for 0

        for x in -10..=10 {
            let x = x as f64;
            let result = horner(&coefficients, x);
            assert_eq!(result, 0.0); // The polynomial is always 0
        }
    }

    fn polynomial(x: f64) -> f64 {
        (x - 5.0) * (x + 7.0) * (x - 8.5) * (x + 0.5)
    }

    #[test]
    fn test_horner1() {
        let coefficients = vec![1.0, -6.0, -55.25, 271.5, 148.75]; // Coefficients for (x - 5)(x + 7)(x - 8.5)(x + 0.5) checked in wolfram alpha

        for x in -10..=10 {
            let x = x as f64;
            let result = horner(&coefficients, x);
            assert_eq!(result, polynomial(x), "x = {x}"); // The polynomial is (x - 5)(x + 7)(x - 8.5)(x + 0.5)
        }
    }
}
