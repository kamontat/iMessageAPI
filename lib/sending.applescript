-- ---------------------------------
-- BSD 3-Clause License
-- Copyright (c) 2017, Kamontat Chantrachirathumrong All rights reserved.
-- Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
-- * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
-- * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
-- * Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, 
-- INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. 
-- IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
-- SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; 
-- LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, 
-- WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, 
-- EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-- ---------------------------------
-- Creator: Kamontat Chantrachirathumrong
-- Create at: 20/08/2560
-- Update at: 20/08/2560
-- Version: 1.0.1
-- ---------------------------------

-- code version and explanation
property code_desc : "add document and fixed bug"
property code_version : "v1.0.1"

-- library name
property lib_name : "searching"
-- file extension
property script_ : ".scpt"
-- library folder
property library : "lib/"
-- file name
property script_file : lib_name & script_

-- EXAMPLE CODE
-- tell SEND
-- start()
-- sendMessageByRegex(someRegex, "test mail")
-- versionToString()
-- end tell
-- END EXAMPLE CODE

script SEND
	-- run this method at first time you need to send message
	to start()
		run application "Messages"
		run application "Contacts"
	end start
	
	-- to load searching library in lib folder
	-- @return library so you can use like `tell search of loadSearchLibrary()...`
	to loadSearchLibrary()
		tell application "Finder" to set theContainer to container of (path to me)
		set searchPath to POSIX path of (theContainer as text) & library & script_file
		return (load script searchPath)
	end loadSearchLibrary
	
	-- get currently app version and library version 
	-- @return only version
	to getVersion()
		tell search of loadSearchLibrary() to set v to getVersion()
		return "sending: " & code_version & return & lib_name & ": " & v
	end getVersion
	
	-- get currently app description and library description
	-- @return version and description
	to versionToString()
		set l to loadSearchLibrary()
		tell search of l to set v to versionToString()
		return "sending: " & code_desc & " (" & code_version & ")" & return & lib_name & ": " & v
		return
	end versionToString
	
	-- send message (msg) to regex person (make sure that regex unique enough otherwise exception will throw)
	-- @throw - learn more about exception in searching library (on lib folder)
	to sendMessageByRegex(regex, msg)
		set searchLib to my loadSearchLibrary()
		tell search of searchLib to set phoneNumber to getiPhone(regex)
		sendMessageByTelNumber(phoneNumber, msg)
	end sendMessageByRegex
	
	-- send message (msg) to phone number
	-- @throw - learn more about exception in searching library (on lib folder)
	to sendMessageByTelNumber(tel, msg)
		tell application "Messages"
			set targetService to 1st service whose service type = iMessage
			set targetBuddy to buddy tel of targetService
			send msg to targetBuddy
		end tell
	end sendMessageByTelNumber
end script