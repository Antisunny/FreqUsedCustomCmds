getwd()
all <- read.table("f2_gen_5.11.csv",header=TRUE,sep=",")
head(all)
all <-  all[,c(1,2,4,5,6)]
size <- dim(all)[1]
a <- 0
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
	got <- dim(this.pan[!is.na(this.pan[,2]),])[1]/dim(this.pan)[1]
	# days+count
	startday <- 23 + min(which(lists != 0)) -1
	curday <- 23 + max(which(lists != 0)) -1
	# days+rosette/cauline
	this.pan.clean <- this.pan[!is.na(this.pan[,5]),]
	names(this.pan.clean) <- c("pan", "name", "rosette","cauline","days")
	select <- this.pan.clean[this.pan.clean[,3]>12 & this.pan.clean[,5]> curday-7,]
	filename <- paste("/Users/admin/Advanced/gt12/",a,"-",curday,"-d.txt",sep="",collapse="")
	write.csv(select,filename)
}