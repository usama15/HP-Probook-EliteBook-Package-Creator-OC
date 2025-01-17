# Applescript create by chris1111
# Install Media HP Laptop OC Copyright (c) 2020 chris1111 All rights reserved.
# No right on OpenCore Bootloader

set theAction to button returned of (display dialog "
Welcome Install Media HP Laptop OC

You can create a bootable USB key 
from macOS 10.12 to macOS Big Sur 11
		
Format your USB Drive with Disk Utility 
in the format Mac OS Extended (Journaled) 
GUID Partition Map

*****************************
You must quit Disk Utility to continue 
installation !" with icon note buttons {"Quit", "Create Install Media"} cancel button "Quit" default button {"Create Install Media"})

--If Create Install Media
if theAction = "Create Install Media" then
	
	tell application "Disk Utility"
		activate
	end tell
	
	repeat
		if application "Disk Utility" is not running then exit repeat
		end repeat
	activate me
	set all to paragraphs of (do shell script "ls /Volumes")
	set w to choose from list all with prompt " 
Pour pouvoir continuer, sélectionner le volume 
que vous venez de formater.
Ensuite appuyez sur le bouton OK" OK button name "OK" with multiple selections allowed
	if w is false then
		display dialog "Quitter Installer" with icon note buttons {"SORTIR"} default button {"SORTIR"}
		
		return
	end if
	try
		repeat with teil in w
			do shell script "diskutil `diskutil list | awk '/ " & teil & "  / {print $NF}'`" with administrator privileges
		end repeat
	end try
	
	
	set source to path to me as string
	set source to POSIX path of source & "Contents/Resources/Installer/VolumePackage.pkg"
	set source to quoted form of source
	
	do shell script ¬
		"installer -pkg  " & source & " -target \"" & w & "\"" with administrator privileges
	delay 1
	--If Continue		
			set theAction to button returned of (display dialog "

Choose the location of your Install macOS.app" with icon note buttons {"Quit", "macOS 10.12", "10.13 to Big Sur 11"} cancel button "Quit" default button {"10.13 to Big Sur 11"})
	if theAction = "10.13 to Big Sur 11" then
		--If 10.13 to 10.16
		display dialog "
Your choice is 10.13 to Big Sur 11
Choose your Install OS X.app 
From macOS High Sierra to macOS Big Sur" with icon note buttons {"Quit", "Continue"} cancel button "Quit" default button {"Continue"}
		
		set InstallOSX to choose file of type {"XLSX", "APPL"} default location (path to applications folder) with prompt "Choose your Install macOS.app"
		set OSXInstaller to POSIX path of InstallOSX
		
		delay 2
		
		set progress description to "Create Install Media
======================================
Installation time 15 to 25 min on a standard USB key
3 to 5 min on a Disk Ext HD
======================================
"
		
		set progress total steps to 7
		
		set progress additional description to "Analysing Install macOS"
		delay 2
		set progress completed steps to 1
		
		set progress additional description to "Analysing USB Install Media"
		delay 2
		set progress completed steps to 2
		
		set progress additional description to "Install USB Media OK"
		delay 2
		set progress completed steps to 3
		
		set progress additional description to "Install in Progress "
		delay 1
		set progress completed steps to 4
		
		set progress additional description to "Install in Progress Wait! "
		delay 1
		set progress completed steps to 5
		
		set progress additional description to "Installing macOS  wait . . . ."
		delay 1
		--display dialog cmd
		set cmd to "sudo \"" & OSXInstaller & "Contents/Resources/createinstallmedia\" --volume /Volumes/Install-Media --nointeraction "
		do shell script cmd with administrator privileges
		set progress completed steps to 6
		
		set progress additional description to "Install in Progress 90%"
		delay 2
		set progress completed steps to 7
		set progress additional description to "
Create Install Media Completed ➤ ➤ ➤ 100%
Create Install Media Completed.
OpenCore Installer! "
		delay 3
		set theFile to ((path to me) as string) & "Contents:Resources:Installer:OpenCore USB.pkg"
		tell application "Finder" to open theFile
		
	else if theAction = "macOS 10.12" then
		
		--If 10.9 to 10.12
		display dialog "
macOS 10.12
Choose the location of your Install macOS.app
" with icon note buttons {"Quit", "Continue"} cancel button "Quit" default button {"Continue"}
		
		set InstallOSX to choose file of type {"XLSX", "APPL"} default location (path to applications folder) with prompt "Choose your Install macOS.app"
		set OSXInstaller to POSIX path of InstallOSX
		
		delay 2
		
		set progress description to "Create Install Media
======================================
Installation time 15 to 20 min on a standard USB key
3 to 5 min on a Disk Ext HD
======================================
"
		
		set progress total steps to 7
		
		set progress additional description to "Analysing Install macOS"
		delay 2
		set progress completed steps to 1
		
		set progress additional description to "Analysing USB Install Media"
		delay 2
		set progress completed steps to 2
		
		set progress additional description to "Install USB Media OK"
		delay 2
		set progress completed steps to 3
		
		set progress additional description to "Install in Progress "
		delay 1
		set progress completed steps to 4
		
		set progress additional description to "Install in Progress Wait! "
		delay 1
		set progress completed steps to 5
		
		set progress additional description to "Installing macOS  wait . . . ."
		delay 1
		--display dialog cmd
		set cmd to "sudo \"" & OSXInstaller & "Contents/Resources/createinstallmedia\" --volume /Volumes/Install-Media --applicationpath \"" & OSXInstaller & "\" --nointeraction "
		do shell script cmd with administrator privileges
		set progress completed steps to 6
		
		set progress additional description to "Install in Progress 90%"
		delay 2
		set progress completed steps to 7
		set progress additional description to "
Create Install Media Completed ➤ ➤ ➤ 100%
Create Install Media Completed.
OpenCore Installer! "
		delay 3
		set theFile to ((path to me) as string) & "Contents:Resources:Installer:OpenCore USB.pkg"
		tell application "Finder" to open theFile
	end if
end if