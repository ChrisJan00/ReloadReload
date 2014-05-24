local monsters = {}

function monsters.load()
	monsters.list = {}
	monsters.maxscale = 2
	monsters.minscale = 0.1
	monsters.zscale = 1/monsters.maxscale - 1/monsters.minscale
	monsters.z0 = 10
	monsters.zbias = monsters.z0 * monsters.zscale + 1/monsters.maxscale

	monsters.enemypics = {
		love.graphics.newImage("images/enemy1.png")
	}
	monsters.solidpics = {
		love.graphics.newImage("images/enemy1_solid.png")
	}


	monsters.spawnDelay = 1
	monsters.spawnTimer = monsters.spawnDelay

end

function monsters.spawnMonster()
	local newMonster = {
		init = function(self)
			-- pic
			local ndx = math.random(#monsters.enemypics)
			self.pic = monsters.enemypics[ndx]
			self.solidpic = monsters.solidpics[ndx]

			-- in-game coords
			self.xx = (math.random()*2 - 1)*0.9
			self.yy = 0
			self.zz = -1



			-- self.ww = self.pic:getWidth() / 800 * 10
			-- self.hh = self.pic:getHeight() / 600 * 10
			self.zspeed = 0.1


		end,

		update = function (self, dt)
			self.zz = self.zz + self.zspeed * dt
			if self.zz > 0 then 
				self:kill() 
				teeth.hit()
			end


			-- screen coords
			local sw,sh = love.graphics.getWidth(),love.graphics.getHeight()
			self.x = sw * (self.xx * 0.5 + 0.5)
			self.y = sh * (self.yy * 0.5 + 0.5)
			
		end,

		draw = function(self)
			local sc = 1 / ( (self.zz - monsters.z0) * monsters.zscale + monsters.zbias )
			
			love.graphics.setColor(255,255,255)
			love.graphics.draw(self.pic, self.x, self.y, 0, sc, sc, self.pic:getWidth()*0.5, self.pic:getHeight()*0.5)
			
			local frac = -self.zz
			love.graphics.setColor(bg.skycolor[1],bg.skycolor[2],bg.skycolor[3],255*frac)
			love.graphics.draw(self.solidpic, self.x, self.y, 0, sc, sc, self.pic:getWidth()*0.5, self.pic:getHeight()*0.5)
		end,

		kill = function(self)
			self.dead = true
			monsters.anyDead = true
		end,

		getLimits = function(self)
			local sc = 1 / ( (self.zz - monsters.z0) * monsters.zscale + monsters.zbias )
			local xleft = self.x - self.pic:getWidth() * sc * 0.5
			local xright = self.x + self.pic:getWidth() * sc * 0.5
			return xleft, xright
		end
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

local function updateSpawner(dt)
	monsters.spawnTimer = monsters.spawnTimer - dt
	while monsters.spawnTimer <= 0 do
		monsters.spawnTimer = monsters.spawnTimer + monsters.spawnDelay
		monsters.spawnMonster()
	end
end


function monsters.update(dt)
	updateSpawner(dt)
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