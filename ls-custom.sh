if [ -f colors-8.sh ];then
    . colors-8.sh
elif [ -f colors-256.sh ];then
    . colors-256.sh
else
    echo
fi
function lz() {
    function du_dir() {
        echo -e "\033[01m$1\033[00m" # $((RANDOM%6+1))
        (cd $1; ls -1 2>/dev/null | sed -e 's/^/"/' -e 's/$/"/'| xargs du -h -d 0 2>/dev/null)
    }
    function du_file() {
        (ls -lha $1 | awk '{print $5,$9}')
    }
    function getpath() { # support . and .. as the special path
            cd $1
            echo `pwd`
    }
    function usage(){
        echo -e " ${bold}usage:${endc} lz [dir]/[file] ..."
        echo " if no arguement is given, 'lz' will show the current working dir"
        echo " .(current dir), ..(parent dir), *(metachar) are supported"
        echo -e "\n -V/-h for this help page"
        echo
    }
    function log(){
        echo -e " \n--------------------------------------------------\n lz v0.2 by Ray Lee - July 1, 2015"
        echo -e " updates:\n  1.clone 'le' as 'lz', new feature added\n  2.empty parameter doesn't work"
        echo -e " ^\n lz v0.2 by Ray Lee - may 28, 2015"
        echo -e " updates: \n  1.make the empty arg work, showing the current directory\n  2.-V and -h works\n  3.add comments for code block\n  4.modify the help page"
    }

    args=($@)
    if [[ ${#args[@]} -gt 1 ]]; then
        ## the * meta means all the things in the current directory, length of it is gt 1 when current dir contains
        ## more than 1 thing, 1 if there is only one thing, le 1 when empty
        ## 
        for each in ${args[@]}; do
            [ -d $each ] && du_dir `getpath $each` || du_file `getpath $each`
        done
    elif [ ! -z $1 ]; then
        ## The oddness of the -d option for file test is that it recognises the empty as a directory
        ## So the -z should be used to make -d solid for empty args.
        ## 
        if [ -d $1 ]; then # support . and .. as the special path
            du_dir `getpath $1`
        elif [[ $1 == '-V' ]]; then
            log
        elif [[ $1 == '-h' ]]; then
            usage
        fi
    else
        du_dir `getpath "."`
    fi
}