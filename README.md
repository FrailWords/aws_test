## Install localstack

`pip install localstack` or `pip3 install localstack`


## Start localstack

`localstack start`


## Run 

1. `aws_init.sh` - creates s3 buckets and creats lambda execution role with the right policy

2. `create_lambda.sh` - creates lambda function with simple code that outputs the key of the s3 file created event

3. `configure_s3_to_publish_event.sh` - configure event for s3 object-creation which will trigger a lambda

4. `aws logs tail "/aws/lambda/MyLambdaFn" --endpoint-url http://localhost:4566 --follow` - follow lambda logs for `console.log` statements

5. `aws s3 cp test.txt s3://source-bucket/test.txt  --endpoint-url http://localhost:4566` - copy local file to s3 bucket


## AWS reference:

https://docs.aws.amazon.com/lambda/latest/dg/nodejs-handler.html
