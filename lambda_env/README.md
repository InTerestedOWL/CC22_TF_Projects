# Basic Infrastructue

## Beschreibung der Dateien
In diesem Ordner findet sich die Konfiguration für ein Lambda Projekt. 

---
**NOTE**

Dieses HTTPS-Projekt funktioniert aufgrund fehlender AWS-Academy Berechtigungen leider nicht in AWS Academy.

Da Lambda aber Https benötigt, ist ein anderer Account zum Testen dieser Konfiguration notwendig

---

Es besteht also aus:
- ALB Listener
- ALB Target Group
- ALB Security Group rule
- EC2 Security Group
- Auto Scaling Group for EC2 instances with Nginx
- AWS Lambda
- AWS Certificates Manager (SSL Certificate)
- Route53 hosted zone record for ALB
- Ein Password

Wir nutzen hierbei folgende Dateien (in alphabetischer Reihenfolge):

- alb.tf: Hier definiert ist ein appplication Loadbalancer (ALB), also ein Anwendungsbasierter LoadBalancer
- instances.tf: definiert alle Instanzen, die auf dem EC2 laufen, in diesem Fall sind hier ein NGINX server und die passenden Security Gruppen definiert und konfiguriert.
- launch_config.tf: Diese Datei enthält die Informationen darüber, was auf dem EC2 gestartet werden soll "aws_launch_config". Hierbei wird also der nginx-Webserver installiert und gestartet. Ebenso wird hier die Autoscaling Gruppe festgelegt, die im Detail festlegt, wie groß die Instanzen sein sollen für den Check, ob alles noch funktioniert wird der Elastic Load Balancer (ELB) genutzt.
- main.tf: Standard terraform Datei enthält hierbei locals, um entsprechend die Instanzen zu betreiben.
- outputs.tf: Enthält alle Informationen, die zum Zugriff auf die Seite benötigt werden.
- providers.tf: Definiert den Provider, in diesem Fall AWS in der Region us-east-1.
- s3.tf: Hierbei definiert wird ein S3-Bucket von cloudposse zum ausliefern von access logs eines ALB.
- scaling_policies.tf: Hier definiert sind alle Policies, die für die autoscaling und den alarm nötig sind, definiert. Somit lässt sich also nicht nur eine Meldung sondern auch das automatische Skalieren der Resourcen um +/- 1 erreichen.
- variables.tf: Variablen, die genutzt werden.
- vpc.tf: VPC = Virtual Private Cloud, definiert private und public Subnetze für die EC2-Instanzen.

Kurz dazu, warum wir Cloudposse in diesem Fall nutzen:
1. Weil das Projekt bereits die Policy mitbringt, damit der AWS Load Balancer seine Access Logs bereitstellen kann und somit kein Configurations-Aufwand mehr nötig ist.
2. Weil man das Rad nicht neu erfinden muss und ich in der Vergangenheit gute Erfahrungen damit gemacht habe.


## Benutzung:
1. Add your terraform.exe to the folder.
2. Öffne die Console.
3. Tippe "terraform init" ein und drücke Enter
4. Lass Terraform das komplette Setup konfigurieren.
5. Update deine Credentials, diese findest du hier: %USERPROFILE%\.aws\credentials dort fügst du die Informationen aus deinem AWS Konto ein, diese bestehen aus:
   [default]
   aws_access_key_id=
   aws_secret_access_key=
   aws_session_token=
6. Anschließend plane den Terraform deploy: "terraform plan" in der Konsole eingeben.
7. Läuft dieser Ohne Probleme durch, kannst du mit "terraform apply" letztlich die Instanzen und Komponenten deployen.

Um zu verifizieren, dass alle Systeme laufen, melde dich im AWS Portal an und gehe in die Region us-east-1 Nord-Virginia
Dort benötigst du: EC2, VPC und S3 und kannst dir dort alle benötigten Resourcen anschauen.

Du solltest sehen 2 EC2 Instanzen nginx-1 und nginx-2.
Links unter EC2 findest du ein Menü Lastausgleich, worunter du den definierten Load Balancer findest. 
