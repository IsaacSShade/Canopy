local growPart = require(game.ServerScriptService.moduleScripts.growPart)

local waterStored = script.Parent.waterStored
local barrierFolder = game.Workspace:WaitForChild("Barrier Folder")
--[[
Input: The GUI element with text, and the numbervalue.Value that it will update to
Output: A changed text label that's up to date
]]
local function updateWaterCountTree(textlabel, waterValue)
	textlabel.Text = (math.round(waterValue * 10^2) / 10^2) .. " water"    --Rounding to 1 decimal place
end

script.Parent.waterStored.Changed:Connect(function()
	updateWaterCountTree(script.Parent.Parent.Sign.SurfaceGui.numberWater, script.Parent.waterStored.Value)
end)



waterStored.Changed:Connect(function()
	--tree, orig xSize, orig ySize, orig zSize, startingYPosition, waterStored value
	growPart.yScale(script.Parent, 0.3, 1.7, 0.3, 208.05, waterStored)
	growPart.allScale(barrierFolder:FindFirstChild("base barrier"), 180, 106.865, 180, waterStored)
	growPart.allScale(barrierFolder:FindFirstChild("second barrier"), 178, 100, 178, waterStored)
	growPart.allScale(barrierFolder:FindFirstChild("third barrier"), 176, 99, 176, waterStored)
	growPart.allScale(barrierFolder:FindFirstChild("fourth barrier"), 174, 98, 174, waterStored)
end)