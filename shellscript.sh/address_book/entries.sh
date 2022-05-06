# Entries Module
echo "Initializing Entries Module..."

ENTRIES="Abercrombie:Bing:ab@email.com:1234 Cinco:Dells:cd@email.com:5678 Eagle:Fixion:ef@email.com:1234"

entries_render_one() {
  OLD_IFS="$IFS"
  IFS=:
  read FIRST_NAME LAST_NAME EMAIL PHONE <<< "$1"
  echo "#$2"
  echo "First Name:	$FIRST_NAME"
  echo "Last Name:	$LAST_NAME"
  echo "Email:		$EMAIL"
  echo "Phone:		$PHONE"
  echo "========================================"
  IFS="$OLD_IFS"
}

entries_show_all()
{
  echo "Here's all the currently stored entries:"
  INDEX=1
  for ENTRY in $ENTRIES; do
    entries_render_one "$ENTRY" "$INDEX"
    INDEX=`expr ${INDEX} + 1`
  done
  echo
}

entries_add()
{
  NEW_ENTRY="${1}"
  entries_find_one "${NEW_ENTRY}"
  IS_NOT_UNIQUE=$?
  if [ "$IS_NOT_UNIQUE" == "0" ]; then
    entries_render_one "${NEW_ENTRY}" 1
    echo "Duplicate entry detected, cancelling \"Add\" Operation..."
    return 1
  fi

  if [ -n "$ENTRIES" ]; then
    ENTRIES="${ENTRIES} ${NEW_ENTRY}"
  else
    ENTRIES="${NEW_ENTRY}"
  fi
}

entries_find_one()
{
  IS_FOUND=1
  TARGET_ENTRY="${1}"
  GREP_RESULT=`grep -i "${TARGET_ENTRY}" <<< "${ENTRIES}"`
  if [ -n "$GREP_RESULT" ]; then
    IS_FOUND=0
  fi
  return "${IS_FOUND}"
}
