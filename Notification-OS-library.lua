local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local WindowAPI = {}
local HistoryData = {} -- เก็บประวัติการแจ้งเตือน

-- [[ Config & สไตล์ OS ]]
local NotificationStyle = "OriginOS" -- เปลี่ยนเป็น: "iOS", "Windows", "Samsung", "OriginOS", "Modern"
local OpenHistoryKeybind = Enum.KeyCode.Insert -- ปุ่มลัดเปิดประวัติสำหรับ PC

local RandomEnjoyTexts = {
    "Enjoy UI library?",
    "System running smoothly.",
    "Everything is up to date.",
    "Optimized for performance."
}

local OS_Themes = {
    iOS = { Corner = 16, Bg = Color3.fromRGB(245, 245, 245), Text = Color3.fromRGB(0, 0, 0), Font = Enum.Font.GothamMedium, StrokeTrans = 1 },
    Windows = { Corner = 4, Bg = Color3.fromRGB(30, 30, 30), Text = Color3.fromRGB(255, 255, 255), Font = Enum.Font.SourceSansSemibold, StrokeTrans = 0.5 },
    Samsung = { Corner = 24, Bg = Color3.fromRGB(250, 250, 250), Text = Color3.fromRGB(20, 20, 20), Font = Enum.Font.Roboto, StrokeTrans = 0.8 },
    OriginOS = { Corner = 20, Bg = Color3.fromRGB(255, 255, 255), Text = Color3.fromRGB(30, 30, 30), Font = Enum.Font.GothamBold, StrokeTrans = 0.9 },
    Modern = { Corner = 8, Bg = Color3.fromRGB(20, 20, 25), Text = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Gotham, StrokeTrans = 0.5 }
}

-- [[ Helper Function ]]
local function CreateTween(instance, properties, duration, style, direction)
    local tweenInfo = TweenInfo.new(duration or 0.3, style or Enum.EasingStyle.Quad, direction or Enum.EasingDirection.Out)
    local tween = TweenService:Create(instance, tweenInfo, properties)
    tween:Play()
    return tween
end

-- [[ 1. สร้าง GUI หลัก ]]
local NotificationGui = Instance.new("ScreenGui", CoreGui)
NotificationGui.Name = "OS_NotificationSystem"
NotificationGui.DisplayOrder = 999999
NotificationGui.ResetOnSpawn = false

local NotifyContainer = Instance.new("Frame", NotificationGui)
NotifyContainer.Size = UDim2.new(1, 0, 0, 100)
NotifyContainer.BackgroundTransparency = 1
NotifyContainer.ZIndex = 999999

-- [[ 2. สร้างหน้าต่าง Notification History (ใช้ CanvasGroup เพื่อ Anti-Lag Fading) ]]
local HistoryPanel = Instance.new("CanvasGroup", NotificationGui)
HistoryPanel.Size = UDim2.new(0, 320, 0, 450)
HistoryPanel.Position = UDim2.new(1, 50, 0.5, -225) -- ซ่อนไว้ขวาสุดจอ
HistoryPanel.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
HistoryPanel.GroupTransparency = 1 -- ซ่อนไว้
HistoryPanel.Visible = false
Instance.new("UICorner", HistoryPanel).CornerRadius = UDim.new(0, 16)

local HistoryTitle = Instance.new("TextLabel", HistoryPanel)
HistoryTitle.Size = UDim2.new(1, -20, 0, 40)
HistoryTitle.Position = UDim2.new(0, 10, 0, 10)
HistoryTitle.BackgroundTransparency = 1
HistoryTitle.Text = "Notification Center"
HistoryTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
HistoryTitle.Font = Enum.Font.GothamBold
HistoryTitle.TextSize = 16
HistoryTitle.TextXAlignment = Enum.TextXAlignment.Left

-- ปุ่ม Toggle Console ในหน้าประวัติ
local ConsoleBtn = Instance.new("TextButton", HistoryPanel)
ConsoleBtn.Size = UDim2.new(0, 80, 0, 30)
ConsoleBtn.Position = UDim2.new(1, -90, 0, 15)
ConsoleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
ConsoleBtn.Text = "Console"
ConsoleBtn.TextColor3 = Color3.fromRGB(200, 200, 255)
ConsoleBtn.Font = Enum.Font.Gotham
ConsoleBtn.TextSize = 12
Instance.new("UICorner", ConsoleBtn).CornerRadius = UDim.new(0, 6)

ConsoleBtn.MouseButton1Click:Connect(function()
    -- ใส่คำสั่งเปิด Console โค้ดของคุณตรงนี้ (เช่น เปิด DevConsole ของ Roblox)
    game:GetService("StarterGui"):SetCore("DevConsoleVisible", true)
end)

local HistoryScroll = Instance.new("ScrollingFrame", HistoryPanel)
HistoryScroll.Size = UDim2.new(1, -20, 1, -60)
HistoryScroll.Position = UDim2.new(0, 10, 0, 50)
HistoryScroll.BackgroundTransparency = 1
HistoryScroll.ScrollBarThickness = 2
HistoryScroll.BorderSizePixel = 0

local ScrollLayout = Instance.new("UIListLayout", HistoryScroll)
ScrollLayout.Padding = UDim.new(0, 10)
ScrollLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- ซิงค์ CanvasSize แบบเรียลไทม์ (Modular Canvas Sync)
ScrollLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    HistoryScroll.CanvasSize = UDim2.new(0, 0, 0, ScrollLayout.AbsoluteContentSize.Y + 10)
end)

