# Einführung

Dieses Projekt ist meine persönliche Leistung. Quellen, die zur Erstellung genutzt wurden sind angegeben:

hashicorp/terraform
cloudposse-s3-alb-projekt

gez. Christian Dechant

# Aufbau
Das Projekt besteht aus 5 Ordner, die sich wie folgt clustern:
- eks_cluster - Basierend auf dem terraform/hashicorp enthält dieses Konfigurationsdateien, um ein Elastic Kubernetes Service (EKS)- Cluster aufzusetzen.
- blue_green_env - Eine Blue-Green-Environment konfiguraiton basierend auf http.
- blue_green_env_https - Eine Blue-Green-Environment konfiguraiton basierend auf https.
- infrastructure - Eine autoscaling konfiguration für den Betrieb von einem Loadbalancer, der zwei NGINX-Webserver verwaltet basierend auf HTTP.
- infrastructure_https - Eine autoscaling konfiguration für den Betrieb von einem Loadbalancer, der zwei NGINX-Webserver verwaltet basierend auf HTTPS.
- lambda_env - Ein Lambda-Environment, dass neben der autoscaling group noch einen password generator als Lambda Funktion bereitstellt. Lambda benötigt HTTPS. 
- docker - Ein weiteres Projekt, dass ich startete, aber leider nicht heute 29.09. mehr testen konnte ist ein ECS = Elastic Contrainer Service based on docker. 

Jedes Projekt muss einzeln deployed werden, indem man den Anweisungen in der README des jeweiligen Projektes folgt.

---
**NOTE**

Alle HTTPS-Projekte laufen leider nicht auf AWS Academy zur Ausführung dieser muss entsprechend eine Berechtigung für Route53 hinzugefügt werden, sofern möglich, andernfalls ist die Nutzung eines eigenen AWS Accounts, mit dem ich diese Projekte ebenfalls getestet habe notwendig

Da Lambda aber Https benötigt, ist ein anderer Account zum Testen dieser Konfiguration notwendig.
Docker und Kubernetes werden ebenfalls nicht von AWS Academy unterstützt. 

---