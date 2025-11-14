local ui =loadstring(game:HttpGet("https://raw.githubusercontent.com/kismile36/rjrzhongxing/refs/heads/main/rjr/kismileui.lua"))()
local win = ui:new("人挤人中心")
local UITab1 = win:Tab("公告",'7734068321')
local UITab2 = win:Tab("超级无敌脚本",'7734068321')

local about = UITab1:section("公告",true)

about:Label("kismile制作")

about:Label("脚本测试中")

local about = UITab2:section("超级无敌脚本",true)
about:Slider("缩放焦距","FieldOfView",Workspace.CurrentCamera.FieldOfView,10,150,false,function(FOV)
	spawn(function()
		while task.wait() do
			Workspace.CurrentCamera.FieldOfView = FOV
		end
	end)
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
