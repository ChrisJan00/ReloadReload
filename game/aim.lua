--- state
	
local coordvals =  {}
local pointerDest,pointerPos,pointerSpeed = 0.5,0.5,0
local jumpDelay = 0.2
local gamew = 0.99
local keycount = 0
local maxcoordval = 0
local mincoordval = 0

local function loadkeymappings()
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

local function setDest(newDest)
	if newDest ~= pointerDest then
		pointerSpeed = (newDest - pointerPos) / jumpDelay
		pointerDest = newDest
	end
end

--------- API
local aim = {}

function aim.load()
	loadkeymappings()

	pointerDest = 0.5
	pointerPos = 0.5
	pointerSpeed = 0
	jumpDelay = 0.2
	

	gamew = 0.9
	keycount = 0

end

function aim.keypressed(key)
	keycount = keycount + 1
	local val = coordvals[key]
	if type(val) == "number" then
		setDest( (val - mincoordval)/(maxcoordval - mincoordval) )
	end
end

function aim.keyreleased(key)
	keycount = keycount - 1
end

function aim.update(dt)
	if keycount == 0 then setDest(0.5) end

	local minDistance = 1/screenSize[1]
	pointerPos = pointerPos + pointerSpeed * dt
	if math.abs(pointerDest - pointerPos) <= minDistance or 
		(pointerSpeed>0 and pointerDest<pointerPos) or 
		(pointerSpeed<0 and pointerDest>pointerPos) then
		pointerPos = pointerDest
		pointerSpeed = 0
	end
end

function aim.draw()

	local posx = (pointerPos * gamew + (1-gamew)*0.5) * screenSize[1]
	local posy = screenSize[2]*0.5
	local meanscale = (screenScale+screenScale)/2
	local r = 40 * meanscale

	love.graphics.setLineWidth(math.max(1,meanscale))

	love.graphics.setColor(139,133,204)
	love.graphics.circle("line", posx, posy, r, r/2)
	love.graphics.line(posx, posy - r, posx, posy + r)
	love.graphics.line(posx - r, posy, posx + r, posy)
end

function aim.getPosition()
  local w = screenSize[1]
  return pointerPos * w
end

return aim

