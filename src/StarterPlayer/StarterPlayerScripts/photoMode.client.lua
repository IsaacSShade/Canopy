local player = game.Players.LocalPlayer

if player.Name == "IsaacShadowShade1" then
	for i,part in pairs(game.Workspace:WaitForChild(player.Name):GetChildren()) do
		if part:IsA("MeshPart") then 
			part.Transparency = 1
		elseif part:IsA("Accessory") then
			part:Destroy()
		end
	end
end