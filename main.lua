local World = require "data.scripts.World"

--Global variables for easy and fast typing--------------------------------------------------------------------
lg, lm, lk, lfs, lw, lt = love.graphics, love.mouse, love.keyboard, love.filesystem, love.window, love.timer
---------------------------------------------------------------------------------------------------------------

function love.load()
  world  = World(1, 2, 3)
  world2 = World(4, 5, 6)
end

function love.update(dt)

end

function love.draw()
  --world.map:drawMiniMap()
end
