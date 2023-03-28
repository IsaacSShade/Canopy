local player = script.Parent.Parent.Parent.Parent.Parent
local humanoid = game.Workspace:FindFirstChild(player.Name):WaitForChild("Humanoid")


local function disableGUI() 
	script.Parent.Parent.Parent.Enabled = false

	humanoid.WalkSpeed = 16
	humanoid.JumpHeight = 7.2
end



script.Parent.MouseButton1Click:Connect(disableGUI)
