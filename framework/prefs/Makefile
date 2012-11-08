include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = GremlinPreferences
GremlinPreferences_FILES = prefs.mm
GremlinPreferences_INSTALL_PATH = /Library/PreferenceBundles
GremlinPreferences_FRAMEWORKS = UIKit
GremlinPreferences_PRIVATE_FRAMEWORKS = Preferences
GremlinPreferences_CFLAGS += -Iinclude

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/prefs.plist$(ECHO_END)
