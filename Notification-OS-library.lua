local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local WindowAPI = {}

-- ฟังก์ชัน Tween พื้นฐาน
local function CreateTween(instance, properties, duration, style, direction)
    local tweenInfo = TweenInfo.new(duration, style, direction)
    local tween = TweenService:Create(instance, tweenInfo, properties)
    tween:Play()
    return tween
end

-- [[ 1. สร้าง Container หลัก ]]
local NotificationGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
NotificationGui.Name = "OS_PullDownSystem"
NotificationGui.DisplayOrder = 999999

-- คอนเทนเนอร์สำหรับ Popup แจ้งเตือน (เด้งลงมาจากใต้ Tab นิดนึง)
local NotifyContainer = Instance.new("Frame", NotificationGui)
NotifyContainer.Size = UDim2.new(1, 0, 0, 100)
NotifyContainer.Position = UDim2.new(0, 0, 0, 25) -- ขยับลงมาหลบ Tab
NotifyContainer.BackgroundTransparency = 1
NotifyContainer.ZIndex = 999999

-- [[ 2. สร้างระบบ Pull-down OS Style (Notification Center) ]]
-- แท็บเล็กๆ สำหรับกดเปิด/ปิด ด้านบนสุด
local PullDownTab = Instance.new("TextButton", NotificationGui)
PullDownTab.Size = UDim2.new(0, 60, 0, 15)
PullDownTab.Position = UDim2.new(0.5, -30, 0, 0) -- ตรงกลางจอบนสุด
PullDownTab.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
PullDownTab.Text = "━"
PullDownTab.TextColor3 = Color3.fromRGB(150, 150, 150)
PullDownTab.AutoButtonColor = false
PullDownTab.ZIndex = 999995
Instance.new("UICorner", PullDownTab).CornerRadius = UDim.new(0, 8)

-- ตัวกรอบ Notification Center (ซ่อนไว้ด้านบนจอ)
local CenterPanel = Instance.new("Frame", NotificationGui)
CenterPanel.Size = UDim2.new(0, 320, 0, 400)
CenterPanel.Position = UDim2.new(0.5, -160, 0, -450) -- ซ่อนอยู่ข้างบน (-450)
CenterPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
CenterPanel.BackgroundTransparency = 0.1 -- ทึบขึ้นเพื่อให้อ่านง่าย
CenterPanel.BorderSizePixel = 0
CenterPanel.ZIndex = 999990
CenterPanel.ClipsDescendants = true -- **แก้ปัญหาการแจ้งเตือนล้นทะลุกรอบ**
local PanelCorner = Instance.new("UICorner", CenterPanel)
PanelCorner.CornerRadius = UDim.new(0, 16)

local PanelStroke = Instance.new("UIStroke", CenterPanel)
PanelStroke.Color = Color3.fromRGB(80, 80, 90)
PanelStroke.Thickness = 1
PanelStroke.Transparency = 0.5 -- ใช้ Transparency ถูกต้องแล้ว

-- หัวข้อใน Center
local CenterTitle = Instance.new("TextLabel", CenterPanel)
CenterTitle.Size = UDim2.new(1, -40, 0, 40)
CenterTitle.Position = UDim2.new(0, 20, 0, 10)
CenterTitle.BackgroundTransparency = 1
CenterTitle.Text = "Notification Center"
CenterTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
CenterTitle.Font = Enum.Font.GothamBold
CenterTitle.TextSize = 16
CenterTitle.TextXAlignment = Enum.TextXAlignment.Left

-- ช่อง Console ด้านล่างสุดของ Center Panel
local ConsoleContainer = Instance.new("Frame", CenterPanel)
ConsoleContainer.Size = UDim2.new(1, -20, 0, 35)
ConsoleContainer.Position = UDim2.new(0, 10, 1, -45)
ConsoleContainer.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Instance.new("UICorner", ConsoleContainer).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", ConsoleContainer).Color = Color3.fromRGB(60, 60, 70)

local ConsoleInput = Instance.new("TextBox", ConsoleContainer)
ConsoleInput.Size = UDim2.new(1, -20, 1, 0)
ConsoleInput.Position = UDim2.new(0, 10, 0, 0)
ConsoleInput.BackgroundTransparency = 1
ConsoleInput.Text = ""
ConsoleInput.PlaceholderText = "> Run command..."
ConsoleInput.TextColor3 = Color3.fromRGB(0, 255, 150)
ConsoleInput.Font = Enum.Font.Code
ConsoleInput.TextSize = 13
ConsoleInput.TextXAlignment = Enum.TextXAlignment.Left
ConsoleInput.ClearTextOnFocus = false

-- คอนเทนเนอร์เก็บรายการย้อนหลัง
local HistoryScroll = Instance.new("ScrollingFrame", CenterPanel)
HistoryScroll.Size = UDim2.new(1, -20, 1, -110)
HistoryScroll.Position = UDim2.new(0, 10, 0, 50)
HistoryScroll.BackgroundTransparency = 1
HistoryScroll.ScrollBarThickness = 3
HistoryScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
HistoryScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
HistoryScroll.ClipsDescendants = true -- **เก็บมิดแน่นอน**

