local monsters = {}

function monsters.load()
	monsters.list = {}
	monsters.spawnMonster()
	monsters.maxscale = 1
	monsters.minscale = 0.1
	monsters.zscale = 1/monsters.maxscale - 1/monsters.minscale
	monsters.z0 = 10
	monsters.zbias = monsters.z0 * monsters.zscale + 1/monsters.maxscale
end

function monsters.spawnMonster()
	local newMonster = {
		init = function(self)
			-- in-game coords
			self.xx = math.random()*2 - 1
			self.yy = 0
			self.zz = -1

			self.ww = 0.5
			self.hh = 1
			self.zspeed = 0.1

		end,

		update = function (self, dt)
			self.zz = self.zz + self.zspeed * dt
			if self.zz > 0 then self:kill() end
		end,

		draw = function(self)
			local x = self.xx * 0.5 + 0.5
			local y = self.yy * 0.5 + 0.5
			local sc = 1 / ( (self.zz - monsters.z0) * monsters.zscale + monsters.zbias )
			local w = self.ww * sc
			local h = self.hh * sc

			local sw,sh = love.graphics.getWidth(),love.graphics.getHeight()
			
			x,y,w,h = x*sw,y*sh,w*sw,h*sh

			local frac = self.zz + 1
			love.graphics.setColor(255*frac,255*frac,255*frac)
			love.graphics.rectangle("fill",x-w*0.5,y-h*0.5,w,h)
		end,

		kill = function(self)
			self.dead = true
			monsters.anyDead = true
		end,
	}

	newMonster:init()
	table.insert(monsters.list, 1, newMonster)
end

local function cleanMonsterList()
	if monsters.anyDead then
		monsters.anyDead = false
		for i = #monsters.list,1,-1 do
			if monsters.list[i].dead then
				table.remove(monsters.list, i)
			end
		end
	end
end

function monsters.update(dt)
	for i,monster in ipairs(monsters.list) do
		monster:update(dt)
	end
	cleanMonsterList()
end

function monsters.draw()
	for i,monster in ipairs(monsters.list) do
		monster:draw()
	end
end

function monsters.mousepressed()
	monsters.spawnMonster()
end

return monsters