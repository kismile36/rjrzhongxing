local Players = game:GetService("Players")  -- 获取玩家服务（管理所有玩家）
local workspace = game:GetService("Workspace")  -- 获取工作区服务（存储游戏内实体）
local Player = Players.LocalPlayer  -- 获取当前本地玩家（脚本使用者）
local ui =loadstring(game:HttpGet("https://raw.githubusercontent.com/kismile36/rjrzhongxing/refs/heads/main/rjr/kismileui.lua"))()
local win = ui:new("人挤人中心")
local UITab1 = win:Tab("公告",'7734068321')
local UITab2 = win:Tab("超级无敌脚本",'7734068321')
local UITab3 = win:Tab("大佛功能区",'7734068321')

local about = UITab1:section("公告",true)

about:Label("kismile制作")

about:Label("脚本测试中")

local about = UITab2:section("超级无敌脚本",true)

about:Slider("视角缩放距离", "Slider",  128, 128, 10000, false, function(Value)
    game:GetService("Players").LocalPlayer.CameraMaxZoomDistance = Value
end)

about:Textbox("快速跑步设置", "WalkSpeed", "输入速度值", function(Value)
    local tspeed = tonumber(Value)
    if tspeed then
        local hb = game:GetService("RunService").Heartbeat
        local tpwalking = true
        local player = game:GetService("Players")
        local lplr = player.LocalPlayer
        local chr = lplr.Character
        local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
        while tpwalking and hb:Wait() and chr and hum and hum.Parent do
          if hum.MoveDirection.Magnitude > 0 then
            if tspeed then
              chr:TranslateBy(hum.MoveDirection * tspeed)
            else
              chr:TranslateBy(hum.MoveDirection)
            end
          end
        end
    end
end)

about:Button("飞行",function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
end)

about:Button("法天象地",function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/kismile36/rjrzhongxing/refs/heads/main/rjr/fatianxiangdi"))()
end)

about:Button("皮脚本",function()
	getgenv().XiaoPi="皮脚本QQ群1002100032" loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/QQ1002100032-Roblox-Pi-script.lua"))()
end)

about:Button("hoho",function()
	loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_UI'))()
end)

local attackTab = UITab3:section("大佛功能区",true)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer
local _ENV = (getgenv or getrenv or getfenv)()
local Settings = {AutoClick = true, ClickDelay = 0.3}
local Module = {}
local _G = _G or getfenv(0)._G
_G.FastAttack = _G.FastAttack ~= nil and _G.FastAttack or true

local function SafeWaitForChild(parent, childName)
	local success, result = pcall(function() return parent:WaitForChild(childName, 10) end)
	if not success or not result then warn("未找到组件: " .. childName) end
	return result
end

local function CheckAndGetCoreComponents()
	local Remotes, Modules, Net, RegisterAttack, RegisterHit, Enemies = nil, nil, nil, nil, nil, nil
	while true do
		Remotes = SafeWaitForChild(ReplicatedStorage, "Remotes")
		Modules = SafeWaitForChild(ReplicatedStorage, "Modules")
		Net = Modules and SafeWaitForChild(Modules, "Net") or nil
		RegisterAttack = Net and SafeWaitForChild(Net, "RE/RegisterAttack") or nil
		RegisterHit = Net and SafeWaitForChild(Net, "RE/RegisterHit") or nil
		Enemies = SafeWaitForChild(workspace, "Enemies")
		if Remotes and Modules and Net and RegisterAttack and RegisterHit and Enemies then
			return Remotes, Net, RegisterAttack, RegisterHit, Enemies
		end
		warn("核心组件缺失，持续重试中...")
		task.wait(1)
	end
end

local function IsAlive(character)
	if not character then return false end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	return humanoid and humanoid.Health and humanoid.Health > 0
end

local function GetRandomValidPart(target)
	local allParts = target:GetDescendants()
	local validParts = {}
	local humanoidRootPart = target:FindFirstChild("HumanoidRootPart")
	local boneParts = humanoidRootPart and humanoidRootPart.Parent:GetDescendants() or {}
	for _, part in ipairs(allParts) do
		if part:IsA("BasePart") and part.CanCollide and table.find(boneParts, part) then
			table.insert(validParts, part)
		end
	end
	return #validParts > 0 and validParts[math.random(1, #validParts)] or target:FindFirstChild("HumanoidRootPart")
end

