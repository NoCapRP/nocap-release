resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

description "Dynasty"

client_scripts {
    "client/blips.lua",
    "client/cl_hostage.lua",
    "client/control.lua",
    "client/dice.lua",
    "client/cl_weapons-on-back.lua",
    "client/greenzones.lua",
    "config.lua",
}

server_scripts {
    "server/control.lua",
    "server/dice.lua",
    "server/sv_hostage.lua",
    "config.lua",
}