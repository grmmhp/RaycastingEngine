require"data.scripts.World"

--Global variables for easy and fast typing--------------------------------------------------------------------
lg, lm, lk, lfs, lw, lt = love.graphics, love.mouse, love.keyboard, love.filesystem, love.window, love.timer
---------------------------------------------------------------------------------------------------------------

function love.load()
  world=World()
end

function love.update(dt)

end

function love.draw()
  world.map:drawMiniMap()
end
