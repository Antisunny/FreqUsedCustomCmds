#Plot Volcano Plot using R packages

## Using `ggplot`
```R
> setwd("Edge/")
> h010 <- read.table("h010-dge/output_score.txt",header=FALSE,sep="\t",skip=1)[,c(1,4,5,7,8,9,10)]
> head(h010)
                V1         V4         V5            V7            V8            V9  V10
1 LOC_Os01g57968.1  0.4527314  0.4240027  0.000000e+00  0.000000e+00  0.000000e+00 TRUE
2 LOC_Os12g19381.1  1.8958151  1.8670863 9.629733e-281 1.964080e-276 1.964080e-276 TRUE
3 LOC_Os01g57958.1  1.8112020  1.7824733 1.157053e-262 1.573284e-258 1.573284e-258 TRUE
4 LOC_Os01g10400.2 -1.3763887 -1.4051175 2.166896e-258 2.209801e-254 2.209801e-254 TRUE
5 LOC_Os12g17600.2  3.4803817  3.4516530 7.693477e-200 6.276647e-196 6.276647e-196 TRUE
6 LOC_Os07g34570.1 -2.6038590 -2.6325878 5.179950e-198 3.521675e-194 3.521675e-194 TRUE
> names(h010) <- c("gname","log2fc","log2fcn","pValue","qValueB","qValueS","sig")
> head(h010)
             gname     log2fc    log2fcn        pValue       qValueB       qValueS  sig
1 LOC_Os01g57968.1  0.4527314  0.4240027  0.000000e+00  0.000000e+00  0.000000e+00 TRUE
2 LOC_Os12g19381.1  1.8958151  1.8670863 9.629733e-281 1.964080e-276 1.964080e-276 TRUE
3 LOC_Os01g57958.1  1.8112020  1.7824733 1.157053e-262 1.573284e-258 1.573284e-258 TRUE
4 LOC_Os01g10400.2 -1.3763887 -1.4051175 2.166896e-258 2.209801e-254 2.209801e-254 TRUE
5 LOC_Os12g17600.2  3.4803817  3.4516530 7.693477e-200 6.276647e-196 6.276647e-196 TRUE
6 LOC_Os07g34570.1 -2.6038590 -2.6325878 5.179950e-198 3.521675e-194 3.521675e-194 TRUE
> col.h010 <- ifelse(h010[,5] < 0.01 & h010[,2] > 1,"Up",ifelse(h010[,5] < 0.01 & h010[,2] < -1,"Down", "Not"))
> h010 <- data.frame(h010,color=col.h010)
> library("ggplot2")
> all.reads <- read.table("merged_count.txt",sep="\t")
> head(all.reads)
                V1   V2        V3   V4        V5  V6        V7  V8        V9
1 LOC_Os01g01010.1 1350 7.4589000 1053 7.1572400 502 6.0103100 429 5.6037200
2 LOC_Os01g01010.2  963 7.2373700  783 7.2392400 285 4.6414300 298 5.2948000
3 LOC_Os01g01019.1    5 0.0739541    4 0.0727828   2 0.0641024   0 0.0000000
4 LOC_Os01g01030.1   82 0.5547400   16 0.1331590  37 0.5424120   6 0.0959633
5 LOC_Os01g01040.1 1194 7.9358400  723 5.9115800 365 5.2569500 480 7.5423800
6 LOC_Os01g01040.2 1123 7.5421300  695 5.7421700 358 5.2101400 457 7.2561900
> head(all.reads[h010[,1],c(3,5,7,9)])
             V3         V5        V7         V9
6049  40045.400 29259.5000 29612.800 21992.8000
63583  2945.400   791.4930  1681.090   321.2640
6044   2934.420   836.1730  4937.470   736.4770
1095   1536.490  3989.0000  2671.040  1840.4200
63398  1061.250    95.0864   581.074    23.5786
42237   219.353  1333.4700   203.773   636.3810
> h010_new <- data.frame(h010,rpkm.h0=all.reads[h010[,1],3],rpkm.h10=all.reads[h010[,1],5])
> head(h010_new)
             gname     log2fc    log2fcn        pValue       qValueB       qValueS  sig color   rpkm.h0   rpkm.h10
1 LOC_Os01g57968.1  0.4527314  0.4240027  0.000000e+00  0.000000e+00  0.000000e+00 TRUE   Not 40045.400 29259.5000
2 LOC_Os12g19381.1  1.8958151  1.8670863 9.629733e-281 1.964080e-276 1.964080e-276 TRUE    Up  2945.400   791.4930
3 LOC_Os01g57958.1  1.8112020  1.7824733 1.157053e-262 1.573284e-258 1.573284e-258 TRUE    Up  2934.420   836.1730
4 LOC_Os01g10400.2 -1.3763887 -1.4051175 2.166896e-258 2.209801e-254 2.209801e-254 TRUE  Down  1536.490  3989.0000
5 LOC_Os12g17600.2  3.4803817  3.4516530 7.693477e-200 6.276647e-196 6.276647e-196 TRUE    Up  1061.250    95.0864
6 LOC_Os07g34570.1 -2.6038590 -2.6325878 5.179950e-198 3.521675e-194 3.521675e-194 TRUE  Down   219.353  1333.4700
# scatter plot w/  log to xy
> ggplot(data=h010_new,aes(x=log(rpkm.h0,base=2),y=log(rpkm.h10,base=2),color=color)) + geom_point(alpha=0.9,size=1,na.rm=TRUE) + xlim(c(-8,15)) + ylim(c(-8,15)) + xlab("log2(h2o-0D(RPKM))") + ylab("log2(h2o-10D(RPKM))")
> ggplot(data=h010_new,aes(x=log2fc,y=-log(qValueB,base=10),colour=color)) + geom_point(alpha=0.9,size=1,na.rm=TRUE) + xlab("log2(FC)") + ylab("-log10(q-value)") + ggtitle("h2o-0D v.s. h2o-10D") + ylim(0,30)
> h010_r2 <- lm(h0r~h10r,data=all.reads)
> summary(h010_r2)$r.squared
[1] 0.9423933
> h010_r <- lm(V2~V3,data=aaa)
> summary(h010_r)$r.squared
[1] 0.9561629
```
![scatter plot](./scatter_plot_1.tiff)
![volcano plot](volcano_plot_1.tiff)

