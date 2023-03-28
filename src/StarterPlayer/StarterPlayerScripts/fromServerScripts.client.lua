

local function updateWaterGUI(guiToChange, waterStored)
	local gui = script.Parent.Parent.PlayerGui:FindFirstChild(guiToChange)
	gui:FindFirstChild("waterAmount", true).Text = "Water: " .. (math.round(waterStored * 10^2) / 10^2)
end

game.ReplicatedStorage.remoteEvents.updateGUI.OnClientEvent:Connect(updateWaterGUI)