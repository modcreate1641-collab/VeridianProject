local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

local WindowAPI = {}

local NotificationStyle = "OriginOS"
local OpenHistoryKeybind = Enum.KeyCode.Insert

local RandomEnjoyTexts = {
	"Enjoy UI library?",
	"System running smoothly.",
	"Everything is up to date."
}

local OS_Themes = {
	OriginOS = {
		Corner = 18,
		Bg = Color3.fromRGB(250, 250, 250),
		Text = Color3.fromRGB(28, 28, 30),
		SubText = Color3.fromRGB(104, 104, 110),
		Stroke = Color3.fromRGB(220, 220, 225),
		StrokeTrans = 0.72,
		BgTrans = 0,
		Overlay = 0.38
	},
	Modern = {
		Corner = 14,
		Bg = Color3.fromRGB(24, 24, 28),
		Text = Color3.fromRGB(255, 255, 255),
		SubText = Color3.fromRGB(180, 180, 180),
		Stroke = Color3.fromRGB(255, 255, 255),
		StrokeTrans = 0.84,
		BgTrans = 0.05,
		Overlay = 0.45
	}
}

local function CreateTween(instance, properties, duration, style, direction)
	local tweenInfo = TweenInfo.new(
		duration or 0.35,
		style or Enum.EasingStyle.Quart,
		direction or Enum.EasingDirection.Out
	)
	local tween = TweenService:Create(instance, tweenInfo, properties)
	tween:Play()
	return tween
end

local function MakeCorner(parent, px)
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, px or 12)
	c.Parent = parent
	return c
end

local function MakeStroke(parent, color, thickness, transparency)
	local s = Instance.new("UIStroke")
	s.Color = color or Color3.fromRGB(255, 255, 255)
	s.Thickness = thickness or 1
	s.Transparency = transparency or 0.8
	s.Parent = parent
	return s
end

local function ParentGui(gui)
	local ok = pcall(function()
		gui.Parent = CoreGui
	end)
	if not ok then
		gui.Parent = LocalPlayer:WaitForChild("PlayerGui")
	end
end

local NotificationGui = Instance.new("ScreenGui")
NotificationGui.Name = "OS_NotificationSystem"
NotificationGui.DisplayOrder = 999999
NotificationGui.ResetOnSpawn = false
NotificationGui.IgnoreGuiInset = true
ParentGui(NotificationGui)

local Root = Instance.new("Frame")
Root.Name = "Root"
Root.Size = UDim2.new(1, 0, 1, 0)
Root.BackgroundTransparency = 1
Root.BorderSizePixel = 0
Root.Parent = NotificationGui

local NotifyContainer = Instance.new("Frame")
NotifyContainer.Name = "NotifyContainer"
NotifyContainer.Size = UDim2.new(1, 0, 1, 0)
NotifyContainer.BackgroundTransparency = 1
NotifyContainer.BorderSizePixel = 0
NotifyContainer.ZIndex = 999999
NotifyContainer.Parent = Root

-- Background overlay
local ShadeBg = Instance.new("Frame")
ShadeBg.Name = "ShadeBg"
ShadeBg.Size = UDim2.new(1, 0, 1, 0)
ShadeBg.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
ShadeBg.BackgroundTransparency = 1
ShadeBg.Visible = false
ShadeBg.BorderSizePixel = 0
ShadeBg.ZIndex = 99990
ShadeBg.Parent = Root

-- History sheet
local HistorySheet = Instance.new("CanvasGroup")
HistorySheet.Name = "HistorySheet"
HistorySheet.Size = UDim2.new(1, 0, 1, 0)
HistorySheet.Position = UDim2.new(0, 0, 0, 0)
HistorySheet.BackgroundTransparency = 1
HistorySheet.GroupTransparency = 1
HistorySheet.Visible = false
HistorySheet.ZIndex = 99991
HistorySheet.Parent = Root

