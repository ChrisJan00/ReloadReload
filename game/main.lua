function love.load()
	aim = love.filesystem.load("aim.lua")()
	aim.load()

	monsters = love.filesystem.load("monsters.lua")()
	monsters.load()
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

function love.mousepressed()
	monsters.mousepressed()
end

function love.update(dt)
	aim.update(dt)
	monsters.update(dt)
end

function love.draw()
	monsters.draw()
	aim.draw()
end