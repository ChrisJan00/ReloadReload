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
	collisions = love.filesystem.load("collisions.lua")()
    teeth = love.filesystem.load("teeth.lua")()
    teeth.load()
    sounds = love.filesystem.load("sounds.lua")()
    sounds.load()

	thickness = 0.05
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
	doctors.update(dt)
	weapon.position = aim.getPosition()
	 collisions.update(dt)
	checkDoctorCollision()
end

function checkDoctorCollision()

	for di,doc in ipairs(doctors.list) do
		for mi,mon in ipairs(monsters.list) do
			if not mon.dead and not doc.dead then
				dxl, dxr = doc:getLimits()
				mxl, mxr = mon:getLimits()

				if rangesIntersect(dxl, dxr, mxl, mxr) and rangesIntersect(doc.zz-thickness, doc.zz, mon.zz, mon.zz+thickness) then
					doc:kill()
					mon:kill()
					sounds.play(sounds.splash)
	        		collisions.spawnExplosion((mxl+mxr)*0.5, love.graphics.getHeight()/2)

				end
			end
		end
	end
end

function rangesIntersect(a,b,x,y)
  return not (a>y or b<x)
end

function love.draw()
	bg.draw()
	monsters.draw()
	doctors.draw()
	aim.draw()
	weapon.draw(aim.getPosition())
	teeth.draw()
 collisions.draw()

    if isGameOver then
        love.graphics.setColor(255,255,255)
        love.graphics.draw(gameoverpic)
    end
end

function love.mousepressed( x, y, button )
  weapon.mousepressed(x,y,button)
	monsters.mousepressed()
end

function gameOver()
   isGameOver = true
   monsters.mousepressed()
end
