# Search Module

echo "Initializing Search Module..."

search_show_initial_option()
{
  echo -n "Enter target keyword: "
  read KEYWORD
  echo
  search_entries "$KEYWORD"
}

search_entries()
{
  MATCHING_ENTRIES=""
  MATCHING_ENTRIES_COUNT=0
  for ENTRY in $ENTRIES; do
    search_check_entry "$ENTRY" $1
  done
  echo "We found ${MATCHING_ENTRIES_COUNT} entries while using [$1] as the keyword."
  echo
  if [ "$MATCHING_ENTRIES_COUNT" -gt 0 ]; then
    echo "Matched entries:"
    INDEX=1
    for MATCHED_ENTRY in $MATCHING_ENTRIES; do
      entries_render_one "$MATCHED_ENTRY" "$INDEX"
      INDEX=`expr $INDEX + 1`
    done
    echo
  fi
}

search_check_entry()
{
  GREP_RESULT=`grep -i "$2" <<< "$1"`
  if [ -n "$GREP_RESULT" ]; then
    if [ -n "$MATCHING_ENTRIES" ]; then
      MATCHING_ENTRIES="${MATCHING_ENTRIES} $1"
    else
      MATCHING_ENTRIES="${1}"
    fi
    MATCHING_ENTRIES_COUNT=`expr "$MATCHING_ENTRIES_COUNT" + 1`
  fi
}

## Main function.
search() 
{
  entries_show_all
  search_show_initial_option
}

