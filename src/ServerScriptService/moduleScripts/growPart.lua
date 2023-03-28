local growPart = {}

--[[
Input: The part that will be scaled, the original size of the part, the y-position of it's base where it shouldn't move from, waterStored number value,
a number where bigger means slower change, and the value of waterStored when this part became a descendent of Workspace
Output: The part is scaled to the waterStored value inside based on it's original size.
]]
function growPart.yScale(part, xSize, ySize, zSize, startingYPosition, waterStored, rate, offset)
	
	local scale = 1 + (waterStored.Value / (10 * rate)) - (offset / (10 * rate)) --Ex: waterStored is 1 then 1.1 is the scale
	local newYSize = (scale * ySize)

	part.Position = Vector3.new(part.Position.X, startingYPosition + (newYSize / 2), part.Position.Z)
	part.Size = Vector3.new((scale * xSize), newYSize, (scale * zSize))
	

	return (newYSize / 2)
end

--[[
Input: The part that will be scaled, the original size of the part, the y-position of it's base where it shouldn't move from, waterStored number value,
whether it should subtract from x-pos or not, a number where bigger means slower change, and the value of waterStored when this part became a descendent of Workspace
Output: The part is scaled to the waterStored value inside based on it's original size.
]]
function growPart.xyScale45Degrees(part, xSize, ySize, zSize, startingXPosition, startingYPosition, waterStored, positive, rate, offset)
	local scale = 1 + (waterStored.Value / (10 * rate)) - (offset / (10 * rate))
	local newXSize = (scale * xSize)
	local newYSize = (scale * ySize)

	local X, Y, Z = part.CFrame:ToOrientation()
	print(X / (math.pi * 180), Y / (math.pi * 180), Z / (math.pi * 180))

	local change = 1
	if not positive then
		change = -1
	end

	part.Position = Vector3.new(startingXPosition + ((change * newXSize) * 2), startingYPosition + ((change * newYSize) / 2), part.Position.Z )
	part.Size = Vector3.new(newXSize, newYSize, (scale * zSize))

end

--[[
Input: The part that will be scaled, the original size of the part, waterStored number value, and a number where bigger means slower change
Output:The part is scaled to the waterStored value inside based on it's original size.
]]
function growPart.allScale(part, xSize, ySize, zSize, waterStored, rate)

    local scale = 1 + (waterStored.Value / (10 * rate) )
    part.Size = Vector3.new((scale * xSize), (scale * ySize), (scale * zSize))
end

return growPart