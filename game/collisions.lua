local collisions = {}
local defaultTime = 1

local explosions = {}

local explosionPic = love.graphics.newImage("images/explosion.png")

function collisions.spawnExplosion(_x, _y, _zz)

  local newExplosion = {
    timeLeft = time or defaultTime,
    x = _x,
    y = _y,
    zz = _zz,
    prescale = 2 / ( (_zz - monsters.z0) * monsters.zscale + monsters.zbias ),
 
    update = function (self, dt)
      self.timeLeft = self.timeLeft - dt
      if self.timeLeft <= dt then
        self:kill()
      end
    end,

    draw = function (self)
      love.graphics.setColor(255,255,255)
      love.graphics.draw(explosionPic, self.x, self.y,0,screenScale*self.prescale,screenScale*self.prescale,explosionPic:getWidth()*0.5,explosionPic:getHeight()*0.5)
    end,

    kill = monsters.killFunc
  }

  table.insert(monsters.list, newExplosion)

end

return collisions
