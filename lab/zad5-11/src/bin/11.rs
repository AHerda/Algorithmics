use rand::prelude::*;
use rayon::prelude::*;
use std::sync::{Arc, Mutex};

fn main() {
    println!("Hello World!");
    let ns = vec![10, 100, 1000, 10000, 100000, 1000000, 10000000];
    let mut results = Arc::new(Mutex::new(vec![0_f64; ns.len()]));
    ns.par_iter().enumerate().for_each(|(i, &n)| {
        println!("Monte Carlo for n = {}", n);
        let result = (0..n)
            .into_par_iter()
            .map(|_| {
                let x = rand::random::<f64>() * std::f64::consts::PI;
                let y = rand::random::<f64>();
                if y <= x.sin() {
                    return 1;
                }
                0
            })
            .sum::<u128>() as f64 / n as f64 * std::f64::consts::PI;
        results.clone().lock().expect("Something went wrong with the mutex!!")[i] = result;
    });
    println!("Result:");
    println!("\t{:^10}{:^23}{:^23}", "n", "result", "err");
    for (i, n) in ns.iter().enumerate() {
        let result = results.clone().lock().expect("Soemething wrong with mutex!!")[i];
        println!("\t{:<10}{:<23?}{:<23}", n, result, (2.-result).abs());
    }
}
