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
local eachangle = FOV/w
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

function get_distance(x1,y1, x2,y2) return ((x2-x1)^2+(y2-y1)^2)^0.5 end


local function castray(angle, strip)

  local Ay, Ax, By, Bx, Ya, Xa, Xb, Yb, ALPHA, hALPHA, vALPHA

  --print(ALPHA)
  ALPHA = math.atan2(math.sin(math.rad(angle)), math.cos(math.rad(angle)))
  -- Intersecção Horizontal ----------------------------------------
  if ALPHA < 0 and ALPHA > -math.pi or ALPHA > math.pi and ALPHA < math.pi*2 then
    dir = "UP"
    Ay = math.floor(py/64)*64-1
    Ya = -64
    hALPHA = -math.atan2(math.sin(math.rad(angle)), math.cos(math.rad(angle)))
  else
    dir = "DOWN"
    Ay = math.floor(py/64)*64+64
    Ya = 64
    hALPHA = math.atan2(math.sin(math.rad(angle)), math.cos(math.rad(angle)))
  end
  Ax = px + (py-Ay)/math.tan(hALPHA)
  Xa = 64/math.tan(hALPHA)

  while world[math.floor(Ay/64)][math.floor(Ax/64)] == 0 do
    Ax = Ax + Xa
    Ay = Ay + Ya
    if Ax > #world[1]*64 or Ay > #world*64 or Ax < 64 or Ay < 64 then
      Ax, Ay = 99999, 99999
      --print('BREAK')
      break
    end
    love.graphics.setColor(0, 255, 0, 50)
    --love.graphics.circle('fill', Ax, Ay, 2)
    love.graphics.setColor(255, 255, 255)
  end
  -- Fim Intersecção Horizontal ----------------------------------------
  -- Intersecção Vertical ----------------------------------------
  if ALPHA < math.pi/2 and ALPHA > -math.pi/2 or ALPHA > 3*(math.pi/2) or ALPHA < -3*(math.pi/2) then
    dir2 = "RIGHT"
    Bx = math.floor(px/64)*64+64
    Xb = 64
    vALPHA = math.atan2(math.sin(math.rad(angle)), math.cos(math.rad(angle)))
  else
    dir2 = "LEFT"
    Bx = math.floor(px/64)*64-64
    Xb = -64
    vALPHA = -math.atan2(math.sin(math.rad(angle)), math.cos(math.rad(angle)))
  end
  By = py + (px-Bx)*math.tan(vALPHA)
  Yb = 64*math.tan(vALPHA)
  --print('Bx', Bx, 'By', By)
  if By < #world[1]*64 and By < #world*64 and Bx > 64 and By > 64 then
    while world[math.floor(By/64)][math.floor(Bx/64)] == 0 do
      Bx = Bx + Xb
      By = By + Yb
      love.graphics.setColor(0, 0, 255, 50)
      --love.graphics.circle('fill', Bx, By, 5))
      love.graphics.setColor(255, 255, 255)
      if math.floor(Bx/64) > #world[1] or math.floor(By/64) > #world or Bx < 64 or By < 64 then
        Bx, By = 99999, 99999
        --print('BREAK2')
        break
      end
      --print('Bx', Bx, 'By', By)
    end
  end
  -- Fim Intersecção Vertical ----------------------------------------
  --print('Bloco em (Ax)', math.floor(Ax/64), math.floor(Ay/64))
  --print('Bloco em (Bx)', math.floor(Bx/64), math.floor(By/64))
  local DH, DV, Xt, Yt, d
  
  DH = get_distance(px, py, Ax, Ay)
  DV = get_distance(px, py, Bx, By)
  
  if DH < DV then
    Xt, Yt = Ax, Ay
    d = DH
    --print(DH, '<', DV)
  else
    Xt, Yt = Bx, By
    d = DV
    --print(DV, '<', DH)
  end
  
  local s = (64/d)*distance --(64 / 330) * 277
  love.graphics.setColor(255, 0, 0, 30)
  --love.graphics.circle('fill', Xt, Yt, 5)
  --love.graphics.line(strip, h/2+(s/2), strip, h/2-(s/2))
  love.graphics.line(px, py, Xt, Yt)
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
  for i=-w/2, w/2-1 do
    castray(pr+a, i)
    a = a + eachangle
  end
end
