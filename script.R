library(sdcMicro)
library(BBmisc)

data(CASCrefmicrodata)
casc <- CASCrefmicrodata
cascCols <- colnames(casc)


# Rank swap
casc.rs0.01 <- rankSwap(casc,variables=cascCols,
                        TopPercent=0,BottomPercent=0,P=0.01)
casc.rs0.02<- rankSwap(casc,variables=cascCols,
                       TopPercent=0,BottomPercent=0,P=0.02)
casc.rs0.03 <- rankSwap(casc,variables=cascCols,
                        TopPercent=0,BottomPercent=0,P=0.03)
casc.rs0.04 <- rankSwap(casc,variables=cascCols,
                        TopPercent=0,BottomPercent=0,P=0.04)
casc.rs0.05 <- rankSwap(casc,variables=cascCols,
                        TopPercent=0,BottomPercent=0,P=0.05)

# Scatter plot all pairs of cols
pairs(~AFNLWGT+AGI+EMCONTRB+FEDTAX+PTOTVAL+STATETAX+TAXINC+POTHVAL+INTVAL+PEARNVAL+FICA+WSALVAL+ERNVAL,data=casc,main="Scatterplot matrix")

## Plot AGI, orig vs masked
par(mfrow=c(2,4))
plot(cbind(casc$AGI,casc.rs0.01$AGI),
     ylim=c(min(casc$AGI),max(casc$AGI)),
     xlim=c(min(casc$AGI),max(casc$AGI)),
     xlab="Original", ylab="Masked", main="Rank Swapping AGI P=0.01")

plot(cbind(casc$AGI,casc.rs0.02$AGI),
     ylim=c(min(casc$AGI),max(casc$AGI)),
     xlim=c(min(casc$AGI),max(casc$AGI)),
     xlab="Original", ylab="Masked", main="Rank Swapping AGI P=0.02")

plot(cbind(casc$AGI,casc.rs0.03$AGI),
     ylim=c(min(casc$AGI),max(casc$AGI)),
     xlim=c(min(casc$AGI),max(casc$AGI)),
     xlab="Original", ylab="Masked", main="Rank Swapping AGI P=0.03")

plot(cbind(casc$AGI,casc.rs0.04$AGI),
     ylim=c(min(casc$AGI),max(casc$AGI)),
     xlim=c(min(casc$AGI),max(casc$AGI)),
     xlab="Original", ylab="Masked", main="Rank Swapping AGI P=0.04")

plot(cbind(casc$AGI,casc.rs0.05$AGI),
     ylim=c(min(casc$AGI),max(casc$AGI)),
     xlim=c(min(casc$AGI),max(casc$AGI)),
     xlab="Original", ylab="Masked", main="Rank Swapping AGI P=0.05")

dRisk.01 <- dRisk(obj=casc, xm=casc.rs0.01)
dRisk.02 <- dRisk(obj=casc, xm=casc.rs0.02)
dRisk.03 <- dRisk(obj=casc, xm=casc.rs0.03)
dRisk.04 <- dRisk(obj=casc, xm=casc.rs0.04)
dRisk.05 <- dRisk(obj=casc, xm=casc.rs0.05)

plot(cbind(c(1,2,3,4,5),
           c(dRisk.01,
             dRisk.02,
             dRisk.03,
             dRisk.04,
             dRisk.05)),
     ylim=c(0,1),xlab="P", ylab="dRisk", main="rank swapping dRisk")



dUtility.01 <- dUtility(obj=casc, xm=casc.rs0.01)
dUtility.02 <- dUtility(obj=casc, xm=casc.rs0.02)
dUtility.03 <- dUtility(obj=casc, xm=casc.rs0.03)
dUtility.04 <- dUtility(obj=casc, xm=casc.rs0.04)
dUtility.05 <- dUtility(obj=casc, xm=casc.rs0.05)

plot(cbind(c(1,2,3,4,5),
           c(dUtility.01,
             dUtility.02,
             dUtility.03,
             dUtility.04,
             dUtility.05)),
        ylim=c(0,2000),xlab="P", ylab="dUtility", main="rank swapping dRisk")


## RU map disclosure risk and data utility
plot(cbind(c(dRisk.01,
             dRisk.02,
             dRisk.03,
             dRisk.04,
             dRisk.05),
           c(dUtility.01,
             dUtility.02,
             dUtility.03,
             dUtility.04,
             dUtility.05)),           
     xlim=c(0,1),
     xlab="dRisk", ylab="dUtility",
     main="Microaggregation individual ranking dRisk(k)")




