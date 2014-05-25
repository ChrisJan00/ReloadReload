local sounds = {}

function sounds.load()
	local s = sounds
	s.reload = {
		love.audio.newSource("sounds/reloadreload1.ogg"),
		love.audio.newSource("sounds/reloadreload2.ogg")
	}
	s.shoot = love.audio.newSource("sounds/shothit.ogg")
	s.explosion = love.audio.newSource("sounds/explosion.ogg")
	s.splash = love.audio.newSource("sounds/splash.ogg")
	s.toothcrunch = love.audio.newSource("sounds/tooth-crunch.ogg")

	s.music = love.audio.newSource("sounds/maf-blup.mp3","stream")
	s.music:setLooping(true)
	s.music:play()

end

function sounds.play(snd)
	snd:stop()
	snd:rewind()
	snd:play()
end

return sounds