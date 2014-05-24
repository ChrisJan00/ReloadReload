function love.load()
	aim = love.filesystem.load("aim.lua")()
	aim.load()
	monsters = love.filesystem.load("monsters.lua")()
	monsters.load()
	bg = love.filesystem.load("background.lua")()
	bg.load()
  doctors = love.filesystem.load("doctors.lua")()
  doctors.load()
  weapon = love.filesystem.load("weapon.lua")()
	weapon.load(200, doctors)
end

function love.keypressed(key)
	if key=="escape" then
		love.event.push("quit")
		return
	end

	aim.keypressed(key)
end

function love.keyreleased(key)
	aim.keyreleased(key)
end

function love.update(dt)
	aim.update(dt)
  weapon.update(dt)
	monsters.update(dt)
  doctors.update(dt)
  weapon.position = aim.getPosition()
end

function love.draw()
	bg.draw()
	monsters.draw()
  doctors.draw()
	aim.draw()
  weapon.draw(aim.getPosition())
end

function love.mousepressed( x, y, button )
  weapon.mousepressed(x,y,button)
	monsters.mousepressed()
end
