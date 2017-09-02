--Global variables for easy and fast typing--------------------------------------------------------------------
lg, lm, lk, lfs, lw, lt = love.graphics, love.mouse, love.keyboard, love.filesystem, love.window, love.timer
---------------------------------------------------------------------------------------------------------------

-- global variables
MINI_MAP_TILE_SIZE=20

BLOCK_SIZE=64
a=true

--

player={
  x=3*BLOCK_SIZE-BLOCK_SIZE/2,
  y=3*BLOCK_SIZE-BLOCK_SIZE/2,
  a=0,
  v=2.5,
  av=.05,
  FOV=math.rad(60),
}

map={
  {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1},
  {1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1},
  {1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
  {1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1},
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1},
  {1, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
  {1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1},
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1},
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
  {1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 1, 0, 1, 0, 0, 0, 1},
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1},
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1},
  {1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1},
  {1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1},
  {1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
  {1, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
  {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},

}

function love.load()
end

function love.update(dt)
  input()
end

function love.draw()
  drawMiniMap()

  lg.print(math.deg(player.a), 10, 10)
end



function input()
  if lk.isDown("w") then
    player.x=player.x+player.v*math.cos(player.a)
    player.y=player.y+player.v*math.sin(player.a)
  end
  if lk.isDown("a") then
    player.x=player.x-player.v*math.cos(player.a+math.rad(90))
    player.y=player.y-player.v*math.sin(player.a+math.rad(90))
  end
  if lk.isDown("s") then
    player.x=player.x-player.v*math.cos(player.a)
    player.y=player.y-player.v*math.sin(player.a)
  end
  if lk.isDown("d") then
    player.x=player.x-player.v*math.cos(player.a-math.rad(90))
    player.y=player.y-player.v*math.sin(player.a-math.rad(90))
  end

  if lk.isDown("right") then
    player.a=player.a+player.av
  end

  if lk.isDown("left") then
    player.a=player.a-player.av
  end
end




-- raycaster functions

function render()
  -- screen width
  local SW=lg.getWidth()

  for angle=0, SW, FOV/(SW-1) do
    print(angle+player.a)
    traceRay(angle, map)
  end
end

function traceRay(angle, world)
  local Xa, Xy
  local Ax, Ay

  if isFacingUp(angle) then
    Ya=-BLOCK_SIZE
  else
    Ya=BLOCK_SIZE
  end


end

function isFacingUp(angle)
  if math.deg(angle)>0 and math.deg(angle)<180 then
    return false
  end
  return true
end

-----------------------




function handleCollision()

end

function drawMiniMap(x, y)
  x=x or 0
  y=y or 0

  for ny=1,#map do
    for nx=1,#map[1] do
      local px = x+MINI_MAP_TILE_SIZE*(nx-1)+1
      local py = y+MINI_MAP_TILE_SIZE*(ny-1)+1

      if map[ny][nx]==0 then
        lg.setColor(255,255,255)
      else
        lg.setColor(0,0,0)
      end

      lg.rectangle("fill", px, py, MINI_MAP_TILE_SIZE, MINI_MAP_TILE_SIZE)
      lg.setColor(200,200,200)
      lg.rectangle("line", px, py, MINI_MAP_TILE_SIZE, MINI_MAP_TILE_SIZE)
    end
  end

  -- draw mini player

  local Px,Py=player.x,player.y
  lg.setColor(255,0,0)
  lg.circle("fill",Px/BLOCK_SIZE*MINI_MAP_TILE_SIZE+x, Py/BLOCK_SIZE*MINI_MAP_TILE_SIZE+y, 5)

  LINE_SIZE=50
  lg.setColor(0,255,0)
  Px,Py=Px/BLOCK_SIZE*MINI_MAP_TILE_SIZE+x,Py/BLOCK_SIZE*MINI_MAP_TILE_SIZE+y
  lg.line(Px,Py,Px+LINE_SIZE*math.cos(player.a),Py+LINE_SIZE*math.sin(player.a))

  local angle_left, angle_right = player.a-player.FOV/2, player.a+player.FOV/2
  lg.line(Px,Py,Px+LINE_SIZE*math.cos(angle_left),Py+LINE_SIZE*math.sin(angle_right))
end
