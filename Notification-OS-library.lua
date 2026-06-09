local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local WindowAPI = {}

local NotificationStyle = "OriginOS" 
local OpenHistoryKeybind = Enum.KeyCode.Insert 

local RandomEnjoyTexts = {
    "Enjoy UI library?",
    "System running smoothly.",
    "Everything is up to date."
}

local OS_Themes = {
    OriginOS = { Corner = 16, Bg = Color3.fromRGB(255, 255, 255), Text = Color3.fromRGB(30, 30, 30), SubText = Color3.fromRGB(100, 100, 100), StrokeTrans = 0.9, BgTrans = 0 },
    Modern = { Corner = 12, Bg = Color3.fromRGB(24, 24, 28), Text = Color3.fromRGB(255, 255, 255), SubText = Color3.fromRGB(180, 180, 180), StrokeTrans = 0.8, BgTrans = 0.1 }
}

local function CreateTween(instance, properties, duration, style, direction)
    local tweenInfo = TweenInfo.new(duration or 0.35, style or Enum.EasingStyle.Quart, direction or Enum.EasingDirection.Out)
    local tween = TweenService:Create(instance, tweenInfo, properties)
    tween:Play()
    return tween
end

local NotificationGui = Instance.new("ScreenGui")
NotificationGui.Name = "OS_NotificationSystem"
NotificationGui.DisplayOrder = 999999
NotificationGui.ResetOnSpawn = false

local success, err = pcall(function() NotificationGui.Parent = CoreGui end)
if not success then NotificationGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui") end

local NotifyContainer = Instance.new("Frame", NotificationGui)
NotifyContainer.Size = UDim2.new(1, 0, 1, 0)
NotifyContainer.BackgroundTransparency = 1
NotifyContainer.ZIndex = 999999

-- [ PULL-DOWN HISTORY CENTER (OS STYLE) ]
local ShadeBg = Instance.new("Frame", NotificationGui)
ShadeBg.Size = UDim2.new(1, 0, 1, 0)
ShadeBg.BackgroundColor3 = Color3.fromRGB(160, 162, 168) 
ShadeBg.BackgroundTransparency = 1
ShadeBg.Visible = false
ShadeBg.ZIndex = 99990

local HistoryPanel = Instance.new("CanvasGroup", NotificationGui)
HistoryPanel.Size = UDim2.new(1, 0, 1, 0)
HistoryPanel.Position = UDim2.new(0, 0, -1, 0)
HistoryPanel.BackgroundTransparency = 1
HistoryPanel.GroupTransparency = 1
HistoryPanel.ZIndex = 99991

local MaxWidthConstraint = Instance.new("UISizeConstraint", HistoryPanel)
MaxWidthConstraint.MaxSize = Vector2.new(600, 9999) 
local CenterLayout = Instance.new("UIListLayout", NotificationGui)
CenterLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local TopHeader = Instance.new("Frame", HistoryPanel)
TopHeader.Size = UDim2.new(1, 0, 0, 80)
TopHeader.Position = UDim2.new(0, 0, 0, 20)
TopHeader.BackgroundTransparency = 1

local HeaderDate = Instance.new("TextLabel", TopHeader)
HeaderDate.Size = UDim2.new(1, -40, 0, 25)
HeaderDate.Position = UDim2.new(0, 20, 0, 10)
HeaderDate.BackgroundTransparency = 1
HeaderDate.Text = os.date("%a %d %b %Y") 
HeaderDate.TextColor3 = Color3.fromRGB(255, 255, 255)
HeaderDate.Font = Enum.Font.GothamBold
HeaderDate.TextSize = 18
HeaderDate.TextXAlignment = Enum.TextXAlignment.Left

