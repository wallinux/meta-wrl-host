FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
	file://0001-linux-user-assume-__NR_gettid-always-exists.patch \
	file://0001-linux-user-rename-gettid-to-sys_gettid-to-avoid-clas.patch \
	"
		      
SRC_URI_append_class-native = " file://0001-linux-user-remove-host-stime-syscall.patch"
