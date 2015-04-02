if [ -f response.txt ];then
	rm response.txt
fi
if [ -f temp.txt ];then
	rm temp.txt
fi
if [ -f gresponse.txt ];then
	rm gresponse.txt
fi
#######################
seed=10
#######################
for (( i=2; i<=$seed*2;i+=2 ))
do
	sed -i -r -e "s/[ \t]*seed[ \t]*[0-9()*+]+/seed $i/" sim_input.txt	
	python cs681.py > /dev/null
done
resp_mean=`cat response.txt | awk '{line += 1;sum += $1} END {print sum/line}'`

start=1
end=10
for (( c=$start;c<=$end;c++ ))
do
	echo $resp_mean
done >temp.txt
paste -d" " response.txt temp.txt > gresponse.txt
resp_var=`cat gresponse.txt | awk '{var+=($1-$2)*($1-$2);line+=1}END{print var/(line-1)}'`
echo $resp_mean $resp_var
