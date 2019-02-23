#!/bin/bash
BLU(){              #随机产生N个蓝球
blues=({01..16})
while :;do
	num=$[RANDOM%16]
	[ -z "${blues[$num]}" ]&&continue
	echo -e -n " \033[34m${blues[$num]}\033[0m"&&unset blues[$num]
	[ "${#blues[@]}" == "$[16-$1]" ]&&break
done
}
RED(){              #随机产生N个红球
reds=({01..33})
while : ;do
	num=$[RANDOM%33]
	[ -z "${reds[$num]}" ]&&continue
	echo -n -e  "\033[31m${reds[$num]} \033[0m" && unset reds[$num]
	[ "${#reds[@]}" == "$[33-$1]" ]&& break
done
}

if echo $1|egrep -q "^[0-9]+[+][0-9]+$";then          #判断输入的是否含有+
	num_red=`echo $1|sed -r 's/(.+)(\+)(.+)/\1/'`
	num_blu=`echo $1|sed -r 's/(.+)(\+)(.+)/\3/'`
	[ "$num_red" -ge 6 -a "$num_red" -le 33 ] ||num_red=6
	[ "$num_blu" -ge 1 -a "$num_blu" -le 16 ] ||num_blu=1
	RED $num_red;BLU $num_blu
	echo
	hq=1
	for i in {1..6};do
		hq=$[hq*num_red]
		let num_red--
		[ $num_red == 0 ]&&break
	done
	hq=$[hq/720]
	echo "金额:$[2*hq*num_blu]元"
elif [ -z "$1" ] ||! expr 7 + $1 &> /dev/null;then   #判断是否为有效数字或者是否为空
	RED 6;BLU 1
	echo
	echo "金额:2元"
else
	for i in `seq $1`;do            #生成$1注
		RED 6;BLU 1 
		echo
	done
	echo "金额:$[2*$1]元"
fi

