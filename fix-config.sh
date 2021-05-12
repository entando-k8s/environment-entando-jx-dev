jx edit storage -c default --git-branch=gh-pages --git-url=https://github.com/entando-k8s/devops-results.git
jx edit storage -c logs --git-branch=logs --git-url=https://github.com/entando-k8s/devops-results.git
jx edit storage -c tests --git-branch=tests --git-url=https://github.com/entando-k8s/devops-results.git
jx edit storage -c coverage --git-branch=coverage --git-url=https://github.com/entando-k8s/devops-results.git
jx edit storage -c reports --git-branch=gh-pages --git-url=https://github.com/entando-k8s/devops-results.git
kubectl delete route -l generator=exposecontroller 
kubectl delete secret jenkins-release-gpg
kubectl get secret jenkins-release-gpg-bup -o yaml|sed 's/gpg-bup/gpg/'|kubectl create -f -
kubectl delete secret jenkins-docker-cfg
kubectl get secret jenkins-docker-cfg-bup -o yaml|sed 's/cfg-bup/cfg/'|kubectl create -f -
kubectl get configmap config -o yaml|sed -e 's/plank: {}/plank: \n      job_url_template: https:\/\/raw.githubusercontent.com\/entando-k8s\/devops-results\/logs\/jenkins-x\/logs\/{{.Spec.Refs.Org}}\/{{.Spec.Refs.Repo}}\/PR-{{with index .Spec.Refs.Pulls 0}}{{.Number}}{{end}}\/{{.Status.BuildID}}.log/g'>temp.yaml
kubectl delete configmap config
kubectl create -f temp.yaml
kubectl apply -f jenkins-x-pod-template-entando-jx-maven-java11.yaml
kubectl apply -f jenkins-x-pod-template-entando-jx-nodejs11.yaml
#jx edit buildpack -u https://github.com/entando-k8s/jenkins-x-kubernetes.git -r master
