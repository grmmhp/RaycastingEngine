local world = {{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
               {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
               {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
               {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
               {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
               {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
               {1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
               {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
               {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
               {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
               {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
               {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
               {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
               {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1},
               {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
               {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
               {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
               {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
               {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
               {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
               {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
               {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
				}
                      --    px    py   pr  pv   prv
local px, py, pr, pv, prv = 218,  218,  0,  2,  2
local FOV = 60
local w, h = 320, 200
local eachangle = w/FOV
local distance = (w/2)/math.tan(math.rad(FOV/2))
local angleoffset = 80
local dir = ""
local dir2 = ""

function drawMap(map)
  for y=1, #map do
    for x=1, #map[y] do
      if map[y][x] == 1 then
        love.graphics.rectangle('fill', x*64, y*64, 64, 64)
      else
        love.graphics.setColor(255, 255, 255, 30)
        love.graphics.rectangle('line', x*64, y*64, 64, 64)
        love.graphics.setColor(255, 255, 255)
      end
    end
  end
end


local function castray(angle)

  local Ay, Ax, By, Bx, Ya, Xa, Xb, Yb, ALPHA

  ALPHA = math.atan2(math.sin(math.rad(angle)), math.cos(math.rad(angle)))
  --print(ALPHA)

  -- Intersecção Horizontal ----------------------------------------
  if angle < 0 and angle > -180 or angle > 180 and angle < 360 then
    dir = "UP"
    Ay = math.floor(py/64)*64-1
    Ya = -64
  else
    dir = "DOWN"
    Ay = math.floor(py/64)*64+64
    Ya = 64
  end
  Ax = px + (py-Ay)/math.tan(ALPHA)
  Xa = 64/math.tan(ALPHA)

  while world[math.floor(Ay/64)][math.floor(Ax/64)] == 0 do
    Ax = Ax + Xa
    Ay = Ay + Ya
    love.graphics.setColor(0, 255, 0)
    love.graphics.circle('fill', Ax, Ay, 3)
    love.graphics.setColor(255, 255, 255)
    if Ax > #world[1]*64 or Ay > #world*64 then
      print('BREAK')
      break
    end
  end
  -- Fim Intersecção Horizontal ----------------------------------------

  -- Intersecção Vertical ----------------------------------------
  --[[if angle < 90 and angle > -90 or angle > 270 or angle < -270 then
    dir2 = "RIGHT"
    Bx = math.floor(px/64)*64+64
    Xb = 64
  else
    dir2 = "LEFT"
    Bx = math.floor(px/64)*64-1
    Xb = -64
  end
  By = py + (px-Bx)*math.tan(ALPHA)
  Yb = 64*math.tan(ALPHA)
  print('Bx', Bx, 'By', By)
  while world[math.floor(By/64)][math.floor(Bx/64)] == 0 do
    Bx = Bx + Xb
    By = By + Yb
    love.graphics.setColor(0, 0, 255)
    love.graphics.circle('fill', Bx, By, 3)
    love.graphics.setColor(255, 255, 255)
    if math.floor(Bx/64) > #world[1] or math.floor(By/64) > #world or Bx < 64 or By < 64 then
      print('BREAK2')
      break
    end
  end]]

  -- Fim Intersecção Vertical ----------------------------------------



  love.graphics.setColor(255, 0, 0)
  --love.graphics.circle('fill', Xt, Yt, 10)
  love.graphics.setColor(255, 255, 255)
end

function love.load()

end

function love.update(dt)
  if love.keyboard.isDown('w') then
    px = px + math.cos(math.rad(pr))*pv
    py = py + math.sin(math.rad(pr))*pv
  end
  if love.keyboard.isDown('a') then
    px = px - math.cos(math.rad(pr)+math.rad(90))*pv
    py = py - math.sin(math.rad(pr)+math.rad(90))*pv
  end
  if love.keyboard.isDown('s') then
    px = px - math.cos(math.rad(pr))*pv
    py = py - math.sin(math.rad(pr))*pv
  end
  if love.keyboard.isDown('d') then
    px = px - math.cos(math.rad(pr)-math.rad(90))*pv
    py = py - math.sin(math.rad(pr)-math.rad(90))*pv
  end
  if love.keyboard.isDown('left') then
    pr = pr - prv
  end
  if love.keyboard.isDown('right') then
    pr = pr + prv
  end
  if pr >= 360 or pr <= -360 then
    pr = 0
  end
end

function love.draw()
  love.graphics.print(pr.." "..dir.." "..dir2)
  love.graphics.scale(0.4)
  drawMap(world)
  love.graphics.rectangle('fill', px, py, 32, 32)
  love.graphics.line(px+16, py+16, px+16+math.cos(math.rad(pr))*50, py+16+math.sin(math.rad(pr))*50)
  local a = 0
  for i=0, 29 do
    castray(a+pr-100)
    a = a + eachangle
  end
end
