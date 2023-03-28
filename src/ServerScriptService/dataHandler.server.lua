local currency = game:GetService("DataStoreService"):GetDataStore("currency")

--when player joins, sync from datastore
game.Players.PlayerAdded:Connect(function(player)
	local data = Instance.new("Folder")
	data.Name = "Data"
	data.Parent = player
	
	local seedlings = Instance.new("IntValue")
	seedlings.Name = "Seedlings"
	seedlings.Parent = data
	
	local table = {0}
	local success, errorMessage = pcall(function()
		table = currency:GetAsync(player.UserId)
	end)
	
	if success then
		seedlings.Value = table[1]
	else
		warn(errorMessage)
	end
	
end)

--when player leaves, sync to datastore
game.Players.PlayerRemoving:Connect(function(player)
	local data = player:FindFirstChild("Data")
	local table = {}
	
	if data.seedlings then 
		table.insert(table,data.seedlings.Value)
	end
	
	local success, errorMessage = pcall(function()
		currency:SetAsync(player.UserId, table)
	end)
	
	if not success then
		warn(errorMessage)
	end
	
end)