FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_class-native = " file://0001-linux-user-remove-host-stime-syscall.patch"
