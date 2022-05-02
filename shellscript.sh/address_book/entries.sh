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

