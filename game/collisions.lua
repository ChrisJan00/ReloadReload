local collisions = {}
local defaultTime = 1

local explosions = {}

local explosionPic = love.graphics.newImage("images/explosion.png")

function collisions.spawnExplosion(_x, _y, time)

  local newExplosion = {
    timeLeft = time or defaultTime,
    x = _x,
    y = _y,
    prescale = 1,

    update = function (self, dt)
      self.timeLeft = self.timeLeft - dt
    end,

    draw = function (self)
      love.graphics.draw(explosionPic, self.x, self.y,0,screenScale[1]*self.prescale,screenScale[2]*self.prescale,explosionPic:getWidth()*0.5,explosionPic:getHeight()*0.5)
    end
  }

  table.insert(explosions, newExplosion)

end

function collisions.update(dt)
  for i = #explosions,1,-1 do
    explosions[i]:update(dt)
    if explosions[i].timeLeft <= 0 then
      table.remove(explosions, i)
    end
  end
end

function collisions.draw()
  for i, exp in ipairs(explosions) do
    exp:draw()
  end
end

return collisions
