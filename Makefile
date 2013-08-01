ramfs.img.gz:
	find . ! -iname README.md ! -iname LICENSE ! -iname Makefile ! -iname zImage_dtb ! -iname $@ |grep -v "\\.git*" |cpio -o --format=newc |gzip -c - > $@
