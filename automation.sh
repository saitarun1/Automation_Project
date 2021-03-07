#!/bin/sh
sudo apt-get update -y
sudo apt-get install apache2 -y
systemctl enable httpd
systemctl start httpd.service
timestamp=$(date '+%d%m%Y-%H%M%S')
sudo tar -cvf saitarun-httpd-logs-${timestamp}.tar /var/log/apache2/
sudo mv saitarun-httpd-logs-${timestamp}.tar /tmp/
aws s3 \
cp /tmp/saitarun-httpd-logs-${timestamp}.tar \
s3://upgrad-ganjam/saitarun-httpd-logs-${timestamp}.tar
cat /var/www/html/inventory.html
crontab -l > automation
echo "0 0 * * * root /root/Automation_Project/Automation_Project/automation.sh" >> automation
crontab automation

