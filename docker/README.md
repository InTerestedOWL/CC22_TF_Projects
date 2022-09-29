# EKS Cluster Infrastructue

Basierend auf dem Tutorial von terraform [Provision an EKS Cluster learn guide](https://learn.hashicorp.com/terraform/kubernetes/provision-eks-cluster).


## Beschreibung der Dateien
In diesem Ordner findet sich die standardmäßige Infrastructure für ein self-scaling project.

Es besteht also aus:
Einem ECS-Cluster

Wir nutzen hierbei folgende Dateien (in alphabetischer Reihenfolge):

- main.tf: Enthält alle Konfiguration, um letztlich den EC-Service aufzusetzen.

---
**NOTE**

Diese Projekt ist nie in vollem Umfang getestet worden, da es weitere Berechtigungen benötigt, und somit nicht auf AWS Academy funktioniert. 
Und da AWS Academy ausgelaufen ist, lässt sich dies somit auch nicht mehr nutzen.
Es handelt sich hierbei auch eher um ein Template, dass weiterhin erweitert werden muss, was aber nicht durchgeführt werden konnte, da Tests nicht möglich waren. 
---

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
