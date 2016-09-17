echo ">>>>>>>  JDK8 & Android Studio Offline Installer"
echo ">>>>>>>  ____________by__sziraqui______________"
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
		echo ">>>>>> jdk source exists. Okay"
	else echo ">>>>> jdk source not accessible"
fi
#change jdk variable name if folder name is different
sudo mkdir /usr/lib/jvm
echo ">>>>>> Installing jdk1.8.0u101..."
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
echo "JDK 8 INSTALLED!!!"
echo " "
sysVer=$(lsb_release -r -s)
touch /home/${user}/$sysVer.szi
if [ -e /home/${user}/x86_64.szi ]
	then
	sudo dpkg --add-architecture i386
	echo ">>>>>> Installing AS dependencies..."
	echo " "
	touch /home/$user/$sysVer.szi
	if [ -e /home/$user/16.10.szi ]
		then
			sudo dpkg -i AS_depends/yakkety/depends/subdepends/*.deb
			sudo dpkg -i AS_depends/yakkety/depends/*.deb
	elif [ -e /home/$user/16.04.szi ]
		then
			sudo dpkg -i AS_depends/xenial/depends/subdepends/*.deb
			sudo dpkg -i AS_depends/xenial/depends/*.deb
	elif [ -e /home/$user/15.10.szi ]
		then
			sudo dpkg -i AS_depends/wily/depends/subdepends/*.deb
			sudo dpkg -i AS_depends/wily/depends/*.deb
	elif [ -e /home/$user/15.04.szi ]
		then
			sudo dpkg -i AS_depends/vivid/depends/subdepends/*.deb
			sudo dpkg -i AS_depends/vivid/depends/*.deb
	elif [ -e /home/$user/14.10.szi ]
		then
			sudo dpkg -i AS_depends/trusty/depends/subdepends/*.deb
			sudo dpkg -i AS_depends/trusty/depends/*.deb
	elif [ -e /home/$user/14.04.szi ]
		then
			sudo dpkg -i AS_depends/trusty/depends/subdepends/*.deb
			sudo dpkg -i AS_depends/trusty/depends/*.deb
	fi
fi
echo " "
echo ">>>>>> Configuring ADB usb access..."
sudo cp linux_usb_access/70-android-tools-fastboot.rules /lib/udev/rules.d
echo " "
echo ">>>>>> Started Installing Android Studio..."
if [ -d /usr/local/android-studio ]
	then
		echo ">>>>>> Removing existing AS-IDE..."
		sudo rm -rf /usr/local/android-studio
		sudo rm -rf /home/${user}/Android
		sudo rm -rf /home/${user}/.android
		sudo rm -rf /home/${user}/.AndroidStudio2.1
		sudo rm -rf /home/${user}/.gradle
		sudo rm /usr/share/applications/Android_Studio.png
fi
echo " "
echo ">>>>>> Installing AS-IDE..."
echo " "
sudo cp -r android-studio /usr/local/
echo ">>>>>> Installing sdk..."
cp -r sdk/Android /home/${user}
#cp -r sdk/.android /home/${user}
#cp -r sdk/.AndroidStudio2.1 /home/${user}
#cp -r sdk/.gradle /home/${user}
#mkdir /home/${user}/AndroidStudioProjects
export PATH=$PATH:/home/${user}/Android/Sdk/platform-tools
sudo mv /usr/local/android-studio/Android_Studio.desktop /usr/share/applications
echo ">>>>>> ANDROID STUDIO INSTALLED!!!!"









