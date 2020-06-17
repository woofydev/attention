include $(THEOS)/makefiles/common.mk
ARCHS = arm64 arm64e

BUNDLE_NAME = attentionprefs 

TARGET = iphoneos:clang:13.2:13.2
SYSROOT = /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS13.2.sdk
attentionprefs_FILES = APRRootListController.m 
attentionprefs_INSTALL_PATH = /Library/PreferenceBundles
attentionprefs_FRAMEWORKS = UIKit
attentionprefs_PRIVATE_FRAMEWORKS = Preferences
attentionprefs_EXTRA_FRAMEWORKS += Cephei CepheiPrefs
attentionprefs_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/attentionprefs.plist$(ECHO_END)
