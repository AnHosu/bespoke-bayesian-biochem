data {
  int<lower=0> N;
  vector[N] log_conc;
  vector[N] y;
}
parameters {
  real bottom;
  real<lower=bottom> top;
  real<lower=0> log_IC50;
  real<lower=0> n;
  real<lower=0> sigma;
}
model {
  vector[N] mu;
  bottom ~ normal(0, 0.05);
  top ~ normal(1, 0.05);
  log_IC50 ~ normal(0.5, 0.2);
  n ~ normal(1, 0.01);
  sigma ~ exponential(3);
  for ( i in 1:N) {
    mu[i] = top + (bottom - top)/(1 + 10^((log_IC50 - log_conc[i])*n));
  }
  y ~ normal(mu, sigma);
}
generated quantities{
  vector[N] log_liho;
  vector[N] mu;
  for ( i in 1:N) {
    mu[i] = top + (bottom - top)/(1 + 10^((log_IC50 - log_conc[i])*n));
    log_liho[i] = normal_lpdf( y[i] | mu[i], sigma );
  }
}
