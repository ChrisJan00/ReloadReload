local sounds = {}

function sounds.load()
	local s = sounds
	s.reload = {
		love.audio.newSource("sounds/reloadreload1.ogg"),
		love.audio.newSource("sounds/reloadreload2.ogg")
	}
	s.shoot = love.audio.newSource("sounds/shothit.ogg")
end


return sounds