function love.load()
	aim = love.filesystem.load("aim.lua")()
	aim.load()
  weapon = love.filesystem.load("weapon.lua")()
  weapon.load(200)
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
  weapon.update()
end

function love.draw()
	aim.draw()
  weapon.draw()
end

function love.mousepressed( x, y, button )
  weapon.mousepressed(x,y,button)
end
