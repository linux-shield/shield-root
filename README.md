Root for NVIDIA SHIELD & Tegra Note 7
=====================================

This is a very basic rooting method for NVIDIA SHIELD and Tegra Note 7, which uses a Linux kernel and a simple ramdisk to install SuperSU [1] on an unlocked device. It should work with any Android version, including 4.3.

[1] https://play.google.com/store/apps/details?id=eu.chainfire.supersu

Obligatory Scary Disclaimer
---------------------------
Please read this section at least 3 times before proceeding.

This is not for the faint of heart or the clueless. This method comes without any warranty and you take sole responsibility for anything bad that might happen. You **really** want to make sure that you understand this document fully and consider the consequences of unlocking and rooting your device before proceeding. Following this guide will irreversibly **VOID YOUR WARRANTY** and **ERASE YOUR USER DATA**. There is no way back - your device will be marked as having been unlocked and **WARRANTY-VOID FOREVER**, even if you re-lock the bootloader afterwards. Also, unlocking your device will leave you more vulnerable to malware and errors that can potentially damage it and turn your new Tegra Note into a breadboard and your shiny SHIELD into a slightly oversized belt buckle.

Do not expect **any** kind of support from anyone if you don't understand this guide or if something goes wrong. It goes without saying that everything said here is unofficial and unsupported by NVIDIA.

You have been warned! Better stop now.

Requirements
------------
- Locked or unlocked SHIELD or Tegra Note 7
- Fastboot binary

Getting root is done in two steps: first, we will unlock the bootloader, then boot a custom OS image that will add SuperSU to our Android system partition.

Unlocking
---------
If your device is already unlocked, you can skip this section.

SHIELD and Tegra Note 7 ship with an unlockable bootloader. The bootloader is locked by default, which prevents anyone (including yourself) from booting custom OSes and changing system partitions to potentially obtain extra privileges. This is a significant security feature: in the event that your device gets stolen, an attacker will not be able to retrieve your personal data or use your device if your lock screen has a password set.

By unlocking the bootloader, you allow anyone with physical access to your device to boot custom images and flash system partitions. This opens the way for an attacker to access your personal information or physically damage your device. For this reason, unlocking the bootloader will erase all your personal data like a factory reset does (so a potential thief cannot get it) and will also void your warranty.

If you know you really, really want to take these risks, here is how you unlock the bootloader.

1. Switch your device off (long press the power button and select `Power off`).
2. **For SHIELD:** power your SHIELD on while maintaining the `back` and `home` buttons pressed (these are the two buttons that lie under the big NVIDIA-logo button, on its left and right). Release them once you see the bootloader screen.

   **For TN7:** power the tablet on while maintaining the `volume up` button pressed. Release it once you see the bootloader screen.
3. Connect your device to your computer using a USB cable.
4. On your computer, enter the following command:

        fastboot oem unlock

5. This will display the unlock menu. Read the disclaimer and think one last time about what you are doing. This is your last chance to stop.
6. Use the `back` and `home` buttons on SHIELD and `volume up`/`volume down` on TN7 to select your option. If you decide to continue, select `Unlock` and press the NVIDIA-logo button on SHIELD or `power` button on TN7 to validate. Your personal data will be erased and your device marked as warranty-void permanently.
7. Regardless of your choice, you will be back to the bootloader screen. Using the same buttons, navigate to `Poweroff` and select this to power your device off.

Rooting
-------
Now your bootloader is unlocked, but you still don't have root access. For this, we need to install SuperSU, and we will do so by booting a custom Linux image that will install it for us.

1. Download the boot image corresponding to your device:

   **For SHIELD:** https://github.com/linux-shield/shield-root/blob/master/root_shield.img?raw=true

   **For TN7:** https://github.com/linux-shield/shield-root/blob/master/root_tn7.img?raw=true
2. **For SHIELD:** power your SHIELD on while maintaining the `back` and `home` buttons pressed (these are the two buttons that lie under the big NVIDIA-logo button, on its left and right). Release them once you see the bootloader screen.

   **For TN7:** power the tablet on while maintaining the `volume up` button pressed. Release it once you see the bootloader screen.

   If the above does not work, try enabling `USB debugging` in the `Developer options` from Android, then issue `adb reboot-bootloader` while your device is connected to your PC via USB.
3. Connect your device to your computer using a USB cable
4. On your computer, navigate into the directory containing the downloaded image and enter the following command:

   **For SHIELD:** `fastboot boot root_shield.img`

   **For TN7:** `fastboot boot root_tn7.img`

The image will be downloaded and started. You will see 4 penguins on your screen, and the root procedure will start. It should take a few seconds to complete. Once it is done, your device will reboot. Congratulations, you are rooted!

For some unknown reason `USB debugging` in `Developer options` might become unchecked after rooting. You will need to re-check it if you want to use ADB.

It is safe to perform the rooting operation as many times as you want (e.g. after an OTA). Your user data will not be erased by rooting itself, it is the act of unlocking the bootloader that does.

Unrooting and re-locking
------------------------
If for some reason you want to unroot and re-lock your device, this is possible. It won't bring your warranty back, but you will at least enjoy the security benefits of a locked device.

Unrooting the device can be done by running the SuperSU application, going into its settings, and choosing `Full unroot`. This will remove all traces of SuperSU.

Then you will likely want to relock your device. Enter the bootloader again, connect your device to your computer via a USB cable, and issue the following command:

    fastboot oem lock

Then on the screen, select `Lock`. Your bootloader will be locked again. Note that your warranty is not coming back - that red message in the bootloader menu is here to stay forever.

Troubleshooting
---------------
This method is completely unofficial and you are on your own. No support whatsoever from anyone. Don't do this if you don't understand and accept the potential consequences.

Rebuilding
----------
The necessary binaries are already in this repository, but if you want to build things by yourself, here is how you do:

1. Compile a bootable kernel zImage from this project: https://github.com/linux-shield/kernel, and copy it into this directory. The binary included replaces the `ignore_loglevel` kernel command-line option with `loglevel=0` to remove kernel log messages.
2. Also copy the `tegra114-roth.dtb` and `tegra114-tn7.dtb` files into this directory.
2. Run `make` into the present project to rebuild it. The SuperSU binaries are in the `rootkit` subdirectory and the script that performs rooting is `/init`.

You can now run `fastboot boot` to boot on the images you built yourself.

Source release
--------------
This binary release uses an unmodified version of Busybox, which source code can be downloaded at https://github.com/linux-shield/busybox. User-space is built from the `examples/bootfloppy` directory with slight modifications to use `mdev`, mount filesystems, and install SuperSU.

This package, as Busybox, is distributed under the terms of the GNU General Public License, version 2. See the LICENSE file for details.

SuperSU is redistributed in its free, unmodified version as kindly permitted by its author.
