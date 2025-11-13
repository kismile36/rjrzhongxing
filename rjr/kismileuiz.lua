local function loadUIWithBackup()
    local mainUIUrl = "https://raw.githubusercontent.com/kismile36/rjrzhongxing/refs/heads/main/rjr/kismileui.lua"
    local backupUIUrl = "https://raw.githubusercontent.com/kismile36/rjrzhongxing/refs/heads/main/rjr/kismileui2.lua"
    
    local success, Library = pcall(function()
        return loadstring(game:HttpGet(mainUIUrl))()
    end)
    
    if not success then
        success, Library = pcall(function()
            return loadstring(game:HttpGet(backupUIUrl))()
        end)
    end
    
    return Library
end

local Library = loadUIWithBackup()
local Window = Library:new("人挤人中心")
