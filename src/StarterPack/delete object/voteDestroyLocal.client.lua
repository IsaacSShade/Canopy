local player = game.Players.LocalPlayer
local mouse = player:GetMouse()


local function voteDestroy(target) 
	
	if script.Parent.Parent.Name == player.Name then
		print ("Clicked: ".. target.Parent.Name)
		if target and target.Parent:IsA("Model") then
			print("Made it")
			if game.ReplicatedStorage.buildingStorage:FindFirstChild(target.Name, true) then
				game.ReplicatedStorage.remoteEvents.voteDestroy:FireServer(target.Parent)
			end

		end
	end


end

mouse.Button1Down:Connect(function ()
	voteDestroy(mouse.Target)
end)

