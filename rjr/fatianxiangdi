local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

local ui = Instance.new("ScreenGui")
ui.Name = "SizeControlUI"
ui.Parent = PlayerGui
ui.IgnoreGuiInset = true
ui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local panel = Instance.new("Frame")
panel.Size = UDim2.new(0, 180, 0, 150)
panel.Position = UDim2.new(0.5, -90, 0.5, -75)
panel.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
panel.BackgroundTransparency = 0.3
panel.Active = true
panel.Draggable = true
panel.Parent = ui
panel.ClipsDescendants = true
panel.BorderSizePixel = 0

local titleBar = Instance.new("TextLabel")
titleBar.Size = UDim2.new(1, 0, 0, 25)
titleBar.BackgroundColor3 = Color3.new(0.25, 0.25, 0.35)
titleBar.Text = "体型控制（1000倍上限）"
titleBar.TextColor3 = Color3.new(1, 1, 1)
titleBar.TextSize = 12
titleBar.TextXAlignment = Enum.TextXAlignment.Center
titleBar.Parent = panel
titleBar.Active = true

local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseUI"
closeBtn.Size = UDim2.new(0, 20, 0, 20)
closeBtn.Position = UDim2.new(1, -23, 0, 2.5)
closeBtn.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.TextSize = 14
closeBtn.TextXAlignment = Enum.TextXAlignment.Center
closeBtn.Parent = panel
closeBtn.AutoButtonColor = false
closeBtn.MouseButton1Click:Connect(function()
    ui:Destroy()
end)

local sizeLabel = Instance.new("TextLabel")
sizeLabel.Size = UDim2.new(1, 0, 0, 25)
sizeLabel.Position = UDim2.new(0, 0, 0, 25)
sizeLabel.BackgroundTransparency = 1
sizeLabel.Text = "当前体型：1.0x"
sizeLabel.TextColor3 = Color3.new(1, 1, 1)
sizeLabel.TextScaled = false
sizeLabel.TextSize = 14
sizeLabel.Parent = panel

local enlargeBtn = Instance.new("TextButton")
enlargeBtn.Size = UDim2.new(0.45, 0, 0, 30)
enlargeBtn.Position = UDim2.new(0, 5, 0, 60)
enlargeBtn.BackgroundColor3 = Color3.new(0.2, 0.7, 0.2)
enlargeBtn.Text = "放大"
enlargeBtn.TextColor3 = Color3.new(1, 1, 1)
enlargeBtn.TextSize = 16
enlargeBtn.TextScaled = false
enlargeBtn.Parent = panel
enlargeBtn.AutoButtonColor = false

local shrinkBtn = Instance.new("TextButton")
shrinkBtn.Size = UDim2.new(0.45, 0, 0, 30)
shrinkBtn.Position = UDim2.new(0.5, 5, 0, 60)
shrinkBtn.BackgroundColor3 = Color3.new(0.7, 0.2, 0.2)
shrinkBtn.Text = "缩小"
shrinkBtn.TextColor3 = Color3.new(1, 1, 1)
shrinkBtn.TextSize = 16
shrinkBtn.TextScaled = false
shrinkBtn.Parent = panel
shrinkBtn.AutoButtonColor = false

local customLabel = Instance.new("TextLabel")
customLabel.Size = UDim2.new(0.4, 0, 0, 20)
customLabel.Position = UDim2.new(0, 5, 0, 100)
customLabel.BackgroundTransparency = 1
customLabel.Text = "自定义："
customLabel.TextColor3 = Color3.new(1, 1, 1)
customLabel.TextSize = 14
customLabel.Parent = panel

local customInput = Instance.new("TextBox")
customInput.Size = UDim2.new(0.35, 0, 0, 20)
customInput.Position = UDim2.new(0.45, 0, 0, 100)
customInput.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
customInput.TextColor3 = Color3.new(1, 1, 1)
customInput.TextSize = 14
customInput.Text = "1.0"
customInput.ClearTextOnFocus = false
customInput.Parent = panel
customInput.ClipsDescendants = true

local confirmBtn = Instance.new("TextButton")
confirmBtn.Size = UDim2.new(0.15, 0, 0, 20)
confirmBtn.Position = UDim2.new(0.85, -5, 0, 100)
confirmBtn.BackgroundColor3 = Color3.new(0.2, 0.2, 0.7)
confirmBtn.Text = "确认"
confirmBtn.TextColor3 = Color3.new(1, 1, 1)
confirmBtn.TextSize = 12
confirmBtn.TextScaled = false
confirmBtn.Parent = panel
confirmBtn.AutoButtonColor = false

