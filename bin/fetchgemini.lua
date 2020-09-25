#!/usr/local/bin/lua

-- fetchgemini.lua = fetch gemini pages
-- jrs
--
-- sep 22, 2020
-- pulled this code from my GeminiFinch code that
--   i modified back in the summer.
--
-- gemini support via solderpunk's Lua demo, gemini-demo.lua.
local socket    = require "socket"
local socketurl = require "socket.url"
local ssl       = require "ssl"
local pl        = require "pl" -- sudo luarocks install penlight - somehow this is accessed by utils.split below. it's not my utils lib.


function fetch_url(url)

    local Body, Code, Headers, Status
    Body = ""

    local ssl_params = {
        mode     = "client",
        protocol = "tlsv1_2"
    }

    local parsed_url = socket.url.parse(url)

    -- Open connection
    conn = socket.tcp()

    ret, str = conn:connect(parsed_url.host, 1965)

    if ret == nil then
        Status = str 
        Code = 90
        goto end_fetch
    end

    conn, err = ssl.wrap(conn, ssl_params)
    if conn == nil then
        Status = err
        Code = 90
        goto end_fetch
    end

    conn:dohandshake()
    -- Send request
    conn:send(url .. "\r\n")
    -- Parse response header
    header = conn:receive("*l")
    status, meta = table.unpack(utils.split(header, "%s+", false, 2))

    if string.sub(status, 1, 1) == "2" then
        Code = status
        Headers = meta
        Status = "Okay"

        while true do
            line, err = conn:receive("*l")
            if line ~= nil then
                Body = Body .. line .. "\n"
            else
                break
	        end
        end
    -- Handle errors
    elseif string.sub(status, 1, 1) == "4" or string.sub(status, 1, 1) == "5" then
        Status = "Error: " .. meta
        Code = 90
    elseif string.sub(status, 1, 1) == "6" then
        Status = "Client certificates not supported."
        Code = 90
    else
        Status = "Invalid response from server."
        Code = 90
    end

    ::end_fetch::

    return Body, tonumber(Code), Headers, Status

end


if #arg < 1 then
    error("fetchgemini url")
end



local x = os.clock()
local b, c, h, s = fetch_url(arg[1])
local y = string.format("elapsed time: %.4f seconds\n", os.clock() - x)

print("code number = " .. c)
print("headers = " .. h)
print("status = " .. s)
print("body = \n" .. b)

print(y)


