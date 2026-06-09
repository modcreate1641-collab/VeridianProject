local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local WindowAPI = {}
local HistoryData = {} 

-- [[ Config & สไตล์ OS ]]
local NotificationStyle = "OriginOS" 
local OpenHistoryKeybind = Enum.KeyCode.Insert 

local RandomEnjoyTexts = {
    "Enjoy UI library?",
    "System running smoothly.",
    "Everything is up to date.",
    "Optimized for performance."
}

local OS_Themes = {
    iOS = { Corner = 16, Bg = Color3.fromRGB(245, 245, 245), Text = Color3.fromRGB(10, 10, 10), Font = Enum.Font.GothamMedium, StrokeTrans = 1, BgTrans = 0.05 },
    Windows = { Corner = 4, Bg = Color3.fromRGB(30, 30, 30), Text = Color3.fromRGB(255, 255, 255), Font = Enum.Font.SourceSansSemibold, StrokeTrans = 0.5, BgTrans = 0.1 },
    Samsung = { Corner = 24, Bg = Color3.fromRGB(250, 250, 250), Text = Color3.fromRGB(20, 20, 20), Font = Enum.Font.Roboto, StrokeTrans = 0.8, BgTrans = 0.05 },
    OriginOS = { Corner = 20, Bg = Color3.fromRGB(255, 255, 255), Text = Color3.fromRGB(20, 20, 20), Font = Enum.Font.GothamBold, StrokeTrans = 0.9, BgTrans = 0.1 },
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

-- ตรวจสอบและซ่อนใน CoreGui (ป้องกันการตรวจจับ)
local success, err = pcall(function() NotificationGui.Parent = CoreGui end)
if not success then NotificationGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui") end

local NotifyContainer = Instance.new("Frame", NotificationGui)
NotifyContainer.Size = UDim2.new(1, 0, 1, 0)
NotifyContainer.BackgroundTransparency = 1
NotifyContainer.ZIndex = 999999

-- [[ 2. สร้างหน้าต่าง Notification History แบบ Dropdown (ลากจากบนลงล่าง) ]]
local HistoryPanel = Instance.new("CanvasGroup", NotificationGui)
HistoryPanel.Size = UDim2.new(0, 340, 0, 500)
HistoryPanel.Position = UDim2.new(0.5, -170, 0, -520) -- ซ่อนไว้ด้านบนสุดของจอ
HistoryPanel.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
HistoryPanel.GroupTransparency = 1
HistoryPanel.Visible = false
Instance.new("UICorner", HistoryPanel).CornerRadius = UDim.new(0, 16)

local HistoryTitle = Instance.new("TextLabel", HistoryPanel)
HistoryTitle.Size = UDim2.new(1, -20, 0, 40)
HistoryTitle.Position = UDim2.new(0, 15, 0, 15)
HistoryTitle.BackgroundTransparency = 1
HistoryTitle.Text = "Notification Center"
HistoryTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
HistoryTitle.Font = Enum.Font.GothamBold
HistoryTitle.TextSize = 18
HistoryTitle.TextXAlignment = Enum.TextXAlignment.Left

local ConsoleBtn = Instance.new("TextButton", HistoryPanel)
ConsoleBtn.Size = UDim2.new(0, 80, 0, 30)
ConsoleBtn.Position = UDim2.new(1, -95, 0, 20)
ConsoleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
ConsoleBtn.Text = "Console"
ConsoleBtn.TextColor3 = Color3.fromRGB(200, 200, 255)
ConsoleBtn.Font = Enum.Font.Gotham
ConsoleBtn.TextSize = 12
Instance.new("UICorner", ConsoleBtn).CornerRadius = UDim.new(0, 8)

ConsoleBtn.MouseButton1Click:Connect(function()
    game:GetService("StarterGui"):SetCore("DevConsoleVisible", true)
end)

local HistoryScroll = Instance.new("ScrollingFrame", HistoryPanel)
HistoryScroll.Size = UDim2.new(1, -20, 1, -80)
HistoryScroll.Position = UDim2.new(0, 10, 0, 60)
HistoryScroll.BackgroundTransparency = 1
HistoryScroll.ScrollBarThickness = 2
HistoryScroll.BorderSizePixel = 0

local ScrollLayout = Instance.new("UIListLayout", HistoryScroll)
ScrollLayout.Padding = UDim.new(0, 8)
ScrollLayout.SortOrder = Enum.SortOrder.LayoutOrder

ScrollLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    HistoryScroll.CanvasSize = UDim2.new(0, 0, 0, ScrollLayout.AbsoluteContentSize.Y + 10)
end)

