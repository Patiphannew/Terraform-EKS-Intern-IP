# ArgoCD 
## config & deployment of ArgoCD
**1.ต้องใส่** `aws eks update-kubeconfig --region ap-southeast-1 --name ${clustername} --profile ${profilename}` **เพื่อ update kubeconfig ก่อน** <br>

**2.terraform apply ได้เลย** `terraform apply -var-file="var.tfvars"` <br>

**3.ใช้คำสั่ง**
`kubectl port-forward svc/argocd-helm-server -n argocd 8080:443` 
**เพื่อ Forward port ของ ArgoCD** <br>

**4.สำหรับรหัสผ่านเข้า ArgoCD** <br>

Username: admin <br>
Password: `kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo` <br>

## deploy nginx-ingress & nodeport service

**1.deploy nginx-ingress โดยใช้คำสั่ง** `kubectl apply -f ${nginx-IngressFileName}`<br>
**2.deploy nodeport service โดยใช้คำสั่ง** `kubectl apply -f ${nodeportFileName}`

## deploy application

**deploy application โดยใช้คำสั่ง** `kubectl apply -f ${applicationFileName}`

## แก้ Host ใน ingress โดยใช้ dns name ของ nlb ใน aws

```
ingress: 
    host: ${nlbDNSName}
```


# Terraform

สร้างS3 bucketในAWSด้วย <br>


https://acloudguru.com/blog/engineering/the-ultimate-terraform-cheatsheet <br>
คำสั่งที่ใช้ร่วมกับVariable Files ถ้าไม่ใส่มันจะไม่มีvaluesนั้น ทำให้ตอนเรารัน เราต้องกำหนดvaluesเอง
```
terraform init   //ใช้ตอนแรกสุด
terraform init -reconfigure    //ใช้ตอนที่มีconfigใหม่ๆเพิ่มขึ้นมา
terraform plan -var-file="var.tfvars"   //ตรวจสอบการทำงาน
terraform apply -var-file="var.tfvars"
terraform destroy -var-file="var.tfvars"
```
https://www.terraform.io/language/configuration-0-11/variables <br>
### มีหลายวิธีในการทำ แต่อันนี้ใช้วิธีสร้าง Variable Files ขึ้นมา
ในไฟล์ eks.tf และ nlb.tf จะมี Variable อยู่เรียกว่า ***Input variables*** ซึ่งสามารถนำไปใช้งานได้ <br>
ไฟล์ var.tfvars เป็น ***Values*** ที่ส่งค่าไปหา Input variables

