#!/usr/bin/env bash

NN=$(echo -e "\e[0;0;0m")  #Revert fonts to standard color
X92=$(echo -e "\e[0;92m")  #Green Good
C139=$(echo -e "\e[1;39m")
XX2=$(echo -e "\e[1;92m")  #
W37=$(echo -e "\e[1;37m")  #
W38=$(echo -e "\e[1;38m")  #
W35=$(echo -e "\e[1;35m")  #
X97=$(echo -e "\e[0;97m")  #White Good
X98=$(echo -e "\e[0;98m")  #Green Good
X10=$(echo -e "\e[4;92m")  # Green

URLS=$(mktemp -t url-$$.XXXXXXXXXX)
TMP=$(mktemp -t tmp-$$.XXXXXXXXXX)
SPC=$(mktemp -t spc-$$.XXXXXXXXXX)
ALD=$(mktemp -t ald-$$.XXXXXXXXXX)
D1=$(mktemp -t D1-$$.XXXXXXXXXX)
D2=$(mktemp -t D2-$$.XXXXXXXXXX)
D3=$(mktemp -t D3-$$.XXXXXXXXXX)
D4=$(mktemp -t D4-$$.XXXXXXXXXX)
D5=$(mktemp -t D5-$$.XXXXXXXXXX)
D6=$(mktemp -t D6-$$.XXXXXXXXXX)
#######################################################################
echo ''
echo ''
echo $RD"===============================================$NN"
echo $RD"------------Fizzy Hunter 0.4b------------------$NN"
echo $RD"===============================================$NN"
echo ''
#######################################################################
lfm(){
DM=`echo -e $LD`
RN=`echo $RANDOM|sed -e s'/^..//'g`
UY=$(ls -ltr logs/ |grep -i $LD| wc -l)
pd=`pwd`
if [ $UY == 0 ];
then
mkdir /root/logs/$DM
fi
P=`echo -e /root/logs/$DM/$YD-DIRS_$RN.log`
S=`echo -e /root/logs/$DM/$YD-FILES_$RN.log`
echo -e "[*] Folder : /Users/bgravois/Documents/bash_fuzzer/List-folder/$DM/ " ;
echo ""
echo " ==================================================================================================="
sleep 2
echo -n " " > $P
echo -n " " > $S
}
#######################################################################
fzfl(){
prompt="Please select a fuzzer file:"
options=( $(find /Users/bgravois/Documents/bash_fuzzer/List-folder* -maxdepth 1 -print0 | xargs -0) )
PS3="$prompt "
select opt in "${options[@]}" "Quit" ; do
    if (( REPLY == 1 + ${#options[@]} )) ; then
        exit

    elif (( REPLY > 0 && REPLY <= ${#options[@]} )) ; then
        echo  "You picked $opt which is file $REPLY"
        break

    else
        echo "Invalid option. Try another one."
    fi
done
}
#######################################################################
read -p "Enter the target URL: " TRG
X=$(echo $TRG|sed -e "s/\/*$//g")
echo -e "TARGET IS SET "$X
CL=$(echo $TRG|rev|cut -d '/' -f2-|rev) #BASE URL DROPPING OFF EVERYTHING AFTER LAST SLASH
BD=$(echo $TRG|cut -d '/' -f1-3) #BASE URL AFTER DOMAIN
YD=$(echo $TRG|cut -d '/' -f 3|cut -d ':' -f 1|sed -e s'/www\.//'g) #DOMAIN WITHOUT WWW
LD=$(echo $TRG|cut -d '/' -f 3|cut -d ':' -f 1|sed -e s'/www\.//'g| rev|cut -d'.' -f1-2|rev) #ROOT DOMAIN
fzfl
for i in `cat $opt`;do
echo $X$i >> $URLS
done
#echo -n '' > cookie.txt
echo ""
echo -e "Fetching URLs"
echo "==================================================================================================="
cat $URLS|parallel -j17 -q  -k --linebuffered curl --write-out 'Status:%{http_code}  \t %{size_download}             \t  - %{url_effective}\n' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101 Firefox/45.0' --compressed -skL --max-time 5 -o /dev/null|tee -a $TMP
#grep -e "^Status:200" -e "^Status:401" -e "^Status:403" -e "^Status:500" >> $TMP
echo "==================================================================================================="
echo ""
A2=$(cat $TMP |grep -e "^Status:200"|awk '!seen[$2]++' |sort -u)
B2=$(cat $TMP |grep -e "^Status:401" -e "^Status:403"|awk '!seen[$2]++' |sort -u)
C2=$(cat $TMP |grep -e "^Status:50"|awk '!seen[$2]++' |sort -u)
echo -e $X97
echo -e "$B2"
echo ""
echo -e $W35
echo -e "$C2"
echo ""
echo -e $X98
echo -e "$A2"
echo -e $NN

