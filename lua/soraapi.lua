#!/usr/bin/env cgilua.cgi

package.path = package.path .. ';/home/gemini/sora/GeminiSora/lib/Shared/?.lua'
package.path = package.path .. ';/home/gemini/sora/GeminiSora/lib/API/?.lua'
local api = require "apidispatch"
api.execute()
