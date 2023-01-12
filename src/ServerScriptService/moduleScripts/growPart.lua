local growPart = {}

--[[
Input: The part that will be scaled, the original size of the part, the y-position of it's base where it shouldn't move from, and the waterStored number value
Output: The part is scaled to the waterStored value inside based on it's original size.
]]
function growPart.yScale(part, xSize, ySize, zSize, startingYPosition, waterStored)
	
	local scale = 1 + (waterStored.Value / 10) --Ex: waterStored is 1 then 1.1 is the scale

	part.Position = Vector3.new(part.Position.X, (startingYPosition + ((scale * ySize)/ 2)), part.Position.Z)
	part.Size = Vector3.new((scale * xSize), (scale * ySize), (scale * zSize))
end

--[[
Input: The part that will be scaled, the original size of the part, and the waterStored number value
Output:The part is scaled to the waterStored value inside based on it's original size.
]]
function growPart.allScale(part, xSize, ySize, zSize, waterStored)

    local scale = 1 + (waterStored.Value / 10) --Might have to make the scale /20 because it grows a little quickly when growing 
    part.Size = Vector3.new((scale * xSize), (scale * ySize), (scale * zSize))
end

return growPart