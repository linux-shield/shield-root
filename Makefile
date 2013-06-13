ramfs.img.gz:
	find . ! -iname README.md ! -iname LICENSE ! -iname Makefile ! -iname $@ |grep -v "\\.git*" |cpio -o --format=newc |gzip -c - > $@