local HistoryCard = Instance.new("CanvasGroup")
HistoryCard.Name = "HistoryCard"
HistoryCard.AnchorPoint = Vector2.new(0.5, 0.5)
HistoryCard.Position = UDim2.new(0.5, 0, -0.45, 0)
HistoryCard.Size = UDim2.new(1, -24, 1, -24)
HistoryCard.BackgroundColor3 = OS_Themes.OriginOS.Bg
HistoryCard.BackgroundTransparency = OS_Themes.OriginOS.BgTrans
HistoryCard.GroupTransparency = 0
HistoryCard.BorderSizePixel = 0
HistoryCard.ZIndex = 99991
HistoryCard.Parent = HistorySheet

local CardSizeConstraint = Instance.new("UISizeConstraint")
CardSizeConstraint.MaxSize = Vector2.new(640, 860)
CardSizeConstraint.MinSize = Vector2.new(320, 420)
CardSizeConstraint.Parent = HistoryCard

MakeCorner(HistoryCard, OS_Themes.OriginOS.Corner)
MakeStroke(HistoryCard, OS_Themes.OriginOS.Stroke, 1, OS_Themes.OriginOS.StrokeTrans)

local CardPadding = Instance.new("UIPadding")
CardPadding.PaddingTop = UDim.new(0, 14)
CardPadding.PaddingBottom = UDim.new(0, 14)
CardPadding.PaddingLeft = UDim.new(0, 14)
CardPadding.PaddingRight = UDim.new(0, 14)
CardPadding.Parent = HistoryCard

local TopHeader = Instance.new("Frame")
TopHeader.Name = "TopHeader"
TopHeader.Size = UDim2.new(1, 0, 0, 78)
TopHeader.BackgroundTransparency = 1
TopHeader.BorderSizePixel = 0
TopHeader.ZIndex = 99992
TopHeader.Parent = HistoryCard

local HeaderDate = Instance.new("TextLabel")
HeaderDate.Size = UDim2.new(1, -120, 0, 26)
HeaderDate.Position = UDim2.new(0, 0, 0, 4)
HeaderDate.BackgroundTransparency = 1
HeaderDate.Text = os.date("%a %d %b %Y")
HeaderDate.TextColor3 = OS_Themes.OriginOS.Text
HeaderDate.Font = Enum.Font.GothamBold
HeaderDate.TextSize = 18
HeaderDate.TextXAlignment = Enum.TextXAlignment.Left
HeaderDate.ZIndex = 99993
HeaderDate.Parent = TopHeader

local HeaderSub = Instance.new("TextLabel")
HeaderSub.Size = UDim2.new(1, -120, 0, 16)
HeaderSub.Position = UDim2.new(0, 0, 0, 30)
HeaderSub.BackgroundTransparency = 1
HeaderSub.Text = "Notifications"
HeaderSub.TextColor3 = OS_Themes.OriginOS.SubText
HeaderSub.Font = Enum.Font.GothamMedium
HeaderSub.TextSize = 12
HeaderSub.TextXAlignment = Enum.TextXAlignment.Left
HeaderSub.ZIndex = 99993
HeaderSub.Parent = TopHeader

local ConsoleButton = Instance.new("TextButton")
ConsoleButton.Name = "ConsoleButton"
ConsoleButton.Size = UDim2.new(0, 84, 0, 32)
ConsoleButton.Position = UDim2.new(1, -188, 0, 8)
ConsoleButton.BackgroundColor3 = Color3.fromRGB(232, 232, 236)
ConsoleButton.TextColor3 = OS_Themes.OriginOS.Text
ConsoleButton.Font = Enum.Font.GothamMedium
ConsoleButton.TextSize = 12
ConsoleButton.Text = "Console"
ConsoleButton.AutoButtonColor = true
ConsoleButton.ZIndex = 99993
ConsoleButton.Parent = TopHeader
MakeCorner(ConsoleButton, 10)

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 32, 0, 32)
CloseButton.Position = UDim2.new(1, -40, 0, 8)
CloseButton.BackgroundColor3 = Color3.fromRGB(232, 232, 236)
CloseButton.TextColor3 = OS_Themes.OriginOS.Text
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 18
CloseButton.Text = "×"
CloseButton.AutoButtonColor = true
CloseButton.ZIndex = 99993
CloseButton.Parent = TopHeader
MakeCorner(CloseButton, 10)

