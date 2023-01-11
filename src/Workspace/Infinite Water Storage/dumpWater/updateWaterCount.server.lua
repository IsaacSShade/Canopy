--[[
Input: The GUI element with text, and the numberValue.Value that will be updated
Output: A changed text label that's up to date
]]
local function updateWaterCount(textlabel, waterValue)
	textlabel.Text = (math.round(waterValue * 10^2) / 10^2) .. " water"    --Rounding to 1 decimal place
end




script.Parent.waterStored.Changed:Connect(function()
	updateWaterCount(script.Parent.Parent.Sign.SurfaceGui.numberWater, script.Parent.waterStored.Value)
end)
