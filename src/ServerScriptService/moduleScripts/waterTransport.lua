local waterTransport = {}

--[[
Input: The model that is transporting water, and the model it's being transported to
Output: The water stored attribute is changed to move water down the chain.
]]
function waterTransport.waterNode(model, outputModel)
	local waterOuput = model:GetAttibute("waterOutput")
	
	while (model:GetAttibute("waterStored") ~= 0 and outputModel:GetAttribute("waterStored") ~= outputModel:GetAttribute("maxWater")) do
		local change = 0
		local maxWater = waterOuput:GetAttribute("maxWater")
		
		if (outputModel:GetAttribute("waterStored") + waterOuput >= maxWater) then
			change = maxWater - outputModel:GetAttribute("waterStored")
		else
			change = waterOuput
		end
		
		model:SetAttribute("waterStored", model:GetAttibute("waterStored") - change)
		outputModel:SetAttribute("waterStored", model:GetAttibute("waterStorage") + change)
		wait(1)
	end
	
end



return waterTransport
