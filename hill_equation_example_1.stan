data {
  int<lower=0> N;
  vector[N] log_conc;
  vector[N] y;
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
  bottom ~ normal(0, 0.05);
  top ~ normal(1, 0.01);
  log_IC50 ~ normal(-6, 1.5);
  nH ~ normal(1, 0.5);
  sigma ~ exponential(10);
  for ( i in 1:N) {
    mu[i] = top + (bottom - top)/(1 + 10^((log_IC50 - log_conc[i])*nH));
  }
  y ~ normal(mu, sigma);
}
generated quantities{
  vector[N] log_likelihood;
  vector[N] mu;
  for ( i in 1:N) {
    mu[i] = top + (bottom - top)/(1 + 10^((log_IC50 - log_conc[i])*nH));
    log_likelihood[i] = normal_lpdf( y[i] | mu[i], sigma );
  }
}
