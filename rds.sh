# Create a new security group
aws ec2 create-security-group --group-name mydb-sg --description "Security group for RDS instance"

# Get the security group ID
SECURITY_GROUP_ID=$(aws ec2 describe-security-groups --group-names mydb-sg --query "SecurityGroups[0].GroupId" --output text)

# Allow inbound access on port 3306 from your IP address
MY_IP=$(curl -s http://checkip.amazonaws.com)
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol tcp --port 3306 --cidr $MY_IP/32

aws rds create-db-instance \
    --db-instance-identifier mydbinstance \
    --db-instance-class db.t3.micro \
    --engine mysql \
    --allocated-storage 20 \
    --master-username admin \
    --master-user-password yourpassword \
    --backup-retention-period 1 \
    --no-multi-az \
    --publicly-accessible \
    --vpc-security-group-ids $SECURITY_GROUP_ID \
    --db-name mydatabase \
    --port 3306

# List databases
aws rds describe-db-instances --query "DBInstances[*].{DBInstanceIdentifier:DBInstanceIdentifier, DBInstanceClass:DBInstanceClass, Engine:Engine, DBInstanceStatus:DBInstanceStatus, Endpoint:Endpoint.Address}" --output table

# Delete instance
aws rds delete-db-instance \
    --db-instance-identifier mydbinstance \
    --skip-final-snapshot \
    --delete-automated-backups
