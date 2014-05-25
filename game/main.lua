function love.load()
	getScreenSizes()

	walk = love.filesystem.load("walk.lua")()

	aim = love.filesystem.load("aim.lua")()
	entities = love.filesystem.load("entities.lua")()

	monsters = love.filesystem.load("monsters.lua")()
	bg = love.filesystem.load("background.lua")()
	doctors = love.filesystem.load("doctors.lua")()
	weapon = love.filesystem.load("weapon.lua")()
	collisions = love.filesystem.load("collisions.lua")()
	teeth = love.filesystem.load("teeth.lua")()
	sounds = love.filesystem.load("sounds.lua")()
	sounds.load()

	newGame()

	thickness = 0.05
	isGameOver = false
	gameoverpic = love.graphics.newImage("images/gameoverscr.png")
	titlepic = love.graphics.newImage("images/title.png")

    if isFullscreen then
    	love.mouse.setVisible( false )
    end
end

function newGame()
	walk.load()
	aim.load()
	entities.load()
	monsters.load()
	bg.load()
	doctors.load()
	weapon.load(doctors)
	collisions.load()
	teeth.load()
	-- sounds.load()

	-- gameover management
	isGameOver = false
	gameoverTimer = 3
	showTitle = true
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

	if isGameOver then
		if gameoverTimer <= 0 then
			newGame()
		end
	else
		aim.keypressed(key)
	end
end

function love.keyreleased(key)
	aim.keyreleased(key)
end

function love.update(dt)
	if dt > 0.1 then return end

	if isGameOver then
		if gameoverTimer > 0 then
			gameoverTimer = gameoverTimer - dt
		end
		return
	end

	walk.update(dt)
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
    elseif showTitle then
        love.graphics.setColor(255,255,255)
        love.graphics.draw(titlepic,0,0,0,screenScale,screenScale)
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
	if showTitle then
		showTitle = false
		return
	end

	if isGameOver then
		if gameoverTimer <= 0 then
			newGame()
		end
	else
		weapon.mousepressed(x,y,button)
	end
end

function gameOver()
   isGameOver = true
end
