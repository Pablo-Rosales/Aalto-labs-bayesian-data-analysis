data {
  int < lower =0 > N ;
  int < lower =0 > J ;
  vector [ J ] y [ N ];
  int < lower =0 > p_mu;
  int < lower =0 > p_alpha;
  int < lower =0 > p_beta;
}
parameters {
  vector [ J ] mu ;
  real tau;
  real theta;
  real sigma ;
}
model {
  // Hyperpriors
  tau ~ normal(0, p_mu);
  theta ~ gamma(p_alpha, p_beta);
  
  // Priors
  for (j in 1: J ){
    mu[ j ] ~ normal (0, tau);
  }
  sigma ~ inv_chi_square (theta);
  // likelihood
  for ( j in 1: J )
    y [ , j ] ~ normal ( mu [ j ] , sigma);
}
generated quantities {
  real ypred ;
  // Compute predictive distribution for the sixth machine
  ypred = normal_rng ( mu [6] , sigma);
}