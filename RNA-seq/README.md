## runTophat.sh
- a wrapper for tophat2
- `paired` requires that `source` dir contains subdirs
  - each subdir contains replicates of one sample
  - the subdirs' name will be used as the name for processing
```text
usage: ./runTophat.sh basedir gft_file_path paired/single
---------
 basedir is the parent dir where all the fastq file are stored
 All the fastq files should be put into a dir named source
---------
basedir|
       |-source
       |-tophat_rst
       |-cuff_rst|
                 |-cufflinks
                 |-cuffmerge
                 |-cuffdiff
```