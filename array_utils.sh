#!/bin/bash

#
# This script contains generic utility functions for operations on array, map and other kind of list
# Version: v1.0 (2015/12/01 10:30)
#


##################################################
# Verify if an array contains a value, we have to test the value returned
# Arguments:
#  1 : the key we are searching for
#  2 : the array
# Returned Values:
#  0 value found
#  1 value not found
##################################################
function listContainsKey () {
	local e
	for e in "${@:2}"; do [[ "${e}" == "$1" ]] && return 0; done
	return 1
}


##################################################
# Verify if an map contains a value, we have to test the value returned
# Note: Map is an array for which each entry is key=value
# Arguments:
#  1 : the key we are searching for
#  2 : the array
# Returned Values:
#  0 value found
#  1 value not found
##################################################
function mapContainsKey () {
	local e
	for e in "${@:2}"; do [[ "${e%=*}" == "$1" ]] && return 0; done
	return 1
}


##################################################
# Returns the value of the key passed as parameter in
# the map.
# Arguments:
#  1 : the key we are searching for
#  2 : the array
# Returned Values:
#  The value related to the key
#  Empty if key not found
##################################################
function mapGetValue() {
	local e
	for e in "${@:2}"; do [[ "${e%=*}" == "$1" ]] && echo ${e#*=}; done
}
