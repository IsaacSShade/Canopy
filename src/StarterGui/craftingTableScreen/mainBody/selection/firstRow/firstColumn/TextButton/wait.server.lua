local function cooldown()
	print("hi")
	if script.Parent.Active == true then
		script.Parent.Active = false
		wait(1)
		script.Parent.Active = true
	end
end

script.Parent.MouseButton1Click:Connect(cooldown)