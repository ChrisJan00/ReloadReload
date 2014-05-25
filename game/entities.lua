local entities = {}

function entities.load()
	entities.list = {}
end

local function cleanEntitiesList()
	if entities.anyDead then
		entities.anyDead = false
		for i = #entities.list,1,-1 do
			if entities.list[i].dead then
				table.remove(entities.list, i)
			end
		end
	end
end


function entities.draw()
	-- z sorting
	cleanEntitiesList()
	table.sort(entities.list, function(a,b) return a.zz < b.zz end)

	for i,entity in ipairs(entities.list) do
		entity:draw()
	end
end

return entities
