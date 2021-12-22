functions {
  // A lower-bounded normal distribution random number generator
  real normal_lower_rng(real mu, real sigma, real lower_bound) {
    // Locate the lower bound
    real p_lower_bound = normal_cdf(lower_bound, mu, sigma);
    // Uniformly sample probabilities in the bounded range
    real u = uniform_rng(p_lower_bound, 1);
    // Transform back to a normal distribution
    real y = mu + sigma * inv_Phi(u);
    return y;
  }
  // An upper-bounded normal distribution random number generator
  real normal_upper_rng(real mu, real sigma, real upper_bound) {
    // Locate the upper bound
    real p_upper_bound = normal_cdf(upper_bound, mu, sigma);
    // Uniformly sample probabilities in the bounded range
    real u = uniform_rng(0, p_upper_bound);
    // Transform back to a normal distribution
    real y = mu + sigma * inv_Phi(u);
    return y;
  }
}
data {
  int<lower=0> N; // Number of samples
  vector[N] log_conc; // Tested concentration on log10 scale
}
generated quantities{
  real<lower = 0> nH = normal_lower_rng(1, 0.01, 0);
  real top = normal_rng(1, 0.01);
  real bottom = normal_upper_rng(0.25, 0.25, top);
  real log_IC50 = normal_rng(-6, 0.7);
  real sigma = exponential_rng(10);
  vector[N] mu;
  vector[N] y;
  for ( i in 1:N) {
    mu[i] = top + (bottom - top)/(1 + 10^((log_IC50 - log_conc[i])*nH));
    y[i] = normal_rng(mu[i], sigma);
  }
}
