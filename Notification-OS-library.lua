local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local WindowAPI = {}
local HistoryData = {} 

-- [[ Config ]]
local NotificationStyle = "OriginOS" 
local OpenHistoryKeybind = Enum.KeyCode.Insert 

local RandomEnjoyTexts = {
    "Enjoy UI library?",
    "System running smoothly.",
    "Everything is up to date.",
    "Optimized for performance."
}

-- ปรับให้สีคอนทราสต์ชัดเจน (Pop-up สีเข้มตัวหนังสือขาว / History Center จะเป็นพื้นขาวตัวหนังสือดำ)
local OS_Themes = {
    OriginOS = { Corner = 16, Bg = Color3.fromRGB(24, 24, 28), Text = Color3.fromRGB(255, 255, 255), Font = Enum.Font.GothamBold, StrokeTrans = 0.8, BgTrans = 0.1 },
    Modern = { Corner = 8, Bg = Color3.fromRGB(20, 20, 25), Text = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Gotham, StrokeTrans = 0.5, BgTrans = 0.15 }
}

local function CreateTween(instance, properties, duration, style, direction)
    local tweenInfo = TweenInfo.new(duration or 0.3, style or Enum.EasingStyle.Quad, direction or Enum.EasingDirection.Out)
    local tween = TweenService:Create(instance, tweenInfo, properties)
    tween:Play()
    return tween
end

-- [[ 1. สร้าง GUI หลัก ]]
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

-- [[ 2. สร้างหน้าต่าง Notification Center แบบในภาพ (Pull-down) ]]
-- พื้นหลังโปร่งแสงเวลาดึงลงมา
local ShadeBg = Instance.new("Frame", NotificationGui)
ShadeBg.Size = UDim2.new(1, 0, 1, 0)
ShadeBg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ShadeBg.BackgroundTransparency = 1
ShadeBg.Visible = false
ShadeBg.ZIndex = 99990

local HistoryPanel = Instance.new("CanvasGroup", NotificationGui)
HistoryPanel.Size = UDim2.new(0, 360, 0, 550)
HistoryPanel.Position = UDim2.new(0.5, -180, 0, -600)
HistoryPanel.BackgroundColor3 = Color3.fromRGB(240, 240, 243) -- สีเทาพื้นหลังมือถือ
HistoryPanel.GroupTransparency = 1
HistoryPanel.ZIndex = 99991
Instance.new("UICorner", HistoryPanel).CornerRadius = UDim.new(0, 0) -- เต็มจอด้านบน

-- Header วันที่ (แบบ Real-time)
local HeaderDate = Instance.new("TextLabel", HistoryPanel)
HeaderDate.Size = UDim2.new(1, -40, 0, 30)
HeaderDate.Position = UDim2.new(0, 20, 0, 30)
HeaderDate.BackgroundTransparency = 1
HeaderDate.Text = os.date("%a %d %B %Y") -- เช่น Tue 9 June 2026
HeaderDate.TextColor3 = Color3.fromRGB(255, 255, 255)
HeaderDate.Font = Enum.Font.GothamBold
HeaderDate.TextSize = 18
HeaderDate.TextXAlignment = Enum.TextXAlignment.Left

-- การ์ดสีขาวที่รวมแจ้งเตือนทั้งหมด
local CardContainer = Instance.new("Frame", HistoryPanel)
CardContainer.Size = UDim2.new(1, -20, 1, -120)
CardContainer.Position = UDim2.new(0, 10, 0, 80)
CardContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", CardContainer).CornerRadius = UDim.new(0, 16)

local HistoryScroll = Instance.new("ScrollingFrame", CardContainer)
HistoryScroll.Size = UDim2.new(1, 0, 1, -40) -- เว้นที่ให้ปุ่ม Clear all
HistoryScroll.Position = UDim2.new(0, 0, 0, 0)
HistoryScroll.BackgroundTransparency = 1
HistoryScroll.ScrollBarThickness = 0
HistoryScroll.BorderSizePixel = 0

local ScrollLayout = Instance.new("UIListLayout", HistoryScroll)
ScrollLayout.SortOrder = Enum.SortOrder.LayoutOrder

ScrollLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    HistoryScroll.CanvasSize = UDim2.new(0, 0, 0, ScrollLayout.AbsoluteContentSize.Y)
end)

-- ปุ่ม Clear all
local ClearAllBtn = Instance.new("TextButton", CardContainer)
ClearAllBtn.Size = UDim2.new(1, -20, 0, 30)
ClearAllBtn.Position = UDim2.new(0, 10, 1, -35)
ClearAllBtn.BackgroundTransparency = 1
ClearAllBtn.Text = "Clear all"
ClearAllBtn.TextColor3 = Color3.fromRGB(40, 120, 255) -- สีฟ้าแบบมือถือ
ClearAllBtn.Font = Enum.Font.GothamMedium
ClearAllBtn.TextSize = 13
ClearAllBtn.TextXAlignment = Enum.TextXAlignment.Right

