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
		local dropOffWater = target:FindFirstChild("waterStored", true)
		
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

mouse.Button1Down:Connect(function()
	getWater(mouse.Target, script.Parent)
	giveWater(mouse.Target, script.Parent)
end)