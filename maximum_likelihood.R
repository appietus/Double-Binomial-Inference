library(maxLik)
dbn<-function(param){
  mu<-param[1]
  phi<-param[2]
  fxn<-rep(NA, length(y))
  for ( i in 1:length(y)){
    if (y[i]==0 || y[i]==1) {fxn[i]<-0}
    else {fxn[i]=y[i]*log(y[i])+(1-y[i])*log(1-y[i])}}
  logL<-log(phi)/2+m*phi*y*log(mu)+m*phi*(1-y)*log(1-mu)-m*phi*fxn
  return(logL)}
mle<-maxLik(logLik=dbn, start=c(mu=0.50, phi=0.1))

summary(mle)
