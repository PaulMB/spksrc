SPK_NAME = MediaAdapter
SPK_VERS = 0.1
SPK_REV = 0
SPK_ICON = src/media-adapter.png
DSM_UI_DIR = app
DSM_APP_NAME=Media.adapter.AppInstance
FIRMWARE=5.0-4447

DEPENDS = cross/media-adapter

MAINTAINER = SynoCommunity
DESCRIPTION = Tool to interact with media containers, typically MKV files. In particular, it may be used add or remove tracks like subtitles to an existing container
DESCRIPTION_FRE = Outil d\\\'édition de conteneurs multimédia, par exemple des fichiers MKV. Peut notament être utilisé pour ajouter ou enlever des pistes à un conteneur existant
STARTABLE = yes
DISPLAY_NAME = Media Adapter

HOMEPAGE   = https://github.com/PaulMB/media-adapter
LICENSE    = Apache 2.0
HELPURL    = https://github.com/PaulMB/media-adapter

INSTALLER_SCRIPT = src/installer.sh
SSS_SCRIPT       = src/dsm-control.sh

INSTALL_PREFIX = /usr/local/$(SPK_NAME)

COPY_TARGET = nop
POST_STRIP_TARGET = media_adapter_extra_install

override ARCH=

PROJECT_DIR=work/media-adapter-$(SPK_VERS)/media-adapter-synology
RESOURCE_DIR=$(PROJECT_DIR)/src/main
TARGET_DIR=$(PROJECT_DIR)/target

include ../../mk/spksrc.spk.mk

.PHONY: media_adapter_extra_install
media_adapter_extra_install:
	install -m 755 -d $(STAGING_DIR)/var
	install -m 755 -d $(STAGING_DIR)/etc
	install -m 755 -d $(STAGING_DIR)/lib
	install -m 644 $(RESOURCE_DIR)/package/etc/dsm-authenticator.xml $(STAGING_DIR)/etc/dsm-authenticator.xml
	install -m 644 $(RESOURCE_DIR)/package/etc/http.conf $(STAGING_DIR)/etc/http.conf
	install -m 644 $(RESOURCE_DIR)/package/etc/media-adapter.xml $(STAGING_DIR)/etc/media-adapter.xml
	install -m 644 $(RESOURCE_DIR)/package/etc/mkvmerge.xml $(STAGING_DIR)/etc/mkvmerge.xml
	install -m 644 $(RESOURCE_DIR)/package/etc/Media.Adapter.legacy.conf $(STAGING_DIR)/etc/Media.Adapter.legacy.conf
	install -m 755 -d $(STAGING_DIR)/app
	install -m 644 src/app/config $(STAGING_DIR)/app/config
	install -m 644 $(RESOURCE_DIR)/webapp/index.conf $(STAGING_DIR)/app/index.conf
	install -m 644 $(RESOURCE_DIR)/webapp/helptoc.conf $(STAGING_DIR)/app/helptoc.conf
	install -m 644 $(TARGET_DIR)/$(SPK_NAME)-$(SPK_VERS)/minify/style.min.css $(STAGING_DIR)/app/style.css
	install -m 644 $(TARGET_DIR)/$(SPK_NAME)-$(SPK_VERS)/minify/adapter.min.js $(STAGING_DIR)/app/adapter.js
	install -m 755 -d $(STAGING_DIR)/doc
	install -m 644 $(RESOURCE_DIR)/package/doc/* $(STAGING_DIR)/doc/
	install -m 644 $(TARGET_DIR)/generated-resources/licenses/* $(STAGING_DIR)/doc/
	install -m 755 -d $(STAGING_DIR)/app/help
	for language in enu; do \
		install -m 755 -d $(STAGING_DIR)/app/help/$${language}; \
		install -m 644 $(RESOURCE_DIR)/webapp/help/$${language}/index.html $(STAGING_DIR)/app/help/$${language}/index.html; \
	done
	install -m 755 -d $(STAGING_DIR)/app/texts
	for language in enu; do \
		install -m 755 -d $(STAGING_DIR)/app/texts/$${language}; \
		install -m 644 src/app/texts/$${language}/strings $(STAGING_DIR)/app/texts/$${language}/strings; \
	done
	install -m 755 -d $(STAGING_DIR)/app/images
	for size in 16 24 32 48 72 90; do \
		convert $(SPK_ICON) -thumbnail $${size}x$${size} \
		        $(STAGING_DIR)/app/images/media$${size}.png ; \
	done
	mvn -f $(WORK_DIR)/media-adapter-$(SPK_VERS)/pom.xml \
	    dependency:copy-dependencies \
	    -DoutputDirectory=$(STAGING_DIR)/lib \
	    -DincludeScope=runtime \
	    -DexcludeArtifactIds=jmf