local HeaderSub = Instance.new("TextLabel", TopHeader)
HeaderSub.Size = UDim2.new(1, -40, 0, 15)
HeaderSub.Position = UDim2.new(0, 20, 0, 35)
HeaderSub.BackgroundTransparency = 1
HeaderSub.Text = "MPT"
HeaderSub.TextColor3 = Color3.fromRGB(220, 220, 220)
HeaderSub.Font = Enum.Font.GothamMedium
HeaderSub.TextSize = 12
HeaderSub.TextXAlignment = Enum.TextXAlignment.Left

local SettingsIcon = Instance.new("Frame", TopHeader)
SettingsIcon.Size = UDim2.new(0, 30, 0, 30)
SettingsIcon.Position = UDim2.new(1, -70, 0, 10)
SettingsIcon.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
SettingsIcon.BackgroundTransparency = 0.5
Instance.new("UICorner", SettingsIcon).CornerRadius = UDim.new(1, 0)

local ProfileIcon = Instance.new("Frame", TopHeader)
ProfileIcon.Size = UDim2.new(0, 30, 0, 30)
ProfileIcon.Position = UDim2.new(1, -30, 0, 10)
ProfileIcon.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
Instance.new("UICorner", ProfileIcon).CornerRadius = UDim.new(1, 0)

local HistoryScroll = Instance.new("ScrollingFrame", HistoryPanel)
HistoryScroll.Size = UDim2.new(1, -20, 1, -150)
HistoryScroll.Position = UDim2.new(0.5, 0, 0, 100)
HistoryScroll.AnchorPoint = Vector2.new(0.5, 0)
HistoryScroll.BackgroundTransparency = 1
HistoryScroll.ScrollBarThickness = 0
HistoryScroll.BorderSizePixel = 0
HistoryScroll.ZIndex = 99993

local ScrollLayout = Instance.new("UIListLayout", HistoryScroll)
ScrollLayout.SortOrder = Enum.SortOrder.LayoutOrder
ScrollLayout.Padding = UDim.new(0, 8)

ScrollLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    HistoryScroll.CanvasSize = UDim2.new(0, 0, 0, ScrollLayout.AbsoluteContentSize.Y + 20)
end)

local ClearAllBtn = Instance.new("TextButton", HistoryPanel)
ClearAllBtn.Size = UDim2.new(1, -40, 0, 30)
ClearAllBtn.Position = UDim2.new(0, 20, 1, -80)
ClearAllBtn.BackgroundTransparency = 1
ClearAllBtn.Text = "Clear all"
ClearAllBtn.TextColor3 = Color3.fromRGB(40, 120, 255) 
ClearAllBtn.Font = Enum.Font.GothamMedium
ClearAllBtn.TextSize = 14
ClearAllBtn.TextXAlignment = Enum.TextXAlignment.Right
ClearAllBtn.ZIndex = 99994

ClearAllBtn.MouseButton1Click:Connect(function()
    for _, child in pairs(HistoryScroll:GetChildren()) do
        if child:IsA("Frame") then child:Destroy() end
    end
end)

local SimText = Instance.new("TextLabel", HistoryPanel)
SimText.Size = UDim2.new(1, 0, 0, 20)
SimText.Position = UDim2.new(0, 0, 1, -30)
SimText.BackgroundTransparency = 1
SimText.Text = "SIM 1 Today: 0.0 B Used this month: 0.0 B >"
SimText.TextColor3 = Color3.fromRGB(240, 240, 240)
SimText.Font = Enum.Font.Gotham
SimText.TextSize = 11