local ScrollLayout = Instance.new("UIListLayout", HistoryScroll)
ScrollLayout.SortOrder = Enum.SortOrder.LayoutOrder
ScrollLayout.Padding = UDim.new(0, 6)
ScrollLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- ระบบเปิด/ปิด Center Panel
local centerOpen = false
PullDownTab.MouseButton1Click:Connect(function()
    centerOpen = not centerOpen
    if centerOpen then
        -- เลื่อนลงมา
        PullDownTab.Text = "▲"
        CreateTween(CenterPanel, {Position = UDim2.new(0.5, -160, 0, 25)}, 0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    else
        -- เลื่อนกลับขึ้นไปซ่อน
        PullDownTab.Text = "━"
        CreateTween(CenterPanel, {Position = UDim2.new(0.5, -160, 0, -450)}, 0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
    end
end)

-- Console ทำงาน
ConsoleInput.FocusLost:Connect(function(enterPressed)
    if enterPressed and ConsoleInput.Text ~= "" then
        local cmd = ConsoleInput.Text
        WindowAPI:Notify({ Title = "Console", Content = cmd, Duration = 2 })
        ConsoleInput.Text = ""
    end
end)


-- [[ 3. ฟังก์ชันแจ้งเตือนแบบอ่านง่ายขึ้น ]]
local historyCount = 0

function WindowAPI:Notify(cfg)
    local title = cfg.Title or "System"
    local content = cfg.Content or "Notification"
    local duration = cfg.Duration or 3

    -- สร้างกล่อง Notification Popup
    local frame = Instance.new("Frame", NotifyContainer)
    frame.Size = UDim2.new(0, 300, 0, 60)
    frame.Position = UDim2.new(0.5, -150, 0, -100)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35) -- ทำให้ทึบขึ้นเพื่อให้อ่านง่าย
    frame.BackgroundTransparency = 0.1 
    frame.ZIndex = 999999
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)
    Instance.new("UIStroke", frame).Color = Color3.fromRGB(80, 80, 90)

    -- เพิ่มเงาจำลอง (Drop Shadow อ่อนๆ) ให้ดูเป็น OS มากขึ้น
    local shadow = Instance.new("ImageLabel", frame)
    shadow.Size = UDim2.new(1, 20, 1, 20)
    shadow.Position = UDim2.new(0, -10, 0, -10)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://13192800046" -- Default Shadow ID
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.6
    shadow.ZIndex = frame.ZIndex - 1

    local tTitle = Instance.new("TextLabel", frame)
    tTitle.Size = UDim2.new(1, -20, 0, 20)
    tTitle.Position = UDim2.new(0, 15, 0, 8)
    tTitle.BackgroundTransparency = 1
    tTitle.Text = title
    tTitle.TextColor3 = Color3.new(1, 1, 1) -- สีขาวล้วน
    tTitle.Font = Enum.Font.GothamBold
    tTitle.TextSize = 14
    tTitle.TextXAlignment = Enum.TextXAlignment.Left

    local tDesc = Instance.new("TextLabel", frame)
    tDesc.Size = UDim2.new(1, -20, 0, 20)
    tDesc.Position = UDim2.new(0, 15, 0, 28)
    tDesc.BackgroundTransparency = 1
    tDesc.Text = content
    tDesc.TextColor3 = Color3.fromRGB(220, 220, 225) -- ทำให้สว่างขึ้นจากเดิม
    tDesc.Font = Enum.Font.GothamMedium -- เปลี่ยนจาก Gotham ธรรมดาเป็น Medium ให้อ่านง่าย
    tDesc.TextSize = 12
    tDesc.TextXAlignment = Enum.TextXAlignment.Left

    -- อนิเมชั่นสไลด์ลงมา
    CreateTween(frame, {Position = UDim2.new(0.5, -150, 0, 10)}, 0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

    -- ลบออกหลังหมดเวลา
    task.delay(duration, function()
        CreateTween(frame, {Position = UDim2.new(0.5, -150, 0, -100)}, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        task.wait(0.3)
        if frame then frame:Destroy() end
    end)

    -- [[ บันทึกลง History Panel ทันที ]]
    historyCount = historyCount + 1
    local histItem = Instance.new("Frame", HistoryScroll)
    histItem.Size = UDim2.new(1, -4, 0, 55)
    histItem.BackgroundColor3 = Color3.fromRGB(40, 40, 45) -- ทำให้ไอเทมข้างในดูเด้งขึ้นมาจากฉากหลัง
    histItem.BackgroundTransparency = 0.2
    histItem.LayoutOrder = -historyCount -- ดันอันใหม่ขึ้นบนสุด
    Instance.new("UICorner", histItem).CornerRadius = UDim.new(0, 8)

    local hTitle = tTitle:Clone()
    hTitle.Parent = histItem
    hTitle.Position = UDim2.new(0, 15, 0, 8)

    local hDesc = tDesc:Clone()
    hDesc.Parent = histItem
    hDesc.Position = UDim2.new(0, 15, 0, 28)
end

-- [[ 4. ฟังก์ชันสุ่มข้อความ ]]
local randomMessages = {
    "System memory is optimized.",
    "Bypassing security checks...",
    "Enjoying the UI Library?",
    "Welcome back, Developer."
}

function WindowAPI:RandomNotify()
    WindowAPI:Notify({
        Title = "System Log",
        Content = randomMessages[math.random(1, #randomMessages)],
        Duration = 4
    })
end

-- ทดสอบ
task.wait(1)
WindowAPI:RandomNotify()
