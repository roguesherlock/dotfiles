function start_aws
    command aws ec2 start-instances --instance-id $AWS_INSTANCE_ID
end

function stop_aws
    command aws ec2 stop-instances --instance-id $AWS_INSTANCE_ID
end

function connect_aws
    start_aws
    set -x AWS_IP (aws ec2 describe-instances --instance-ids $AWS_INSTANCE_ID --query 'Reservations[0].Instances[0].PublicIpAddress' | sed -e 's/^"//' -e 's/"$//')
    ssh -i ~/keys/0xelectron-aws.pem ubuntu@$AWS_IP
end
