function love.load()
	aim = love.filesystem.load("aim.lua")()
	aim.load()
	weapon = love.filesystem.load("weapon.lua")()
	weapon.load(200)
	monsters = love.filesystem.load("monsters.lua")()
	monsters.load()
	bg = love.filesystem.load("background.lua")()
	bg.load()
	teeth = love.filesystem.load("teeth.lua")()
	teeth.load()

	isGameOver = false
	gameoverpic = love.graphics.newImage("images/gameoverscr.png")
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
	if isGameOver then
		return
	end
	aim.update(dt)
 	weapon.update(dt)
	monsters.update(dt)
end

function love.draw()
	bg.draw()
	monsters.draw()
	aim.draw()
 	weapon.draw(aim.getPosition())
  	teeth.draw()

  	if isGameOver then
  		love.graphics.setColor(255,255,255)
  		love.graphics.draw(gameoverpic)
  	end
end

function love.mousepressed( x, y, button )
  weapon.mousepressed(x,y,button)
end

function gameOver()
	isGameOver = true
end
