#!/usr/bin/env bash
aws s3api put-bucket-notification-configuration --bucket source-bucket --notification-configuration file://notification.json --endpoint-url http://localhost:4566
