local bg = {}


function bg.load()
	bg.skycolor, bg.groundcolor = {255, 195, 244}, {236, 246, 150}

	-- 0 is bottom, 1 is top
	local groundpos = 0.6

	local canvas = love.graphics.newCanvas()
	love.graphics.setCanvas(canvas)

	love.graphics.setColor(unpack(bg.skycolor))
	love.graphics.rectangle("fill",0,0,love.graphics.getWidth(), love.graphics.getHeight())

	local ww,hh = love.graphics.getWidth(), love.graphics.getHeight()
	local ymin = hh * (1-groundpos)
	for y=hh,ymin,-1 do
		local fraction = math.pow((hh - y)/(hh-ymin),2)
		local color = {}
		for i=1,3 do
			color[i] = bg.skycolor[i] * fraction + bg.groundcolor[i] * (1-fraction)
		end

		love.graphics.setColor(unpack(color))
		love.graphics.rectangle("fill",0,y, ww, 1)
	end

	love.graphics.setCanvas()

	bg.bgimg = love.graphics.newImage(canvas:getImageData())
end

function bg.draw()
	love.graphics.setColor(255,255,255)
	love.graphics.draw(bg.bgimg,0,0,0,screenScale[1],screenScale[2])
end

return bg
