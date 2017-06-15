#!/bin/sh

#
# This script offers utilities to generate script menu.
#

#==============================
# Imports
#==============================

source ~/scripts/utils/logging.sh


#==============================
# Functions
#==============================

#
# This methods displays the selection menu listing based on the
# array elements passed as parameter.
# The expected format of each argument is a key=value pair.
#
function show_menu_selection() {

	local menu_entries=$*

	local counter=1

	# getting the length of the longest meny key
	local max_menu_key_length=0
	for menu_selection_entry in ${menu_entries[*]}; do
		entry_key=${menu_selection_entry%%=*}
		if [ ${#entry_key} -gt $max_menu_key_length ]; then max_menu_key_length=${#entry_key}; fi
	done

	menu_border=`printf "+%$((max_menu_key_length + 7))s+" | tr ' ' -`
	printf "${menu_border}\n"
	for menu_selection_entry in ${menu_entries[*]}; do
		entry_key=${menu_selection_entry%%=*}
		printf "|%3d : %-$((max_menu_key_length + 1))s|\n" $counter $entry_key
		let counter+=1
	done
	printf "${menu_border}\n"
}


#
# This method generates an enumerated selection menu.
# 
# Input parameters:
#  - 1 : a variable in which the selected value will be stored
#  - * : After the first parameter, a list of key=value pair. The key will be used to be displayed
#        on the select menu to the user, the selected value will be returned in the first paramter.
#
function generate_enumerated_menu() {

	# first parameter is the returned value
	local __returnvar=$1

	# getting all parameters as we expect array as input
	local all_parameters=$@

	# removing first param from all param to keep only the menu array
	local menu_entries_as_str=("${all_parameters[@]/$__returnvar}")
	
	# convert menu entries as string into array
	local menu_entries=($menu_entries_as_str)

	# display the select menu
	show_menu_selection ${menu_entries[@]}

	local counter=1

	printf "Please select an entry: "
	
	# read the input and return selected value
	read menu_selection_input
	log_debug "Menu select input : ${menu_selection_input}"

	let menu_map_index=menu_selection_input-1

	if [[ $menu_map_index -lt 0 ]] || [[ $menu_map_index -ge ${#menu_entries[*]} ]] ; then
		log_error "Invalid selection!"
		exit 1
	fi

	eval $__returnvar="${menu_entries[menu_map_index]##*=}"
}
