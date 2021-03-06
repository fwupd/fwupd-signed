include /usr/share/dpkg/default.mk

EFI_NAME := UNKNOWN-EFI-NAME

ifeq ($(DEB_HOST_ARCH),amd64)
EFI_NAME := x64
endif

ifeq ($(DEB_HOST_ARCH),i386)
EFI_NAME := ia32
endif

ifeq ($(DEB_HOST_ARCH),arm64)
EFI_NAME := aa64
endif

ifeq ($(DEB_HOST_ARCH),armhf)
EFI_NAME := arm
endif

SIGNED := \
	fwupd$(EFI_NAME).efi.signed \
	$(NULL)

all: $(SIGNED)

$(SIGNED):
	./download-fwupd

install: $(SIGNED)
	install -d $(DESTDIR)/usr/libexec/fwupd/efi
	install -m0644 $(SIGNED) version \
		$(DESTDIR)/usr/libexec/fwupd/efi/

clean:
	rm -f $(SIGNED) version
