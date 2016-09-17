echo ">>>>>>>  JDK8 Offline Installer"
echo ">>>>>>> _____by__sziraqui______"
echo " "
echo " "
user=$(whoami)
touch /home/${user}/$user.szi
echo ">>>>>> Removing old jdk..."
echo " "
apt-cache search java | awk '{print($1)}' | grep -E -e '^(ia32-)?(sun|oracle)-java' -e '^openjdk-' -e '^icedtea' -e '^(default|gcj)-j(re|dk)' -e '^gcj-(.*)-j(re|dk)' -e 'java-common' | xargs sudo apt-get -y remove
sudo apt-get -y autoremove
dpkg -l | grep ^rc | awk '{print($2)}' | xargs sudo apt-get -y purge
sudo bash -c 'ls -d /home/*/.java' | xargs sudo rm -rf
sudo rm -rf /usr/lib/jvm/*
for g in ControlPanel java java_vm javaws jcontrol jexec keytool mozilla-javaplugin.so orbd pack200 policytool rmid rmiregistry servertool tnameserv unpack200 appletviewer apt extcheck HtmlConverter idlj jar jarsigner javac javadoc javah javap jconsole jdb jhat jinfo jmap jps jrunscript jsadebugd jstack jstat jstatd native2ascii rmic schemagen serialver wsgen wsimport xjc xulrunner-1.9-javaplugin.so; do sudo update-alternatives --remove-all $g; done
echo ">>>>>> Installing jdk1.8 for all users..."
jdk=jdk1.8.0_101
sudo rm /home/${user}/*.szi
arch=$(uname -i)
touch /home/${user}/$arch.szi
if [ -e /home/${user}/x86_64.szi ]
	then
		jdksource=64-bit
	else jdksource=32-bit
fi
if [ -d $jdksource/$jdk ]
	then
		echo ">>>>>> jdk source exists. [Okay]"
	else echo ">>>>> jdk source not accessible or doesn't exist!"
fi
#change jdk variable name if folder name is different
sudo mkdir /usr/lib/jvm
sudo cp -r ${jdksource}/${jdk} /usr/lib/jvm
echo ">>>>>> running update-alternatives..."
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/${jdk}/jre/bin/java 2000
echo ">>>>>> updating java path variables..."
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/${jdk}/bin/javac 2000
export J2SDKDIR=/usr/lib/jvm/${jdk}
export J2REDIR=/usr/lib/jvm/${jdk}/jre
export PATH=$PATH:/usr/lib/jvm/${jdk}/bin:/usr/lib/jvm/${jdk}/db/bin:/usr/lib/jvm/${jdk}/jre/bin
export JAVA_HOME=/usr/lib/jvm/${jdk}
export DERBY_HOME=/usr/lib/jvm/${jdk}/db
java -version
echo ">>>>>> JDK 8 INSTALLED!!!"

