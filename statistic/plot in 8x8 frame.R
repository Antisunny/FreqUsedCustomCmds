#plot in 8x8 frame
getwd()
all <- read.table("f2_gen_5.11.csv",header=TRUE,sep=",")
head(all)
all <-  all[,c(1,2,4,5,6)]

size <- dim(all)[1]
par(mfrow=c(4,8),mar=c(1,1,1,1))
a <- 0
require(graphics)

while(a< 32){
	a <- a+1
	this.pan <- all[all[,1]==a,]
	this.pan.clean <- this.pan[!is.na(this.pan[,5]),]
	lists <- c()
	for (day in seq(from=23,to=50)){
		count <- dim(this.pan.clean[this.pan.clean[,5]==day,])[1]
		lists <- cbind(lists, count)
	}
	# for the pie plot
	# got <- dim(this.pan[!is.na(this.pan[,2]),])[1]/dim(this.pan)[1]
	# not.got <- 1 - got
	# lists.p <- c(got,not.got)
	# names(lists.p) <- c(">1cm","<1cm")
	# pie(abs(lists.p), edges=200, radius=1.0, col=c('blue','gray'))
	# days+count
	start <- 23 + min(which(lists != 0)) -1
	barplot(lists[seq(from=min(which(lists != 0)),to=28)],names.arg=seq(from=start,to=50))
	lines(lowess(lists[seq(from=min(which(lists != 0)),to=28)]), col="red")
}

# 所有数据的一个整图
# for (day in seq(from=23,to=50)){
# 		count <- dim(all[all[,5]==day,])[1]
# 		lists <- cbind(lists, count)
# }
# start <- 23 + min(which(lists != 0)) - 1
# end <- 23 + max(which(lists != 0)) -1
# barplot(lists[seq(from=start-22,to=end-22)],names.arg=seq(from=start,to=end))
# lines(lowess(lists[seq(from=start-22,to=end-22)]), col="red")