y<-dataset ##generated from the "generate_dataset.R" script
N<-length(y)
for ( i in 1:length(y)){
  if (y[i]==0) {y[i]<-0.00001}
  if(y[i]==1) {y[i]<-0.99999}
}
a.s<-m*sum(y*log(y))
b.s<-m*sum(y)
c.s<-m*sum((1-y)*log(1-y))
d.s<-m*sum(1-y)
mu<- rep(NA, 110000)
phi<- rep(NA, 110000)
T <- 10000    # burnin
phi[1] <- 0.10 # initialisation
for(i in 2:110000) {  
  mu[i]  <- rbeta(n=1,shape1=m*sum(y)*phi[i-1]+0.5,shape2=m*sum(1-y)*phi[i-1]+0.5)    
  phi[i] <- rgamma(n=1,shape=(N+1)/2,scale=1/(a.s-b.s*log(mu[i])+c.s-d.s*log(1-mu[i])))
}
mu<-mu[-(1:T)]
phi<-phi[-(1:T)]
thin_indx<-seq(from=10,100000,by=10)
mu<-mu[thin_indx]
phi<-phi[thin_indx]

