
##############################################################
#
# AESD-ASSIGNMENTS
#
##############################################################

#TODO: Fill up the contents below in order to reference your assignment 3 git contents
AESD_ASSIGNMENTS_VERSION = 5c0822240799efc7b9b71a931f251691e26f8875
# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:

AESD_ASSIGNMENTS_SITE = git@github.com:cu-ecen-aeld/assignments-3-and-later-KirSpaceB.git
AESD_ASSIGNMENTS_SITE_METHOD = git
AESD_ASSIGNMENTS_GIT_SUBMODULES = YES

define AESD_ASSIGNMENTS_BUILD_CMDS
	# build writer (assignment 4 stuff)
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/finder-app writer

	# build aesdsocket (assignment 5 part 2 stuff)
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/server clean
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/server
endef

define AESD_ASSIGNMENTS_INSTALL_TARGET_CMDS
	# aesdsocket binary
	$(INSTALL) -D -m 0755 $(@D)/server/aesdsocket $(TARGET_DIR)/usr/bin/aesdsocket

	# init script to start at boot
	$(INSTALL) -D -m 0755 $(@D)/server/aesdsocket-start-stop $(TARGET_DIR)/etc/init.d/S99aesdsocket

	# writer binary
	$(INSTALL) -m 0755 $(@D)/finder-app/writer $(TARGET_DIR)/usr/bin/

	# finder scripts (put them in PATH)
	$(INSTALL) -m 0755 $(@D)/finder-app/finder.sh $(TARGET_DIR)/usr/bin/finder.sh
	$(INSTALL) -m 0755 $(@D)/finder-app/finder-test.sh $(TARGET_DIR)/usr/bin/finder-test.sh

	# configs needed by finder-test.sh
	$(INSTALL) -d 0755 $(TARGET_DIR)/etc/finder-app/conf/
	$(INSTALL) -m 0644 $(@D)/conf/* $(TARGET_DIR)/etc/finder-app/conf/
endef

$(eval $(generic-package))
