#!/usr/bin/env bash
aws logs delete-log-group --log-group-name /aws/lambda/MyLambdaFn --endpoint-url http://localhost:4566
aws lambda delete-function --function-name MyLambdaFn --endpoint-url http://localhost:4566
