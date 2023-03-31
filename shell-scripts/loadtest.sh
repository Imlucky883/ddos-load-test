#!/bin/bash


for i in {1..200};
do
	output1=$(curl -s http://front-end-lb-1368332406.us-east-1.elb.amazonaws.com/)
	echo $i - $output1
	sleep 0.5

done

