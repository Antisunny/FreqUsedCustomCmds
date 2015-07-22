setwd("Edge/")
h010 <- read.table("h010-dge/output_score.txt",header=FALSE,sep="\t",skip=1)[,c(1,4,5,7,8,9,10)]
head(h010)
names(h010) <- c("gname","log2fc","log2fcn","pValue","qValueB","qValueS","sig")
head(h010)
col.h010 <- ifelse(h010[,5] < 0.01 & h010[,2] > 1,"Up",ifelse(h010[,5] < 0.01 & h010[,2] < -1,"Down", "Not"))
h010 <- data.frame(h010,color=col.h010)
library("ggplot2")
all.reads <- read.table("merged_count.txt",sep="\t")
head(all.reads)
head(all.reads[h010[,1],c(3,5,7,9)])
h010_new <- data.frame(h010,rpkm.h0=all.reads[h010[,1],3],rpkm.h10=all.reads[h010[,1],5])
head(h010_new)
# scatter plot w/  log to xy
ggplot(data=h010_new,aes(x=log(rpkm.h0,base=2),y=log(rpkm.h10,base=2),color=color)) + geom_point(alpha=0.9,size=1,na.rm=TRUE) + xlim(c(-8,15)) + ylim(c(-8,15)) + xlab("log2(h2o-0D(RPKM))") + ylab("log2(h2o-10D(RPKM))")
ggplot(data=h010_new,aes(x=log2fc,y=-log(qValueB,base=10),colour=color)) + geom_point(alpha=0.9,size=1,na.rm=TRUE) + xlab("log2(FC)") + ylab("-log10(q-value)") + ggtitle("h2o-0D v.s. h2o-10D") + ylim(0,30)
h010_r2 <- lm(h0r~h10r,data=all.reads)
summary(h010_r2)$r.squared
h010_r <- lm(V2~V3,data=aaa)
summary(h010_r)$r.squared