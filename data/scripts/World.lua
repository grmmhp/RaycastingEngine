require"data.scripts.Map"

World = {}
World.mt = {__index=World}

setmetatable(World,
{__call = function(t,map,entities)
  local w={
    map=map or Map(),
    entities=entities or {},
  }

  return setmetatable(World, World.mt)
end})

function World:drawMiniMap(self)
  self.map:draw()
end