-- [[ 3. Pull-down Tab (ปุ่มแท็บเล็กๆ ด้านบนสุดของจอ) ]]
local TopTabHitbox = Instance.new("TextButton", NotificationGui)
TopTabHitbox.Size = UDim2.new(0, 100, 0, 20)
TopTabHitbox.Position = UDim2.new(0.5, -50, 0, 0)
TopTabHitbox.BackgroundTransparency = 1 -- ซ่อน Hitbox ให้กดง่ายๆ
TopTabHitbox.Text = ""

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
        HistoryPanel.Visible = true
        CreateTween(HistoryPanel, {Position = UDim2.new(0.5, -170, 0, 40), GroupTransparency = 0}, 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        CreateTween(TopTabVisual, {BackgroundTransparency = 1}, 0.2)
    else
        CreateTween(HistoryPanel, {Position = UDim2.new(0.5, -170, 0, -520), GroupTransparency = 1}, 0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
        CreateTween(TopTabVisual, {BackgroundTransparency = 0.5}, 0.2)
        task.wait(0.4)
        if not isHistoryOpen then HistoryPanel.Visible = false end
    end
end

TopTabHitbox.MouseButton1Click:Connect(ToggleHistory)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == OpenHistoryKeybind then ToggleHistory() end
end)

-- [[ 4. ฟังก์ชันเพิ่มประวัติ ]]
local function AddToHistory(title, content, theme)
    local item = Instance.new("Frame", HistoryScroll)
    item.Size = UDim2.new(1, 0, 0, 65)
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
    hDesc.Size = UDim2.new(1, -20, 0, 35)
    hDesc.Position = UDim2.new(0, 10, 0, 25)
    hDesc.BackgroundTransparency = 1
    hDesc.Text = content
    hDesc.TextColor3 = theme.Text
    hDesc.TextTransparency = 0.1
    hDesc.Font = Enum.Font.Gotham
    hDesc.TextSize = 11
    hDesc.TextWrapped = true
    hDesc.TextXAlignment = Enum.TextXAlignment.Left
    hDesc.TextYAlignment = Enum.TextYAlignment.Top
end

-- [[ 5. ฟังก์ชันแจ้งเตือนหลัก ]]
local NotificationCount = 0 -- ใช้จัดคิวไม่ให้ซ้อนกัน

function WindowAPI:Notify(cfg)
    local theme = OS_Themes[cfg.Style or NotificationStyle] or OS_Themes.Modern
    local title = cfg.Title or "System"
    local content = cfg.Content or "Notification"
    local duration = cfg.Duration or 3

    if cfg.UseRandomText then
        content = content .. "\n- " .. RandomEnjoyTexts[math.random(1, #RandomEnjoyTexts)]
    end

    AddToHistory(title, content, theme)

    -- ใช้ CanvasGroup เพื่อให้การ Fade เนียนและไม่เกิด Error ยิบย่อย
    local frame = Instance.new("CanvasGroup", NotifyContainer)
    frame.Size = UDim2.new(0, 320, 0, 75)
    
    -- คำนวณตำแหน่ง Y ให้แจ้งเตือนดันลงมาเรื่อยๆ ถ้ามีหลายอัน
    local targetY = 20 + (NotificationCount * 85)
    frame.Position = UDim2.new(0.5, -160, 0, -100) -- จุดเริ่มต้น (ซ่อนด้านบน)
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

    -- อนิเมชันสไลด์ลง
    CreateTween(frame, {Position = UDim2.new(0.5, -160, 0, targetY)}, 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    NotificationCount = NotificationCount + 1

    local isDismissed = false
    local function DismissNotify()
        if isDismissed then return end
        isDismissed = true
        NotificationCount = math.max(0, NotificationCount - 1)
        
        -- ปัดขึ้นแล้วเฟดหายไป
        CreateTween(frame, {Position = UDim2.new(0.5, -160, 0, frame.Position.Y.Offset - 100), GroupTransparency = 1}, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        task.wait(0.3)
        frame:Destroy()
    end

    -- [[ Custom Logic: Swipe Up to Dismiss ]]
    local startY = 0
    local dragging = false

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            startY = input.Position.Y
        end
    end)

    frame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
            -- ถ้าลากนิ้ว/เมาส์ขึ้นเกิน 15 Pixel ให้ปัดทิ้งเลย
            if startY - input.Position.Y > 15 then
                DismissNotify()
            end
        end
    end)

    -- สั่งลบตัวเองออกหลังหมดเวลา (ถ้ายังไม่ได้ถูกปัดทิ้ง)
    task.delay(duration, function()
        DismissNotify()
    end)
end

return WindowAPI
