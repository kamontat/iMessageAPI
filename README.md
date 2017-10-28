# iMessage APIs 
This repository contains both `APIs for iMessage` and `Runable Script`

## Table of Content
- [Performance](#performance)
- [Usage](#usage)
- [Develop (APIs)](#develop-apis)
- [Creator](#creator)
- [Technology](#technology)
- [LICENSE](#license)

# Performance
- run on commandline (zsh) with iTerm 3.4.1 (use `time` command)
    - real 2.49 second(s)
    - user 0.37 second(s)
    - syst 0.09 second(s)

# Usage
- you can use **source code** in src to run directly (not-recommend - slow)
- you can use `send_imessage` script to send too
    - special parameter
        - **help** - open help command
        - **version** - log current command version
    - normal use
        - 2 parameters
            1. regex of contact (name, email, phone_number)
                - must unique so script known whose to sent
            2. message with or without `"` (if your message don't have space so you no need to use it)

# Develop (APIs)
- APIs are in [src/lib](src/lib) folder and compiled file are in [lib](lib) folder
- code, example and document are right in source code

# Creator
- Kamontat Chatrachirathumrong (github.com/kamontat)

# Technology
- applescript
- bashscript

# LICENSE
BSD 3-Clause License
Copyright (c) 2017, Kamontat Chantrachirathumrong All rights reserved.
Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
* Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
* Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, 
INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. 
IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; 
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, 
WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, 
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
