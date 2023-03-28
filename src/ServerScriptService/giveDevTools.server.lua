--gives dev tools if kiwi or isaac
local function giveDeveloperItems(player)
	
	if player.UserId == 96457592 or player.UserId == 86669859 or player.UserId == 1407383061 then
		wait(2)
		local bucket = game.ReplicatedStorage.devToolStorage:FindFirstChild("Mega Bucket"):Clone()
		bucket.Parent = player.Backpack
		print("whats up admino")
		print(bucket.Parent.Name)
		print(player.Name)
	end
	
end

game:GetService("Players").PlayerAdded:Connect(giveDeveloperItems)