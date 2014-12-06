# ex: set tabstop=4 noexpandtab: 
VERSION = $(shell cat VERSION)
NAME=meta-wearable
TAGVER = $(shell cat VERSION | sed -e "s/\([0-9\.]*\).*/\1/")
DESTDIR=
ARCH=i586

ifeq ($(VERSION), $(TAGVER))
        TAG = $(TAGVER)
else
        TAG = "HEAD"
endif

all:

install:
	install -d ${DESTDIR}/usr/share/image-configurations/wearable/configs
	install -d ${DESTDIR}/usr/share/image-configurations/wearable/custom
	install -d ${DESTDIR}/usr/share/image-configurations/wearable/scripts
	install -d ${DESTDIR}/usr/share/image-configurations/wearable/partitions
	install -d ${DESTDIR}/usr/share/package-groups/wearable
	install -m 644 wearable.yaml ${DESTDIR}/usr/share/image-configurations/wearable
	install -m 644 wearable-repos.yaml ${DESTDIR}/usr/share/image-configurations/wearable
	install -m 644 wearable-targets.yaml ${DESTDIR}/usr/share/image-configurations/wearable
	install -m 644 ks/*.yaml ${DESTDIR}/usr/share/image-configurations/wearable/configs
	install -D partitions/* ${DESTDIR}/usr/share/image-configurations/wearable/partitions
	install -D scripts/* ${DESTDIR}/usr/share/image-configurations/wearable/scripts
	install -m 644 patterns/*.yaml ${DESTDIR}/usr/share/package-groups/wearable

test:
	merge-patterns -o output/ -p patterns -s
	kickstarter -c wearable.yaml -e ks -r wearable-repos.yaml

tag:
	git tag -a $(VERSION) -m "$(VERSION)"
	git push --tags

changelog:
	python ./scripts/gitlog2changelog.py


dist-bz2:
	git archive --format=tar --prefix=$(NAME)-$(VERSION)/ $(TAG) | \
		bzip2  > $(NAME)-$(VERSION).tar.bz2

dist-gz:
	git archive --format=tar --prefix=$(NAME)-$(VERSION)/ $(TAG) | \
		gzip  > $(NAME)-$(VERSION).tar.gz

dist: dist-bz2

clean:
	rm -rf patterns.xml INDEX.xml group.xml *.xml
