data {
  int < lower =0 > N ;
  int < lower =0 > J ;
  vector [ J ] y [ N ];
  real < lower =0 > p_mu;
  int < lower =0 > p_sigma;
}
parameters {
  vector [ J ] mu ;
  vector < lower =0 >[ J ] sigma ;
}
model {
  // priors
  for ( j in 1: J ){
    mu [ j ] ~ normal (0 , p_mu);
    sigma [ j ] ~ inv_chi_square (p_sigma);
  }
  // likelihood
  for ( j in 1: J )
    y [ , j ] ~ normal ( mu [ j ] , sigma [ j ]);
}
generated quantities {
real ypred ;
  // Compute predictive distribution for the first machine
  ypred = normal_rng ( mu [1] , sigma [1]);
}