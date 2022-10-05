fx_version 'cerulean'
games {'gta5'}

description 'Job'
author 'Sp1ry32' -- For support: @Sp1ry#2599
dependency 'dpemotes' -- https://forum.cfx.re/t/dpemotes-1-7-390-emotes-walkingstyles-keybinding-dances-expressions-and-shared-emotes/843105
shared_script 'config.lua'

client_scripts{ 
  "client.lua"
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "server.lua"
}