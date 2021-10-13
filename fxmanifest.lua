fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

description 'QBR-PoliceJob'
version '1.0.0'

shared_script {
	'config.lua'
}

client_scripts {
	'client/main.lua',
	'client/interactions.lua',
	'client/job.lua',
	'client/gui.lua',
	'client/objects.lua'
}

server_script 'server/main.lua'

exports {
	'IsHandcuffed',
}

dependency 'qbr-core'
