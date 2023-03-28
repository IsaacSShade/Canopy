local ReplicatedStorage = game:GetService("ReplicatedStorage")
local craftedRemote = ReplicatedStorage:FindFirstChild("itemCrafted",true)
local tablePos

--spawns the crafted item
local function onCraftedItem(player, toolName, costItem)
	local craftedTool = ReplicatedStorage:FindFirstChild(toolName, true)
	
	if script.Parent.waterStored.Value >= costItem then
		local toolClone = game.ReplicatedStorage.toolStorage:FindFirstChild(craftedTool.Name):Clone()
		toolClone.Parent = game.Workspace
		tablePos = script.Parent:FindFirstChild("Trunk").Position
		toolClone.Handle.CFrame = CFrame.new(Vector3.new(tablePos.X, tablePos.Y + 3,tablePos.Z))
		
		script.Parent.waterStored.Value -= costItem
	end

end

craftedRemote.OnServerEvent:Connect(onCraftedItem)