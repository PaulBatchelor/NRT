require 'json'
require 'pp'
data = JSON.parse(`./nrt -j -s "[drm][zf]"`)
notes = data["notes"]
out = notes.sort_by{ |k, v| k["time"]
}
pp out

