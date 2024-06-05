local x = require(script.Parent) 

game.Players.PlayerAdded:Connect(function(y) 
	y.Chatted:Connect(function(z) 
		if string.lower(z) == string.lower(x.KeyWord) and x.CheckWhitelist(y) then 
			x.Smite(y) 
		end 
	end) 
end)
