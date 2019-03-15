#!/bin/bash
## 找出有数字行的最大值，并求和
## 每行可能包含整数，小数，字母，符号
max_num(){  #利用冒泡算法找出每行的最大值
	max=0
	sum=(`sed -nr $2's/([^0-9.])/ /gp' $1`)
	for i in `echo ${sum[@]}`;do
		max=`echo|awk -v i=$i -v max=$max '{num=i-max}END{if(num>0){print i}else{print max}}'`
	done
	echo $max 
}

num1=0
num2=0
file="/tmp/test.txt"
for i in "$@";do
	num1=`max_num $file $i`
	num2=`awk -v num1=$num1 -v num2=$num2 'BEGIN{print num1+num2}'`
done
echo $num2