Module.FastAttack = (function()
	if _ENV.rz_FastAttack then return _ENV.rz_FastAttack end
	local FastAttack = {
		Distance = 500,
		attackMobs = true,
		attackPlayers = true,
		Equipped = nil,
		IsRunning = _G.FastAttack,
		consecutiveFailures = 0,
		maxConsecutiveFailures = 5
	}

	local function ProcessEnemies(OthersEnemies, Folder)
		if not Folder or not FastAttack.attackMobs then return nil end
		local BasePart = nil
		for _, Enemy in Folder:GetChildren() do
			if Enemy == Player.Character or not IsAlive(Enemy) then continue end
			local foundPart = GetRandomValidPart(Enemy)
			if foundPart and Player:DistanceFromCharacter(foundPart.Position) < FastAttack.Distance then
				table.insert(OthersEnemies, {Enemy, foundPart})
				BasePart = foundPart
			end
		end
		return BasePart
	end

	local function ProcessRealPlayers(OthersEnemies)
		if not FastAttack.attackPlayers then return nil end
		local BasePart = nil
		for _, OtherPlayer in Players:GetPlayers() do
			if OtherPlayer == Player then continue end
			local OtherChar = OtherPlayer.Character
			if not IsAlive(OtherChar) then continue end
			local foundPart = GetRandomValidPart(OtherChar)
			if foundPart and Player:DistanceFromCharacter(foundPart.Position) < FastAttack.Distance then
				table.insert(OthersEnemies, {OtherChar, foundPart})
				BasePart = foundPart
			end
		end
		return BasePart
	end

	function FastAttack:Attack(BasePart, OthersEnemies)
		local _, Net, temp_RegisterAttack, temp_RegisterHit, _ = CheckAndGetCoreComponents()
		if not (BasePart and OthersEnemies and #OthersEnemies > 0 and temp_RegisterAttack and temp_RegisterHit) then
			self.consecutiveFailures = self.consecutiveFailures + 1
			if self.consecutiveFailures >= self.maxConsecutiveFailures then
				self.consecutiveFailures = 0
				self.Equipped = Player.Character and IsAlive(Player.Character) and Player.Character:FindFirstChildOfClass("Tool")
			end
			task.delay(0.5, function() self:AttackNearest() end)
			return
		end
		self.consecutiveFailures = 0
		temp_RegisterAttack:FireServer(Settings.ClickDelay or 0)
		temp_RegisterHit:FireServer(BasePart, OthersEnemies)
	end

	function FastAttack:AttackNearest()
		if not self.IsRunning then return end
		local _, _, _, _, Enemies = CheckAndGetCoreComponents()
		local OthersEnemies = {}
		local Part1 = ProcessEnemies(OthersEnemies, Enemies)
		local Part2 = ProcessRealPlayers(OthersEnemies)
		if #OthersEnemies > 0 then
			self:Attack(Part1 or Part2, OthersEnemies)
		else
			task.wait(0)
		end
	end

	function FastAttack:BladeHits()
		if not self.IsRunning then return end
		local Equipped = Player.Character and IsAlive(Player.Character) and Player.Character:FindFirstChildOfClass("Tool")
		if Equipped and Equipped.ToolTip ~= "Gun" then
			self:AttackNearest()
		else
			task.wait(0)
		end
	end

	task.spawn(function()
		while true do
			task.wait(Settings.ClickDelay)
			if Settings.AutoClick and FastAttack.IsRunning then
				FastAttack:BladeHits()
			else
				task.wait(0.1)
			end
		end
	end)

	_ENV.rz_FastAttack = FastAttack
	return FastAttack
end)()

-- UI控件绑定
attackTab:Toggle("开关", "FastAttackToggle", _G.FastAttack, function(state)
	if _ENV.rz_FastAttack then
		_ENV.rz_FastAttack.IsRunning = state
		_G.FastAttack = state
	end
end)

attackTab:Textbox("范围", "AttackRange", "2500", function(text)
	local num = tonumber(text) or 2500
	num = math.floor(math.clamp(num, 1, 2500))
	if _ENV.rz_FastAttack then
		_ENV.rz_FastAttack.Distance = num
	end
end)

attackTab:Textbox("攻速", "ClickDelay", "0.1", function(text)
	local num = tonumber(text) or 0.1
	num = math.round(math.clamp(num, 0.05, 2) * 100) / 100
	Settings.ClickDelay = num
end)

attackTab:Toggle("打怪物", "AttackMobsToggle", true, function(state)
	if _ENV.rz_FastAttack then
		_ENV.rz_FastAttack.attackMobs = state
	end
end)

attackTab:Toggle("打玩家", "AttackPlayersToggle", true, function(state)
	if _ENV.rz_FastAttack then
		_ENV.rz_FastAttack.attackPlayers = state
	end
end)

-- 组件恢复逻辑
task.spawn(function()
	while true do
		task.wait(1)
		if not _ENV.rz_FastAttack then
			warn("⚠️ 快速攻击组件未完全加载，持续尝试恢复...")
			while not _ENV.rz_FastAttack do
				task.wait(0.5)
				if _G.FastAttack then
					local Remotes, Net, RegisterAttack, RegisterHit, Enemies = CheckAndGetCoreComponents()
					Module.FastAttack = Module.FastAttack or (function()
						local FastAttack = {
							Distance=500,
							attackMobs=true,
							attackPlayers=true,
							Equipped=nil,
							IsRunning=_G.FastAttack,
							consecutiveFailures=0,
							maxConsecutiveFailures=5
						}

						local function ProcessEnemies(OthersEnemies, Folder)
							if not Folder or not FastAttack.attackMobs then return nil end
							local BasePart = nil
							for _, Enemy in Folder:GetChildren() do
								if Enemy == Player.Character or not IsAlive(Enemy) then continue end
								local foundPart = GetRandomValidPart(Enemy)
								if foundPart and Player:DistanceFromCharacter(foundPart.Position) < FastAttack.Distance then
									table.insert(OthersEnemies, {Enemy, foundPart})
									BasePart = foundPart
								end
							end
							return BasePart
						end

						local function ProcessRealPlayers(OthersEnemies)
							if not FastAttack.attackPlayers then return nil end
							local BasePart = nil
							for _, OtherPlayer in Players:GetPlayers() do
								if OtherPlayer == Player then continue end
								local OtherChar = OtherPlayer.Character
								if not IsAlive(OtherChar) then continue end
								local foundPart = GetRandomValidPart(OtherChar)
								if foundPart and Player:DistanceFromCharacter(foundPart.Position) < FastAttack.Distance then
									table.insert(OthersEnemies, {OtherChar, foundPart})
									BasePart = foundPart
								end
							end
							return BasePart
						end

						function FastAttack:Attack(BasePart, OthersEnemies)
							local _, Net, temp_RegisterAttack, temp_RegisterHit, _ = CheckAndGetCoreComponents()
							if not (BasePart and OthersEnemies and #OthersEnemies > 0 and temp_RegisterAttack and temp_RegisterHit) then
								self.consecutiveFailures = self.consecutiveFailures + 1
								if self.consecutiveFailures >= self.maxConsecutiveFailures then
									self.consecutiveFailures = 0
									self.Equipped = Player.Character and IsAlive(Player.Character) and Player.Character:FindFirstChildOfClass("Tool")
								end
								task.delay(0.5, function() self:AttackNearest() end)
								return
							end
							self.consecutiveFailures = 0
							temp_RegisterAttack:FireServer(Settings.ClickDelay or 0)
							temp_RegisterHit:FireServer(BasePart, OthersEnemies)
						end

						function FastAttack:AttackNearest()
							if not self.IsRunning then return end
							local _, _, _, _, Enemies = CheckAndGetCoreComponents()
							local OthersEnemies = {}
							local Part1 = ProcessEnemies(OthersEnemies, Enemies)
							local Part2 = ProcessRealPlayers(OthersEnemies)
							if #OthersEnemies > 0 then
								self:Attack(Part1 or Part2, OthersEnemies)
							end
						end

						function FastAttack:BladeHits()
							local Equipped = Player.Character and IsAlive(Player.Character) and Player.Character:FindFirstChildOfClass("Tool")
							if Equipped and Equipped.ToolTip ~= "Gun" then
								self:AttackNearest()
							end
						end

						task.spawn(function()
							while true do
								task.wait(Settings.ClickDelay)
								if Settings.AutoClick and FastAttack.IsRunning then
									FastAttack:BladeHits()
								else
									task.wait(0.1)
								end
							end
						end)

						_ENV.rz_FastAttack = FastAttack
						return FastAttack
					end)()
				end
			end
		end
	end
end)



attackTab:Textbox("速度(推荐900）", "TranslateAccelSpeed", "输入速度值", function(Value)
    local speed = tonumber(Value)
    if speed then
        getfenv().translateSpeed = speed
    end
end)

attackTab:Toggle("加速开关", "TranslateAccelToggle", false, function(State)
    getfenv().translateAccelEnabled = State
    
    if State then
        if getfenv().sudu then
            getfenv().sudu:Disconnect()
            getfenv().sudu = nil
        end
        
        getfenv().translateConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if game:GetService("Players").LocalPlayer.Character and 
               game:GetService("Players").LocalPlayer.Character.Humanoid and 
               game:GetService("Players").LocalPlayer.Character.Humanoid.Parent then
               
                local humanoid = game:GetService("Players").LocalPlayer.Character.Humanoid
                
                if humanoid.MoveDirection.Magnitude > 0 then
                    local moveDirection = humanoid.MoveDirection
                    local acceleration = moveDirection * (getfenv().translateSpeed or 50) / 30
                    
                    game:GetService("Players").LocalPlayer.Character:TranslateBy(acceleration)
                end
            end
        end)
    else
        if getfenv().translateConnection then
            getfenv().translateConnection:Disconnect()
            getfenv().translateConnection = nil
        end
    end
end)