-- ปุ่ม Console บน Header
local ConsoleBtn = Instance.new("TextButton", HistoryPanel)
ConsoleBtn.Size = UDim2.new(0, 35, 0, 35)
ConsoleBtn.Position = UDim2.new(1, -50, 0, 25)
ConsoleBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ConsoleBtn.BackgroundTransparency = 0.5
ConsoleBtn.Text = "C"
ConsoleBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
ConsoleBtn.Font = Enum.Font.GothamBold
ConsoleBtn.TextSize = 14
Instance.new("UICorner", ConsoleBtn).CornerRadius = UDim.new(1, 0)

ConsoleBtn.MouseButton1Click:Connect(function()
    game:GetService("StarterGui"):SetCore("DevConsoleVisible", true)
end)

-- ฟังก์ชันล้างประวัติ
ClearAllBtn.MouseButton1Click:Connect(function()
    for _, child in pairs(HistoryScroll:GetChildren()) do
        if child:IsA("Frame") then child:Destroy() end
    end
    HistoryData = {}
end)

-- [[ 3. Pull-down Tab ]]
local TopTabHitbox = Instance.new("TextButton", NotificationGui)
TopTabHitbox.Size = UDim2.new(0, 100, 0, 20)
TopTabHitbox.Position = UDim2.new(0.5, -50, 0, 0)
TopTabHitbox.BackgroundTransparency = 1
TopTabHitbox.Text = ""
TopTabHitbox.ZIndex = 99999

local TopTabVisual = Instance.new("Frame", TopTabHitbox)
TopTabVisual.Size = UDim2.new(0, 40, 0, 4)
TopTabVisual.Position = UDim2.new(0.5, -20, 0, 5)
TopTabVisual.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
TopTabVisual.BackgroundTransparency = 0.5
Instance.new("UICorner", TopTabVisual).CornerRadius = UDim.new(1, 0)