-- [[ 3. Floating Button (สไตล์ OriginOS/Funtouch) สำหรับมือถือ ]]
local FloatingBtn = Instance.new("TextButton", NotificationGui)
FloatingBtn.Size = UDim2.new(0, 45, 0, 45)
FloatingBtn.Position = UDim2.new(1, -60, 0.5, -22)
FloatingBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
FloatingBtn.BackgroundTransparency = 0.2
FloatingBtn.Text = "🔔"
FloatingBtn.TextSize = 20
Instance.new("UICorner", FloatingBtn).CornerRadius = UDim.new(1, 0) -- เป็นวงกลม
Instance.new("UIStroke", FloatingBtn).Color = Color3.fromRGB(200, 200, 200)

local isHistoryOpen = false
local function ToggleHistory()
    isHistoryOpen = not isHistoryOpen
    if isHistoryOpen then
        HistoryPanel.Visible = true
        CreateTween(HistoryPanel, {Position = UDim2.new(1, -340, 0.5, -225), GroupTransparency = 0}, 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        CreateTween(FloatingBtn, {BackgroundTransparency = 0.8}, 0.3)
    else
        local hideTween = CreateTween(HistoryPanel, {Position = UDim2.new(1, 50, 0.5, -225), GroupTransparency = 1}, 0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
        CreateTween(FloatingBtn, {BackgroundTransparency = 0.2}, 0.3)
        task.wait(0.4)
        if not isHistoryOpen then HistoryPanel.Visible = false end
    end
end

FloatingBtn.MouseButton1Click:Connect(ToggleHistory)

-- Keybind สำหรับ PC
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == OpenHistoryKeybind then
        ToggleHistory()
    end
end)

-- [[ 4. ฟังก์ชันเพิ่มประวัติ ]]
local function AddToHistory(title, content, theme)
    local item = Instance.new("Frame", HistoryScroll)
    item.Size = UDim2.new(1, 0, 0, 60)
    item.BackgroundColor3 = theme.Bg
    item.BackgroundTransparency = 0.1
    Instance.new("UICorner", item).CornerRadius = UDim.new(0, 8)
    
    local hTitle = Instance.new("TextLabel", item)
    hTitle.Size = UDim2.new(1, -20, 0, 20)
    hTitle.Position = UDim2.new(0, 10, 0, 5)
    hTitle.BackgroundTransparency = 1
    hTitle.Text = title
    hTitle.TextColor3 = theme.Text
    hTitle.Font = theme.Font
    hTitle.TextSize = 13
    hTitle.TextXAlignment = Enum.TextXAlignment.Left

    local hDesc = Instance.new("TextLabel", item)
    hDesc.Size = UDim2.new(1, -20, 0, 30)
    hDesc.Position = UDim2.new(0, 10, 0, 25)
    hDesc.BackgroundTransparency = 1
    hDesc.Text = content
    hDesc.TextColor3 = theme.Text
    hDesc.TextTransparency = 0.2
    hDesc.Font = Enum.Font.Gotham
    hDesc.TextSize = 11
    hDesc.TextWrapped = true
    hDesc.TextXAlignment = Enum.TextXAlignment.Left
end

-- [[ 5. ฟังก์ชันแจ้งเตือนหลัก ]]
function WindowAPI:Notify(cfg)
    local theme = OS_Themes[cfg.Style or NotificationStyle] or OS_Themes.Modern
    
    local title = cfg.Title or "System"
    local content = cfg.Content or "Notification"
    local duration = cfg.Duration or 3

    -- สอดแทรกข้อความสุ่ม (ถ้าตั้งค่า UseRandomText = true)
    if cfg.UseRandomText then
        content = content .. "\n- " .. RandomEnjoyTexts[math.random(1, #RandomEnjoyTexts)]
    end

    -- บันทึกประวัติ
    table.insert(HistoryData, {Title = title, Content = content, Time = os.time()})
    AddToHistory(title, content, theme)

    -- สร้างกล่อง Notification
    local frame = Instance.new("Frame", NotifyContainer)
    frame.Size = UDim2.new(0, 300, 0, 70)
    frame.Position = UDim2.new(0.5, -150, 0, -100)
    frame.BackgroundColor3 = theme.Bg
    frame.BackgroundTransparency = 0.15 
    frame.ZIndex = 999999
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, theme.Corner)

    local stroke = Instance.new("UIStroke", frame)
    stroke.Color = Color3.fromRGB(100, 100, 110)
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
    tDesc.Size = UDim2.new(1, -20, 0, 30)
    tDesc.Position = UDim2.new(0, 15, 0, 30)
    tDesc.BackgroundTransparency = 1
    tDesc.Text = content
    tDesc.TextColor3 = theme.Text
    tDesc.TextTransparency = 0.2
    tDesc.Font = Enum.Font.Gotham
    tDesc.TextSize = 12
    tDesc.TextWrapped = true
    tDesc.TextXAlignment = Enum.TextXAlignment.Left

    -- อนิเมชั่นสไลด์ลง
    CreateTween(frame, {Position = UDim2.new(0.5, -150, 0, 20)}, 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

    task.delay(duration, function()
        CreateTween(frame, {Position = UDim2.new(0.5, -150, 0, -100), BackgroundTransparency = 1}, 0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        for _, v in pairs(frame:GetChildren()) do
            if v:IsA("TextLabel") or v:IsA("UIStroke") then
                CreateTween(v, {TextTransparency = 1, Transparency = 1}, 0.3)
            end
        end
        task.wait(0.4)
        frame:Destroy()
    end)
end

return WindowAPI
