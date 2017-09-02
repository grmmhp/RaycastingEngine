require"data.scripts.Map"

local World = {}
local World_mt = {__index=World}
setmetatable(World, {__call = function(t,map,entities) return World._new(t, map, entities) end})

function World._new(t, map, entities)
  local o = {}
  o.map = map or Map()
  o.entities = entities or {}
  return setmetatable(o, World_mt)
end

function World:drawMiniMap(x, y)
  self.map:draw(x, y)
end

return World
