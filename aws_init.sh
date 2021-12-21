#!/usr/bin/env bash

## Create S3 bucket - Source
aws s3 mb s3://source-bucket --region ap-southeast-2 --endpoint-url http://localhost:4566

## Create S3 bucket - Destination
aws s3 mb s3://destination-bucket --region ap-southeast-2 --endpoint-url http://localhost:4566

## List all s3 buckets
aws s3 ls --endpoint-url http://localhost:4566

## Create role for lambda to read from S3 bucket
aws iam create-role --role-name lambda-s3-role --assume-role-policy-document "{"Version": "2012-10-17","Statement": [{ "Effect": "Allow", "Principal": {"Service": "lambda.amazonaws.com"}, "Action": "sts:AssumeRole"}]}" --endpoint-url http://localhost:4566

## Create policy to read from S3 bucket
aws iam create-policy --policy-name read-policy --policy-document file://iam_read_policy.json --endpoint-url http://localhost:4566

## Create policy to write to S3 bucket
aws iam create-policy --policy-name write-policy --policy-document file://iam_write_policy.json --endpoint-url http://localhost:4566

## Attach Policy to the role for read
aws iam attach-role-policy --policy-arn arn:aws:iam::000000000000:policy/read-policy --role-name lambda-s3-role --endpoint-url http://localhost:4566

## Attach Policy to the role for write
aws iam attach-role-policy --policy-arn arn:aws:iam::000000000000:policy/write-policy --role-name lambda-s3-role --endpoint-url http://localhost:4566

## List attached role policies
aws iam list-attached-role-policies --role-name lambda-s3-role --endpoint-url http://localhost:4566
