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
		["home"] = 17,
		["j"] = 9.5,
		["m"] = 10,
		["l"] = 11.5,
		["o"] = 11.5,
		["n"] = 8.5,
		["lgui"] = 3,
		["p"] = 12.5,
		["s"] = 3.5,
		["insert"] = 16,
		["u"] = 9,
		["t"] = 6.5,
		["pageup"] = 17,
		["v"] = 6,
		["y"] = 8,
		["x"] = 4,
		["z"] = 3,
		["f9"] = 10,
		["pagedown"] = 17,
		["left"] = 15,
		["delete"] = 17,
		["scrolllock"] = 14,
		["escape"] = 1,
		["f4"] = 5,
		["rctrl"] = 13,
		["lctrl"] = 1,
		["f8"] = 9.5,
		["f11"] = 12,
		[" "] = 7.5,
		["'"] = 13.5,
		["ralt"] = 11,
		["+"] = 14.5,
		["-"] = 13,
		[","] = 11,
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
		["right"] = 17,
		["7"] = 8.5,
		["backspace"] = 15.5,
		["application"] = 12,
		["end"] = 17,
		["f5"] = 6,
		["r"] = 5.5,
		["k"] = 10,
		["return"] = 15.5,
		["2"] = 3,
		["rshift"] = 14.5,
		["f2"] = 3,
		["h"] = 8,
		["f1"] = 2,
		["q"] = 2,
		["lalt"] = 4,
		["f6"] = 7,
		["capslock"] = 1.5,
		["pause"] = 15,
		["["] = 13.5,
		["f12"] = 13,
		["lshift"] = 1,
		["w"] = 3,
		["up"] = 16,
		["down"] = 16,
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

	local posx = (playerPos * gamew + (1-gamew)) * love.graphics.getWidth()
	local posy = love.graphics.getHeight()*0.5
	local r = 40

	love.graphics.circle("line", posx, posy, r, r/2)
	love.graphics.line(posx, posy - r, posx, posy + r)
	love.graphics.line(posx - r, posy, posx + r, posy)
end
