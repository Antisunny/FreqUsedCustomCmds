#!/bin/bash

function getpath() { 
  # support . and .. as the special path
  # get the absolute path version of the given dir
  cd $1
  echo `pwd`
}

# prepare colors' variables
if [ -f colors-8.sh ];then
  . colors-8.sh
elif [ -f colors-256.sh ];then
  . colors-256.sh
else
  bold="\033[01m"
  endc="\033[00m"
  red="\033[01;31m"
  green="\033[01;32m"
  blue="\033[01;33m"
  yellow="\033[01;34m"
fi

usage(){
  echo -e "${bold}usage:${endc} $0 basedir gft_file_path bowtie2_index paired/single\n---------"
  echo " basedir is the parent dir where all the fastq file are stored"
  echo -e " All the fastq files should be put into a dir named source\n---------"
  echo -e "basedir|\n       |-source\n       |-${green}tophat_rst${endc}\n       |-cuff_rst|\n                 |-cufflinks\n                 |-cuffmerge\n                 |-cuffdiff"
  exit
}

# print progressing dot
print_dot(){
  count=$1
  is_oneline=$2
  if [[ $is_oneline -ge 2 ]];then
    echo "The 2nd argument is 0,1, indicating oneline and multiline"
    exit
  elif [ -z $is_oneline ];then
    is_oneline=0
  else
    is_oneline=0
  fi
  n=$count
  while [ $n -gt 0 ];do
    echo -n "."
    sleep 0.5
    n=$(( $n - 1 ))
    if [ $n -eq 0 ];then
      seq_b=$( seq -s "\\b" $(( $count + 1 )) | sed -e 's/[0-9]//g' )
      seq_s=$( seq -s " " $(( $count + 1 )) | sed -e 's/[0-9]//g' )
      if [[ $is_oneline -eq 0 ]];then
        echo -en "$seq_b${seq_s}$seq_b"
      elif [[ $is_oneline -eq 1 ]];then
        echo
      else
        echo -en "$seq_b${seq_s}$seq_b"
      fi
      n=$count
    fi
    sleep 0.7
  done
}

# validation for parameters
if [ $# -lt 4 ];then
  if [ $# -eq 0 ];then
    usage
  fi
  echo -e "${red}Error:${endc} exact 4 parameters should be given\n***************"
  usage
fi
if [ $# -gt 4 ];then
  echo -e "${red}Error:${endc} exact 4 parameters should be given\n****************"
  usage
fi

if [ -d $1 ];then
  basedir=$( getpath $1 )
else
  echo -e "${red}Error:${endc} The 1st parameter should be directory"
  exit
fi

if [ ! -z $basedir/source ];then
  if [ ! -d $basedir/source ];then
    echo -e "all the fastq files should be put in the \e[01;31m$basedir/source\e[00m"
    exit
  fi
fi

if [ -f $2 ];then
  gft_file_path=$2
else
  echo -e "${red}Error:${endc} The 2st parameter should be gtf format text file"
  exit
fi

if [ -n $3 ];then
  gft_file_path=$3
else
  echo -e "${red}Error:${endc} The 3st parameter should be bowtie2 index"
  exit
fi

if [ ! -z $4 ];then
  if [[ $4 == "single" ]];then
    pairorsingle=1
  elif [[ $4 == "paired" ]];then
    pairorsingle=2
  else
    echo -e "${red}Error:${endc} The 4st parameter should be single or paired"
    exit
  fi
else
  echo -e "${red}Error:${endc} The 4st parameter should be given"
  exit
fi
######################## tophat part #####################

if [ ! -z $basedir/tophat_rst ];then
  if [ -d $basedir/tophat_rst ];then
    echo -en "$basedir/tophat_rst Already Exist"
    read -p " Clear[y/n]? " choice
    if [[ $choice == 'y' ]];then
      rm -r $basedir/tophat_rst
      # clear before any operation
      mkdir -p $basedir/tophat_rst
    elif [[ $choice == 'n' ]];then
      exit
    else
      exit
    fi
  else
    mkdir -p $basedir/tophat_rst
  fi
fi

# validate the tophat_rst
if [ $? -eq 0 ];then
  echo "tophat_rst Prepared"
else
  exit
fi
time_diff_(){
  endtime=$2
  starttime=$1
  time_diff=$(($endtime-$starttime))
  days=$(($time_diff/4320))
  echo -n "Time Used: "
  if [[ $days -gt 1 ]]; then
    echo -en "$days Days + "
  else
    echo -en "$days Day + "
  fi
  hours=$(($time_diff/360))
  if [[ $hours -gt 1 ]]; then
    echo -en "$hours Hours + "
  else
    echo -en "$hours Hour + "
  fi
  mins=$(($time_diff%360/60))
  if [[ $mins -gt 1 ]]; then
    echo -n "$mins Mins"
  else
    echo -n "$mins Min"
  fi
  echo
}

function tophat_single(){
  cur=$1
  cur_name=$2
  start_time=$(date +%s)
  tophat2 -N 2 -o $basedir/tophat_rst/$cur_name -p 24 -G $gft_file_path $bowtie2_index $cur 1>&2 2> /dev/null
  end_time=$(date +%s)
  echo "Outputed to $basedir/tophat_rst/$cur_name"
  time_diff_ start_time end_time
  # if [[ $? -eq 0 ]];then
  #   echo -n $name
  #   print_dot 10
  # fi
}

function tophat_pair(){
  cur_r1=$1
  cur_r2=$2
  cur_name=$3
  start_time=$(date +%s)
  tophat2 -N 2 -o $basedir/tophat_rst/$cur_name -p 24 -G $gft_file_path $bowtie2_index $cur_r1 $cur_r2 1>&2 2> /dev/null
  end_time=$(date +%s)
  echo "Outputed to $basedir/tophat_rst/$cur_name"
  time_diff_ start_time end_time
  # if [[ $? -eq 0 ]];then
  #   echo -n $name
  #   print_dot 10
  # fi
}
echo "-------------------"

if [[ $pairorsingle -eq 1 ]];then
  for item in $basedir/source/*.fastq;do
    name=$( basename $item )
    name=${name//.fastq/}
    tophat_single $item $name
    echo
  done
elif [[ $pairorsingle -eq 2 ]];then
  for item in $basedir/source/*;do
    name=$( basename $item )
    if [ -d $item ];then
      ls $basedir/source*.fastq 1>&2 2> /dev/null
      if [ $? -eq 0 ];then
        fasqtqs=`ls $basedir/source/*.fastq`
        name=${name//.fastq/}
      else
        fasqtqs=`ls $item/*.fastq.gz`
        name=${name//.fastq.gz/}
      fi
      tophat_pair $fasqtqs $name
      echo
    fi
  done
else
  echo "Error: never get here"
fi