local GestureBar = Instance.new("Frame")
GestureBar.Name = "GestureBar"
GestureBar.Size = UDim2.new(1, 0, 0, 44)
GestureBar.Position = UDim2.new(0, 0, 0, 0)
GestureBar.BackgroundTransparency = 1
GestureBar.BorderSizePixel = 0
GestureBar.ZIndex = 99994
GestureBar.Parent = HistoryCard

local GestureHint = Instance.new("Frame")
GestureHint.Size = UDim2.new(0, 54, 0, 5)
GestureHint.AnchorPoint = Vector2.new(0.5, 0)
GestureHint.Position = UDim2.new(0.5, 0, 0, 10)
GestureHint.BackgroundColor3 = Color3.fromRGB(180, 180, 185)
GestureHint.BackgroundTransparency = 0.2
GestureHint.BorderSizePixel = 0
GestureHint.ZIndex = 99994
GestureHint.Parent = GestureBar
MakeCorner(GestureHint, 3)

local HistoryScroll = Instance.new("ScrollingFrame")
HistoryScroll.Name = "HistoryScroll"
HistoryScroll.Size = UDim2.new(1, 0, 1, -132)
HistoryScroll.Position = UDim2.new(0, 0, 0, 88)
HistoryScroll.BackgroundTransparency = 1
HistoryScroll.BorderSizePixel = 0
HistoryScroll.ScrollBarThickness = 2
HistoryScroll.ScrollBarImageColor3 = Color3.fromRGB(170, 170, 175)
HistoryScroll.ZIndex = 99992
HistoryScroll.Parent = HistoryCard

local ScrollLayout = Instance.new("UIListLayout")
ScrollLayout.SortOrder = Enum.SortOrder.LayoutOrder
ScrollLayout.Padding = UDim.new(0, 8)
ScrollLayout.Parent = HistoryScroll

local ScrollPad = Instance.new("UIPadding")
ScrollPad.PaddingTop = UDim.new(0, 2)
ScrollPad.PaddingBottom = UDim.new(0, 20)
ScrollPad.PaddingLeft = UDim.new(0, 2)
ScrollPad.PaddingRight = UDim.new(0, 2)
ScrollPad.Parent = HistoryScroll

ScrollLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	HistoryScroll.CanvasSize = UDim2.new(0, 0, 0, ScrollLayout.AbsoluteContentSize.Y + 24)
end)

local ClearAllBtn = Instance.new("TextButton")
ClearAllBtn.Name = "ClearAllBtn"
ClearAllBtn.Size = UDim2.new(1, 0, 0, 30)
ClearAllBtn.Position = UDim2.new(0, 0, 1, -34)
ClearAllBtn.BackgroundTransparency = 1
ClearAllBtn.Text = "Clear all"
ClearAllBtn.TextColor3 = Color3.fromRGB(40, 120, 255)
ClearAllBtn.Font = Enum.Font.GothamMedium
ClearAllBtn.TextSize = 14
ClearAllBtn.TextXAlignment = Enum.TextXAlignment.Right
ClearAllBtn.ZIndex = 99993
ClearAllBtn.Parent = HistoryCard

local SimText = Instance.new("TextLabel")
SimText.Name = "SimText"
SimText.Size = UDim2.new(1, 0, 0, 18)
SimText.Position = UDim2.new(0, 0, 1, -14)
SimText.BackgroundTransparency = 1
SimText.Text = "SIM 1 Today: 0.0 B   Used this month: 0.0 B"
SimText.TextColor3 = OS_Themes.OriginOS.SubText
SimText.Font = Enum.Font.Gotham
SimText.TextSize = 11
SimText.TextXAlignment = Enum.TextXAlignment.Left
SimText.ZIndex = 99993
SimText.Parent = HistoryCard

local NotificationActive = {}
local HistoryCount = 0
local isHistoryOpen = false
local consoleCallback = nil

local function RepositionNotifications()
	local currentY = 14
	for i = #NotificationActive, 1, -1 do
		local notif = NotificationActive[i]
		if notif and notif.Parent then
			local h = notif.AbsoluteSize.Y
			if h <= 0 then
				h = 72
			end
			CreateTween(
				notif,
				{ Position = UDim2.new(0.5, 0, 0, currentY) },
				0.35,
				Enum.EasingStyle.Quart,
				Enum.EasingDirection.Out
			)
			currentY = currentY + h + 10
		end
	end
