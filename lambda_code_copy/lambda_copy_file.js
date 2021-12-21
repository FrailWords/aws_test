const stream = require('stream')
const readline = require('readline')
const AWS = require('aws-sdk')
const S3 = new AWS.S3()

// read S3 file by line
function createReadline(Bucket, Key) {

  // s3 read stream
  const input = S3
      .getObject({
        Bucket,
        Key
      })
      .createReadStream()

  // node readline with stream
  return readline
      .createInterface({
        input,
        terminal: false
      })
}

// write S3 file
function createWriteStream(Bucket, Key) {
  const writeStream = new stream.PassThrough()
  const uploadPromise = S3
      .upload({
        Bucket,
        Key,
        Body: writeStream
      })
      .promise()
  return { writeStream, uploadPromise }
}

// perform processing on line
function processLine(line) {
  // do something
  return line
}

// event.inputBucket: source file bucket
// event.inputKey: source file key
// event.outputBucket: target file bucket
// event.outputKey: target file key
// event.limit: maximum number of lines to read
exports.handler = function execute(event, context, callback) {
  console.log(JSON.stringify(event, null, 2))
  var totalLineCount = 0

  // create input stream from S3
  const readStream = createReadline(event.inputBucket, event.inputKey)

  // create output stream to S3
  const { writeStream, uploadPromise } = createWriteStream(event.outputBucket, event.outputKey)

  // read each line
  readStream.on('line', line => {

    // close stream on limit
    if (event.limit && event.limit <= totalLineCount) {
      return readStream.close()
    }

    // process line
    else {
      line = processLine(line)
      writeStream.write(`${line}\n`)
    }

    totalLineCount++
  })

  // clean up on close
  readStream.on('close', async () => {

    // end write stream
    writeStream.end()

    // wait for upload
    const uploadResponse = await uploadPromise

    // return processing insights
    callback(null, {
      totalLineCount,
      uploadResponse
    })
  })
}
