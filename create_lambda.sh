#!/usr/bin/env bash
rm -f function.zip
cd lambda_code_simple
zip -r ../function.zip *
cd ..
aws lambda create-function --region ap-southeast-2 --function-name MyLambdaFn --zip-file fileb://function.zip --handler index.handler --runtime nodejs14.x --timeout 10 --memory-size 1024 --role arn:aws:iam::000000000000:role/lambda-s3-role --endpoint-url http://localhost:4566
aws logs create-log-group --log-group-name /aws/lambda/MyLambdaFn --endpoint-url http://localhost:4566
aws logs create-log-stream --log-group-name /aws/lambda/MyLambdaFn --log-stream-name /aws/lambda/MyLambdaFn --endpoint-url http://localhost:4566
