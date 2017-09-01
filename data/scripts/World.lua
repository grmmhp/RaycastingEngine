require"Map"

World = {}
World.mt = {}

setmetatable(World,
{__call = function(t,map,entities)
  local w={
    map=map or Map()
    entities=entities or {}
  }

  return setmetatable(World, World.mt)
end})
