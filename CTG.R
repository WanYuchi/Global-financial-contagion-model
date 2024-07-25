rm(list = ls())

##############################################################################
# 1. swarch estimated probs of being high-vol. state
library(MSGARCH)

#setwd("logreturns_dataframe_file_directory")
setwd("Data/output_lgr")
temp = list.files(pattern="*.csv")
list2env(
  lapply(setNames(temp, make.names(gsub("*.csv$", "", temp))), 
         read.csv), envir = .GlobalEnv)
all_list <- lapply(temp, read.csv, sep = ",", header=T)

smo_mat <- list()

for (i in c(1:length(all_list))) {
  dt <- all_list[[i]]
  ms2.arch_std <- CreateSpec(variance.spec = list(model = c("sGARCH")), 
                             distribution.spec = list(distribution = c("std")), 
                             switch.spec = list(K=2))
  Vol.mod2 <- function (datVol) {
    fit.ml.arch_std <- FitML(spec = ms2.arch_std, data = datVol,ctr = list(do.plm=F))
    return(list(arch.scl.std = fit.ml.arch_std, state = State(fit.ml.arch_std)))
  }
  
  vol.mod <- apply(dt[,-1], 2, Vol.mod2)
  
  smo.mat <- cbind(vol.mod[[1]]$state$SmoothProb[,,2],vol.mod[[2]]$state$SmoothProb[,,2],
                   vol.mod[[3]]$state$SmoothProb[,,2],vol.mod[[4]]$state$SmoothProb[,,2])
  
  smo_mat[[i]] <- data.frame(date = dt$X,
                             stk_smo = smo.mat[-1,1],
                             gd_smo = smo.mat[-1,2],
                             frx_smo = smo.mat[-1,3],
                             bd_smo = smo.mat[-1,4])
}

##############################################################################
# 2. code for generating the ctg index (dcc model part)
library(forecast)
library(MSGARCH)
library(rmgarch)
library(tseries)

meanSpec=list(armaOrder=c(0,0),include.mean=FALSE,archpow=1)
distSpec=c("mvnorm")
varSpec=list(model="sGARCH",garchOrder=c(1,1))
spec1=ugarchspec(mean.model=meanSpec,variance.model=varSpec)

mySpec=multispec(replicate(2,spec1))
mspec=dccspec(mySpec,VAR=F,robust = F,lag=1,lag.max=NULL,lag.criterion = c("AIC"),
              external.regressors = NULL,robust.control = list(gamma=0.25,delta=0.01,nc=10,ns=500),
              dccOrder = c(1,1),model = c("aDCC"), distribution = distSpec,start.pars = list(),fixed.pars = list())

ctg_country <- list()
for (i in c(14:16)){
  ctg_index <- matrix(rep(0, 12*nrow(all_list[[i]])), nrow = nrow(all_list[[i]]))
  for (j in c(2:5)) {
    ctg <- c()
    for (k in setdiff(c(2:5),j)){
      fdcc <- dccfit(data = all_list[[i]][,c(j,k)],mspec,
                     solver = "solnp",solver.control = list(),
                     fit.control = list(eval.se=TRUE,stationary=TRUE,scale=FALSE),
                     parallel=TRUE,parallel.control=list(pkg=c("multicore"),cores=2),
                     fit=NULL,VAR.fit=NULL)
      rcc <- rcor(fdcc, type="R")
      t <- as.matrix(rcc) 
      cc <- abs(t[seq(2,nrow(t),4),1])
      ctg <- append(ctg,cc*smo_mat[[i]][,j])
    }
    ctg_index[,c(1:3)+(j-2)*3]<- ctg
  }
  ctg_country[[i]] <- ctg_index
}

setwd("../all_ctg_index_value")
for (i in c(1:length(ctg_country))) {
  aaa<-data.frame(date = all_list[[i]]$X,
                  ctg_country[[i]]) 
  names(aaa)<- c("date","sg","sf","sb", "gs", "gf","gb",
                 "fs","fg","fb", "bs","bg","bf")
  write.csv(aaa, paste0("actg_allvalue_",temp[i]))
}