all: root_shield.img root_tn7.img

ramfs.img.gz:
	find . ! -iname README.md ! -iname LICENSE ! -iname Makefile ! -iname "zImage*" ! -iname "*.dtb" ! -iname "*.img" ! -iname $@ |grep -v "\\.git*" |cpio -o --format=newc |gzip -c - > $@

zImage_roth: zImage tegra114-roth.dtb
	cat $^ >$@

root_shield.img: zImage_roth ramfs.img.gz
	mkbootimg --kernel $< --ramdisk ramfs.img.gz -o $@

zImage_tn7: zImage tegra114-tn7.dtb
	cat $^ >$@

root_tn7.img: zImage_tn7 ramfs.img.gz
	mkbootimg --kernel $< --ramdisk ramfs.img.gz -o $@

clean:
	rm -f root_*.img zImage_* ramfs.img.gz
