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
    prescale = 10 / ( (_zz - monsters.z0) * monsters.zscale + monsters.zbias ),
    amp = 0,
    opacity = 1,
 
    update = function (self, dt)
      self.timeLeft = self.timeLeft - dt
      if self.timeLeft <= dt then
        self:kill()
      end

      local t = (defaultTime - self.timeLeft)/defaultTime * 5
      self.amp = t * math.exp(-t) * self.prescale
      if t>1 then
        self.opacity = self.opacity * math.pow(0.9, dt*60)
      end
    end,

    draw = function (self)
      love.graphics.setColor(255,255,255,255*self.opacity)
      love.graphics.draw(explosionPic, self.x, self.y,0,self.amp * screenScale,self.amp * screenScale,explosionPic:getWidth()*0.5,explosionPic:getHeight()*0.5)
    end,

    kill = monsters.killFunc
  }

  table.insert(monsters.list, newExplosion)

end

return collisions
