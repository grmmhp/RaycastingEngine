Entity={}
Entity.mt={}

setmetatable(Entity,{
  __call=function(t, x, y)
    local e={
      x=x or 0
      y=y or 0
    }

    return setmetatable(e,Entity.mt)
  end
})
