# POC DEMO- White listing IP's using Cloud Armor (DDoS Attack)
Ref: https://github.com/hashicorp/terraform-provider-google/tree/master/examples/cloud-armor

This is an example of setting up a project to take advantage of one of the [Cloud Armor features](https://cloud.google.com/armor/) that allows whitelisting of traffic to a compute instance based on ip address. It will set up a single compute instance running nginx that is accessible via a load balanced pool that is managed by cloud armor security policies.

We are going to walkthrough the process of creating a Cloud Armor policy, which will be used to protect against a simulated distributed denial of service (DDoS) attack

![alt text](https://github.com/victorbecerragit/poc-armor/blob/main/images/gcp-armor-lb.jpg "GCP diagram")

```
To run the example:
* Set up a Google Cloud Platform service account. 
* [Configure the Google Cloud Provider credentials](https://www.terraform.io/docs/providers/google/index.html#credentials)
* Update the `variables.tf` OR provide overrides in the command line
* gcloud config:
  $gcloud auth login
  $gcloud iam service-accounts list | grep terraform-deploy
  $gcloud iam service-accounts keys create sa-tf.json --iam-account terraform-deploy@lynqs-sandbox-ba.iam.gserviceaccount.com
  $gcloud config set project <your-project>
```
* Run with a command similar to:
```
terraform apply \
	-var="region=us-west1" \
	-var="region_zone=us-west1-a" \
	-var="project_name=my-project-id-123" \
```

After running `terraform apply` the external ip addresses  of the load balancer , 2 Web Backend and one stress instances will be output to the console. Either enter the ip address into the browser directly for test.

Also you can visualize the IP addresses with 'terraform output'

* Begin simulated DDoS attack
SSH into stress-instance instance that will be created in other region (us-west1)
```
$gcloud compute ssh poc-armor-stress-instance --zone=us-west1-a
```
Enter the below command to open 1000 concurrent connections to the application.
Substitute your frontend IP address for (your-frontend-ip)
```
$ab -n 10000000 -c 1000 -k http://(your-LB-frontend-ip)/
```
Allow the command to run, and go back to your web console.

You can perform the same test from your local machine. 

* View load balancer backend traffic
After running the Now that our attack is underway, let's check on how our load balancer is handling the flood of traffic.

Wait a few minutes for your stress instance to generate traffic and have metrics created
Go to your load balancer page by going to the top left menu - Network Services - Load Balancing
Select the Backends tab
Select 'armor-backend' from the LB 'armor-url-map'
You should be able to view metrics of backend traffic distribution. If you refresh your page every few minutes, the backend distribution will shift between regions as one region becomes overwhelemed, causing the load balancer to redistributed traffic to the other region

* Create a Cloud Armor policy to deny traffic from our `stress` instance
  
  Copy the armor-policy.tf file to the root directory and run:
```  
$terraform apply -auto-approve
```
 A new Policy will be created.

* View logs and results
Wait a few minutes for new logs to generate
In the Cloud Armor menu, select your `ddos-block' policy
Select the Logs tab
Click View policy logs, which should open a new tab in Cloud Logging for your HTTP Load Balancer logs
Click the Jump to now button to jump to the latest records.
Expand a recent record (should be in an error state), then select Expand all on the right side.
Confirm that the logged external IP matches your ddos-attack instance
Under the field jsonPayload, there should be a sub-field for enforcedSecurityPolicy. If you do not see this field. Wait a few more minutes, then click the Jump to now again to jump to latest records.
View enforcedSecurityPolicy fields. It should provide confirmation that the traffic request from your instance was denied due to the 'ddos-block' policy.
Go back to your load balancer backend and confirm that traffic requests have been reduced.

