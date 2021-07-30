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
  real <lower=0> theta;
  real <lower=0> sigma ;
}
model {
  // Hyperpriors
  tau ~ normal(0, p_mu);
  theta ~ gamma(p_alpha, p_beta);
  
  // Priors
  for (j in 1: J ){
    mu[ j ] ~ normal (tau, theta);
  }
  sigma ~ gamma(1,1);
  // likelihood
  for ( j in 1: J )
    y [ , j ] ~ normal ( mu [ j ] , sigma);
}
generated quantities {
  real ypred1;
  real ypred2;
  real ypred3;
  real ypred4;
  real ypred5;
  real ypred6;
  real ypred7;
  real mu_7;
  
  vector [J] log_lik [N];
  // Compute predictive distribution for the sixth machine
  ypred1 = normal_rng ( mu [1] , sigma);
  ypred2 = normal_rng ( mu [2] , sigma);
  ypred3 = normal_rng ( mu [3] , sigma);
  ypred4 = normal_rng ( mu [4] , sigma);
  ypred5 = normal_rng ( mu [5] , sigma);
  ypred6 = normal_rng ( mu [6] , sigma);
  
  mu_7 = normal_rng(tau, theta);
  ypred7 = normal_rng(mu_7, sigma);
  
  for (j in 1:J){
    for (n in 1:N){
      log_lik[n,j] = normal_lpdf(y[n,j] | mu[j], sigma);
    }
  }
}
