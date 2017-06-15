#!/bin/bash

#
# This script contains logging utilities for formatted and colorized logging.
# Version: v1.0 (2015/10/26 10:00)
#

# This flags indicates whether the debug must be printed or not.
# Default is false, it must be overrided in the script uising this file.
LOGGING_DEBUG=false


# This flag indicates if the logs must be prefixed with the current date
LOG_DATE_PREFIX=true


#######################################
# This function prints a colorized log.
# The log is prefixed by the current date.
# Arguments:
#  - $1 : The log level, it is a string prefix that will be inserted
#         between the date and the log message
#  - $2 : The color code (31 is red, 32 is green, 33 is yellow, 36 is cyan, ...)
# Returns:
#   None
#######################################
function log_color() {
    local log_date_prefix=""
	if $LOG_DATE_PREFIX ; then
		log_date_prefix="$(date --rfc-3339=seconds) - "
	fi
    local log_level=$1;
    local color_code=$2; shift; shift
    local log_message=$*
    
    echo -e "\e[${color_code}m${log_date_prefix}${log_level} - ${log_message}\e[0m"
}

#######################################
# This function prints a debug (green, prefix DEBUG)
# Message is printed only if LOGGING_DEBUG is true
# Arguments:
#  - $* : The message to be logged
# Returns:
#   None
#######################################
function log_debug() {
    if $LOGGING_DEBUG ; then
        log_color "DEBUG" 32 $*
    fi
}

#######################################
# This function prints an info (cyan, prefix INFO)
# Arguments:
#  - $* : The message to be logged
# Returns:
#   None
#######################################
function log_info() {
    log_color "INFO" 36 $*
}

#######################################
# This function prints an info (yellow, prefix WARN)
# Arguments:
#  - $* : The message to be logged
# Returns:
#   None
#######################################
function log_warning() {
    log_color "WARN" 33 $*
}

#######################################
# This function prints an error (red, prefix ERROR)
# Arguments:
#  - $* : The message to be logged
# Returns:
#   None
#######################################
function log_error() {
    log_color "ERROR" 31 $*
}
