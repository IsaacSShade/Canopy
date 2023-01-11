--[[
Input:  Player the event fired from, water object, the tool, and whether the water object is going to be all gone, and the amount of water that will be subtracted
Output: Subtracts the tool's max capacity from the water's pool and adds it to the bucket,
        Shrinks the water according the the water's size
]]
local function getWaterServer (player, water, tool, success, changeValue)
	--Getting variables from tool and water
	local maxWater = tool.maxWater
	local storedWater = tool.waterStored
	local waterValue = water.waterValue
	
	if success then
		--This scenario the water can be taken from
		local waterYDisplacement = changeValue / (water.Size.X * water.Size.Z)
		water.Size = Vector3.new(water.Size.X, (water.Size.Y - waterYDisplacement), water.Size.Z)
		water.Position = Vector3.new(water.Position.X, (water.Position.Y - (waterYDisplacement / 2)), water.Position.Z)
		
		waterValue.Value = waterValue.Value - changeValue
		storedWater.Value = storedWater.Value + changeValue
		
	else
		--This scenario the water is smaller than capacity
		storedWater.Value = storedWater.Value + waterValue.Value
		
		water:Destroy()
		
	end
end

--[[ 
Input: Player the event fired from, transferring object that is clicked (must have a "waterStored" number value), the bucket tool, and the value to transfer water
Output: Subtracts the tool's current storage and adds it to the clicked object
]]
local function giveWaterServer (player, target, tool, changeValue) 
	
	local dropOffWater = target.waterStored
	local storedWater = tool.waterStored
	
	storedWater.Value = storedWater.Value - changeValue
	dropOffWater.Value = dropOffWater.Value + changeValue
end

--[[ 
Input: Player the event fired from, part that's being checked for intersecting water parts
Output: Changes the given part's boolean value to true if there's still water or false if there's no water
]]
local function checkForWater (player, checkPart) 
	
	for i,part in pairs(game.Workspace:GetPartsInPart(checkPart)) do
		if part:FindFirstChild("waterValue") then
			checkPart.waterTransferrable.Value = true
			return
		else
			checkPart.waterTransferrable.Value = false
		end
	end
end

game.ReplicatedStorage.remoteEvents.waterGotten.OnServerEvent:Connect(getWaterServer)
game.ReplicatedStorage.remoteEvents.waterGiven.OnServerEvent:Connect(giveWaterServer)
game.ReplicatedStorage.remoteEvents.checkForWater.OnServerEvent:Connect(checkForWater)