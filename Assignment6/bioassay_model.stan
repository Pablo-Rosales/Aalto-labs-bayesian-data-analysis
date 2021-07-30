data {
  int N;
  vector[N] x; // doses for each observation
  int n[N]; // animals for each observation
  int y[N]; // deaths for each observation
}
parameters {
  vector[2] theta;
}
model {
  // model block creates the log density to be sampled
  vector[2] nu;
  matrix[2,2] Sigma;
  vector[N] p;
  nu[1] = 0;
  nu[2] = 10;
  Sigma[1,1] = 4;
  Sigma[1,2] = 10;
  Sigma[2,1] = 10;
  Sigma[2,2] = 100;
  p = inv_logit(theta[1] + theta[2] * x);
  
  theta ~ multi_normal(nu, Sigma);
  for (i in 1:N) {
    
    y[i] ~ binomial_logit(n[i], p[i]);
  }
  // y ~ binomial_logit(n, theta);
}
