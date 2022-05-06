# Add Module

echo "Initializing Add Module..."

add_take_input()
{
  echo "NEW ENTRY:"

  while : ; do
    echo -n "Enter First Name: "
    read FIRST_NAME
    add_validate_input "$FIRST_NAME"
    IS_VALID=$?
    if [ "$IS_VALID" != "0" ]; then
      add_show_validation_message "$FIRST_NAME"
    else
      break
    fi
  done
  while : ; do
    echo -n "Enter Last Name: "
    read LAST_NAME
    add_validate_input "$LAST_NAME"
    IS_VALID=$?
    if [ "$IS_VALID" != "0" ]; then
      add_show_validation_message "$LAST_NAME"
    else
      break
    fi
  done
  while : ; do
    echo -n "Enter Email: "
    read EMAIL
    add_validate_input "$EMAIL"
    IS_VALID=$?
    if [ "$IS_VALID" != "0" ]; then
      add_show_validation_message "$EMAIL"
    else
      break
    fi
  done
  while : ; do
    echo -n "Enter Phone Number: "
    read PHONE
    add_validate_input "$PHONE"
    IS_VALID=$?
    if [ "$IS_VALID" != "0" ]; then
      add_show_validation_message "$PHONE"
    else
      break
    fi
  done

  NEW_ENTRY="${FIRST_NAME}:${LAST_NAME}:${EMAIL}:${PHONE}"
}

add_validate_input()
{
  IS_VALID=1
  if [ -n "$1" ]; then
    IS_VALID=0
  fi
  return "$IS_VALID"
}

add_show_validation_message()
{
  echo "\"${1}\" is an invalid value, please re-enter the value again."
}

add_new()
{
  entries_add "$1" 
}

add_confirmation()
{
  echo "You have successfully added the following entry:"
  entries_render_one "${NEW_ENTRY}" 1
}

### Main function.
add()
{
  NEW_ENTRY=""
  add_take_input
  add_new "$NEW_ENTRY"
  add_confirmation "$NEW_ENTRY"
}
