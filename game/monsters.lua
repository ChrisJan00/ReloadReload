local monsters = {}

function monsters.load()
	monsters.list = {}
	monsters.maxscale = 2
	monsters.minscale = 0.1
	monsters.zscale = 1/monsters.maxscale - 1/monsters.minscale
	monsters.z0 = 10
	monsters.zbias = monsters.z0 * monsters.zscale + 1/monsters.maxscale

	monsters.enemypics = {
		love.graphics.newImage("images/enemy1.png"),
		love.graphics.newImage("images/enemy2.png"),
		love.graphics.newImage("images/enemy3.png"),
		love.graphics.newImage("images/enemy4.png")
	}
	monsters.solidpics = {
		love.graphics.newImage("images/enemy1_solid.png"),
		love.graphics.newImage("images/enemy2_solid.png"),
		love.graphics.newImage("images/enemy3_solid.png"),
		love.graphics.newImage("images/enemy4_solid.png")
	}


	monsters.spawnCycle = 0
	monsters.spawnCycleSpeed = 0.1
	monsters.spawnCycleAmp = 2
	monsters.spawnDelay = 3
	monsters.spawnTimer = monsters.spawnDelay

end

function monsters.spawnMonster()
	local newMonster = {
		init = function(self)
			self.isMonster = true

			-- pic
			local ndx = math.random(#monsters.enemypics)
			self.pic = monsters.enemypics[ndx]
			self.solidpic = monsters.solidpics[ndx]

			-- in-game coords
			self.xx = (math.random()*2 - 1)*0.9
			self.yy = 0
			self.zz = -1

			local incspeed = math.random()
			self.zspeed = 0.1 + 0.1 * incspeed

			self.walkspeed = 3 + incspeed*2.5
			self.cycle = 0
			self.amp = 30 + math.random()*60
		end,

		update = function (self, dt)
			self.zz = self.zz + self.zspeed * dt
			if self.zz > 0 then 
				self:kill() 
				teeth.hit()
			end

			-- screen coords
			local sw,sh = screenSize[1],screenSize[2]
			self.x = sw * (self.xx * 0.5 + 0.5)
			self.y = sh * (self.yy * 0.5 + 0.5)


			-- walk
			self.cycle = (self.cycle + self.walkspeed * dt) % (math.pi * 2)
			local amp = math.pow(math.sin(self.cycle),2) * self.amp * screenScale
			self.y = self.y - amp * self:getScale()
		end,

		draw = function(self)
			local sc = self:getScale() * screenScale

			love.graphics.setColor(255,255,255)
			love.graphics.draw(self.pic, self.x, self.y, 0, sc, sc, self.pic:getWidth()*0.5, self.pic:getHeight()*0.5)
			
			local frac = -self.zz
			love.graphics.setColor(bg.skycolor[1],bg.skycolor[2],bg.skycolor[3],255*frac)
			love.graphics.draw(self.solidpic, self.x, self.y, 0, sc, sc, self.pic:getWidth()*0.5, self.pic:getHeight()*0.5)
		end,

		kill = function (self)
			self.dead = true
			monsters.anyDead = true
			entities.anyDead = true
		end,

		getScale = function(self)
			return 1 / ( (self.zz - monsters.z0) * monsters.zscale + monsters.zbias )
		end,

		getLimits = function(self)
			local sc = self:getScale() * screenScale
			local xleft = self.x - self.pic:getWidth() * sc * 0.5
			local xright = self.x + self.pic:getWidth() * sc * 0.5
			return xleft, xright
		end
	}

	newMonster:init()
	table.insert(monsters.list, 1, newMonster)
	table.insert(entities.list, newMonster)
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
	-- avoid spawning while showing enemies
	if showTitle then return end

	monsters.spawnCycle = (monsters.spawnCycle + monsters.spawnCycleSpeed * dt) % (math.pi*2)
	monsters.spawnDelay = 1 + (1+math.cos(monsters.spawnCycle)) * monsters.spawnCycleAmp

	monsters.spawnTimer = monsters.spawnTimer + dt
	while monsters.spawnTimer >= monsters.spawnDelay do
		monsters.spawnTimer = monsters.spawnTimer - monsters.spawnDelay
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

function monsters.mousepressed()
	monsters.spawnMonster()
end

return monsters