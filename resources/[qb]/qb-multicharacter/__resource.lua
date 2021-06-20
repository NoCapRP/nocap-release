resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

shared_script "@alfa-scripts/cl_errorlog.lua"

ui_page "html/index.html"

client_scripts {
    'client/main.lua',
}

server_scripts {
    'server/main.lua',
}

files {
    'html/index.html',
    'html/style.css',
    'html/reset.css',
    'html/script.js',
    'html/qbus-logo.png'
}