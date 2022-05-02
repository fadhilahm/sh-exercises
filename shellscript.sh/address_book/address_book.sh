#!/bin/bash

. entries.sh
. search.sh

### Functions
show_options()
{
  echo "ADDRESS BOOK MAIN MENU"
  echo "1) Search Entries."
  echo "2) Add an entry."
  echo "3) Remove an entry."
  echo "4) Edit an entry."
  echo "5) Exit program."
}

take_input()
{
  while :
  do
    echo -n "Your option: "
    read CHOSEN_OPTION
    validate_input "$CHOSEN_OPTION"
    VALIDATION_RESULT="$?"
    if [ "$VALIDATION_RESULT" -ne "0" ]; then
      echo "${CHOSEN_OPTION} is not a valid option, pick a number between 1-5."
    else
      echo
      break
    fi
  done
}

validate_input()
{
  case "$1" in
	[1-5])
          return 0;;
  	*)
	  return 1;;
  esac
}

process_input()
{
  case "$CHOSEN_OPTION" in
	1) search;;
 	2) add;;
	3) remove;;
	4) edit;;
        5) exit_app;;
  esac
}

exit_app()
{
  echo "See you later~"
  break
  exit
}

### Main Script
echo
echo "Welcome to the Address Book!"
echo

while :
do
  show_options
  take_input
  process_input
done

