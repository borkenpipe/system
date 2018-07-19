#!/usr/bin/env bash

SYSTEM_PATH_BIN=${SYSTEM_PATH_BIN:-"$HOME/bin"}
SYSTEM_PATH_ETC=${SYSTEM_PATH_ETC:-"$HOME/etc"}
SOURCE_DIR_SYSTEM=${SYSTEM_PATH_BIN}
source "${SYSTEM_PATH_BIN}/common/includer.sh"
script_include "common/util.sh"
script_include "common/osdetect"

bann "Processing hosts out of hosts.csv"
declare -A THE_MAP
while read -r line ; do
    debug "Processing: $line"
    # shellcheck disable=SC2086
    COLOR_NAME=$(echo $line | awk -F ',' '$1!=""{print $2}')
    # shellcheck disable=SC2086
    COLOR_HOST=$(echo $line | awk -F ',' '$1!=""{print $1}')
    COLOR_HOST_TPUT=$(echo $line | awk -F ',' '$1!=""{print $3}')
    if [ -n "$COLOR_NAME" ] ; then
        THE_MAP[$COLOR_HOST]="$COLOR_NAME,$COLOR_HOST_TPUT"
    fi
done < hosts.csv

debug " THE_MAP[@] ${THE_MAP[@]}"
debug "!THE_MAP[@] ${!THE_MAP[@]}"

if [ "$(detectos)" = "osx" ] ; then

    cat <<-EOF > it2prof_hosts.sh
#!/bin/bash
#it2prof()
#{
    #echo -e "\033]50;SetProfile=$1\a[*] Term2 Profile changed to $1"
#}
EOF

    for K in "${!THE_MAP[@]}" ; do 
        LOOKUP_VALUE_PAIR=${THE_MAP[$K]}
        LOOKUP_VALUE="$(echo $LOOKUP_VALUE_PAIR | cut -d , -f 1)"
        HOSTNAME_VALUE=$K
        bann "Processing host"
        info "$LOOKUP_VALUE"
        info "$HOSTNAME_VALUE"
        TMPFILE=tmpfile
        TMPFILE1=tmpfile1

        RED=$(jq ".Colors[] | select(.\"Name\" == $LOOKUP_VALUE) | .\"Red Component\"" < colors.json)
        # shellcheck disable=SC2002
        cat base_template.json | jq ".Profiles[0].\"Foreground Color\".\"Red Component\" |= $RED" > $TMPFILE

        GREEN=$(jq ".Colors[] | select(.\"Name\" == $LOOKUP_VALUE) | .\"Green Component\"" < colors.json)
        # shellcheck disable=SC2002
        cat $TMPFILE  | jq ".Profiles[0].\"Foreground Color\".\"Green Component\" |= $GREEN" > $TMPFILE1

        BLUE=$(jq ".Colors[] | select(.\"Name\" == $LOOKUP_VALUE) | .\"Blue Component\"" < colors.json)
        # shellcheck disable=SC2002
        cat $TMPFILE1 | jq ".Profiles[0].\"Foreground Color\".\"Blue Component\" |= $BLUE" > $TMPFILE

        # shellcheck disable=SC2002
        cat $TMPFILE  | jq ".Profiles[0].\"Guid\" |= \"$(uuidgen)\"" > $TMPFILE1
        if [[ "$(hostname)" != "$HOSTNAME_VALUE" ]] ; then
            # shellcheck disable=SC2002
            cat $TMPFILE1 | jq ".Profiles[0].\"Command\" |= \"bash -l -c $HOSTNAME_VALUE\"" > $TMPFILE
            # shellcheck disable=SC2002
            cat $TMPFILE  | jq ".Profiles[0].\"Custom Command\" |= \"Yes\"" > $TMPFILE1
        else
            # shellcheck disable=SC2002
            cat $TMPFILE1 | jq ".Profiles[0].\"Command\" |= \"\"" > $TMPFILE
            # shellcheck disable=SC2002
            cat $TMPFILE  | jq ".Profiles[0].\"Custom Command\" |= \"No\"" > $TMPFILE1
        fi
        # shellcheck disable=SC2002 disable=2086 disable=2046 disable=SC2001
        cat $TMPFILE1 | jq ".Profiles[0].\"Name\" |= \"$HOSTNAME_VALUE\"" > $(echo $HOSTNAME_VALUE | sed 's/\"//g').json
        # shellcheck disable=SC2002 disable=2086 disable=2046 disable=SC2001
        file  $(echo $HOSTNAME_VALUE| sed 's/\"//').json

        cat <<-EOF >> it2prof_hosts.sh
$HOSTNAME_VALUE()
{
    it2prof $HOSTNAME_VALUE
    LC_ITERM2_PROFILE_ALREADY_SET="hasstuffinit" ssh -o SendEnv=LC_ITERM2_PROFILE_ALREADY_SET $HOSTNAME_VALUE
    it2prof \$(hostname)
}
EOF

        cat <<-EOF >> it2prof_hosts.sh
${HOSTNAME_VALUE}-console()
{
    it2prof $HOSTNAME_VALUE
    tmuxinator start ${HOSTNAME_VALUE}-console
    it2prof \$(hostname)
}
EOF

        cat <<-EOF > ~/etc/dotfiles/.config/tmuxinator/${HOSTNAME_VALUE}-console.yml
name: ${HOSTNAME_VALUE}-console
root: ~/

windows:
  - editor:
      layout: tiled
      panes:
        - ssh ${HOSTNAME_VALUE}
EOF

        done

#else # assume linux
fi

#shellcheck disable=SC2188
> myhosts
for K in "${!THE_MAP[@]}" ; do 
    LOOKUP_VALUE=${THE_MAP[$K]}
    HOSTNAME_VALUE=$K
    echo "$HOSTNAME_VALUE:${LOOKUP_VALUE//\"/}" >> myhosts

    cat <<-EOF >> it2prof_hosts.sh
$HOSTNAME_VALUE()
{
    it2prof $HOSTNAME_VALUE
    LC_ITERM2_PROFILE_ALREADY_SET="hasstuffinit" ssh -o SendEnv=LC_ITERM2_PROFILE_ALREADY_SET $HOSTNAME_VALUE
    it2prof \$(hostname)
}
EOF

    cat <<-EOF >> it2prof_hosts.sh
${HOSTNAME_VALUE}-console()
{
    it2prof $HOSTNAME_VALUE
    tmuxinator start ${HOSTNAME_VALUE}-console
    it2prof \$(hostname)
}
EOF

    cat <<-EOF > ~/etc/dotfiles/.config/tmuxinator/$HOSTNAME_VALUE-console.yml
name: ${HOSTNAME_VALUE}-console
root: ~/

windows:
  - editor:
      layout: tiled
      panes:
        - ssh ${HOSTNAME_VALUE}
EOF

done
