# Basic Infrastructue

## Beschreibung der Dateien
Dieses Projekt beschreibt ein Blue-Green-Environment in HTTPS.

---
**NOTE**

Dieses Projekt funktioniert aufgrund fehlender AWS-Academy Berechtigungen leider nicht in AWS Academy.

---

Es besteht also aus:
- ALB-Listener mit Konfiguration der Weiterleitungsregeln
- Zwei ALB-Zielgruppen
- ALB-Sicherheitsgruppenregel
- EC2-Sicherheitsgruppe
- Zwei Auto Scaling Group für EC2-Instanzen mit Nginx (blaue und grüne Umgebung)

Wir nutzen hierbei folgende Dateien (in alphabetischer Reihenfolge):

- acm.tf: AWS Certificate Manager, kontrolliert https zertifikate und stellt eben solche bereit.
- alb.tf: Hier definiert ist ein appplication Loadbalancer (ALB), also ein Anwendungsbasierter LoadBalancer
- blue.tf/green.tf/instances.tf: definiert alle Instanzen, die auf den EC2s laufen, in diesem Fall sind hier zwei NGINX server und die passenden Security Gruppen definiert und konfiguriert.
- main.tf: Standard terraform Datei enthält hierbei locals, um entsprechend die Instanzen zu betreiben.
- outputs.tf: Enthält alle Informationen, die zum Zugriff auf die Seite benötigt werden.
- providers.tf: Definiert den Provider, in diesem Fall AWS in der Region us-east-1.
- s3.tf: Hierbei definiert wird ein S3-Bucket von cloudposse zum ausliefern von access logs eines ALB.
- variables.tf: Variablen, die genutzt werden.
- vpc.tf: VPC = Virtual Private Cloud, definiert private und public Subnetze für die EC2-Instanzen.

Kurz dazu, warum wir Cloudposse in diesem Fall nutzen:
1. Weil das Projekt bereits die Policy mitbringt, damit der AWS Load Balancer seine Access Logs bereitstellen kann und somit kein Configurations-Aufwand mehr nötig ist.
2. Weil die Erfahrungen, die damit gesammelt wurde für mich sehr vielversprechend waren


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

Du solltest sehen 4 EC2 Instanzen nginx-1 und nginx-2.
Links unter EC2 findest du ein Menü Lastausgleich, worunter du den definierten Load Balancer findest.
Durch nutzung des entsprechenden DNS-Eintrages kann auf die Applikation zugegriffen werden.
