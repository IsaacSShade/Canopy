local CONSTANT_FOLDER_NAME = "waterHarvesters"
local CONSTANT_BUILDING_NAME = "Well"
local CONSTANT_BUILDING = game.ReplicatedStorage.buildingStorage:FindFirstChild(CONSTANT_FOLDER_NAME):FindFirstChild(CONSTANT_BUILDING_NAME)

--[[^^ CONSTANTS ^^]]--

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
mouse.TargetFilter = game.Workspace.mouseFilter



--[[
Input: The building that needs to be cloned in ReplicatedStorage, and the player's character in the workspace
Output: Fires the ghostBuilding event to the server to the createGhostBuilding function in the buildingFunctions script
Notes: Requires to fire to server to use the wait() function then firest client again that's why it's convoluted
]]
local function ghostBuilding(building, playerInWorkspace) 
	game.ReplicatedStorage.remoteEvents.ghostBuilding:FireServer(script.Parent, building)
	
end

--[[
Input: Vector3 coordinates
Output: A vector3 with rounded values to whole numbers (excluding y value)
]]
local function snap(position)
	return Vector3.new(math.round(position.X), position.Y, math.round(position.Z))
end

--[[
Input: The building's ghost model, and it's placeability bool value (This function is getting fired from the server)
Output: Changes the building's position to the mouse's and checks if the anchoring part underneath is on ground (a valid surface) and gives it a red color if not successful.
]]
local function moveGhostBuilding(buildingGhost, placeable)
	
	local primaryPart = buildingGhost:FindFirstChild(buildingGhost.PrimaryPart.Name, true)
	placeable.Value = false
	
	--First checking if the anchoring part is inside the ground
	for i,part in pairs(game.Workspace:GetPartsInPart(primaryPart)) do
		if part.Name == "grass" or part.Name == "ground" then
			placeable.Value = true
		else
			
		end
	end
	
	
	--Secondly checking if anything is intersecting the building itself
	for i,part in pairs(game.Workspace:GetPartsInPart(buildingGhost:FindFirstChild("no intersection part", true))) do
		if part == buildingGhost:FindFirstChild(part.Name) then
		
		else
			print("intersecting")                  --Looking for bugs
			placeable.Value = false
		end
	end
	
	-- Making the building visible for the player while everyone else it's invisible and changes color depending on if it's a valid location
	for i,child in pairs (buildingGhost:GetDescendants()) do
		if child:IsA("MeshPart") then
			if placeable.Value then
				child.TextureID = "rbxassetid://12044968766"
			else
				child.TextureID = "rbxassetid://12044968190"
			end
			
			child.Transparency = 0.45
		end
		
		if child:IsA("Part") and child.Name ~= "detection part" then
			if placeable.Value then
				child.Color = Color3.fromRGB(34, 80, 78)
			else
				child.Color = Color3.fromRGB(255, 25, 17)
			end
			
			child.Transparency = 0.45
		end
	end
	
	local position = snap(mouse.Hit.Position)
	--Changes model's position
	primaryPart:PivotTo(CFrame.new(position) * primaryPart.CFrame.Rotation)
end

--[[
Input: The folder the building is in, and the building's name
Output: Fires the remote event "placeBuilding" on buildingFunctions if it's a valid location. If not, it plays a buzzing noise.
]] 
local function placeBuilding(building)
	
	local buildingGhost = game.Workspace.mouseFilter:FindFirstChild(building.Name .. " GHOST " .. player.Name)
	
	if buildingGhost:FindFirstChild("placeable").Value == true then
		game.ReplicatedStorage.remoteEvents.placeBuilding:FireServer(script.Parent, building, mouse.Hit.Position)
	else
		print("Not placing")
		game.Workspace.soundEffects:FindFirstChild("buzzer").Playing = true
	end
	
end





game.ReplicatedStorage.remoteEvents.ghostBuilding.OnClientEvent:Connect(moveGhostBuilding)

script.Parent.Equipped:Connect(function()
	ghostBuilding(CONSTANT_BUILDING, game.Workspace:FindFirstChild(player.Name))
end)

script.Parent.Activated:Connect(function()
	placeBuilding(CONSTANT_BUILDING)
end)


