init:
	helm init --client-only
	helm repo add jenkins-x https://jenkins-x-charts.github.io/v2
	helm repo add bitnami https://charts.bitnami.com/bitnami
	helm repo add stable https://charts.helm.sh/stable

build: clean init
	jx step helm build --boot --provider-values-dir=../kubeProviders
	helm lint .

clean: 
	rm -rf charts
	rm -rf requirements.lock
