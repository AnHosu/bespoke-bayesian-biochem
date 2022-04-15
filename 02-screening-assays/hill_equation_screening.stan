data {
  int<lower=0> N;
  int<lower=0> M;
  int<lower=0> curve_ind[N];
  vector[N] log_conc;
  vector[N] y;
}

parameters {
  real top;
  vector<upper=top>[M] bottom;
  vector[M] log_IC50;
  real<lower=0> nH;
  real<lower=0> sigma;
  
}

model {
  vector[N] mu;
  bottom ~ normal(0.25, 0.25);
  top ~ normal(1, 0.01);
  log_IC50 ~ normal(-6, 1.5);
  nH ~ normal(1, 0.01);
  sigma ~ exponential(10);
  for ( i in 1:N ) {
    mu[i] = top + (bottom[curve_ind[i]] - top) 
                  / (1 + 10^((log_IC50[curve_ind[i]] - log_conc[i])*nH));
  }
  y ~ normal(mu, sigma);
}

generated quantities {
  vector[N] mu;
  vector[N] y_sampled;
  for ( i in 1:N ) {
    mu[i] = top + (bottom[curve_ind[i]] - top) 
                  / (1 + 10^((log_IC50[curve_ind[i]] - log_conc[i])*nH));
    y_sampled[i] = normal_rng(mu[i], sigma);
  }
}

