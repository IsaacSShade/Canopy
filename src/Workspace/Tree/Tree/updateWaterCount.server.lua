local waterStored = script.Parent.waterStored

--[[
Input: The GUI element with text, and the numbervalue.Value that it will update to
Output: A changed text label that's up to date
]]
local function updateWaterCountTree(textlabel, waterValue)
	textlabel.Text = (math.round(waterValue * 10^2) / 10^2) .. " water"    --Rounding to 1 decimal place
end

--[[
Input: The part that will be scaled, the original size of the part, and the y-position of it's base where it shouldn't move from
Output: The tree is scaled to the waterStored value inside based on it's original size.
]]
local function treeScale(tree, xSize, ySize, zSize, startingYPosition)
	
	local scale = 1 + (waterStored.Value / 10) --Ex: waterStored is 1 then 1.1 is the scale

	tree.Position = Vector3.new(tree.Position.X, (startingYPosition + ((scale * ySize)/ 2)), tree.Position.Z)
	tree.Size = Vector3.new((scale * xSize), (scale * ySize), (scale * zSize))
end


script.Parent.waterStored.Changed:Connect(function()
	updateWaterCountTree(script.Parent.Parent.Sign.SurfaceGui.numberWater, script.Parent.waterStored.Value)
end)



waterStored.Changed:Connect(function()
	treeScale(script.Parent, 0.3, 1.7, 0.3, 7.2)
end)