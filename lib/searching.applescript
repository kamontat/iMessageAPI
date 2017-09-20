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
-- Create at: 19/08/2560
-- Update at: 19/08/2560
-- Version: 1.0.1
-- ---------------------------------

property code_desc : "fix phone number output"
property code_version : "v1.0.1"

property str_size : 100
property iPhone_label : "iPhone"
property mobile_label : "mobile"

property email_label : "email"
property iCloud_label : "iCloud"

-- TESTING CODE
tell SEARCH
	-- repeat 5 times
	-- set mgRightNow to "perl -e 'use Time::HiRes qw(time); print time'"
	-- set mgStart to do shell script mgRightNow
	
	getiPhone("Nattana")
	log code_version
	-- error of person Can’t get value of {}.
	
	-- set mgStop to do shell script mgRightNow
	-- set mgRunTime to mgStop - mgStart
	
	-- log "This took " & mgRunTime & " seconds. || that's " & (round (mgRunTime * 1000)) & " milliseconds."
	-- end repeat
end tell
-- END TESTING CODE

script SEARCH

	-- @return only version
	to getVersion()
		return code_version
	end getVersion
	
	-- @return version and description
	to versionToString()
		return code_desc & " (" & code_version & ")"
	end versionToString
	
	to replaceNL(someText)
		return my replaceText(someText, "
", " ")
	end replaceNL
	
	to replaceSpace(someText)
		return my replaceText(someText, " ", "")
	end replaceSpace
	
	to replaceDash(someText)
		return my replaceText(someText, "-", "")
	end replaceDash
	
	to replaceText(someText, oldItem, newItem)
		set {tempTID, AppleScript's text item delimiters} to {AppleScript's text item delimiters, oldItem}
		try
			set {itemList, AppleScript's text item delimiters} to {text items of someText, newItem}
			set {someText, AppleScript's text item delimiters} to {itemList as text, tempTID}
		on error errorMessage number errorNumber -- oops
			set AppleScript's text item delimiters to tempTID
			error errorMessage number errorNumber -- pass it on
		end try
		return someText
	end replaceText
	
	-- check is regex matches with every text of person (just one of them is enough)
	-- @params - eachPerson - input person
	-- @params - regex      - searching text
	-- @params - checked    - bypass method by return true
	-- @return boolean, true if matched or checked is true
	to matchesTextParams(eachPerson, regex, checked)
		if checked then return true
		repeat with val in (properties of eachPerson) as list
			if class of val = text and (count val) < str_size then
				set newValue to replaceNL(val)
				if newValue contains regex then
					return true
				end if
				-- log {class of newValue, newValue, (count newValue)}
			end if
		end repeat
		return false
	end matchesTextParams
	
	-- check is regex matches with telephone number of person or not
	-- @params - eachPerson - input person
	-- @params - regex      - searching telephone number
	-- @params - checked    - bypass method by return true
	-- @return boolean, true if matched or checked is true
	to matchesTelephoneParams(eachPerson, regex, checked)
		if checked then return true
		tell application "Contacts"
			repeat with val in (value of phones of eachPerson) as list
				set newValue to my replaceNL(my replaceSpace(my replaceDash(val)))
				if newValue contains regex then
					return true
				end if
				-- log {class of newValue, newValue, (count newValue)}
			end repeat
			return false
		end tell
	end matchesTelephoneParams
	
	-- check is regex matches with email of input person or not
	-- @params - eachPerson - input person
	-- @params - regex      - searching email
	-- @params - checked    - bypass method by return true
	-- @return boolean, true if matched or checked is true
	to matchesEmailParams(eachPerson, regex, checked)
		if checked then return true
		tell application "Contacts"
			repeat with val in (value of emails of eachPerson) as list
				if val contains regex then
					return true
				end if
				-- log {class of val, val, (count val)}
			end repeat
			return false
		end tell
	end matchesEmailParams
	
	-- get people list or indv. person with regex return 1 element
	-- @params - regex     - searching text
	-- @params - allPeople - people list, either people in Contact application or result of this method
	-- @return {people} matches with regex or list of {person} 
	-- @throw 123 - if person with regex not found
	to filterPeople(regex, allPeople)
		set peopleList to {}
		tell application "Contacts"
			repeat with eachPerson in allPeople
				
				set s to false
				set s to my matchesTextParams(eachPerson, regex, s) -- check with text parameters
				set s to my matchesTelephoneParams(eachPerson, regex, s) -- check with telephone parameters
				set s to my matchesEmailParams(eachPerson, regex, s) -- check with email parameters
				
				if s then
					copy eachPerson to end of peopleList
					set s to false
				end if
			end repeat
			
			set s to (count peopleList)
			-- error 
			if s = 0 then
				error "person regex = \"" & regex & "\" not found" number 123
				-- indv person
			else if s = 1 then
				return first item of peopleList
				-- else people
			else
				return peopleList
			end if
		end tell
	end filterPeople
	
	-- get all people by regex
	-- @return {people} matches with regex or list of {person} 
	to searchPeople(regex)
		tell application "Contacts"
			return filterPeople(regex, people)
		end tell
	end searchPeople
	
	-- get indv person from given regex
	-- @return {person}
	-- @throw 155 - regex given more that 1 person
	to getPerson(regex)
		tell application "Contacts"
			set p to my filterPeople(regex, people)
			if class of p = list then
				set str to return
				set n to 0
				repeat with pp in p
					set str to str & " || " & (get name of pp)
					set n to n + 1
					if (n mod 5) = 0 then set str to str & return
				end repeat
				error "too many person or regex not unique enough." & return & "list: (" & (count p) & ")" & (str) number 155
			end if
			return p
		end tell
	end getPerson
	
	-- get iPhone phone number from regex person description (can be firstname lastname email telephone etc.)
	-- if more than 1, get first only
	-- @return text of iPhone
	-- @throw 123 - if person with regex not found
	-- @throw 124 - if phone label invalid
	-- @throw 155 - regex given more that 1 person
	to getiPhone(regex)
		return replaceDash(first item of getPhones(regex, iPhone_label)'s item 2)
	end getiPhone
	
	-- get mobile phone from regex person description (can be firstname lastname email telephone etc.) with index specify (start with 1..n)
	-- if more than 1, get first only
	-- @return text of mobile phone
	-- @throw 120 - if index too many
	-- @throw 123 - if person with regex not found
	-- @throw 124 - if phone label invalid
	-- @throw 155 - regex given more that 1 person
	to getMobile(regex, index)
		set ms to getMobiles(regex)
		set s to (count ms)
		if s < index then
			error "have " & s & ", but require " & index number 120
		end if
		return replaceDash(item index of ms)
	end getMobile
	
	-- get icloud mail from regex person description (can be firstname lastname email telephone etc.)
	-- @return text of iCloud mail
	-- @throw 123 - if person with regex not found
	-- @throw 125 - if email label invalid
	-- @throw 155 - regex given more that 1 person
	to getiCloudMail(regex)
		return first item of getEmails(regex, iCloud_label)'s item 2
	end getiCloudMail
	
	-- get mobile phones number from regex person description (can be firstname lastname email telephone etc.)
	-- @return format: list("TEL1", "TEL2", ...)
	-- @throw 123 - if person with regex not found
	-- @throw 124 - if phone label invalid
	-- @throw 155 - regex given more that 1 person
	to getMobiles(regex)
		return getPhones(regex, mobile_label)'s item 2
	end getMobiles
	
	-- get phones from regex person description (can be firstname lastname email telephone etc.)
	-- @return format: list("LABEL", "TEL1", "TEL2", ...)
	-- @throw 123 - if person with regex not found
	-- @throw 124 - if phone label invalid
	-- @throw 155 - regex given more that 1 person
	to getPhones(regex, pLabel)
		tell application "Contacts"
			set p to my getPerson(regex)
			set phoneList to value of phones of p whose label = pLabel
			if (count phoneList) = 0 then
				error "phone label = \"" & pLabel & "\" not found" number 124
			end if
			return {pLabel, phoneList}
		end tell
	end getPhones
	
	-- get emails from regex person description (can be firstname lastname email telephone etc.)
	-- @return format: list("LABEL", "MAIL1", "MAIL2", ...)
	-- @throw 123 - if person with regex not found
	-- @throw 125 - if email label invalid
	-- @throw 155 - regex given more that 1 person
	to getEmails(regex, eLabel)
		tell application "Contacts"
			set p to my getPerson(regex)
			set emailList to value of emails of p whose label = eLabel
			if (count emailList) = 0 then
				error "email label = \"" & eLabel & "\" not found" number 125
			end if
			return {eLabel, emailList}
		end tell
	end getEmails
end script