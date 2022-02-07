# ArgoCD
**ก่อนจะใช้คำสั่ง**  ` terraform apply -var-file="var.tfvars ` <br>

**ต้องใส่** ` aws eks update-kubeconfig --region ap-southeast-1 --name ${clustername} --profile produser ` **เพื่อ update kubeconfig** <br>

**ใช้คำสั่ง** ` kubectl port-forward svc/argocd-helm-server -n argocd 8080:443 ` **เพื่อ Forward port ของ ArgoCD** <br>

Username: admin <br>
Password: `kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo`