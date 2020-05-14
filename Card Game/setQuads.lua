local images = require('images')
local tables = require('tables')

local function setQuads()
	for i=1, 4, 1 do 
		table.insert(tables.quads, love.graphics.newQuad(55*(i-1),0,55,75,images.cardImg:getDimensions())) 
	end
	for i=1, 4, 1 do
		table.insert(tables.quads, love.graphics.newQuad(55*(i-1),75,55,75,images.cardImg:getDimensions()))
	end
end

return setQuads