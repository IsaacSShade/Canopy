local ReplicatedStorage = game:GetService("ReplicatedStorage")
local craftedRemote = ReplicatedStorage:FindFirstChild("itemCrafted",true)
local costItem = script.Parent:FindFirstChild("costItem").Value
local tool

for i,child in pairs(script.Parent.Parent.ViewportFrame:GetChildren()) do
	if child:IsA("Model") then
		tool = child
	end
end

--if its activated 
local function fireRemote()
	if script.Parent.Active == true then
		craftedRemote:FireServer(tool.Name, costItem)
	end
end

script.Parent.MouseButton1Click:Connect(fireRemote)