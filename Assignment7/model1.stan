data {
  int < lower =0 > N ; // number of data points
  vector [ N ] x ;
  // observation year
  vector [ N ] y ;
  // observation number of drowned
  real xpred ;
  // prediction year
  real pmualpha;  // prior mean for alpha
  real psalpha;   // prior std for alpha
  real pmubeta;   // prior mean for beta
  real psbeta;    // prior std for beta
}
parameters {
  real alpha ;
  real beta ;
  real < lower =0 > sigma ;
}
transformed parameters {
  vector [ N ] mu = alpha + beta * x ;
}
model {
  alpha ~ normal(pmualpha, psalpha);  // prior
  beta ~ normal(pmubeta, psbeta); // prior
  y ~ normal ( mu , sigma );
}
generated quantities {
  real ypred = normal_rng ( alpha+beta*xpred, sigma );
}