require"Tile"

Map = {}
Map.mt={
  __index=Map,
}

-- constants
local DEFAULT_MAP_SIZE=30

setmetatable(Map,{
  __call=function(t,width,height)
    local m={
      walls={},
      floor={},
      ceiling={},
    }

    width=width or DEFAULT_MAP_SIZE
    height=height or DEFAULT_MAP_SIZE

    for y=1,height do
      m.walls[y]=Tile()
      for x=1,width do
        m.walls[x]=Tile()
      end
    end

    return setmetatable(m,Map.mt)
  end
})
