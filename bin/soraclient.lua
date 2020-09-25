#!/usr/local/bin/lua


-- cootc.lua
-- trying to create an easy way to create and
--   update content for a Gemini site. currently,
--   i'm using sora to manage my gemsite. sora
--   is a web-based static site generator that i
--   created in lua. 
-- 
-- mon, sep 21, 2020
-- pleasant fall day. morning temps in the 40s
--   afternoon temps in the low 70s. sunny.
--   i saw some decent early fall color
--   yesterday while birdwatching along the 
--   lake erie shoreline of northwest ohio.
--
-- "coot" refers to american coot, which is a
--    waterfowl-like bird. to me, it seems like
--    part chicke and part duck. the nickname
--    for american coot is the "mudhen," which
--    is the nickname for the toledo minor
--    league baseball team.
--
-- cootc is the client piece. i'll create a server
--    piece later, called coots. for now, i'll use
--    the web protocol to communicate between this
--    command line utility and the server. initially,
--    the server will be nginx and my sora web-based
--    static site generator. eventually, i will create
--    a small web server that will contain sora. 
--    sora will be a web server or the small web
--    server will be sora. someday, i would like to 
--    create a desktop editor that communicates with 
--    the server code, and some day, i will replace
--    the http protocol with my custom code. this
--    process will occur in several interations.
--    ironically, i will continue to rely on web tech
--    to manage Gemini content. maybe this all too 
--    much, and i should keep it simple with the 
--    fewest number of moving parts by editing on
--    my laptop with either Vim or Typora and then 
--    using SFTP to transfer the files to the server.
--    no need for custom made client and server code.
--    but if the goal is to attract non-tech people, then
--    something more graphical and non-commannd-line
--    may be needed.
--
-- cootc actions:
--    login 
--    activate
--    create
--    update
--
-- thu, sep 24, 2020 update:
--  i changed the name from cootc.lua to soraclient.lua, since 
--  i'm using the web protocol to communicated with the api
--  of my sora cms. i will leave this utility as is.
--  i plan to create my own custom socket programming 
--  client-server setup to copy local content to my gemini
--  server. this gemini+write setup may be called Coot.


local user = require "user"
local post = require "post"


if #arg < 1 then
    error("missing parameters. use ./cootc.lua help for info.")
end


if #arg == 1 and arg[1] == "login" then
    user.request_login_link()
elseif #arg == 2 and arg[1] == "activate" then
    user.activate_login(arg[2])  
elseif #arg == 2 and arg[1] == "create" then
    post.create(arg[2])    
elseif #arg == 3 and arg[1] == "update" then
    post.update(arg[2], arg[3])
else
    print("nothing to do for: " .. arg[1])
end
