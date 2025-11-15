local ui =loadstring(game:HttpGet("https://raw.githubusercontent.com/kismile36/rjrzhongxing/refs/heads/main/rjr/kismileui.lua"))()
local win = ui:new("人挤人中心")
local UITab1 = win:Tab("公告",'7734068321')
local UITab2 = win:Tab("超级无敌脚本",'7734068321')

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
