#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

# Backup registry
readonly backupPath="$(cygpath -w ${USERPROFILE})"
readonly regtool="$(which regtool)"

function backup() {
  subkey=$(sed -e 's:.*\\::' <<<$1)
  regPath=${1#"\\"}
  regPath=$(sed -r 's:/:\\:g' <<<${regPath})

  if [ ! -z ${2+x} ]; then
    filePath="${backupPath}/${2}"
  else
    filePath="${backupPath}/${subkey}_backup.reg"
  fi

  # we could use the /y to force overwrite but don't want to overwrite our backups
  reg export "${regPath}" "${filePath}"
}

backup "HKLM"
backup "HKCU"
backup "HKCR"
backup "HKU"
backup "HKCC"

# Keys
readonly one_drive_explorer_key="\HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\System.IsPinnedToNameSpaceTree"
readonly personalized_theme_key="\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalized"
readonly app_light_theme_key="${personalized_theme_key}\AppsUseLightTheme"
# backup "${one_drive_explorer_key}"

regtool set $one_drive_explorer_key -d 00000000

# http://fieldguide.gizmodo.com/how-to-unlock-secret-settings-in-windows-10-1780625579
regtool add $personalized_theme_key
regtool set $app_light_theme_key -d 00000000
