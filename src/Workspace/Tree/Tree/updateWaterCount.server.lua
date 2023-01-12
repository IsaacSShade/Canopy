local growPart = require(game.ServerScriptService.moduleScripts.growPart)

local waterStored = script.Parent.waterStored
local barrierFolder = game.Workspace:WaitForChild("Barrier Folder")
local firstMilestone = false
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
	local baseChangeInY = 0
	local barrierSlowScale = 4 -- Higher this is, the slower the rate at which it's scaled
	--tree, orig xSize, orig ySize, orig zSize, startingYPosition, waterStored value
	baseChangeInY += growPart.yScale(script.Parent, 0.3, 1.7, 0.3, 207.2, waterStored, 1, 0)

	growPart.allScale(barrierFolder:FindFirstChild("base barrier"), 180, 106.865, 180, waterStored, barrierSlowScale)
	growPart.allScale(barrierFolder:FindFirstChild("second barrier"), 178, 100, 178, waterStored, barrierSlowScale)
	growPart.allScale(barrierFolder:FindFirstChild("third barrier"), 176, 99, 176, waterStored, barrierSlowScale)
	growPart.allScale(barrierFolder:FindFirstChild("fourth barrier"), 174, 98, 174, waterStored, barrierSlowScale)

	if waterStored.Value >= 20 and firstMilestone == false then
		local M1 = game.ReplicatedStorage.treeStorage.Milestone1:FindFirstChild("Branch-M1"):Clone()
		M1.Parent = script.Parent.Parent
		M1 = game.ReplicatedStorage.treeStorage.Milestone1:FindFirstChild("Trunk-M1"):Clone()
		M1.Parent = script.Parent.Parent

		firstMilestone = true
	end

	if firstMilestone then
		local part = script.Parent.Parent:FindFirstChild("Branch-M1")
		growPart.xyScale45Degrees(part, 0.3, 1.5, 0.3, -2.5, 209.42, waterStored, true, 1, 20)
		part = script.Parent.Parent:FindFirstChild("Trunk-M1")
		growPart.yScale(part, 0.3, 1.5, 0.3, (207.2 + (baseChangeInY * 2)), waterStored, 1, 20)
	end
end)