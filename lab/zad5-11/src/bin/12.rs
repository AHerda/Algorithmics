use rand::prelude::*;
use rayon::prelude::*;

fn function_to_integrate(x: f64) -> f64 {
    (1. - x.powi(2)).sqrt()
}

fn test_1d_basic(n: u64) -> f64 {
    let mut rng = rand::rng();
    (0..n).into_iter().fold(0., |acc, _| {
        let x = rng.random();
        acc + function_to_integrate(x)
    }) / n as f64
}

fn test_1d_stratifiesd(n: u64, strata: usize) -> f64 {
    let mut rng = rand::rng();
    let m = (n as usize) / strata;
    let width = 1.0 / (strata as f64);
    let mut total = 0.0;
    for k in 0..strata {
        let base = (k as f64) * width;
        total += (0..m).into_iter().fold(0., |acc, _| {
            let u: f64 = rng.random_range(0.0..1.0);
            let x = base + u * width;
            acc + function_to_integrate(x)
        }) / (m as f64);
    }
    total / (strata as f64)
}

fn test_1d_antithetic(n: u64) -> f64 {
    let mut rng = rand::rng();
    (0..(n / 2)).into_iter().fold(0., |acc, _| {
        let x = rng.random();
        let y = 1. - x;
        acc + ((function_to_integrate(x) + function_to_integrate(y)) / n as f64)
    })
}

fn test_2d_basic(n: u64) -> f64 {
    let mut rng = rand::rng();
    (0..n).into_iter().fold(0., |acc, _| {
        let x: f64 = rng.random();
        let y: f64 = rng.random();
        acc + if y <= function_to_integrate(x) {
            1.
        } else {
            0.
        }
    }) / n as f64
}

fn test_2d_stratified(n: u64, strata: usize) -> f64 {
    let mut rng = rand::rng();
    let cells = strata.pow(2);
    let m = (n as usize) / cells;
    let width = 1.0 / (strata as f64);
    let mut total = 0.0;
    for i in 0..strata {
        for j in 0..strata {
            let x0 = (i as f64) * width;
            let y0 = (j as f64) * width;
            for _ in 0..m {
                let ux: f64 = rng.random();
                let uy: f64 = rng.random();
                let x = x0 + ux * width;
                let y = y0 + uy * width;
                total += if y <= function_to_integrate(x) {
                    1.
                } else {
                    0.
                } / (m as f64);
            }
        }
    }
    total / (cells as f64)
}

fn test_2d_antithetic(n: u64) -> f64 {
    let mut rng = rand::rng();
    (0..(n / 2)).into_iter().fold(0., |acc, _| {
        let x: f64 = rng.random();
        let y: f64 = rng.random();
        let x_antithetic = 1. - x;
        let y_antithetic = 1. - y;
        acc + if y <= function_to_integrate(x) {
            1.
        } else {
            0.
        } + if y_antithetic <= function_to_integrate(x_antithetic) {
            1.
        } else {
            0.
        }
    }) / (n as f64)
}

fn main() {
    let iterations = 10000;
    let n = 100_000;
    let strata = 10;
    let methods = vec![
        "1D Basic",
        "1D Stratified",
        "1D Antithetic",
        "2D Basic",
        "2D Stratified",
        "2D Antithetic",
    ];

    let results: Vec<Vec<f64>> = (0..iterations)
        .into_par_iter()
        .map(|_i| {
            // println!("Iteration: {}", _i);
            vec![
                test_1d_basic(n),
                test_1d_stratifiesd(n, strata),
                test_1d_antithetic(n),
                test_2d_basic(n),
                test_2d_stratified(n, strata),
                test_2d_antithetic(n),
            ]
        })
        .collect();

    let avgs: Vec<f64> = results
        .clone()
        .into_iter()
        .reduce(|acc, x| acc.iter().zip(x).map(|(a, b)| a + b).collect())
        .expect("Failed to reduce results")
        .iter()
        .map(|avg| avg / iterations as f64)
        .collect();
    let vars: Vec<f64> = results
        .into_iter()
        .reduce(|acc, x| {
            acc.iter()
                .zip(x)
                .zip(&avgs)
                .map(|((a, b), avg)| a + (b - avg).powi(2))
                .collect()
        })
        .expect("Failed to reduce results")
        .iter()
        .map(|var| var / (iterations as f64 - 1.))
        .collect();

    let correct_answer = std::f64::consts::PI / 4.;

    println!("\t{:=<25}RESULTS{:=<25}", "", "");
    println!(
        "\t{:5}{:^14}{:^14}{:^14}{:^14}",
        "", "Method", "Result", "Variation", "Correct answer"
    );
    let mut combined: Vec<(&str, (f64, f64))> = methods.into_iter().zip(avgs.into_iter().zip(vars)).collect();
    combined.sort_by(|(_, (_, var_a)), (_, (_, var_b))| var_a.partial_cmp(var_b).unwrap());
    for (i, (method, (avg, var))) in combined.iter().enumerate() {
        println!(
            "\t{:>2}.  {:<14}{:>14.10}{:>14.10}{:>14.10}",
            i + 1, method, avg, var, correct_answer
        );
    }
}
