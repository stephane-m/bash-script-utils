#!/bin/sh

. ../menu_utils.sh

#
# Test 1 : With a long title
#

menu_list=(
	"key1=value-1"
	"key2=value-2"
	"key3=value-3"
	"key4=value-4"
	"key5=value-5"
)

# Call the menu generation with list of entries, the selected value will be set in variable selected_value
generate_enumerated_menu selected_value "Please select a value as a key for the input" ${menu_list[@]}

echo "The selected value is : ${selected_value}"


#
# Test 2 : With a entry that has long key
#

menu_list_2=(
	"key1=value-1"
	"key2_with_a_long_key_name_unfortunately_spaces_are_not_supported=value-2"
	"key3=value-3"
	"key4=value-4"
	"key5=value-5"
)

# Call the menu generation with list of entries, the selected value will be set in variable selected_value
generate_enumerated_menu selected_value "Please select" ${menu_list_2[@]}

echo "The selected value is : ${selected_value}"
