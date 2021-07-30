data {
  int < lower =0 > N ;
  int < lower =0 > J ;
  vector [ J ] y [ N ];
  int < lower =0 > p_mu;
  int < lower =0 > p_alpha;
  int < lower =0 > p_beta;
}
parameters {
  real mu ;
  real sigma ;
}
model {
  // priors
  mu ~ normal (0 , p_mu);
  sigma  ~ gamma (p_alpha, p_beta);
  // likelihood
  for ( j in 1: J )
    y [ , j ] ~ normal ( mu  , sigma );
}
generated quantities {
  real ypred ;
  vector [J] log_lik [N];
  // Compute predictive distribution for the first machine
  ypred = normal_rng ( mu, sigma);
  for (j in 1:J){
    for (n in 1:N){
      log_lik[n,j] = normal_lpdf(y[n,j] | mu, sigma);
    }
  }
}