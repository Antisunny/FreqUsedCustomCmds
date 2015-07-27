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
| pan | name | date | rosette | cauline | days |
| :-------- | --------:| :--: |
| 1 | A1-1-1 | 7 | 11 | 6 | 46 |
| 1 | A1-1-3 | 28 | 7 | 4 | 37 |
| 1 | A1-1-4 | 28 | 7 | 4 | 37 |
| 1 | A1-1-5 | 24 | 10 | 4 | 33 |
| 1 | A1-1-6 | 23 | 6 | 3 | 32 |
| 1 | A1-1-7 | 27 | 9 | 4 | 36 |
- plot_out.R
	- 