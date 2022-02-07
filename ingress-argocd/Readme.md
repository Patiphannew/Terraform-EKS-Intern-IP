# ArgoCD 
## config & deployment of ArgoCD
**1.ต้องใส่** `aws eks update-kubeconfig --region ap-southeast-1 --name ${clustername} --profile ${profilename}` **เพื่อ update kubeconfig ก่อน** <br>

**2.terraform apply ได้เลย** `terraform apply -var-file="var.tfvars` <br>

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