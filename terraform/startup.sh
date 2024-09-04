#!/bin/bash
sudo apt-get update
sudo apt-get install -y nginx

# Nginx 설정 및 시작
sudo systemctl start nginx
sudo systemctl enable nginx