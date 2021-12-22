functions {
  real normal_lower_rng(real mu, real sigma, real lower_bound) {
    real p_lower_bound = normal_cdf(lower_bound, mu, sigma);
    real u = uniform_rng(p_lower_bound, 1);
    real y = inv_Phi(u)*sigma + mu;
    return y;
  }
}
data {
  int<lower=0> N;
  vector[N] log_conc;
}
generated quantities{
  real n = normal_lower_rng(1, 0.5, 0);
  real bottom = normal_rng(0, 0.05);
  real top = normal_rng(1, 0.01);
  real log_IC50 = normal_rng(-6, 1.5);
  real sigma = exponential_rng(10);
  vector[N] mu;
  vector[N] y;
  for ( i in 1:N) {
    mu[i] = top + (bottom - top)/(1 + 10^((log_IC50 - log_conc[i])*n));
    y[i] = normal_rng(mu[i], sigma);
  }
}
