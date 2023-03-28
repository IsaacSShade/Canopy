local function detecting()

	local detectionPart = script.Parent:FindFirstChild("detection part")

	print(detectionPart.Name) 

	for i,part in pairs(game.Workspace:GetPartsInPart(detectionPart)) do

		if part:FindFirstChild("waterValue") then

			script.Parent.light.Color = Color3.fromRGB(0, 255, 0)

		end
	end

end

script.Parent:GetPropertyChangedSignal("Parent"):Connect(detecting)
