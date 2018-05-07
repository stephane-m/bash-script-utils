#!/bin/sh

#
# This script offers utilities to generate simple script menu.
# See at https://github.com/stephane-m/bash-script-utils/edit/master/menu_utils.sh
#

#==============================
# Variables
#==============================

# character used to draw menu horizontal lines
menu_line_char='-'

# character used to draw menu corners
menu_corner_char='+'

# character used to draw menu vartical lines
menu_col_char='|'

# padding added on the left of menu
menu_left_padding='   '

# location of the current script
_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


#==============================
# Imports
#==============================

source ${_SCRIPT_DIR}/logging.sh


#==============================
# Functions
#==============================

#
# This methods displays the selection menu listing based on the
# array elements passed as parameter.
# The expected format of each argument is a key=value pair.
#
function show_menu_selection() {

	local menu_t=$1

	shift
	local menu_entries=$*

	local counter=1

	# getting the length of the longest menu key or title
	local max_menu_key_length=${#menu_t}
	for menu_selection_entry in ${menu_entries[*]}; do
		entry_key=${menu_selection_entry%%=*}
		if [ ${#entry_key} -gt $max_menu_key_length ]; then max_menu_key_length=${#entry_key}; fi
	done
	
	menu_border=`printf "${menu_corner_char}%$((max_menu_key_length + 7))s${menu_corner_char}" | tr ' ' $menu_line_char`
	printf "${menu_left_padding}${menu_border}\n"
	
	printf "${menu_left_padding}${menu_col_char} %-$((max_menu_key_length + 6))s${menu_col_char}\n" "$menu_t"
	printf "${menu_left_padding}${menu_border}\n"
	for menu_selection_entry in ${menu_entries[*]}; do
		entry_key=${menu_selection_entry%%=*}
		printf "${menu_left_padding}${menu_col_char}%3d : %-$((max_menu_key_length + 1))s${menu_col_char}\n" $counter $entry_key
		let counter+=1
	done
	printf "${menu_left_padding}${menu_border}\n"
}


#
# This method generates an enumerated selection menu.
# 
# Input parameters:
#  - 1 : a variable in which the selected value will be stored
#  - 2 : menu title
#  - * : After the first parameter, a list of key=value pair. The key will be used to be displayed
#        on the select menu to the user, the selected value will be returned in the first paramter.
#
function generate_enumerated_menu() {

	# first parameter is the returned value
	local __returnvar=$1

	local menu_title=$2

	shift
	shift
	menu_entries_as_str=$@
	
	# convert menu entries as string into array
	local menu_entries=($menu_entries_as_str)

	# display the select menu
	show_menu_selection "${menu_title}" ${menu_entries[@]}

	local counter=1

	printf "${menu_left_padding} > "
	
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
