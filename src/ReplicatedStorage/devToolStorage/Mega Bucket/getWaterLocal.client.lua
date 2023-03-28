local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

--[[ 
Input:  Water object that is clicked, and the bucket tool 
Output: Subtracts the tool's max capacity from the water's pool and adds it to the bucket,
        Shrinks the water according the the water's size
Fires remote event to: game.ServerScriptService.waterFunctions - getWaterServer
]]
local function getWater (water, tool)
	if script.Parent.Parent.Name == player.Name then
		--Checking if part clicked is water
		local waterValue = water:FindFirstChild("waterValue")
		
		if waterValue then
			--Getting variables from tool
			local maxWater = tool.maxWater
			local storedWater = tool.waterStored
			local waterPerClick = tool.waterPerClick
			
			--Checking if water in object is all gone and change value is so the bucket doesn't go over it's capacity
			local success = true
			local changeValue = waterPerClick.Value              --Just a side note here, you have to do .Value for everything here because it can't be assigned as a variable
			
			if ((maxWater.Value - storedWater.Value) <= waterPerClick.Value) then
				changeValue = (maxWater.Value - storedWater.Value)
			end
			
			if ((waterValue.Value - changeValue) <= 0)then
				success = false
			end

			game.ReplicatedStorage.remoteEvents.waterGotten:FireServer(water, tool, success, changeValue)
			
		end
	end
end

--[[ 
Input:  Transferring object that is clicked (must have a "waterStored" number value), and the bucket tool 
Output: Subtracts the tool's current storage and adds it to the clicked object
Fires remote event to: game.ServerScriptService.waterFunctions - giveWaterServer
]]
local function giveWater (target, tool)
	if script.Parent.Parent.Name == player.Name then
		--Checking that this part can be transferred to
		local actualTarget = target

		if target.Parent:IsA("Model") or target.Parent.Name == "Tree"  then
			actualTarget = target.Parent
		end

		local dropOffWater = actualTarget:FindFirstChild("waterStored", true)
		
		if dropOffWater then
			--Getting variables
			local objectWithValues = dropOffWater.Parent
			local dropOffMax = dropOffWater.Parent.maxWater
			local storedWater = tool.waterStored
			
			local changeValue = storedWater.Value
			
			if (dropOffMax.Value - dropOffWater.Value) <= storedWater.Value then
				changeValue = dropOffMax.Value - dropOffWater.Value
			end
			
			game.ReplicatedStorage.remoteEvents.waterGiven:FireServer(objectWithValues, tool, changeValue)
			
		end
		
	end
end

--[[ 
Input:  The building the player clicked, and the bucket
Output: Finds the first water object connected (intersecting) the building and collects from the first water object
Fires remote event to: game.ServerScriptService.waterFunctions - getWaterServer and checkForWater
Note: If the first water source found is about to run out, it won't fill the bucket all the way for that click, but this is so minor I decided it was fine    
	  Part must be in a model and have a part called "detection part" (Potential change: make it search for a clickable part first so the person can't click the wall of the structure)
]]
local function collectWater(target, tool)
	if script.Parent.Parent.Name == player.Name then
		
		print(target.Parent.Name)
		local detectionPart = target.Parent:FindFirstChild("detection part", true)
		if detectionPart then
			
			if detectionPart.waterTransferrable.Value == true then     --If the building has water in it that had intersected with it previously
				--Getting variables from tool
				local maxWater = tool.maxWater
				local storedWater = tool.waterStored
				local waterPerClick = tool.waterPerClick
				
				for i,part in pairs(game.Workspace:GetPartsInPart(detectionPart)) do
					if part:FindFirstChild("waterValue") then
						
						local success = true
						local changeValue = waterPerClick.Value

						if ((maxWater.Value - storedWater.Value) <= waterPerClick.Value) then
							changeValue = (maxWater.Value - storedWater.Value)
						end

						if ((part.waterValue.Value - changeValue) <= 0)then
							success = false
						end
						
						game.ReplicatedStorage.remoteEvents.waterGotten:FireServer(part, tool, success, changeValue)
						game.ReplicatedStorage.remoteEvents.checkForWater:FireServer(detectionPart)
						return
					end
				end
			end
			
		end
	end
end

mouse.Button1Down:Connect(function()
	getWater(mouse.Target, script.Parent)
	giveWater(mouse.Target, script.Parent)
	collectWater(mouse.Target, script.Parent)
end)