## F2 generation flowering time and fertility stat.
> F2 of hen1-2 (early flowering) x hen1-8 (late flowering). both mutants have severe fertility defects.
- 总共32盘
- 每盘播种120株，但实际的发芽率和环境因素的影响，没有一盘是完整的
- 最后只统计了3364株的相关参数，最后仍然有67株没有统计

- data.txt
	- `pan` 所在盘的数字编号
	- `name` 每株植物的编号，唯一性
	- `date` 主颈2cm时的日期，没有标明月份
	- `rosette` 莲座叶
	- `cauline`	分支叶
	- `days` 主颈2cm距播种日期的时间(天数)
	- ![data.txt showage](./partial_data.png)
- plot_out.R
	- 为每一盘都做一组统计图表，包括barplot, pie plot, statter plot
	- barlpot 横坐标为天数，纵坐标为
结果图为
![plot all](./10x16-4.pdf)
