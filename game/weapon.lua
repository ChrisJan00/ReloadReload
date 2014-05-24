local weapon = {}

local x, y = love.mouse.getPosition()
local lastY = y

local traveled = 0 

-- 0: nothing, 1: already moved up, 2: moved down too, its reloaded now
local reloadState = 0

local reloadLength = 0

local shotgun = love.graphics.newImage( "images/shotgunready.png" )

local doctors = {}

weapon.position = 0

function weapon.load(rl,docs)
  reloadLength = rl
  doctors = docs 
end

function weapon.update(dt)

    local x, y = love.mouse.getPosition()
    
    local dy = lastY - y
    
    local direction = reloadStateToDirection(reloadState)
    
    if direction == -1 and dy > 0 then
      traveled = 0
    elseif direction == 1 and dy < 0 then
      traveled = 0
    else
      traveled = traveled + math.abs(dy)
    end

    lastY = y

    if traveled > reloadLength and reloadState < 2 then
      reloadState = reloadState + 1

      sounds.play(sounds.reload[reloadState])
      traveled = 0
    end

    return reloadState == 2
end

function weapon.shoot()
  sounds.play(sounds.shoot)
  reloadState = 0
  traveled = 0
end

function reloadStateToDirection(reloadState)
  if reloadState == 0 then
    return -1
  elseif reloadState == 1 then
    return 1
  else
    return 0
  end
end

function weapon.mousepressed(x,y,button)
  if button == "l" and reloaded() then
    weapon.shoot()
    doctors.spawnDoctor(weapon.position)
  end
end

function weapon.draw()
  love.graphics.draw(shotgun, weapon.position + 100, 440)
  -- if reloaded() then
  --   love.graphics.print("reloaded", 10,50)
  -- end
end

function reloaded()
  return reloadState == 2
end

return weapon 
