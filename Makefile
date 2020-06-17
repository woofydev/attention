FINALPACKAGE=1
DEBUG = 0

INSTALL_TARGET_PROCESSES = SpringBoard

ARCHS = arm64 arm64e

include  $(THEOS_MAKE_PATH)/common.mk

TWEAK_NAME = attention

attention_FILES = Tweak.x
attention_CFLAGS = -fobjc-arc
attention_EXTRA_FRAMEWORKS += Cephei

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += attentionprefs
include $(THEOS_MAKE_PATH)/aggregate.mk