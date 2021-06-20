fx_version 'adamant'

game 'gta5'

description 'brp_sr'

version '1.2.0'

server_scripts {
    "server/3dme_server.lua",
	"server/ca_server.lua",
    "server/noshuff_server.lua", 
	"server/sv_carry.lua",
}

client_scripts {
    "client/3dme_client.lua",
	"client/ca_client.lua",
	"client/cl_carry.lua",
	"client/disabledispatch_client.lua",
    "client/noshuff_client.lua",
	"client/greenzones.lua",	
}

files {
	'data/events.meta',
	'data/relationships.dat'
}

data_file 'FIVEM_LOVES_YOU_4B38E96CC036038F' 'data/events.meta'
