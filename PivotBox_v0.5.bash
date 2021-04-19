
#!/bin/bash
#PivotBox automation script v0.5
#Fait par Lucas Bayol
#Février 2021

#mettre le nom du docteur ici
DR="DrMachin"

#Customise Alerts fail2ban
sed -i 's/sender = faibanl2ban/sendername = '"$DR"'/g' /etc/fail2ban/action.d/sendmail-common.conf
sed -i 's/sendername = fail2ban/sendername = '"$DR"'/g' /etc/fail2ban/action.d/sendmail-common.conf

#Configuration SSH
sed -i 's/@include common-auth/#@include common-auth/g' /etc/pam.d/sshd
sed -i 's/#auth required pam_google_authenticator.so/auth required pam_google_authenticator.so/g' /etc/pam.d/sshd
sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/g' /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication yes/#PasswordAuthentication yes/g' /etc/ssh/sshd_config
sed -i 's/#AllowUsers sshservice/AllowUsers sshservice/g' /etc/ssh/sshd_config
sed -i 's/#AllowUsers sshservice/AllowUsers sshservice/g' /etc/ssh/sshd_config
sed -i 's/AuthenticationMethods password/AuthenticationMethods publickey,keyboard-interactive/g' /etc/ssh/sshd_config

#change le propriétaire/permissions du dossier
chown -R sshservice:sshservice /home/sshservice/.ssh/
chmod 700 /home/sshservice/.ssh/
chmod 600 /home/sshservice/.ssh/authorized_keys

#Restart services
service ssh restart
service fail2ban restart
