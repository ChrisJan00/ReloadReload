function love.load()
	aim = love.filesystem.load("aim.lua")()
	aim.load()
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
end

function love.draw()
	aim.draw()
end