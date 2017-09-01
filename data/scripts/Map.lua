require"data.scripts.Tile"

Map = {}
Map.mt={
  __index=Map,
}

-- constants
local DEFAULT_MAP_SIZE=30
local MINI_MAP_TILE_SIZE=15

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

function Map:draw(self, x, y)
  for ny=1,#self.walls do
    for nx=1,#self.walls[1] do
      local px = x+MINI_MAP_TILE_SIZE*(nx-1)+1
      local py = y+MINI_MAP_TILE_SIZE*(ny-1)+1

      if self.walls[ny][nx].id==0 then
        lg.setColor(255,255,255)
      else
        lg.setColor(0,0,0)
      end

      lg.rectangle("fill", px, py, MINI_MAP_TILE_SIZE, MINI_MAP_TILE_SIZE)
    end
  end
end