local creditLabel = Instance.new("TextLabel")
creditLabel.Size = UDim2.new(1, 0, 0, 15)
creditLabel.Position = UDim2.new(0, 0, 0, 125) -- 位于自定义区域下方
creditLabel.BackgroundTransparency = 1
creditLabel.Text = "by：kismile"
creditLabel.TextColor3 = Color3.new(0.8, 0.8, 0.8) -- 浅灰色，不突兀
creditLabel.TextSize = 11 -- 小号字体，贴合UI风格
creditLabel.TextXAlignment = Enum.TextXAlignment.Center -- 居中显示
creditLabel.Parent = panel

local currentSize = 1.0
local sizeStep = 0.8
local sizeLimit = {min=0.0001, max=1000.0}
local char
local isScaling = false
local scaleUpdateConnection = nil

local function updateScale()
    if not char or isScaling then return end
    isScaling = true
    char:ScaleTo(currentSize, 0.05)
    task.wait(0.05)
    isScaling = false
end

local function updateLabelText(text, color)
    sizeLabel.Text = text
    sizeLabel.TextColor3 = color or Color3.new(1,1,1)
end

player.CharacterAdded:Connect(function(c)
    char = c
    if scaleUpdateConnection then
        scaleUpdateConnection:Disconnect()
    end
    scaleUpdateConnection = RunService.RenderStepped:Connect(function()
        if char and char:IsDescendantOf(workspace) then
            char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame
        end
    end)
    updateScale()
end)

enlargeBtn.MouseButton1Click:Connect(function()
    if not char then
        updateLabelText("角色未加载！", Color3.new(1,0.5,0.5))
        task.wait(1.5)
        updateLabelText(string.format("当前体型：%.1fx", currentSize))
        return
    end
    if currentSize >= sizeLimit.max then
        updateLabelText("已达1000倍上限！", Color3.new(1,0.8,0))
        task.wait(1)
        updateLabelText(string.format("当前体型：%.1fx", currentSize))
        return
    end
    currentSize = math.min(currentSize + sizeStep, sizeLimit.max)
    updateLabelText(string.format("当前体型：%.1fx", currentSize))
    customInput.Text = string.format("%.1f", currentSize)
    updateScale()
end)

shrinkBtn.MouseButton1Click:Connect(function()
    if not char then
        updateLabelText("角色未加载！", Color3.new(1,0.5,0.5))
        task.wait(1.5)
        updateLabelText(string.format("当前体型：%.1fx", currentSize))
        return
    end
    if currentSize <= sizeLimit.min then
        updateLabelText("已达最小体型！", Color3.new(1,0.8,0))
        task.wait(1)
        updateLabelText(string.format("当前体型：%.1fx", currentSize))
        return
    end
    currentSize = math.max(currentSize - sizeStep, sizeLimit.min)
    updateLabelText(string.format("当前体型：%.1fx", currentSize))
    customInput.Text = string.format("%.1f", currentSize)
    updateScale()
end)

confirmBtn.MouseButton1Click:Connect(function()
    if not char then
        updateLabelText("角色未加载！", Color3.new(1,0.5,0.5))
        task.wait(1.5)
        updateLabelText(string.format("当前体型：%.1fx", currentSize))
        return
    end
    local inputNum = tonumber(customInput.Text)
    if not inputNum then
        updateLabelText("输入无效！", Color3.new(1,0.5,0.5))
        task.wait(1)
        updateLabelText(string.format("当前体型：%.1fx", currentSize))
        customInput.Text = string.format("%.1f", currentSize)
        return
    end
    local newSize = math.clamp(inputNum, sizeLimit.min, sizeLimit.max)
    currentSize = newSize
    updateLabelText(string.format("当前体型：%.1fx", currentSize))
    customInput.Text = string.format("%.1f", currentSize)
    updateScale()
end)

enlargeBtn.MouseEnter:Connect(function()
    enlargeBtn.BackgroundColor3 = Color3.new(0.3, 0.8, 0.3)
end)
enlargeBtn.MouseLeave:Connect(function()
    enlargeBtn.BackgroundColor3 = Color3.new(0.2, 0.7, 0.2)
end)

shrinkBtn.MouseEnter:Connect(function()
    shrinkBtn.BackgroundColor3 = Color3.new(0.8, 0.3, 0.3)
end)
shrinkBtn.MouseLeave:Connect(function()
    shrinkBtn.BackgroundColor3 = Color3.new(0.7, 0.2, 0.2)
end)

closeBtn.MouseEnter:Connect(function()
    closeBtn.BackgroundColor3 = Color3.new(0.9, 0.3, 0.3)
end)
closeBtn.MouseLeave:Connect(function()
    closeBtn.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
end)

confirmBtn.MouseEnter:Connect(function()
    confirmBtn.BackgroundColor3 = Color3.new(0.3, 0.3, 0.8)
end)
confirmBtn.MouseLeave:Connect(function()
    confirmBtn.BackgroundColor3 = Color3.new(0.2, 0.2, 0.7)
end)

customInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        confirmBtn.MouseButton1Click:Fire()
    end
end)

if player.Character then
    char = player.Character
    updateScale()
end
