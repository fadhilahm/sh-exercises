# Removal Module

echo "Initializing Removal Module..."

remove_select()
{
    TARGET_KEYWORD=""
    remove_ask_input
    remove_filter
    remove_handle_filter_results
    remove_confirmation
    remove_entry
}

remove_ask_input() 
{
    echo -n "Enter target keyword: "
    read TARGET_KEYWORD
}

remove_filter()
{
    MATCHING_ENTRIES=""
    MATCHING_ENTRIES_COUNT=0
    for ENTRY in $ENTRIES; do
        search_check_entry "${ENTRY}" "${TARGET_KEYWORD}"
    done
}

remove_handle_filter_results()
{
    if [ "${MATCHING_ENTRIES_COUNT}" = "0" ]; then
        echo "No matching entry."
        break
    elif [ "${MATCHING_ENTRIES_COUNT}" = "1" ]; then
        SELECTED_ENTRY="${MATCHING_ENTRIES}"
    else
        remove_handle_multiple_filter_results
    fi
}

remove_handle_multiple_filter_results()
{
    echo "Multiple matched entries found. Please select one of the following entry:"
    INDEX=1
    for ENTRY in $MATCHING_ENTRIES; do
        entries_render_one "$ENTRY" "$INDEX"
        INDEX=`expr "$INDEX" + 1`
    done

    VALIDATION_REGEX="[1-${INDEX}]"
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

remove_confirmation()
{
    echo "The following entry will be deleted:"
    entries_render_one "${SELECTED_ENTRY}" 1
}

remove_entry()
{
    NEW_ENTRIES=""
    for ENTRY in $ENTRIES; do
        if [ "${ENTRY}" = "${SELECTED_ENTRY}" ]; then
            :
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

## Main function.
remove()
{
    SELECTED_ENTRY=""
    remove_select
    remove_entry
}
