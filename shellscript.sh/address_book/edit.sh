# Edit Module

echo "Initializing Edit Module..."

edit_select()
{
    TARGET_KEYWORD=""
    edit_ask_input
    edit_filter
    edit_handle_filter_results
}

edit_ask_input()
{
    echo -n "Enter target keyword: "
    read TARGET_KEYWORD
}

edit_filter()
{
    MATCHING_ENTRIES=""
    MATCHING_ENTRIES_COUNT=0
    for ENTRY in $ENTRIES; do
        search_check_entry "${ENTRY}" "${TARGET_KEYWORD}"
    done
}

edit_handle_filter_results()
{
    if [ "${MATCHING_ENTRIES_COUNT}" = "0" ]; then
        echo "No matching entry."
        break
    elif [ "${MATCHING_ENTRIES_COUNT}" = "1" ]; then
        SELECTED_ENTRY="${MATCHING_ENTRIES}"
    else
        edit_handle_multiple_filter_results
    fi
}

edit_handle_multiple_filter_results()
{
    echo "Multiple matched entries found. Please select one of the following entry:"
    INDEX=1
    for ENTRY in $MATCHING_ENTRIES; do
        entries_render_one "$ENTRY" "$INDEX"
        INDEX=`expr "$INDEX" + 1`
    done

    MAX_INDEX=`expr "${INDEX}" - 1`
    VALIDATION_REGEX="[1-${MAX_INDEX}]"
    while : ; do
    echo -n "Your choice: "
    SELECTED_CHOICE=""
    read SELECTED_CHOICE
        case "${SELECTED_CHOICE}" in
            $VALIDATION_REGEX)
                break
                ;;
            *)
                echo "Invalid choice, please choose from valid choices ("${VALIDATION_REGEX}")."
                ;;
        esac
    done

    INDEX=1
    for ENTRY in $MATCHING_ENTRIES; do
        if [ "${INDEX}" = "${SELECTED_CHOICE}" ]; then
            SELECTED_ENTRY="${ENTRY}"
        fi
        INDEX=`expr $INDEX + 1`
    done
}

edit_entry()
{
    edit_entry_new_input
    edit_entry_commit
    edit_entry_confirmation
}

edit_entry_new_input()
{
    FIRST_NAME=""
    LAST_NAME=""
    EMAIL=""
    PHONE=""
    entries_parse_one "${SELECTED_ENTRY}"
    UPDATED_FIRST_NAME=""
    UPDATED_LAST_NAME=""
    UPDATED_EMAIL=""
    UPDATED_PHONE=""    

    echo "Enter updated entry data:"
    echo -n "First Name [ ${FIRST_NAME} ]: "
    read UPDATED_FIRST_NAME
    echo -n "Last Name [ ${LAST_NAME} ]: "
    read UPDATED_LAST_NAME
    echo -n "Email [ ${EMAIL} ]: "
    read UPDATED_EMAIL
    echo -n "Phone [ ${PHONE} ]: "
    read UPDATED_PHONE

    if [ -z "${UPDATED_FIRST_NAME}" ]; then
        UPDATED_FIRST_NAME="${FIRST_NAME}"
    fi
    if [ -z "${UPDATED_LAST_NAME}" ]; then
        UPDATED_LAST_NAME="${LAST_NAME}"
    fi
    if [ -z "${UPDATED_EMAIL}" ]; then
        UPDATED_EMAIL="${EMAIL}"
    fi
    if [ -z "${UPDATED_PHONE}" ]; then
        UPDATED_PHONE="${PHONE}"
    fi
}

edit_entry_commit()
{
    NEW_ENTRIES=""
    UPDATED_ENTRY="${UPDATED_FIRST_NAME}:${UPDATED_LAST_NAME}:${UPDATED_EMAIL}:${UPDATED_PHONE}"
    for ENTRY in ${ENTRIES}; do
        if [ "${SELECTED_ENTRY}" = "${ENTRY}" ]; then
            if [ -n "${NEW_ENTRIES}" ]; then
                NEW_ENTRIES="${NEW_ENTRIES} ${UPDATED_ENTRY}"

            else
                NEW_ENTRIES="${UPDATED_ENTRY}"
            fi
        else
            if [ -n "${NEW_ENTRIES}" ]; then
                NEW_ENTRIES="${NEW_ENTRIES} ${ENTRY}"
            else
                NEW_ENTRIES="${ENTRY}"
            fi
        fi
    done
    ENTRIES="${NEW_ENTRIES}"
}

edit_entry_confirmation()
{
    echo
    echo "The following entry has been upserted successfully."
    echo "First Name: ${UPDATED_FIRST_NAME}"
    echo "Last Name": "${UPDATED_LAST_NAME}"
    echo "Email: ${UPDATED_EMAIL}"
    echo "Phone: ${UPDATED_PHONE}"
    echo "========================================"
    echo
}

## Main function.
edit()
{
    edit_select # Pick which entry to edit.
    edit_entry # Edit an entry.
}