@echo OFF
if not exist recovery.img cp lineage-*-recovery-*.img recovery.img 
adb reboot bootloader
fastboot flash boot recovery.img
fastboot reboot bootloader
ping -n 5 127.0.0.1 >nul
echo : # Flasing downloaded "./lineage-*", "./MindTheGapps*" and "./Magisk" packages
echo : ? "lineage-*-signed.zip" is downloaded?
echo : ! Press [Volume] the to select "Recovery Mode".
echo : ! Tap "Factory Reset", then "Format data / factory reset" and continue with the formatting process.
echo : * This will remove encryption and delete all files stored in the internal storage, as well as format your cache partition.
echo : ! Return to the main menu.
echo : ! On the device, select "Apply Update", then "Apply from ADB" for Sideload.
ping -n 15 127.0.0.1 >nul
echo : * Continue to Sideload LineageOS package
pause
if not exist LineageOS.zip cp lineage-*-signed.zip LineageOS.zip
ping -n 5 127.0.0.1 >nul
adb sideload LineageOS.zip
ping -n 5 127.0.0.1 >nul
echo : ---
echo : # Continue to Sideload MindTheGapps:
echo : ? "MindTheGapps*.zip" is downloaded?
echo : ! Return to the main menu.
echo : ! "Advanced" .. "Reboot to Recovery",
echo : ! On the device, select "Apply Update", then "Apply from ADB" for Sideload.
echo : * Continue to Sideload the MindTheGapps*.zip
echo : * or Ctrl+C can Cancel to Sideload the MindTheGapps*.zip
pause
if not exist MindTheGapps.zip cp MindTheGapps*.zip MindTheGapps.zip
ping -n 5 127.0.0.1 >nul
adb sideload MindTheGapps.zip
ping -n 5 127.0.0.1 >nul
echo : ! Return to the main menu.
echo : ! "Reboot system now",
echo : ---
PATH=%PATH%;"%SYSTEMROOT%\System32"
echo : # Rooting/Magisk info here: https://github.com/topjohnwu/Magisk
echo : ? "Magisk-*.apk" is downloaded?
echo : ! Boot into system and enable ADB then,
echo : * continue to install Magisk
echo : * or Ctrl+C can Cancel installing Magisk
pause
if not exist magisk.apk cp Magisk-*.apk magisk.apk
adb install -r magisk.apk
ping -n 5 127.0.0.1 >nul
adb push recovery.img /sdcard
adb shell monkey -p com.topjohnwu.magisk -c android.intent.category.LAUNCHER 1
adb shell input keyevent 26
adb shell input keyevent KEYCODE_WAKEUP
echo : ! Tap "Install" in Magisk
echo : ! Tap "Select and Patch a File"
echo : ! Select the "/recovery.img" file
ping -n 5 127.0.0.1 >nul
echo : ! Tap "LET'S GO"
ping -n 5 127.0.0.1 >nul
echo : * After "All done!" appear on screen,
echo : * continue to pull the patched Recovery
pause
if not exist magisk.img adb pull /sdcard/Download/ .
if not exist magisk.img cp Download/magisk_patched-*.img magisk.img
adb reboot bootloader
fastboot flash boot magisk.img
fastboot reboot
echo : :-) All done! 
echo : Press any key to exit...
pause >nul
exit
