#!/bin/bash

rm -rf ./env_vars/ec2_info1.yml
rm -rf ./env_vars/ec2_info2.yml
rm -rf ./env_vars/ec2_info3.yml
rm -rf ./env_vars/elb_info.yml
rm -rf ./hosts

echo "[local]" >> ./hosts
echo "localhost" >> ./hosts
echo "[primary]" >> ./hosts
echo "[node1]" >> ./hosts
echo "[node2]" >> ./hosts