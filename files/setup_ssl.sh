#!/bin/bash

echo "running ghe-ssl-certificate-setup"
/usr/local/share/enterprise/ghe-ssl-certificate-setup -c github-combined.pem

ghe-config-apply
