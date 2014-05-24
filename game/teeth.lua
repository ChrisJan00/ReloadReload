local teeth = {}

function teeth.load()
	teeth.count = 16
	local ht = math.floor(teeth.count/2)
	teeth.pic = love.graphics.newImage("images/tooth.png")
	teeth.scale = 0.55
	teeth.width = teeth.pic:getWidth() * teeth.scale
	teeth.spacing = (love.graphics.getWidth() - teeth.width * ht) / (ht+1) + teeth.width
end

function teeth.draw()
	love.graphics.setColor(255,255,255)
	for i=1,teeth.count do
		local y0 = teeth.width
		local ysc = -1
		if i<=8 then
			y0 = love.graphics.getHeight() - teeth.width
			ysc = 1
		end
		local x = ((i-1)%8 +0.25) * teeth.spacing
		love.graphics.draw(teeth.pic, x, y0, 0, teeth.scale, teeth.scale*ysc)
	end
end

function teeth.hit()
	-- was hit by a candy
	teeth.count = teeth.count - 1
	if teeth.count == 0 then
		gameOver()
	end
end

return teeth