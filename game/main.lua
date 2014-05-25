function love.load()
	getScreenSizes()

	aim = love.filesystem.load("aim.lua")()
	aim.load()
	entities = love.filesystem.load("entities.lua")()
	entities.load()

	monsters = love.filesystem.load("monsters.lua")()
	monsters.load()
	bg = love.filesystem.load("background.lua")()
	bg.load()
	doctors = love.filesystem.load("doctors.lua")()
	doctors.load()
	weapon = love.filesystem.load("weapon.lua")()
	weapon.load(100, doctors)
	collisions = love.filesystem.load("collisions.lua")()
	collisions.load()
	teeth = love.filesystem.load("teeth.lua")()
	teeth.load()
	sounds = love.filesystem.load("sounds.lua")()
	sounds.load()


	thickness = 0.05
	isGameOver = false
	gameoverpic = love.graphics.newImage("images/gameoverscr.png")

    if isFullscreen then
    	love.mouse.setVisible( false )
    end
end

function getScreenSizes()
	local w,h = love.graphics.getWidth(),love.graphics.getHeight()
	screenScale = h / 600
	screenSize = { w, h }
	screenOffset = 0

	if w/h ~= 4/3 then
		screenSize[1] = 800 * screenScale
		screenOffset = (w - screenSize[1]) / 2
		screenScale = screenScale
	end
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
	doctors.update(dt)
	collisions.update(dt)
	weapon.position = aim.getPosition()
end



function rangesIntersect(a,b,x,y)
  return not (a>y or b<x)
end

function drawGame()
	bg.draw()
	entities.draw()
	aim.draw()
	weapon.draw(aim.getPosition())
	teeth.draw()
	
    if isGameOver then
        love.graphics.setColor(255,255,255)
        love.graphics.draw(gameoverpic,0,0,0,screenScale,screenScale)
    end
end

function love.draw()
	-- black borders
	love.graphics.push()
	love.graphics.translate(screenOffset, 0)
	love.graphics.setScissor(screenOffset, 0, screenSize[1], screenSize[2])

	drawGame()

   	love.graphics.setScissor()
    love.graphics.pop()
end

function love.mousepressed( x, y, button )
  weapon.mousepressed(x,y,button)
end

function gameOver()
   isGameOver = true
end
