#!/usr/bin/env bash
set -euo pipefail

for f in "$@"; do 
  if head -n 2 $f | tail -1 | grep -q "set -euo pipefail"; then
    echo "$f has"
  else
    echo "$f have not"
    #sed -i '2iset -euo pipefail' $f
  fi

  # Check that bash file shebang uses /usr/bin/env bash 
  if ! head -n 1 $f | grep -q '#!/usr/bin/env bash'; then
    echo "$f has incorrect shebang"
    #sed -i '2iset -euo pipefail' $f
  fi
done
