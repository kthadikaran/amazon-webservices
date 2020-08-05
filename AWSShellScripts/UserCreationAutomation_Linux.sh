#!/bin/bash 
#current users
cat /etc/passwd | grep -v centos:x: | grep :x:[0-9][0-9][0-9][0-9]:[0-9][0-9][0-9][0-9]: | grep :/bin/bash | cut -d ':' -f1 | sort > currentusers
#disabled users
cat /etc/passwd | grep -v centos:x: | grep :x:[0-9][0-9][0-9][0-9]:[0-9][0-9][0-9][0-9]: | grep :/sbin/nologin | cut -d ':' -f1 | sort > disabledusers
#updatedusers
cat original.csv | cut -d ',' -f1 | sort > users
#deluser
diff currentusers users | grep "<" | cut -d ' ' -f2 > delusers 
while read f1 ; 
do
	usermod -s /sbin/nologin $f1
	passwd -l $f1
	> /home/$f1/.ssh/authorized_keys
done < delusers
#addusers
diff currentusers users | grep ">" | cut -d '>' -f2 |  cut -d ' ' -f2 > add-users 
grep -Ff disabledusers add-users > enable-users 
grep -Fwf enable-users original.csv > enableusers 
while IFS=',' read f1 f2 f3 ; 
do
	usermod -s /bin/bash $f1
        passwd -u $f1
	echo $f3 > /home/$f1/.ssh/authorized_keys 
done < enableusers 

cat /etc/passwd | grep -v centos:x: | grep :x:[0-9][0-9][0-9][0-9]:[0-9][0-9][0-9][0-9]: | grep :/bin/bash | cut -d ':' -f1 | sort > currentusers1 
diff currentusers users | grep ">" | cut -d '>' -f2 |  cut -d ' ' -f2 > add-users1 
grep -Fwf add-users1 original.csv > addusers 
while IFS=',' read f1 f2 f3 ; 
do
	useradd $f1
	mkdir /home/$f1/.ssh
	chown $f1:$f1 /home/$f1/.ssh
	chmod 700 /home/$f1/.ssh
	touch /home/$f1/.ssh/authorized_keys
	chown $f1:$f1 /home/$f1/.ssh/authorized_keys
	chmod 600 /home/$f1/.ssh/authorized_keys
	echo $f3 > /home/$f1/.ssh/authorized_keys 
done < addusers
#add sudo
grep ,sudo, original.csv | cut -d ',' -f1 > sudousers 
while read f1 ; 
do 
	usermod -a -G  wheel $f1
done < sudousers
#remove sudo
grep ",," original.csv | cut -d ',' -f1 > normalusers 
while read f1 ; 
do 
	gpasswd -d $f1 wheel
done < normalusers
rm currentusers disabledusers users delusers add-users enable-users enableusers currentusers1 add-users1 addusers sudousers normalusers
