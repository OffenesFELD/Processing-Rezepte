== Setup

Der Drehwertgeber horcht auf seiner Standard IP-Adresse: 10.10.10.10
Entweder manuell eine Route hinzufügen oder der LAN Schnittstelle des Rechners manuell eine IP in diesem Bereich zuweisen z.B. 10.10.10.1 (Subnetz-Maske 255.255.0.0)


== Testen

Entweder den Sensor anpingen und schauen ob was zurück kommt, oder versuchen über einen Web-Browser das Konfigurationsinterface aufzurufen (http://10.10.10.10)


== Settings

Die Settings des Encoders lassen sich über das Konfigurationsinterface (http://10.10.10.10) ändern.
Für die Kommunikation mit der Klasse sollte das Protokoll auf ASCII stehen und der TimeMode auf COS.

