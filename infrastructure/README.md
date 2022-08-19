# Basic Infrastructue

In diesem Ordner findet sich die folgende Architektur, die einen Virtual Private Cloud, zwei Subnetze und ein NAT-Gateway enthält.

Da es hier weniger um ein VPC gehen soll, nutzen wir das aws-terraform-modul für vpcs

Dabei gliedert sich unser Ordner-Aufbau in folgende Dateien:

- **Backend**: Das Backend basiert auf einem s3-Modul. Durch die Definierung dieses Moduls, wird AWS angehalten, eben diesen Ort zum Speichern von Dateien zu nutzen, anstatt  den Default "local" zu nutzen. Klar ist, es lassen sich die Dateien dann schneller ablegen :)

- **Variables**: Selbsterklärend: Variablen

- **Main**: Hier sind hauptsächlich lokale Variablen für die VPC-Modul-Konfiguration abgelegt.

- **VPC**: Hier definieren wir unsere virtual private cloud, mit zwei öffentlichen Subnetzen und einem privaten Subnetz. Wie bereits angesprochen, nutzen wir ein NAT-Gateway um eine Trennung zwischen privat und öffentlich durchzuführen


Folgendes Bild zeigt den jetzigen Aufbau:

