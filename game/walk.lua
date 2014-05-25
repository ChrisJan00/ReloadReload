local walk = {}

function walk.load()
	walk.cycle = 0
	walk.speed = 2.5
	walk.amp = 15
	walk.current = 0
end

function walk.update(dt)
	walk.cycle = (walk.cycle + walk.speed * dt) % (math.pi*2)
	walk.current = math.pow(math.sin(walk.cycle),2) * walk.amp
end

function walk.value(delay)
	return math.pow(math.sin(walk.cycle + delay),2) * walk.amp
end

return walk