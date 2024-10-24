library(rstan)
# Create a list for Stan
data_list <- list(
  N = length(y),
  y = y,
  m = m
)

# Fit the model using Stan
fit <- stan(
  file = 'double_binomial.stan',  # Stan model file
  data = data_list,                # Data list
  iter = 110000,                   # Total number of iterations
  warmup = 10000,                  # Number of warmup iterations
  thin = 10,                       # Thinning interval
  chains = 2                       # Number of chains
)

# Print the results
print(fit)
