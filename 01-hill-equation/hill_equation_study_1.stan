data {
  int<lower=0> N; // Number of observations
  vector[N] log_conc; // Tested concentration on log10 scale
  vector[N] y; // Normalised assay responses
}
parameters {
  real bottom;
  real<lower=bottom> top;
  real log_IC50;
  real<lower=0> nH;
  real<lower=0> sigma;
}
model {
  vector[N] mu;
  bottom ~ normal(0, 0.01);
  top ~ normal(1, 0.01);
  log_IC50 ~ normal(-6, 1.5);
  nH ~ lognormal(0, 1);
  sigma ~ exponential(10);
  for ( i in 1:N) {
    mu[i] = top + (bottom - top)/(1 + 10^((log_IC50 - log_conc[i])*nH));
  }
  y ~ normal(mu, sigma);
}
