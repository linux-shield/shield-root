ramfs.img.gz:
	find . ! -iname Makefile ! -iname $@ |grep -v "\\.git*" |cpio -o --format=newc |gzip -c - > $@
