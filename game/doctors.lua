local doctors = {}

function doctors.load()
	doctors.list = {}
	doctors.maxscale = 2
	doctors.minscale = 0.1
	doctors.zscale = 1/doctors.maxscale - 1/doctors.minscale
	doctors.z0 = 10
	doctors.zbias = doctors.z0 * doctors.zscale + 1/doctors.maxscale
	doctors.prescale = 0.7

	doctors.pics = {
		love.graphics.newImage("images/doctor.png")
	}

	doctors.solidpics = {
		love.graphics.newImage("images/doctor_solid.png")
	}

end

function doctors.spawnDoctor(spawnPosition)
	local newDoctor = {
		init = function(self)
			-- pic
			self.isDoctor = true
			
			local ndx = math.random(#doctors.pics)
			self.pic = doctors.pics[ndx]
			self.solidpic = doctors.solidpics[ndx]

			-- in-game coords
			self.xx = (spawnPosition/screenSize[1])*2-1
			self.yy = 0
			self.zz = 0

			self.ww = self.pic:getWidth() / 800 * 10
			self.hh = self.pic:getHeight() / 600 * 10
			self.zspeed = -0.1

			self.angle = 0
			self.angularspeed = (math.random()-0.5)*math.pi


		end,

		update = function (self, dt)
			self.zz = self.zz + self.zspeed * dt
			if self.zz < -1 then self:kill() end

			self.angle = (self.angle + self.angularspeed * dt) % (math.pi*2)

						-- screen coords
			local sw,sh = screenSize[1],screenSize[2]
			self.x = sw * (self.xx * 0.5 + 0.5)
			self.y = sh * (self.yy * 0.5 + 0.5)
		end,

		draw = function(self)
			local sc = self:getScale() * screenScale * doctors.prescale
			
			love.graphics.setColor(255,255,255)
			love.graphics.draw(self.pic, self.x, self.y, self.angle, sc, sc, self.pic:getWidth()*0.5, self.pic:getHeight()*0.5)
			
			local frac = -self.zz
			love.graphics.setColor(bg.skycolor[1],bg.skycolor[2],bg.skycolor[3],255*frac)
			love.graphics.draw(self.solidpic, self.x, self.y, self.angle, sc, sc, self.pic:getWidth()*0.5, self.pic:getHeight()*0.5)
		end,

		kill = monsters.killFunc,

		getScale = function(self)
			return 1 / ( (self.zz - monsters.z0) * monsters.zscale + monsters.zbias )
		end,

		getLimits = function(self)
			local sc = self:getScale() * screenScale * doctors.prescale
			local xleft = self.x - self.pic:getWidth() * sc * 0.5
			local xright = self.x + self.pic:getWidth() * sc * 0.5
			return xleft, xright
		end

	}

	newDoctor:init()
	table.insert(monsters.list, newDoctor)
end

return doctors
