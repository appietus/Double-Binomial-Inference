data {
  int<lower=0> N;        // Number of observations
  int<lower=1> m;        // Number of trials (the m in the likelihood)
  array[N] real<lower=0, upper=1> y;  // Observations y_i, between 0 and 1
}

parameters {
  real<lower=0, upper=1> mu;    // Parameter mu
  real<lower=0> phi;            // Parameter phi (dispersion)
}

model {
  
  // Joint prior for mu and phi
  target += 0.5 * log(1 / (phi * mu * (1 - mu))); 

  
  for (i in 1:N) {
    real my = m * y[i];   // m * y[i]

    // Create a local variable to adjust y[i] without modifying the original y[i]
    real y_adj = y[i];

    // Adjust the value of y_adj to avoid log(0) issues
    if (y[i] == 0) {
      y_adj = 0.00001;
    }
    if (y[i] == 1) {
      y_adj = 0.99999;
    }

    // Use y_adj in the likelihood calculation instead of y[i]
    target += 0.5 * log(phi) + 
              lgamma(m + 1) - lgamma(my + 1) - lgamma(m - my + 1) + 
              my * log(y_adj) + (m - my) * log(1 - y_adj) +
              phi * (my * log(mu / y_adj) + (m - my) * log((1 - mu) / (1 - y_adj)));
  }
}
