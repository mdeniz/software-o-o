require "activexml/activexml"

api = URI(CONFIG['api_host'])
map = ActiveXML::setup_transport(api.scheme, api.hostname, api.port)

map.connect :published, 'rest:///published/:project/:repository/:arch/:name?:view'
map.connect :seeker, 'rest:///search?match=:match',
    :project => 'rest:///search/project/id?match=:match',
    :package => 'rest:///search/package/id?match=:match',
    :pattern => 'rest:///search/published/pattern/id?match=:match',
    :binary => 'rest:///search/published/binary/id?match=:match'
#map.connect :appdata, 'rest:///build/:prj/:repo/:arch/:pkgname/:appdata'
map.connect :attribute, 'rest:///source/:prj/_attribute/:attribute'
map.set_additional_header( "X-Username", CONFIG['api_username'])
map.login CONFIG['api_username'], CONFIG['api_password']
map.set_additional_header( "User-Agent", "software.o.o" )
map.set_additional_header("X-opensuse_data", CONFIG['opensuse_cookie']) if CONFIG['opensuse_cookie']

