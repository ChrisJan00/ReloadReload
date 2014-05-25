local weapon = {}

local x, y = love.mouse.getPosition()
local lastY = y

local traveled = 0 

-- 0: nothing, 1: already moved up, 2: moved down too, its reloaded now
local reloadState = 0

local reloadLength = 100

local shotgunAngles = {}
local currentAngle = 0

local shotgun = love.graphics.newImage( "images/shotgunready.png" )

weapon.position = 0

function weapon.load()
  reloadState = 2
  currentAngle = 0
  shotgunAngles = { math.pi/12, 3*math.pi/12, 0 }
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

    if traveled > reloadLength*screenScale and reloadState < 2 then
      reloadState = reloadState + 1

      sounds.play(sounds.reload[reloadState])
      traveled = 0
    end


    local alphacoef = math.pow(0.85,dt*60)
    if reloadState == 0 then 
      -- faster transition when shooting
      alphacoef = math.pow(0.7,dt*60)
    end
    currentAngle = currentAngle * alphacoef + shotgunAngles[reloadState+1] * (1-alphacoef)


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
  love.graphics.draw(shotgun, 
      weapon.position + (100 + shotgun:getWidth()) * screenScale, 
      screenSize[2] + (-180 + shotgun:getHeight()) * screenScale - walk.value(aim.phase), 
      currentAngle, 
      screenScale, 
      screenScale,
      shotgun:getWidth(),
      shotgun:getHeight())
end

function reloaded()
  return reloadState == 2
end

return weapon 
