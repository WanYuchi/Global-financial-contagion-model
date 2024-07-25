rm(list = ls())
# install.packages("BGGM")
library("BGGM")
library(readxl)
library(lubridate)

############################################################################
# 2013-01-01 to 2023-06-01 phase 1 to 5

market = c('composite','bond', 'forex', 'stock', 'gold')
#mkt = 'composite'

for (mkt in market){
  c=read.csv(paste0("Data/summed_ctg_index/",mkt,"_Market.csv"))
  c$date <- as.Date(c$date)
  
  critical_date=c('2013-01-01','2014-10-30','2015-12-17','2019-08-01','2021-11-04','2023-06-01') #('2013-01-01','2017-06-15','2019-08-01','2020-03-16','2022-03-17','2023-06-01')
  ranges = list()
  
  for(i in 1:(length(critical_date)-1)){
    ranges[[i]] = (c$date >= critical_date[i] & c$date < critical_date[i+1])
    temp=c[ranges[[i]],]
    fit <- estimate(temp[,2:17], type = "continuous")
    E <- select(fit,
                cred = 0.9,
                alternative = "two.sided")
    #plot(E, edge_magnify = 10)
    #summary(fit)
    #plot(summary(fit,cred = 0.9))
    pcorr=E$pcor_adj #apply(fit$post_samp$pcors, MARGIN=c(1,2), FUN=mean) #E$pcor_adj
    data <- as.data.frame(pcorr)
    colnames(data) <- colnames(c)[2:17]
    write.csv(data, file=paste0("Data/BGGM/pcorr_",mkt,"/pcorr_", i, ".csv"), row.names = colnames(c)[2:17])
  }
}

