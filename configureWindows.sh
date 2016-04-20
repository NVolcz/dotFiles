#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

# Backup registry
readonly backupPath="$(cygpath -w ${USERPROFILE})"
readonly regtool="$(which regtool)"


function backup() {
	subkey=$(sed -e 's:.*\\::' <<< $1 )
	regPath=${1#"\\"}
	regPath=$(sed -r 's:/:\\:g' <<< ${regPath})
	# we could use the /y to force overwrite but don't want to overwrite our backups
	reg export "${regPath}" "${backupPath}/${subkey}_backup.reg"
}

backup "HKEY_CURRENT_USER" "$backupPath/full_backup.reg"
# Keys
readonly control_panel_key="\HKEY_CURRENT_USER\Control Panel"
readonly desktop_key="${control_panel_key}\HKEY_CURRENT_USER\Control Panel\Desktop"
readonly window_metric_key="${desktop_key}\WindowMetrics"
readonly accessibility_key="${control_panel_key}\Accessibility"
readonly one_drive_explorer_key="\HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\System.IsPinnedToNameSpaceTree"
backup "${accessibility_key}"
backup "${one_drive_explorer_key}"

regtool set $one_drive_explorer_key -d 00000000
# Test
# echo $(regtool list "${window_metric_key}")

