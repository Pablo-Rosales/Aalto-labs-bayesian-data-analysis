data {
  int < lower =0 > N ;
  int < lower =0 > J ;
  vector [ J ] y [ N ];
  int p_mu;
  int < lower =0 > p_alpha;
  int < lower =0 > p_beta;
}
parameters {
  vector [ J ] mu ;
  vector < lower =0 >[ J ] sigma ;
}
model {
  // priors
  for ( j in 1: J ){
    mu [ j ] ~ normal (0 , p_mu);
    sigma [ j ] ~ gamma (p_alpha, p_beta);
  }
  // likelihood
  for ( j in 1: J )
    y [ , j ] ~ normal ( mu [ j ] , sigma [ j ]);
}
generated quantities {
  real ypred ;
  // Compute predictive distribution for the first machine
  ypred = normal_rng ( mu [6] , sigma [6]);
}