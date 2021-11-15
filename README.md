# ec2_userData_tag_spot

Simple EC2 user-data script that applies Spot instance name tag and EBS volume tags at boot time. Can be set to run via User-Data inside a Launch Template for Spot Fleet and ASG. 

Proper EC2 instance profile/role premissions must be in place for `descibe-instances` and `create-tags`.
