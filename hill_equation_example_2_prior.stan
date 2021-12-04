functions {
  real normal_lower_rng(real mu, real sigma, real lower_bound) {
    real p_lower_bound = normal_cdf(lower_bound, mu, sigma);
    real u = uniform_rng(p_lower_bound, 1);
    real y = mu + sigma * inv_Phi(u);
    return y;
  }
  
  real normal_upper_rng(real mu, real sigma, real upper_bound) {
    real p_upper_bound = normal_cdf(upper_bound, mu, sigma);
    real u = uniform_rng(0, p_upper_bound);
    real y = mu + sigma * inv_Phi(u);
    return y;
  }
}

data {
  int<lower=0> N;
  vector[N] log_conc;
}
generated quantities{
  real<lower = 0> nH = normal_lower_rng(1, 0.01, 0);
  real top = normal_rng(1, 0.05);
  real bottom = normal_upper_rng(0, 0.5, top);
  real log_IC50 = normal_rng(-6, 1.5);
  real sigma = exponential_rng(10);
  vector[N] mu;
  vector[N] y;
  for ( i in 1:N) {
    mu[i] = top + (bottom - top)/(1 + 10^((log_IC50 - log_conc[i])*nH));
    y[i] = normal_rng(mu[i], sigma);
  }
}
