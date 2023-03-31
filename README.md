# Building a Robust DDoS Protection Strategy for AWS with AWS WAF

## What is DDoS attack ??

A **distributed denial-of-service (DDoS)** attack is a malicious attempt to disrupt the normal traffic of a targeted server, service or network by overwhelming the target or its surrounding infrastructure with a flood of Internet traffic.

![DDOS](https://i.imgur.com/PpowK9A.png)

## What is WAF ??

**AWS WAF & Shield** is a web application firewall that lets you monitor the HTTP and HTTPS requests that are forwarded to Amazon CloudFront, an Amazon API Gateway REST API, an Application Load Balancer, an AWS AppSync GraphQL API, or an Amazon Cognito user pool.(3) You do this by defining a web access control list (ACL) and then associating it with one or more web application resources that you want to protect.

AWS WAF protects the following resource types: Amazon CloudFront distribution, Amazon API Gateway REST API, Application Load Balancer, AWS AppSync GraphQL API, and Amazon Cognito user pool.

![DDOS](https://d1tcczg8b21j1t.cloudfront.net/strapi-assets/11_AWS_waf_what_it_is_3_75023d5b21.png)


## Getting Started

### Pre-requisites

+ AWS Account
+ Terraform installed
+ AWS Credentials configured on your localhost

```
git clone https://github.com/Imlucky883/ddos-load-test
cd ddos-load-test
cd terraform
terraform init
terraform apply --auto-approve
```

### Setting up WAF


+ Open the AWS WAF console and select "Web ACLs" in the left-hand navigation menu.
+ Click on "Create web ACL" to create a new web ACL.
+ Give the web ACL a name and a description, and then select the region where you want to deploy it.
+ Click on "Add rules and rule groups" to define the rules that will be applied to incoming traffic.
+ Create a rule group by clicking "Create rule group" and select the type of rule group you want to create.
+ Add rules to the rule group by clicking "Add rule" and selecting the rule type you want to add.
+ Configure the rule settings as per your requirements.
+ Once the rules and rule group are configured, go back to the web ACL and click "Add rules and rule groups" again.
+ Add the rule group to the web ACL by selecting it from the list.
+ Associate the web ACL with the load balancer by going to the "Load Balancers" section of the AWS WAF console.
+ Select the load balancer you want to associate with the web ACL and click "Edit" in the "Associated web ACLs" section.
+ Choose the web ACL you created and click "Save".
+ Copy the DNS of the load balancer and paste it in browser. You should see something like below 

![output](https://i.imgur.com/Q3N5gcV.png)

### Load Testing

+ Open the file under  `shell-scripts > loadtest.sh`
+ Copy the DNS of the load balancer and paste it here `curl -s your_url`
+ Add permissions to execute `sudo chmod +x loadtest.sh`
+ Execute the file
+ You will see that after 100 requests from the same IP, it will block the access.
+ You can view in your `WAF Dashboard`, it shows something like below 

![WAF_Dashboard](https://i.imgur.com/Vg1WWrh.png)

## References

+ https://cmakkaya.medium.com/how-to-secure-our-resources-from-doos-attacks-with-aws-waf-shield-5307c85cb476#ec34
+ https://cmakkaya.medium.com/creating-a-load-test-using-bashscript-and-trying-on-a-website-protected-by-aws-waf-6815d561bdd8

