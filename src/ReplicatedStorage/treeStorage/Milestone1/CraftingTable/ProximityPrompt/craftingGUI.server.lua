--Constants
local guiToChange = "craftingTableScreen"

---------------------------------------------------------------------

local function enableGUI(player)
	local humanoid = game.Workspace:FindFirstChild(player.Name):WaitForChild("Humanoid")

	player.PlayerGui.craftingTableScreen.Enabled = true

	humanoid.WalkSpeed = 0
	humanoid.JumpHeight = 0

end

local function updateWaterCount(waterStored) 
	game.ReplicatedStorage.remoteEvents.updateGUI:FireAllClients(guiToChange, waterStored)
end

script.Parent.Triggered:Connect(function(player)
	enableGUI(player)
end)

script.Parent.Parent.waterStored.Changed:Connect(function()
	updateWaterCount(script.Parent.Parent.waterStored.Value)
end)
