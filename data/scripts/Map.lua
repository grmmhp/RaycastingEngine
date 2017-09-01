Map = {}
Map.mt={}

-- constants
local DEFAULT_MAP_SIZE=30

setmetatable(Map,{
  __call=function(t,width,height)
    local m={}

    width=width or DEFAULT_MAP_SIZE
    height=height or DEFAULT_MAP_SIZE

    for y=1,height do
      m[y]=0
      for x=1,width do
        m[x]=0
      end
    end

    return setmetatable(m,Map.mt)
  end
})
