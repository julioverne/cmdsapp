include theos/makefiles/common.mk

SUBPROJECTS += getappdir
SUBPROJECTS += getapplist

include $(THEOS_MAKE_PATH)/aggregate.mk

all::
	