end

local function AddToHistory(title, content, theme)
	HistoryCount += 1

	local item = Instance.new("Frame")
	item.Name = "HistoryItem_" .. tostring(HistoryCount)
	item.Size = UDim2.new(1, 0, 0, 0)
	item.AutomaticSize = Enum.AutomaticSize.Y
	item.BackgroundColor3 = theme.Bg
	item.BackgroundTransparency = theme.BgTrans
	item.BorderSizePixel = 0
	item.ZIndex = 99992
	item.Parent = HistoryScroll

	MakeCorner(item, theme.Corner)
	MakeStroke(item, theme.Stroke, 1, theme.StrokeTrans)

	local pad = Instance.new("UIPadding")
	pad.PaddingTop = UDim.new(0, 10)
	pad.PaddingBottom = UDim.new(0, 12)
	pad.PaddingLeft = UDim.new(0, 14)
	pad.PaddingRight = UDim.new(0, 14)
	pad.Parent = item

	local appIcon = Instance.new("Frame")
	appIcon.Size = UDim2.new(0, 16, 0, 16)
	appIcon.Position = UDim2.new(0, 0, 0, 2)
	appIcon.BackgroundColor3 = Color3.fromRGB(0, 200, 150)
	appIcon.BorderSizePixel = 0
	appIcon.ZIndex = 99993
	appIcon.Parent = item
	MakeCorner(appIcon, 4)

	local appInfo = Instance.new("TextLabel")
	appInfo.Size = UDim2.new(1, -48, 0, 18)
	appInfo.Position = UDim2.new(0, 24, 0, 0)
	appInfo.BackgroundTransparency = 1
	appInfo.Text = "Veridian Hub • now"
	appInfo.TextColor3 = theme.SubText
	appInfo.Font = Enum.Font.Gotham
	appInfo.TextSize = 11
	appInfo.TextXAlignment = Enum.TextXAlignment.Left
	appInfo.ZIndex = 99993
	appInfo.Parent = item

	local timeLabel = Instance.new("TextLabel")
	timeLabel.Size = UDim2.new(0, 80, 0, 18)
	timeLabel.Position = UDim2.new(1, -80, 0, 0)
	timeLabel.BackgroundTransparency = 1
	timeLabel.Text = os.date("%H:%M")
	timeLabel.TextColor3 = theme.SubText
	timeLabel.Font = Enum.Font.Gotham
	timeLabel.TextSize = 11
	timeLabel.TextXAlignment = Enum.TextXAlignment.Right
	timeLabel.ZIndex = 99993
	timeLabel.Parent = item

	local hTitle = Instance.new("TextLabel")
	hTitle.Size = UDim2.new(1, 0, 0, 20)
	hTitle.Position = UDim2.new(0, 0, 0, 22)
	hTitle.BackgroundTransparency = 1
	hTitle.Text = title
	hTitle.TextColor3 = theme.Text
	hTitle.Font = Enum.Font.GothamMedium
	hTitle.TextSize = 14
	hTitle.TextXAlignment = Enum.TextXAlignment.Left
	hTitle.ZIndex = 99993
	hTitle.Parent = item

	local hDesc = Instance.new("TextLabel")
	hDesc.Size = UDim2.new(1, 0, 0, 0)
	hDesc.Position = UDim2.new(0, 0, 0, 44)
	hDesc.BackgroundTransparency = 1
	hDesc.Text = content
	hDesc.TextColor3 = theme.SubText
	hDesc.Font = Enum.Font.Gotham
	hDesc.TextSize = 13
	hDesc.TextWrapped = true
	hDesc.TextXAlignment = Enum.TextXAlignment.Left
	hDesc.AutomaticSize = Enum.AutomaticSize.Y
	hDesc.ZIndex = 99993
	hDesc.Parent = item

	task.defer(function()
		ScrollLayout:SortOrder()
		HistoryScroll.CanvasPosition = Vector2.new(0, math.max(0, HistoryScroll.CanvasSize.Y.Offset))
	end)
end

