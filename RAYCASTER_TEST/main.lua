--Global variables for easy and fast typing--------------------------------------------------------------------
lg, lm, lk, lfs, lw, lt = love.graphics, love.mouse, love.keyboard, love.filesystem, love.window, love.timer
---------------------------------------------------------------------------------------------------------------

-- global variables
MINI_MAP_TILE_SIZE=5
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
  lg.setColor(255, 0, 255)
  lg.print(math.deg(player.a) .."\n"..math.ceil(player.x/64) ..", ".. math.ceil(player.y/64), 10, 10)

  render()
  drawMiniMap(10, 10)
end

--

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

  player.a=player.a%math.rad(360)
end




-- raycaster functions

function render()
  -- screen width
  local SW=lg.getWidth()
  local x=0

  for angle=player.a-player.FOV/2, player.a+player.FOV/2, player.FOV/(SW-1) do
    --print(angle+player.a-player.FOV/2)
    distance = traceRay(angle, map)
    distance=distance*math.cos(player.a-angle)

    distProjPlane=SW/(2*math.tan(player.FOV/2))
    sliceHeight=BLOCK_SIZE/distance*distProjPlane
    drawVerticalStrip(x, sliceHeight)
    x=x+1
  end
end

function drawVerticalStrip(x, height)
  lg.setColor(255,0,0)
  lg.line(x, lg.getHeight()/2+height/2, x, lg.getHeight()/2-height/2)
end

function traceRay(angle, world, strip)
  angle=angle%math.rad(360)
  local distanceh, distancev

  local Xa, Ya
  local Ax, Ay

  -- Checks for horizontal intersections
  if isFacingUp(angle) then
    Ya=-BLOCK_SIZE
    Ay=math.floor(player.y/BLOCK_SIZE)*BLOCK_SIZE
  else
    Ya=BLOCK_SIZE
    Ay=math.ceil(player.y/BLOCK_SIZE)*BLOCK_SIZE+1
  end

  Xa=BLOCK_SIZE/math.tan(-angle)
  Ax = player.x + (player.y-Ay)/math.tan(-angle)

  lg.setColor(255, 0, 255)
  while true do    --lg.circle("fill",Ax/BLOCK_SIZE*MINI_MAP_TILE_SIZE,Ay/BLOCK_SIZE*MINI_MAP_TILE_SIZE,5)
    if index(math.ceil(Ay/64), math.ceil(Ax/64))==1 or outOfBounds(math.ceil(Ay/64), math.ceil(Ax/64)) then
      -- gets the distance from wall to the player
      distanceh=math.sqrt((player.x-Ax)^2+(player.y-Ay)^2)
      break
    end

    Ay=Ay+Ya
    if isFacingUp(angle) then
      Ax=Ax+Xa
    else
      Ax=Ax-Xa
    end
  end

  -- Checks for vertical intersections
  if isFacingRight(angle) then
    Xb=BLOCK_SIZE
    Bx=math.ceil(player.x/BLOCK_SIZE)*BLOCK_SIZE+1
  else
    Xb=-BLOCK_SIZE
    Bx=math.floor(player.x/BLOCK_SIZE)*BLOCK_SIZE
  end
  Yb=math.tan(angle)*BLOCK_SIZE
  By=player.y + (player.x-Bx)*math.tan(-angle)

  while true do
    if index(math.ceil(By/64), math.ceil(Bx/64))==1 or outOfBounds(math.ceil(By/64), math.ceil(Bx/64)) then

      -- gets the distance from wall to the player
      distancev=math.sqrt((player.x-Bx)^2+(player.y-By)^2)
      break
    end

    Bx=Bx+Xb
    if isFacingRight(angle) then
      By=By+Yb
    else
      By=By-Yb
    end
  end

  lg.setColor(255,255,0)
  local distancetoproj = lg.getWidth()/math.tan(player.FOV)
  --[[if distanceh<distancev then
    local h = (64/distanceh)*distancetoproj
    lg.line(player.x/BLOCK_SIZE*MINI_MAP_TILE_SIZE,player.y/BLOCK_SIZE*MINI_MAP_TILE_SIZE,Ax/BLOCK_SIZE*MINI_MAP_TILE_SIZE,Ay/BLOCK_SIZE*MINI_MAP_TILE_SIZE)
    lg.line(strip, lg.getHeight()/2+h/2, strip, lg.getHeight()/2-h/2)
  else
    local h = (64/distancev)*distancetoproj
    --lg.line(player.x/BLOCK_SIZE*MINI_MAP_TILE_SIZE,player.y/BLOCK_SIZE*MINI_MAP_TILE_SIZE,Bx/BLOCK_SIZE*MINI_MAP_TILE_SIZE,By/BLOCK_SIZE*MINI_MAP_TILE_SIZE)
  end]]

  return math.min(distanceh, distancev)
end



function isFacingUp(angle)
  if math.deg(angle)>0 and math.deg(angle)<180 then
    return false
  end
  return true
end

function isFacingRight(angle)
  if math.deg(angle)<90 or math.deg(angle)>270 then
    return true
  end
  return false
end

function outOfBounds(y, x)
  if x<1 or x>#map[1] or y<1 or y>#map then return true end
  return false
end

function index(y, x)
  if not outOfBounds(y, x) then
    return map[y][x]
  end
end
-----------------------

-- misc


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
  LINE_SIZE=50
  lg.setColor(0,255,0)
  Px,Py=Px/BLOCK_SIZE*MINI_MAP_TILE_SIZE+x,Py/BLOCK_SIZE*MINI_MAP_TILE_SIZE+y
  lg.line(Px,Py,Px+LINE_SIZE*math.cos(player.a),Py+LINE_SIZE*math.sin(player.a))

  lg.setColor(255,0,0)
  lg.circle("fill",Px/BLOCK_SIZE*MINI_MAP_TILE_SIZE+x, Py/BLOCK_SIZE*MINI_MAP_TILE_SIZE+y, 10*MINI_MAP_TILE_SIZE/30)


  lg.setColor(0,0,255)
  --local angle_left, angle_right = player.a-player.FOV/2, player.a+player.FOV/2
  --lg.line(Px,Py,Px+LINE_SIZE*math.cos(angle_left),Py+LINE_SIZE*math.sin(angle_left))
  --lg.line(Px,Py,Px+LINE_SIZE*math.cos(angle_right),Py+LINE_SIZE*math.sin(angle_right))
end
