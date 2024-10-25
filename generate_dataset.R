rm(list = ls())

# Set fixed parameters
mu <- 0.35
phi <- 0.65

# Choose a single value of m
m <- 100  # You can set this to any other single value, e.g., m = 50 or m = 10

# Function to calculate the double binomial distribution
db <- function(m, y, mu, phi) {
  sqrt(phi) * choose(m, m * y) * y^(m * y) * (1 - y)^(m - m * y) * 
    (mu / y)^(m * y * phi) * ((1 - mu) / (1 - y))^(m * phi - m * phi * y)
}

# Function to calculate the cumulative distribution
cdf <- function(U, p, m) {
  if (U <= p[1]) {
    return(0)
  }
  for (k in 2:length(p)) {
    if (sum(p[1:(k - 1)]) < U && U <= sum(p[1:k])) {
      return((k - 1) / m)
    }
  }
}

# Function to generate data for a single m value
generate_data <- function(m) {
  y <- (0:m) / m
  p <- db(m, y, mu, phi)  # Calculate the double binomial distribution
  set.seed(1984)
  N <- 1000
  uni <- runif(N)  # Generate uniform random numbers
  Y <- NULL
  for (g in 1:N) {
    Y <- c(Y, cdf(uni[g], p, m))  # Pass p and m to cdf
  }
  return(Y)
}

# Generate dataset for the chosen m value
dataset <- generate_data(m)


