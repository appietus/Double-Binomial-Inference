## Inference on the Double Binomial Distribution
This repository contains all the code, data and R scripts for the *Communications in Statistics: Theory and Methods* manuscript titled "Inference on the Double Binomial Distribution" by J. Appiah Kubi, D.D. Bowman and E.O Olusegun. 
The following R scripts are included in this repository for more specific details on implementing the code for the respective sections.



### generate_dataset.R
This contains the R script for generating a dataset based on the double binomial distribution for a single value of `m`, using user-defined parameters for the mean (`mu`) and the dispersion parameter (`phi`). 

For the parameter initialization: 
- `mu`: Represents the mean (between 0 and 1), set to 0.35 but can be adjusted as desired; 
- `phi`: The dispersion parameter (> 0), set to 0.07 but can be adjusted as desired; 
- `m`: Number of trials (positive integer) in the double binomial distribution, which can be adjusted as desired (default: `m = 100`).

The function `db()` calculates the double binomial probability distribution for each possible outcome (`y`) based on the specified parameters `m`, `mu`, and `phi`. This function returns the probability of each outcome happening in the experiment. The `cdf()` function converts uniformly generated random numbers into corresponding values from the double binomial distribution. This process simulates random outcomes by calculating cumulative probabilities.

The `generate_data()` function generates a dataset of `N = 1000` values based on the double binomial distribution for a single value of `m`. It draws samples from the distribution using the CDF. By changing the value of `m` (e.g., setting it to `50` or `10`), users can explore how different numbers of trials impact the distribution.




### maximum_likelihood.R
This contains the R code that performs Maximum Likelihood Estimation (MLE) on a dataset generated from a Double Binomial distribution using the `maxLik` package. The `maxLik` package is a set of functions and tools used to perform Maximum Likelihood (ML) estimation. The goal is to estimate the parameters `mu` (mean) and `phi` (dispersion) by maximizing the likelihood function. Given a log-likelihood function and a vector of parameters' starting values, it returns an object of class `maxLik` based on optimization methods.

This R (`R Core Team, 2023`) script is for the computation of the MLEs for the Double Binomial distribution. The dataset `y` represents the data for the MLE process. You can use the dataset generated from the previous R script (`generate_dataset.R`) as your dataset. For instance, the dataset `y` is generated using the double binomial simulation for a single value of `m` (e.g., `m = 100`). This dataset serves as the input for the MLE process.

This contains the R code that performs Maximum Likelihood Estimation (MLE) on a dataset generated from a Double Binomial distribution using the maxLik package. The maxLik-package is a set of functions and tools used to perform Maximum Likelihood(ML) estimation. The goal is to estimate the parameters mu (mean) and phi (dispersion) by maximizing the likelihood function. Given a log-likelihood function and a vector of parameters’starting values, it returns an object of class ’maxLik’ based on optimization methods. This R(R Core Team, 2023) script is for the computation of the MLEs for the Double Binomial distribution. The dataset y represents the data for the MLE process. You can use the dataset generated from the previous R script (generate_dataset.R) as your dataset. For instance, the dataset y is generated using the double binomial simulation for a single value of m (e.g., m = 100). This dataset serves as the input for the MLE process.



### stan_model.R
This is R script containing the R Stan code. It uses the Stan library to fit the Double Binomial model based on the stan file ("double_binomial.stan"). We create the data_list consisting of the number of observations, N; the observed data, y (proportion between 0 and 1); and the number of trials, m (positive integer). The stan function runs the model that has been specified in the stan file ("double_binomial.stan"). We set the total number of iterations, iter to 110,000 with 1000 iterations that will be discarded as warmup and a thinning interval of 10 to minimize autocorrelation. The number of chains used for the sampling was set to 2.



### Gibbs_sampler.R
This R scripts performs Bayesian estimation of the two parameters:mu, the mean parameter, and phi, the dispersion parameter using the Gibbs sampling approach for the Double Binomial model. The data, y, is generated from the R script (generate_dataset.R). Observations of 0 and 1 are adjusted to avoid computational issues of log(0). Iteratively samples from the conditional distributions of mu and phi. mu is updated using the Beta distribution and the phi is updated using the Gamma distribution. The code runs for 110,000 iterations and a burn-in period of 10,000. After running the code, mu and phi will contain the posterior samples after burn-in and thinning, for the mean parameter and the dispersion parameter respectively . 





### double_binomial.stan
This file implements the double binomial model in Stan for Bayesian inference. The model aims to estimate the two parameters: mu, the mean parameter, and phi, the dispersion parameter.The model is designed for a dataset with N:number of observations, m: number of trials (positive integer), and y: array of observations where each element is a proportion between 0 and 1. Adjustments are made to observations that are exactly 0 and 1 to avoid running into numerical issues in the computation of log(0).

