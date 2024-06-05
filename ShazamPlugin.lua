local module = {}

module.WhiteList = {"KietMaples"}
module.KeyWord = "shazam!"
module.HealthIncrease = true
module.HealthBonusAmount = 50
module.Fly = true

module.TweenService = game:GetService('TweenService')
module.TweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.In)

function module.CheckWhitelist(player:Player)
	for i,v in pairs(module.WhiteList) do
		if v == player.Name or v == player.UserId then
			return true
		end
	end
end

function module.CreateLightning()
	local Lightning = script.Storage.Lightning:Clone()
	
	return Lightning
end

function module.AddCape(player:Player)
	local Cape = script.Storage.Cape:Clone()
	local Humanoid:Humanoid = player.Character:FindFirstChild('Humanoid')
	
	if player.Character:FindFirstChild('Cape') then
		player.Character:FindFirstChild('Cape'):Destroy()
		
		if player.Character:FindFirstChild('FlyScript') then
			player.Character:FindFirstChild('FlyScript').Flying.Value = false
			wait(.2)
			player.Character:FindFirstChild('FlyScript').Enabled = false
			player.Character:FindFirstChild('FlyScript'):Destroy()
		end
		
		
		if module.HealthIncrease == true then
			Humanoid.MaxHealth -= module.HealthBonusAmount
		end
	else
		Humanoid:AddAccessory(Cape)

		if module.HealthIncrease then
			Humanoid.MaxHealth += module.HealthBonusAmount
			Humanoid.Health = Humanoid.MaxHealth
		end

		if module.Fly then
			local FlyScript = script.Storage.FlyScript:Clone()
			FlyScript.Parent = player.Character
			FlyScript.Enabled = true
		end
	end
end

function module.AddClothes(player:Player)	
	if player:FindFirstChild('ShazamClothesStorage') then
		for i,v in pairs(player.Character:GetChildren()) do
			if v:IsA('Shirt') or v:IsA('Pants') or v:IsA('ShirtGraphic') then
				v:Destroy()
			end
		end
		
		for i,v in pairs(player:FindFirstChild('ShazamClothesStorage'):GetChildren()) do
			v.Parent = player.Character
		end
		
		player:FindFirstChild('ShazamClothesStorage'):Destroy()
	else
		local ShazamClothesStorage = Instance.new('Folder', player)
		ShazamClothesStorage.Name = 'ShazamClothesStorage'
		
		for i,v in pairs(player.Character:GetChildren()) do
			if v:IsA('Shirt') or v:IsA('Pants') or v:IsA('ShirtGraphic') then
				v.Parent = ShazamClothesStorage
			end
		end
		
		local Shirt = Instance.new('Shirt')
		Shirt.ShirtTemplate = "http://www.roblox.com/asset/?id=576383249"
		Shirt.Parent = player.Character

		local Pants = Instance.new('Pants')
		Pants.PantsTemplate = "http://www.roblox.com/asset/?id=2151646445"
		Pants.Parent = player.Character
	end
end

function module.Smite(player:Player)
	local Lightning = module.CreateLightning()
	local TweenBegin = module.TweenService:Create(Lightning.Bolt, module.TweenInfo, {Transparency = 0.3})
	local TweenEnd = module.TweenService:Create(Lightning.Bolt, module.TweenInfo, {Transparency = 1})
	Lightning:SetPrimaryPartCFrame(player.Character.HumanoidRootPart.CFrame)
	Lightning.Main.Orientation = Vector3.new(0, math.random(1,120), 0)
	Lightning.Parent = workspace
	Lightning.Main.Strike:Play()
	TweenBegin:Play()
	module.AddCape(player)
	module.AddClothes(player)
	wait(.25)
	TweenEnd:Play()
	wait(2.5)
	Lightning:Destroy()
end

return module
