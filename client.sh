if [ -f resp_client.txt ];then
	rm resp_client.txt
fi
for i in  {1..183..30}
do
	sed -i -r -e "s/[ \t]*no_of_clients[ \t]*[0-9()*+]+/no_of_clients $i/" sim_input.txt	
	bash bash.sh >> resp_client.txt
	echo $i
done

#####calculating confidence interval #################
cat resp_client.txt | awk '{print $1-0.95*sqrt($2/10),$1+0.95*sqrt($2/10)}'