local isHistoryOpen = false
local function ToggleHistory()
    isHistoryOpen = not isHistoryOpen
    if isHistoryOpen then
        ShadeBg.Visible = true
        HeaderDate.Text = os.date("%a %d %B %Y") -- อัปเดตวันที่ตอนเปิด
        CreateTween(ShadeBg, {BackgroundTransparency = 0.6}, 0.4)
        CreateTween(HistoryPanel, {Position = UDim2.new(0.5, -180, 0, 0), GroupTransparency = 0}, 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        CreateTween(TopTabVisual, {BackgroundTransparency = 1}, 0.2)
    else
        CreateTween(ShadeBg, {BackgroundTransparency = 1}, 0.4)
        CreateTween(HistoryPanel, {Position = UDim2.new(0.5, -180, 0, -600), GroupTransparency = 1}, 0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
        CreateTween(TopTabVisual, {BackgroundTransparency = 0.5}, 0.2)
        task.wait(0.4)
        if not isHistoryOpen then ShadeBg.Visible = false end
    end
end

TopTabHitbox.MouseButton1Click:Connect(ToggleHistory)
UserInputService.InputBegan:Connect(function(input, gp)
    if not gp and input.KeyCode == OpenHistoryKeybind then ToggleHistory() end
end)

-- [[ 4. ฟังก์ชันเพิ่มประวัติ (ดีไซน์ตามภาพ) ]]
local function AddToHistory(title, content)
    local item = Instance.new("Frame", HistoryScroll)
    item.Size = UDim2.new(1, 0, 0, 80)
    item.BackgroundTransparency = 1
    
    -- เส้นคั่น Divider
    local divider = Instance.new("Frame", item)
    divider.Size = UDim2.new(1, 0, 0, 1)
    divider.Position = UDim2.new(0, 0, 1, -1)
    divider.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    divider.BorderSizePixel = 0

    -- App Info (แถวบนสุด: ชื่อแอป • เวลา)
    local appInfo = Instance.new("TextLabel", item)
    appInfo.Size = UDim2.new(1, -40, 0, 20)
    appInfo.Position = UDim2.new(0, 40, 0, 10)
    appInfo.BackgroundTransparency = 1
    appInfo.Text = "Veridian Hub • now"
    appInfo.TextColor3 = Color3.fromRGB(120, 120, 120) -- สีเทาหม่น
    appInfo.Font = Enum.Font.Gotham
    appInfo.TextSize = 11
    appInfo.TextXAlignment = Enum.TextXAlignment.Left

    -- ไอคอนแอปสมมติ
    local appIcon = Instance.new("Frame", item)
    appIcon.Size = UDim2.new(0, 16, 0, 16)
    appIcon.Position = UDim2.new(0, 15, 0, 12)
    appIcon.BackgroundColor3 = Color3.fromRGB(40, 150, 255)
    Instance.new("UICorner", appIcon).CornerRadius = UDim.new(0, 4)

    -- หัวข้อ (Title)
    local hTitle = Instance.new("TextLabel", item)
    hTitle.Size = UDim2.new(1, -30, 0, 20)
    hTitle.Position = UDim2.new(0, 15, 0, 35)
    hTitle.BackgroundTransparency = 1
    hTitle.Text = title
    hTitle.TextColor3 = Color3.fromRGB(20, 20, 20) -- สีดำตัดพื้นขาวชัดเจน
    hTitle.Font = Enum.Font.GothamMedium
    hTitle.TextSize = 14
    hTitle.TextXAlignment = Enum.TextXAlignment.Left

    -- เนื้อหา (Content)
    local hDesc = Instance.new("TextLabel", item)
    hDesc.Size = UDim2.new(1, -30, 0, 20)
    hDesc.Position = UDim2.new(0, 15, 0, 55)
    hDesc.BackgroundTransparency = 1
    hDesc.Text = content
    hDesc.TextColor3 = Color3.fromRGB(60, 60, 60)
    hDesc.Font = Enum.Font.Gotham
    hDesc.TextSize = 13
    hDesc.TextXAlignment = Enum.TextXAlignment.Left
    hDesc.TextTruncate = Enum.TextTruncate.AtEnd
end

-- [[ 5. ฟังก์ชันแจ้งเตือนหลัก (ป๊อปอัพ) ]]
local NotificationCount = 0 

function WindowAPI:Notify(cfg)
    local theme = OS_Themes[cfg.Style or NotificationStyle] or OS_Themes.OriginOS
    local title = cfg.Title or "System"
    local content = cfg.Content or "Notification"
    local duration = cfg.Duration or 3

    if cfg.UseRandomText then content = content .. " - " .. RandomEnjoyTexts[math.random(1, #RandomEnjoyTexts)] end

    AddToHistory(title, content)

    local frame = Instance.new("CanvasGroup", NotifyContainer)
    frame.Size = UDim2.new(0, 320, 0, 75)
    local targetY = 20 + (NotificationCount * 85)
    frame.Position = UDim2.new(0.5, -160, 0, -100) 
    frame.BackgroundColor3 = theme.Bg
    frame.BackgroundTransparency = theme.BgTrans
    frame.ZIndex = 999999
    frame.GroupTransparency = 0
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, theme.Corner)

    local stroke = Instance.new("UIStroke", frame)
    stroke.Color = Color3.fromRGB(150, 150, 150)
    stroke.Thickness = 1
    stroke.Transparency = theme.StrokeTrans

    local tTitle = Instance.new("TextLabel", frame)
    tTitle.Size = UDim2.new(1, -20, 0, 20)
    tTitle.Position = UDim2.new(0, 15, 0, 10)
    tTitle.BackgroundTransparency = 1
    tTitle.Text = title
    tTitle.TextColor3 = theme.Text
    tTitle.Font = theme.Font
    tTitle.TextSize = 14
    tTitle.TextXAlignment = Enum.TextXAlignment.Left

    local tDesc = Instance.new("TextLabel", frame)
    tDesc.Size = UDim2.new(1, -20, 0, 35)
    tDesc.Position = UDim2.new(0, 15, 0, 30)
    tDesc.BackgroundTransparency = 1
    tDesc.Text = content
    tDesc.TextColor3 = theme.Text
    tDesc.Font = Enum.Font.Gotham
    tDesc.TextSize = 12
    tDesc.TextWrapped = true
    tDesc.TextXAlignment = Enum.TextXAlignment.Left
    tDesc.TextYAlignment = Enum.TextYAlignment.Top

    CreateTween(frame, {Position = UDim2.new(0.5, -160, 0, targetY)}, 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    NotificationCount = NotificationCount + 1

    local isDismissed = false
    local function DismissNotify()
        if isDismissed then return end
        isDismissed = true
        NotificationCount = math.max(0, NotificationCount - 1)
        CreateTween(frame, {Position = UDim2.new(0.5, -160, 0, frame.Position.Y.Offset - 100), GroupTransparency = 1}, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        task.wait(0.3)
        frame:Destroy()
    end

    local startY = 0
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then startY = input.Position.Y end
    end)
    frame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            if startY - input.Position.Y > 15 then DismissNotify() end
        end
    end)

    task.delay(duration, function() DismissNotify() end)
end

return WindowAPI
