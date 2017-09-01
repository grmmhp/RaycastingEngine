Tile={}
Tile.mt={}

setmetatable(Tile,{
  __call=function(t,id)
    local t={
      id=id or 0,
    }

    return setmetatable(t,Tile.mt)
  end
})
