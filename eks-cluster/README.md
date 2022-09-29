# EKS Cluster Infrastructue

Basierend auf dem Tutorial von terraform [Provision an EKS Cluster learn guide](https://learn.hashicorp.com/terraform/kubernetes/provision-eks-cluster).


## Beschreibung der Dateien
In diesem Ordner findet sich die standardmäßige Infrastructure für ein self-scaling project.

Es besteht also aus:
- Zwei Nodegruppen
- Kubernetes service
- Kubernetes Nutzer
- Security Groups
- Virtual Private Cloud (VPC)

Wir nutzen hierbei folgende Dateien (in alphabetischer Reihenfolge):

- eks-cluster.tf: Hier definiert, die Nodes, die zum Cluster gehören sollen
- main.tf: Standard terraform Datei enthält hierbei locals, um entsprechend die Instanzen zu betreiben und a den Kubernetes Service und dessen Konfiguration.
- outputs.tf: Enthält alle Informationen, die zum Zugriff auf die Seite benötigt werden.
- security-groups.tf: Definiert den Alle security Gruppen.
- variables.tf: Variablen, die genutzt werden.
- versions.tf: Alle Versionen, von Terraform und terraform/random.
- vpc.tf: VPC = Virtual Private Cloud, definiert private und public Subnetze für die EC2-Instanzen.

---
**NOTE**

Diese Projekt ist nie in vollem Umfang getestet worden, da es weitere Berechtigungen benötigt, und somit nicht auf AWS Academy funktioniert. 
Es handelt sich hierbei auch eher um ein Template, dass weiterhin erweitert werden muss.
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
