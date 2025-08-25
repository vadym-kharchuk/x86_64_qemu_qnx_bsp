
ROOT_DIR := $(notdir $(CURDIR))
ifndef QCONFIG
QCONFIG=qconfig.mk
endif
include $(QCONFIG)
unexport ROOT_DIR

.PHONY: all install clean links make_links dummy images prebuilt binaries


SUFFIXES := .mk

all: images
	@echo done

clean:
	-$(RM_HOST) -r ifs.bin

images:
	mkifs ifs.build ifs.bin


