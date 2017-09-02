local World = require "data.scripts.World"

--Global variables for easy and fast typing--------------------------------------------------------------------
lg, lm, lk, lfs, lw, lt = love.graphics, love.mouse, love.keyboard, love.filesystem, love.window, love.timer
---------------------------------------------------------------------------------------------------------------

function love.load()
  world  = World()
  world2 = World()
end

function love.update(dt)

end

function love.draw()
  world:drawMiniMap(0, 0)
end


-- 23:29
-- 01/09/2017
-- HP7 <3