local isHistoryOpen = false
local function ToggleHistory()
    isHistoryOpen = not isHistoryOpen
    if isHistoryOpen then
        ShadeBg.Visible = true
        HeaderDate.Text = os.date("%a %d %b %Y") 
        CreateTween(ShadeBg, {BackgroundTransparency = 0.2}, 0.3)
        CreateTween(HistoryPanel, {Position = UDim2.new(0, 0, 0, 0), GroupTransparency = 0}, 0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    else
        CreateTween(ShadeBg, {BackgroundTransparency = 1}, 0.3)
        CreateTween(HistoryPanel, {Position = UDim2.new(0, 0, -1, 0), GroupTransparency = 1}, 0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
        task.wait(0.35)
        if not isHistoryOpen then ShadeBg.Visible = false end
    end
end

UserInputService.InputBegan:Connect(function(input, gp)
    if not gp and input.KeyCode == OpenHistoryKeybind then ToggleHistory() end
end)

local function AddToHistory(title, content, theme)
    local item = Instance.new("Frame", HistoryScroll)
    item.Size = UDim2.new(1, 0, 0, 0) 
    item.BackgroundColor3 = theme.Bg
    item.ZIndex = 99993
    item.AutomaticSize = Enum.AutomaticSize.Y
    Instance.new("UICorner", item).CornerRadius = UDim.new(0, theme.Corner)
    
    local appIcon = Instance.new("Frame", item)
    appIcon.Size = UDim2.new(0, 16, 0, 16)
    appIcon.Position = UDim2.new(0, 15, 0, 12)
    appIcon.BackgroundColor3 = Color3.fromRGB(0, 200, 150)
    Instance.new("UICorner", appIcon).CornerRadius = UDim.new(0, 4)

    local appInfo = Instance.new("TextLabel", item)
    appInfo.Size = UDim2.new(1, -50, 0, 20)
    appInfo.Position = UDim2.new(0, 40, 0, 10)
    appInfo.BackgroundTransparency = 1
    appInfo.Text = "Veridian Hub • now"
    appInfo.TextColor3 = theme.SubText 
    appInfo.Font = Enum.Font.Gotham
    appInfo.TextSize = 11
    appInfo.TextXAlignment = Enum.TextXAlignment.Left

    local expandArrow = Instance.new("TextLabel", item)
    expandArrow.Size = UDim2.new(0, 20, 0, 20)
    expandArrow.Position = UDim2.new(1, -25, 0, 10)
    expandArrow.BackgroundTransparency = 1
    expandArrow.Text = "v"
    expandArrow.TextColor3 = theme.SubText
    expandArrow.Font = Enum.Font.Gotham
    expandArrow.TextSize = 12

    local hTitle = Instance.new("TextLabel", item)
    hTitle.Size = UDim2.new(1, -30, 0, 20)
    hTitle.Position = UDim2.new(0, 15, 0, 35)
    hTitle.BackgroundTransparency = 1
    hTitle.Text = title
    hTitle.TextColor3 = theme.Text 
    hTitle.Font = Enum.Font.GothamMedium
    hTitle.TextSize = 14
    hTitle.TextXAlignment = Enum.TextXAlignment.Left

    local hDesc = Instance.new("TextLabel", item)
    hDesc.Size = UDim2.new(1, -30, 0, 0)
    hDesc.Position = UDim2.new(0, 15, 0, 55)
    hDesc.BackgroundTransparency = 1
    hDesc.Text = content
    hDesc.TextColor3 = theme.SubText
    hDesc.Font = Enum.Font.Gotham
    hDesc.TextSize = 13
    hDesc.TextXAlignment = Enum.TextXAlignment.Left
    hDesc.TextWrapped = true
    hDesc.AutomaticSize = Enum.AutomaticSize.Y
    
    local pad = Instance.new("UIPadding", item)
    pad.PaddingBottom = UDim.new(0, 15)
end

-- [ TOP-DOWN NOTIFICATION POPUP ]
local NotificationActive = {}

function WindowAPI:Notify(cfg)
    local theme = OS_Themes[cfg.Style or NotificationStyle] or OS_Themes.OriginOS
    local title = cfg.Title or "System"
    local content = cfg.Content or "Notification"
    local duration = cfg.Duration or 3

    if cfg.UseRandomText then content = content .. " - " .. RandomEnjoyTexts[math.random(1, #RandomEnjoyTexts)] end

    AddToHistory(title, content, theme)

    local frame = Instance.new("CanvasGroup", NotifyContainer)
    frame.Size = UDim2.new(0, 340, 0, 0)
    frame.AutomaticSize = Enum.AutomaticSize.Y
    frame.Position = UDim2.new(0.5, 0, 0, -150) 
    frame.AnchorPoint = Vector2.new(0.5, 0) 
    frame.BackgroundColor3 = theme.Bg
    frame.BackgroundTransparency = theme.BgTrans
    frame.ZIndex = 999999
    frame.GroupTransparency = 0
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, theme.Corner)
    
    local padPopup = Instance.new("UIPadding", frame)
    padPopup.PaddingBottom = UDim.new(0, 15)
    padPopup.PaddingTop = UDim.new(0, 5)

    local stroke = Instance.new("UIStroke", frame)
    stroke.Color = Color3.fromRGB(200, 200, 200)
    stroke.Thickness = 1
    stroke.Transparency = theme.StrokeTrans

    local appIcon = Instance.new("Frame", frame)
    appIcon.Size = UDim2.new(0, 16, 0, 16)
    appIcon.Position = UDim2.new(0, 15, 0, 10)
    appIcon.BackgroundColor3 = Color3.fromRGB(0, 200, 150)
    Instance.new("UICorner", appIcon).CornerRadius = UDim.new(0, 4)

    local appName = Instance.new("TextLabel", frame)
    appName.Size = UDim2.new(1, -50, 0, 20)
    appName.Position = UDim2.new(0, 40, 0, 8)
    appName.BackgroundTransparency = 1
    appName.Text = "Veridian Hub • now"
    appName.TextColor3 = theme.SubText
    appName.Font = Enum.Font.Gotham
    appName.TextSize = 11
    appName.TextXAlignment = Enum.TextXAlignment.Left

    local tTitle = Instance.new("TextLabel", frame)
    tTitle.Size = UDim2.new(1, -30, 0, 20)
    tTitle.Position = UDim2.new(0, 15, 0, 32)
    tTitle.BackgroundTransparency = 1
    tTitle.Text = title
    tTitle.TextColor3 = theme.Text
    tTitle.Font = Enum.Font.GothamMedium
    tTitle.TextSize = 14
    tTitle.TextXAlignment = Enum.TextXAlignment.Left

    local tDesc = Instance.new("TextLabel", frame)
    tDesc.Size = UDim2.new(1, -30, 0, 0)
    tDesc.Position = UDim2.new(0, 15, 0, 52)
    tDesc.BackgroundTransparency = 1
    tDesc.Text = content
    tDesc.TextColor3 = theme.SubText
    tDesc.Font = Enum.Font.Gotham
    tDesc.TextSize = 13
    tDesc.TextWrapped = true
    tDesc.TextXAlignment = Enum.TextXAlignment.Left
    tDesc.AutomaticSize = Enum.AutomaticSize.Y

    table.insert(NotificationActive, frame)

    local function UpdatePositions()
        local currentY = 15 
        for i = #NotificationActive, 1, -1 do
            local notif = NotificationActive[i]
            if notif and notif.Parent then
                CreateTween(notif, {Position = UDim2.new(0.5, 0, 0, currentY)}, 0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
                currentY = currentY + notif.AbsoluteSize.Y + 10
            end
        end
    end

    UpdatePositions()

    local isDismissed = false
    local function DismissNotify()
        if isDismissed then return end
        isDismissed = true
        for i, v in ipairs(NotificationActive) do
            if v == frame then table.remove(NotificationActive, i) break end
        end
        CreateTween(frame, {Position = UDim2.new(0.5, 0, 0, -150), GroupTransparency = 1}, 0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
        UpdatePositions()
        task.wait(0.3)
        frame:Destroy()
    end

    local startY = 0
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then startY = input.Position.Y end
    end)
    frame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            if startY - input.Position.Y > 20 then DismissNotify() end 
        end
    end)

    task.delay(duration, function() DismissNotify() end)
end

return WindowAPI
