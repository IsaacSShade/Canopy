--[[
Input: Player that fired the event, the tool, and building in remote storage it should clone
Output: A blueprint only the player can see that follows their mouse
Fires local event to: ghostBuilding - placeObjectLocal script
]]
local function createGhostBuilding(player, tool, building)
	local buildingGhost = building:Clone()
	local positionWithMouse = nil

	buildingGhost.Name = building.Name .. " GHOST " .. player.Name
	buildingGhost.Parent = game.Workspace.mouseFilter	
	
	--Need to make this model invisible for everyone else but visible for the player
	for i,child in pairs (buildingGhost:GetDescendants()) do     
		if child:IsA("Part") then
			child.CanCollide = false
			child.Transparency = 1
		elseif child:IsA("MeshPart") then
			child.CanCollide = false
			child.Transparency = 1
		end
	end
	
	while tool and tool.Parent.Name == player.Name do
		wait()
		if not tool then
			break
		end
		game.ReplicatedStorage.remoteEvents.ghostBuilding:FireClient(player, buildingGhost)
	end
	
	buildingGhost:Destroy()
end

--[[
Input: Player that fired the event, the tool, and building in remote storage it should place down
Output: Places specified building
]]
local function placeBuilding(player, tool, building, position)
	local buildingClone = building:Clone()
	
	buildingClone.PrimaryPart:PivotTo(CFrame.new(position) * buildingClone.PrimaryPart.CFrame.Rotation)
	buildingClone.Parent = game.Workspace
	
	tool.Parent = game.ReplicatedStorage
	wait(1)
	tool:Destroy()
	
	--Unwelding bucket for building "Well"
	if buildingClone.Name == "Well" then
		buildingClone:FindFirstChild("moving part"):FindFirstChild("handle.003"):Destroy()
	end
end

game.ReplicatedStorage.remoteEvents.ghostBuilding.OnServerEvent:Connect(createGhostBuilding)
game.ReplicatedStorage.remoteEvents.placeBuilding.OnServerEvent:Connect(placeBuilding)