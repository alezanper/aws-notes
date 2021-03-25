# List S3 buckets
aws s3 ls

# List S3 files
aws s3 ls s3://bucketname

# Create a bucket
aws s3 mb s3://bucketnametocreate

# Remove a bucket
aws s3 rb s3://buckettodelete

# Copy a file from bucket
aws s3 cp s3://bucketorigin/image.jpg image.jpg