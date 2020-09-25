#!/usr/bin/env cgilua.cgi

package.path = package.path .. ';/home/gemini/sora/GeminiSora/lib/Shared/?.lua'
package.path = package.path .. ';/home/gemini/sora/GeminiSora/lib/Client/?.lua'
local client = require "clientdispatch"
client.execute()
