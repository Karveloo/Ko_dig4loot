fx_version 'cerulean'
game 'gta5'
lua54 'yes'

description 'KO dig4loot'
author 'Ko'

client_script {
    'cl.lua',
}

server_script {
    'sv.lua'
}

shared_script {
    '@es_extended/imports.lua',
    'config.lua',
    '@ox_lib/init.lua',
    '@es_extended/locale.lua'
}
