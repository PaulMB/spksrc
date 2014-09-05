PKG_NAME = media-adapter
PKG_VERS_SHORT = 0.1
PKG_VERS = v$(PKG_VERS_SHORT)
PKG_EXT = tar.gz
PKG_DIST_NAME = $(PKG_VERS).$(PKG_EXT)
PKG_DIST_SITE = https://github.com/PaulMB/media-adapter/archive
PKG_DIR = $(PKG_NAME)

DEPENDS = 

HOMEPAGE = https://github.com/PaulMB
LICENSE  = Apache 2.0

EXTRACT_PATH = $(WORK_DIR)
CONFIGURE_TARGET = nop
COMPILE_TARGET = media-adapter-compile
INSTALL_TARGET = nop

include ../../mk/spksrc.cross-cc.mk

.PHONY: media-adapter-compile
media-adapter-compile:
	mvn -f $(WORK_DIR)/$(PKG_NAME)-$(PKG_VERS_SHORT)/pom.xml clean install -DskipTests