local function OpenHistory()
	if isHistoryOpen then
		return
	end
	isHistoryOpen = true

	HistorySheet.Visible = true
	ShadeBg.Visible = true

	CreateTween(ShadeBg, { BackgroundTransparency = 1 - OS_Themes[NotificationStyle].Overlay }, 0.25)
	CreateTween(HistorySheet, { GroupTransparency = 0 }, 0.25)
	CreateTween(HistoryCard, {
		Position = UDim2.new(0.5, 0, 0.5, 0)
	}, 0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
end

local function CloseHistory()
	if not isHistoryOpen then
		return
	end
	isHistoryOpen = false

	CreateTween(ShadeBg, { BackgroundTransparency = 1 }, 0.22)
	CreateTween(HistorySheet, { GroupTransparency = 1 }, 0.22)
	CreateTween(HistoryCard, {
		Position = UDim2.new(0.5, 0, -0.45, 0)
	}, 0.28, Enum.EasingStyle.Quart, Enum.EasingDirection.In)

	task.delay(0.23, function()
		if not isHistoryOpen then
			ShadeBg.Visible = false
			HistorySheet.Visible = false
		end
	end)
end

local function ToggleHistory()
	if isHistoryOpen then
		CloseHistory()
	else
		OpenHistory()
	end
end

local function DismissNotify(frame)
	if not frame or not frame.Parent then
		return
	end

	for i, v in ipairs(NotificationActive) do
		if v == frame then
			table.remove(NotificationActive, i)
			break
		end
	end

	CreateTween(
		frame,
		{ Position = UDim2.new(0.5, 0, 0, -150), GroupTransparency = 1 },
		0.25,
		Enum.EasingStyle.Quart,
		Enum.EasingDirection.In
	)

	RepositionNotifications()

	task.delay(0.26, function()
		if frame and frame.Parent then
			frame:Destroy()
		end
	end)
end

function WindowAPI:Notify(cfg)
	local theme = OS_Themes[cfg.Style or NotificationStyle] or OS_Themes.OriginOS
	local title = cfg.Title or "System"
	local content = cfg.Content or "Notification"
	local duration = cfg.Duration or 3

	if cfg.UseRandomText then
		content = content .. " - " .. RandomEnjoyTexts[math.random(1, #RandomEnjoyTexts)]
	end

	AddToHistory(title, content, theme)

	local frame = Instance.new("CanvasGroup")
	frame.Name = "NotifyCard"
	frame.Size = UDim2.new(0, 340, 0, 0)
	frame.AutomaticSize = Enum.AutomaticSize.Y
	frame.AnchorPoint = Vector2.new(0.5, 0)
	frame.Position = UDim2.new(0.5, 0, 0, -150)
	frame.BackgroundColor3 = theme.Bg
	frame.BackgroundTransparency = theme.BgTrans
	frame.BorderSizePixel = 0
	frame.GroupTransparency = 0
	frame.ZIndex = 999999
	frame.Parent = NotifyContainer

	MakeCorner(frame, theme.Corner)
	MakeStroke(frame, theme.Stroke, 1, theme.StrokeTrans)

	local pad = Instance.new("UIPadding")
	pad.PaddingTop = UDim.new(0, 10)
	pad.PaddingBottom = UDim.new(0, 12)
	pad.PaddingLeft = UDim.new(0, 14)
	pad.PaddingRight = UDim.new(0, 14)
	pad.Parent = frame

	local appIcon = Instance.new("Frame")
	appIcon.Size = UDim2.new(0, 16, 0, 16)
	appIcon.Position = UDim2.new(0, 0, 0, 2)
	appIcon.BackgroundColor3 = Color3.fromRGB(0, 200, 150)
	appIcon.BorderSizePixel = 0
	appIcon.ZIndex = 999999
	appIcon.Parent = frame
	MakeCorner(appIcon, 4)

	local appName = Instance.new("TextLabel")
	appName.Size = UDim2.new(1, -48, 0, 18)
	appName.Position = UDim2.new(0, 24, 0, 0)
	appName.BackgroundTransparency = 1
	appName.Text = "Veridian Hub • now"
	appName.TextColor3 = theme.SubText
	appName.Font = Enum.Font.Gotham
	appName.TextSize = 11
	appName.TextXAlignment = Enum.TextXAlignment.Left
	appName.ZIndex = 999999
	appName.Parent = frame

	local tTitle = Instance.new("TextLabel")
	tTitle.Size = UDim2.new(1, 0, 0, 20)
	tTitle.Position = UDim2.new(0, 0, 0, 22)
	tTitle.BackgroundTransparency = 1
	tTitle.Text = title
	tTitle.TextColor3 = theme.Text
	tTitle.Font = Enum.Font.GothamMedium
	tTitle.TextSize = 14
	tTitle.TextXAlignment = Enum.TextXAlignment.Left
	tTitle.ZIndex = 999999
	tTitle.Parent = frame

	local tDesc = Instance.new("TextLabel")
	tDesc.Size = UDim2.new(1, 0, 0, 0)
	tDesc.Position = UDim2.new(0, 0, 0, 44)
	tDesc.BackgroundTransparency = 1
	tDesc.Text = content
	tDesc.TextColor3 = theme.SubText
	tDesc.Font = Enum.Font.Gotham
	tDesc.TextSize = 13
	tDesc.TextWrapped = true
	tDesc.TextXAlignment = Enum.TextXAlignment.Left
	tDesc.AutomaticSize = Enum.AutomaticSize.Y
	tDesc.ZIndex = 999999
	tDesc.Parent = frame

	table.insert(NotificationActive, 1, frame)

	task.defer(function()
		RepositionNotifications()
	end)

	local startY = nil
	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			startY = input.Position.Y
		end
	end)

	frame.InputEnded:Connect(function(input)
		if startY and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
			if startY - input.Position.Y > 20 then
				DismissNotify(frame)
			end
			startY = nil
		end
	end)

	task.delay(duration, function()
		DismissNotify(frame)
	end)
end

function WindowAPI:ClearHistory()
	for _, child in ipairs(HistoryScroll:GetChildren()) do
		if child:IsA("Frame") or child:IsA("CanvasGroup") then
			child:Destroy()
		end
	end
end

function WindowAPI:SetConsoleCallback(fn)
	consoleCallback = fn
end

CloseButton.MouseButton1Click:Connect(function()
	CloseHistory()
end)

ConsoleButton.MouseButton1Click:Connect(function()
	if typeof(consoleCallback) == "function" then
		consoleCallback()
	end
end)

ClearAllBtn.MouseButton1Click:Connect(function()
	WindowAPI:ClearHistory()
end)

ShadeBg.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		CloseHistory()
	end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then
		return
	end

	if input.KeyCode == OpenHistoryKeybind then
		ToggleHistory()
	end
end)

local dragging = false
local dragStartY = 0
local dragFromTop = false

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then
		return
	end

	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStartY = input.Position.Y
		dragFromTop = (not isHistoryOpen and dragStartY <= 40) or (isHistoryOpen and dragStartY <= 120)
	end
end)

