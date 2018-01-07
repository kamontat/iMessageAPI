#!/usr/bin/osascript

-- library name
property search_lib : "searching"
property send_lib : "sending"
-- file extension
property script_ : ".scpt"
-- library folder
property library : "lib/"

property help_msg : "
To run this script, 
1. you must be macOS or OSx.
2. this file must executable, (default is true); otherwise, permission denied.
3. you must give 2 parameter to this file.
	3.1. is regex of person (can be name email telephone on your Contact App only) who want to talk with.
	3.2. message send to that person.
"

-- code version and explanation
property code_desc : "Support sent library v2.1.1"
property code_version : "v1.0.2"

to loadLibrary(libName)
	tell application "Finder" to set theContainer to container of (path to me)
	set script_file to libName & script_
	set libPath to POSIX path of (theContainer as text) & library & script_file
	-- log libPath
	return (load script libPath)
end loadLibrary

-- get currently app description and library description
-- @return version and description
to versionToString()
	return "main: " & code_desc & " (" & code_version & ")"
end versionToString


on run of params
	if (count params) = 2 then
		set regex to params's item 1
		set msg to params's item 2
		
		tell send of loadLibrary(send_lib)
			-- log versionToString()
			start_send()
			sendMessage by regex given message:msg
			end_send()
		end tell
	else if (count params) = 1 and (params's item 1) = "help" then
		log help_msg
	else if (count params) = 1 and (params's item 1) = "version" then
		log versionToString()
		tell send of loadLibrary(send_lib)
			log versionToString()
		end tell
	else
		error help_msg number 1
	end if
end run
