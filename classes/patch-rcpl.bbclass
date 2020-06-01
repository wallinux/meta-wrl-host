# Implement a variable to be used when we want to apply patches to
# a specific range of RCPLs.
#
# Example usage:
#
# SRC_URI_RCPL_ISSUE = "issue1"
# SRC_URI_RCPL_issue1[2] = "file://my_diff.patch"
#   will apply the patch to SRC_URI for all RCPLs, starting with RCPL0002 upwards
#
# SRC_URI_RCPL_ISSUE += "issue2"
# SRC_URI_RCPL_issue2[3-6] = "file://my_diff2.patch"
#   will apply the patch to SRC_URL for all RCPLs between RCPL0003 and RCPL0006
#

python() {
    current_rcpl = int(d.getVar("DISTRO_VERSION").split(".")[3])
    #bb.debug(1,"RCPLPATCH current_rcpl: %d" % (current_rcpl))

    rcpl_issues = (d.getVar("SRC_URI_RCPL_ISSUE") or "").split()
    for issue in rcpl_issues:
        issue_var = "SRC_URI_RCPL_"+issue
        rcpl_range = list(d.getVarFlags(issue_var).keys())[0].split("-")
        src_uri = list(d.getVarFlags(issue_var).values())[0]

        min_rcpl = int(rcpl_range[0])
        if len(rcpl_range) == 1:
            max_rcpl = current_rcpl
        else:
            max_rcpl = int(rcpl_range[1])

        if current_rcpl >= min_rcpl and current_rcpl <= max_rcpl:
             bb.debug(1,"RCPLPATCH %s: SRC_URI += %s" % (issue_var, src_uri))
             d.appendVar('SRC_URI', src_uri)
}
