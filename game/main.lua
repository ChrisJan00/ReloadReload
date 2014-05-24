function love.load()
	loadkeymappings()

	playerPos = 0.5
	gamew = 0.9
end

function loadkeymappings()
	coordvals = {
		["a"] = 2,
		["c"] = 5,
		["b"] = 7.5,
		["e"] = 4,
		["d"] = 4.5,
		["g"] = 7,
		["f"] = 5.5,
		["i"] = 10,
		["f10"] = 11,
		["j"] = 9.5,
		["m"] = 10,
		["l"] = 11.5,
		["o"] = 11.5,
		["n"] = 8.5,
		["lgui"] = 3,
		["p"] = 12.5,
		["s"] = 3.5,
		["u"] = 9,
		["t"] = 6.5,
		["v"] = 6,
		["y"] = 8,
		["x"] = 4,
		["z"] = 3,
		["f9"] = 10,
		["f4"] = 5,
		["lctrl"] = 1,
		["f8"] = 9.5,
		["f11"] = 12,
		["ralt"] = 11,
		["."] = 12,
		["1"] = 2,
		["0"] = 12,
		["3"] = 4,
		["f3"] = 4,
		["5"] = 6,
		["4"] = 5,
		["f7"] = 8,
		["6"] = 7.5,
		["9"] = 11,
		["8"] = 9.5,
		["<"] = 2,
		["tab"] = 1,
		["7"] = 8.5,
		["f5"] = 6,
		["r"] = 5.5,
		["k"] = 10,
		["2"] = 3,
		["f2"] = 3,
		["h"] = 8,
		["f1"] = 2,
		["q"] = 2,
		["lalt"] = 4,
		["f6"] = 7,
		["capslock"] = 1.5,
		["lshift"] = 1,
		["w"] = 3,
		[" "] = 7.5,
	}

	maxcoordval = 0
	mincoordval = 100
	for k,v in pairs(coordvals) do
		mincoordval = math.min(mincoordval, v)
		maxcoordval = math.max(maxcoordval, v)
	end

end

function love.keypressed(key)
	local val = coordvals[key]
	if type(val) == "number" then
		playerPos = (val - mincoordval)/(maxcoordval - mincoordval)
	end
end


function love.draw()

	local posx = (playerPos * gamew + (1-gamew)*0.5) * love.graphics.getWidth()
	local posy = love.graphics.getHeight()*0.5
	local r = 40

	love.graphics.circle("line", posx, posy, r, r/2)
	love.graphics.line(posx, posy - r, posx, posy + r)
	love.graphics.line(posx - r, posy, posx + r, posy)
end
