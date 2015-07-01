# FreqUsedCustomCmds
freq used custom commands in linux/unix

##lz
- ls with only size and name, ans size is given with K/M/G/T


## colors-8.sh
- contains only 8 colors: `black`, `red`, `green`, `yellow`, `blue`, `fuchsia`, `ultramarine`, `white`
- basic style: bold(01), underline(03), dim(02), reverse(07), blink(05)
- b_* for bold, d_* for dim, i_* for blink, v_* for reverse
- underline is not added as a group due to its infrequentness
- The color motif is \033[❶<0?[0124578];>❷<[34][012345679]>m
 - ❷ 3 represents setting for foreground color
     4 for background color
| code | name  | command |
| [0m  | black | sgr0    |