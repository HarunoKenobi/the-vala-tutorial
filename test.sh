#!/bin/sh
# Global variables
importpath="test"
ok=0
fails=0
count=0
args="$*"

# Include
. $importpath/sanity_test.sh
. $importpath/file_test.sh
. $importpath/link_parser.sh
. $importpath/utils.sh
. $importpath/debug.sh

main () {
	if ( string_contains $args "--debug" ); then
		debug=true
	fi

	test_title "Initializing tests on $(pwd)"
	sanity_test
	file_test
	test_result
	# TODO
	# if fails < 0 return error :)
}

main
