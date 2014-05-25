local collisions = {}
local defaultTime = 1

local explosions = {}

local explosionPic

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

    kill = function(self) 
      self.dead = true
      entities.anyDead = true
    end,
  }

  table.insert(collisions.list, newExplosion)
  table.insert(entities.list, newExplosion)

end


local function cleanCollisionsList()
  if collisions.anyDead then
    collisions.anyDead = false
    for i = #collisions.list,1,-1 do
      if collisions.list[i].dead then
        table.remove(collisions.list, i)
      end
    end
  end
end

function collisions.load()
  explosionPic = love.graphics.newImage("images/explosion.png")
  collisions.list = {}
end

function collisions.update(dt)
  for i,explo in ipairs(collisions.list) do
    explo:update(dt)
  end
  cleanCollisionsList()

  collisions.check()
end

function collisions.check()
  for i,mon in ipairs(monsters.list) do
    for j,doc in ipairs(doctors.list) do
      dxl, dxr = doc:getLimits()
      mxl, mxr = mon:getLimits()

      if rangesIntersect(dxl, dxr, mxl, mxr) and rangesIntersect(doc.zz-thickness, doc.zz, mon.zz, mon.zz+thickness) then
        doc:kill()
        mon:kill()
        sounds.play(sounds.splash)
        collisions.spawnExplosion((mxl+mxr)*0.5, screenSize[2]/2, mon.zz)
      end
    end
  end
end

return collisions
