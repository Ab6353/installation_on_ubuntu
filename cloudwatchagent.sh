#!/bin/bash
wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
sudo dpkg -i -E ./amazon-cloudwatch-agent.deb
sudo apt-get update && sudo apt-get -y install collectd

sudo bash /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-config-wizard
