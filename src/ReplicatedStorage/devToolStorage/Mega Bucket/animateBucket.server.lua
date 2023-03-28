local bucket = script.Parent

--[[
Input: N/A
Output: Updates current animation to idle when bucket equipped
]]
function bucketEquipped()
	local playChar = bucket.Parent
	if playChar then
		local humanoid = playChar:FindFirstChildWhichIsA("Humanoid")
		local loadAnim = humanoid:LoadAnimation(script.idleanim)

		loadAnim:Play()
	end
end

--[[
Input: N/A
Output: Updates current animation to scoop when bucket activated
]]
function bucketActivated()

	local playChar = bucket.Parent
	if playChar then
		local humanoid = playChar:FindFirstChildWhichIsA("Humanoid")
		local loadAnim = humanoid:LoadAnimation(script.scoop)

		loadAnim:Play()

	end
end

--[[
Input: N/A
Output: Updates current animation to none when bucket unequipped
]]
function bucketUnequipped()

	local playerName = bucket.Parent.Parent.Name
	local playChar = game.Workspace:FindFirstChild(playerName)
	if playChar then

		local humanoid = playChar:FindFirstChildWhichIsA("Humanoid")

		for i, anim in pairs(humanoid.Animator:GetPlayingAnimationTracks()) do     --here Alex
			if anim.Name == "idleanim" or anim.Name == "scoop" then
				anim:Stop()
			end
		end
	end
end

--[[
Input: N/A
Output: Updates water appearance based on the waterStored value
]]
function waterUpdate()
	local bkmodel = bucket:FindFirstChild("Bucket Model")

	if bucket.waterStored.Value <= (bucket.maxWater.Value / 4) then
		bkmodel.waterfull.Transparency = 1
		bkmodel.waterhalf.Transparency = 1

	elseif bucket.waterStored.Value <= ((3 * bucket.maxWater.Value) / 4) then
		bkmodel.waterfull.Transparency = 1
		bkmodel.waterhalf.Transparency = 0.35

	elseif bucket.waterStored.Value <= (bucket.maxWater.Value) then
		bkmodel.waterfull.Transparency = 0.35
		bkmodel.waterhalf.Transparency = 1
	end
end

bucket.Equipped:Connect(function()
	bucketEquipped()
end)

bucket.Activated:Connect(function()
	bucketActivated()
end)

bucket.Unequipped:Connect(function()
	bucketUnequipped()
end)

bucket.waterStored.Changed:Connect(function()
	waterUpdate()
end)