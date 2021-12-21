#!/usr/bin/env bash
aws logs get-log-events --log-group-name /aws/lambda/MyLambdaFn --log-stream-name $(cat out) --tail --endpoint-url http://localhost:4566
