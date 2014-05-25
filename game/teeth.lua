local teeth = {}

function teeth.load()
	teeth.count = 16
	local ht = math.floor(teeth.count/2)
	teeth.pic = love.graphics.newImage("images/tooth-fresh.png")
	teeth.rottenpic = love.graphics.newImage("images/tooth-rotten.png")
	teeth.scale = 1
	teeth.width = teeth.pic:getWidth() * teeth.scale * screenScale
	teeth.height = (teeth.pic:getHeight() + 6) * teeth.scale  * screenScale
	teeth.spacing = (screenSize[1] - teeth.width * ht) / (ht+1) + teeth.width

	teeth.bgpic = love.graphics.newImage("images/teeth-bg.png")
end

function teeth.draw()
	love.graphics.setColor(255,255,255)
	love.graphics.draw(teeth.bgpic, 0, 0, 0, screenScale, screenScale)
	for i=1,16 do
		local y0 = teeth.height
		local ysc = -1
		if i<=8 then
			y0 = screenSize[2] - teeth.height
			ysc = 1
		end
		local x = ((i-1)%8 +0.25) * teeth.spacing
		local pic = teeth.pic
		if i>teeth.count then pic = teeth.rottenpic end
		love.graphics.draw(pic, x, y0, 0, teeth.scale*screenScale, teeth.scale*ysc*screenScale)
	end
end

function teeth.hit()
	-- was hit by a candy
	teeth.count = teeth.count - 1
	sounds.play(sounds.toothcrunch)
	if teeth.count == 0 then
		gameOver()
	end
end

return teeth