UserInputService.InputChanged:Connect(function(input, gameProcessed)
	if gameProcessed or not dragging or not dragFromTop then
		return
	end

	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		local deltaY = input.Position.Y - dragStartY

		if not isHistoryOpen and deltaY > 70 then
			OpenHistory()
			dragging = false
		elseif isHistoryOpen and deltaY < -70 then
			CloseHistory()
			dragging = false
		end
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
		dragFromTop = false
	end
end)

function WindowAPI:SetStyle(styleName)
	if OS_Themes[styleName] then
		NotificationStyle = styleName
		local theme = OS_Themes[styleName]

		HistoryCard.BackgroundColor3 = theme.Bg
		HistoryCard.BackgroundTransparency = theme.BgTrans

		local stroke = HistoryCard:FindFirstChildOfClass("UIStroke")
		if stroke then
			stroke.Color = theme.Stroke
			stroke.Transparency = theme.StrokeTrans
		end

		HeaderDate.TextColor3 = theme.Text
		HeaderSub.TextColor3 = theme.SubText
		ClearAllBtn.TextColor3 = Color3.fromRGB(40, 120, 255)
		SimText.TextColor3 = theme.SubText
	end
end

function WindowAPI:OpenHistory()
	OpenHistory()
end

function WindowAPI:CloseHistory()
	CloseHistory()
end

return WindowAPI