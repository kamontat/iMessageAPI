#!/usr/bin/osascript

-- library name
property search_lib : "searching"
property send_lib : "sending"
-- file extension
property script_ : ".scpt"
property text_ : ".applescript"
-- library folder
property library : "lib/"

to loadLibrary(libName)
	tell application "Finder" to set theContainer to container of (path to me)
	set script_file to libName & script_
	set libPath to POSIX path of (theContainer as text) & library & script_file
	log libPath
	return (load script libPath)
end loadLibrary

on run in {regex, msg}
	tell send of loadLibrary(send_lib)
	  -- log versionToString()
	  start()
	  sendMessage by regex given message:msg
	end tell
end run
