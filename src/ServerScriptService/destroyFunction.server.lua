--Increments vote and adds player name to children to prevent multiple votes
local function runVote (player, targetObject)

	local votes = targetObject:FindFirstChild("numVotes")
	local billboard = targetObject.PrimaryPart:FindFirstChild("voteCounter")
	local numPlayers = #game.Players:GetPlayers()
	local playerTracker = targetObject:FindFirstChild("ownerName")

	if not votes then --if there is no votes value then make it exist
		votes = Instance.new("IntValue")
		votes.Name = "numVotes"
		votes.Parent = targetObject
		votes.Value = 0
	end
	
	if not billboard then --if there is no billboard gui then make it exist
		billboard = game.ReplicatedStorage.fileStorage:FindFirstChild("voteCounter"):Clone()
		billboard.Parent = targetObject.PrimaryPart
	end
	
	if votes then --if votes exists and the player hasn't voted, then add a vote with their name and increment the value of votes
		if not votes:FindFirstChild(player.Name) then
			local castVote = Instance.new("StringValue")
			castVote.Name = player.Name
			castVote.Parent = votes

			votes.Value += 1
			billboard.textHolder.Text = votes.Value
		end
		
		if votes.Value >= (numPlayers / 2) + 1 or playerTracker.Value == player.Name then --if we reach the threshold or the object owner votes
			local objectPos = targetObject.PrimaryPart.Position 
			
			local toolClone = game.ReplicatedStorage.toolStorage:FindFirstChild(targetObject.Name):Clone()
			toolClone.Parent = game.Workspace
			toolClone.Handle.CFrame = CFrame.new(Vector3.new(objectPos.X, objectPos.Y + 2,objectPos.Z))
			
			targetObject:destroy()--then this gets destroyed
		end 
		
	end

end

game.ReplicatedStorage.remoteEvents.voteDestroy.OnServerEvent:Connect(runVote) --runs when this is fired