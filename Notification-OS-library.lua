local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local WindowAPI = {}

-- [[ 1. CONFIG & NEON OS THEMES ]]
local CurrentStyle = "Apple" -- ค่าเริ่มต้น (เปลี่ยนเป็น Samsung, Vivo, Xiaomi, Windows, macOS ได้)
local MAX_VISIBLE_NOTIFICATIONS = 3 -- แสดงผลบนจอพร้อมกันได้สูงสุดกี่ตัว (ที่เหลือต่อคิวรอ)

local OS_Themes = {
	Samsung = {
		Corner = 16,
		Bg = Color3.fromRGB(20, 24, 30),
		Text = Color3.fromRGB(255, 255, 255),
		SubText = Color3.fromRGB(150, 160, 175),
		NeonColor = Color3.fromRGB(50, 130, 255), -- นีออนฟ้าน้ำทะเล
		BgTrans = 0.25,
		StrokeTrans = 0.4
	},
	Apple = {
		Corner = 22,
		Bg = Color3.fromRGB(25, 25, 25),
		Text = Color3.fromRGB(255, 255, 255),
		SubText = Color3.fromRGB(170, 170, 170),
		NeonColor = Color3.fromRGB(255, 255, 255), -- นีออนขาวคลีนหรูหรา
		BgTrans = 0.3,
		StrokeTrans = 0.6
	},
	Vivo = {
		Corner = 12,
		Bg = Color3.fromRGB(15, 15, 20),
		Text = Color3.fromRGB(255, 255, 255),
		SubText = Color3.fromRGB(160, 165, 170),
		NeonColor = Color3.fromRGB(0, 220, 255), -- นีออน OriginOS ไซเบอร์
		BgTrans = 0.2,
		StrokeTrans = 0.3
	},
	Xiaomi = {
		Corner = 14,
		Bg = Color3.fromRGB(30, 30, 35),
		Text = Color3.fromRGB(255, 255, 255),
		SubText = Color3.fromRGB(180, 180, 185),
		NeonColor = Color3.fromRGB(255, 80, 0), -- นีออนส้ม HyperOS ดุดัน
		BgTrans = 0.25,
		StrokeTrans = 0.4
	},
	Windows = {
		Corner = 8, -- มินิมอลเหลี่ยมๆ สไตล์ Win11-13
		Bg = Color3.fromRGB(20, 25, 35),
		Text = Color3.fromRGB(255, 255, 255),
		SubText = Color3.fromRGB(140, 150, 165),
		NeonColor = Color3.fromRGB(0, 255, 200), -- นีออนฟลูออเรสเซนต์เซาะร่อง
		BgTrans = 0.15,
		StrokeTrans = 0.3
	},
	macOS = {
		Corner = 12,
		Bg = Color3.fromRGB(28, 28, 30),
		Text = Color3.fromRGB(255, 255, 255),
		SubText = Color3.fromRGB(155, 155, 160),
		NeonColor = Color3.fromRGB(255, 0, 130), -- นีออนชมพูตัวแม่เด่นๆ
		BgTrans = 0.3,
		StrokeTrans = 0.5
	}
}

-- [[ 2. UTILITY FUNCTIONS ]]
local function CreateTween(instance, properties, duration, style, direction)
	local tweenInfo = TweenInfo.new(duration or 0.35, style or Enum.EasingStyle.Quart, direction or Enum.EasingDirection.Out)
	local tween = TweenService:Create(instance, tweenInfo, properties)
	tween:Play()
	return tween
end

local function ParentGui(gui)
	local ok = pcall(function() gui.Parent = CoreGui end)
	if not ok then gui.Parent = LocalPlayer:WaitForChild("PlayerGui") end
end

-- [[ 3. SETUP CORE CONTAINER ]]
local NotificationGui = Instance.new("ScreenGui")
NotificationGui.Name = "OS_NeonNotificationSystem"
NotificationGui.DisplayOrder = 999999
NotificationGui.ResetOnSpawn = false
NotificationGui.IgnoreGuiInset = true
ParentGui(NotificationGui)

local NotifyContainer = Instance.new("Frame")
NotifyContainer.Name = "NotifyContainer"
NotifyContainer.Size = UDim2.new(1, 0, 1, 0)
NotifyContainer.BackgroundTransparency = 1
NotifyContainer.BorderSizePixel = 0
NotifyContainer.ZIndex = 999999
NotifyContainer.Parent = NotificationGui

-- [[ 4. QUEUE & REPOSITION SYSTEM ]]
local NotificationQueue = {}  -- คิวรอแสดงผล
local ActiveNotifications = {} -- คิวที่กำลังแสดงผลบนหน้าจอ

local function RepositionActiveNotifications()
	local currentY = 20 -- เว้นจากขอบบนจอลงมาหน่อย
	for i = 1, #ActiveNotifications do
		local card = ActiveNotifications[i]
		if card and card.Parent then
			-- สไลด์จัดตำแหน่งเรียงลงมาเป็นตับๆ
			CreateTween(card, { Position = UDim2.new(0.5, 0, 0, currentY) }, 0.3, Enum.EasingStyle.Quart)
			local height = card.AbsoluteSize.Y > 0 and card.AbsoluteSize.Y or 75
			currentY = currentY + height + 10 -- ระยะห่างระหว่างกล่อง
		end
	end
end

local function ProcessQueue()
	-- ถ้าตัวบนจอโผล่ไม่เกินโควตา และยังมีของเหลืออยู่ในคิวรอ
	if #ActiveNotifications < MAX_VISIBLE_NOTIFICATIONS and #NotificationQueue > 0 then
		local nextNotify = table.remove(NotificationQueue, 1)
		table.insert(ActiveNotifications, nextNotify.Frame)
		
		nextNotify.Frame.Parent = NotifyContainer
		RepositionActiveNotifications()
		
		-- อนิเมชั่นสไลด์ลงมาจากนอกจอแบบนุ่มนวล
		CreateTween(nextNotify.Frame, { GroupTransparency = 0 }, 0.25)
		
		-- ตั้งเวลาตายให้มันตาม Duration ที่กำหนด
		task.delay(nextNotify.Duration, function()
			-- ขากลับ สไลด์แว่บขึ้นข้างบนพร้อมจางหาย
			for i, v in ipairs(ActiveNotifications) do
				if v == nextNotify.Frame then
					table.remove(ActiveNotifications, i)
					break
				end
			end
			
			CreateTween(nextNotify.Frame, { Position = UDim2.new(0.5, 0, 0, -150), GroupTransparency = 1 }, 0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
			RepositionActiveNotifications()
			
			task.wait(0.3)
			nextNotify.Frame:Destroy()
			ProcessQueue() -- ดึงคิวต่อไปขึ้นมาทำงานทันทีสัส!
		end)
	end
end

-- [[ 5. NOTIFY CORE API ]]
function WindowAPI:Notify(cfg)
	local theme = OS_Themes[cfg.Style or CurrentStyle] or OS_Themes.Apple
	local title = cfg.Title or "System" -- ตามที่ตกลงกันไว้ หลุดมาเป็น nil ยัด System ทันทีกันเอ๋อ!
	local content = cfg.Content or "Notification Active"
	local duration = cfg.Duration or 3.5

	-- สร้างการ์ดข้อความ (CanvasGroup ตัวจบเรื่องจางใส)
	local frame = Instance.new("CanvasGroup")
	frame.Name = "NeonCard_" .. theme.NeonColor.R
	frame.Size = UDim2.new(0, 320, 0, 0)
	frame.AutomaticSize = Enum.AutomaticSize.Y
	frame.AnchorPoint = Vector2.new(0.5, 0)
	frame.Position = UDim2.new(0.5, 0, 0, -150) -- สตาร์ทนอกจอข้างบนสุด
	frame.BackgroundColor3 = theme.Bg
	frame.BackgroundTransparency = theme.BgTrans
	frame.BorderSizePixel = 0
	frame.GroupTransparency = 1 -- ซ่อนไว้ก่อน เดี๋ยวค่อยจางเข้าตอนหลุดคิว
	frame.ZIndex = 999999

	local corner = Instance.new("UICorner", frame)
	corner.CornerRadius = UDim.new(0, theme.Corner)

	-- กรอบนีออนเรืองแสงสะท้อนตาโจร
	local stroke = Instance.new("UIStroke", frame)
	stroke.Color = theme.NeonColor
	stroke.Thickness = 1.2
	stroke.Transparency = theme.StrokeTrans

	local pad = Instance.new("UIPadding", frame)
	pad.PaddingTop = UDim.new(0, 12)
	pad.PaddingBottom = UDim.new(0, 12)
	pad.PaddingLeft = UDim.new(0, 16)
	pad.PaddingRight = UDim.new(0, 16)

	-- ไอคอนจุดนีออนเล็กๆ เท่ๆ สไตล์สมาร์ทโฟน
	local neonDot = Instance.new("Frame", frame)
	neonDot.Size = UDim2.new(0, 8, 0, 8)
	neonDot.Position = UDim2.new(0, 0, 0, 5)
	neonDot.BackgroundColor3 = theme.NeonColor
	neonDot.BorderSizePixel = 0
	neonDot.ZIndex = 999999
	Instance.new("UICorner", neonDot).CornerRadius = UDim.new(1, 0)

	-- [[ หัวข้อนีออน (Title) ]]
	local tTitle = Instance.new("TextLabel", frame)
	tTitle.Size = UDim2.new(1, -20, 0, 18)
	tTitle.Position = UDim2.new(0, 16, 0, 0)
	tTitle.BackgroundTransparency = 1
	tTitle.Text = title:upper() -- ทำเป็นตัวพิมพ์ใหญ่ให้ดูขึงขังเหมือนแจ้งเตือนระบบ
	tTitle.TextColor3 = theme.Text
	tTitle.Font = Enum.Font.GothamBold
	tTitle.TextSize = 12
	tTitle.TextXAlignment = Enum.TextXAlignment.Left
	tTitle.ZIndex = 999999

	-- ตัวหนังสือนีออนเรืองแสงใต้ข้อความ (ใช้วิธีซ้อน Stroke คมๆ)
	local titleNeon = Instance.new("UIStroke", tTitle)
	titleNeon.Color = theme.NeonColor
	titleNeon.Thickness = 0.5
	titleNeon.Transparency = 0.4

	-- [[ เนื้อหา (Content) ]]
	local tDesc = Instance.new("TextLabel", frame)
	tDesc.Size = UDim2.new(1, 0, 0, 0)
	tDesc.Position = UDim2.new(0, 0, 0, 24)
	tDesc.BackgroundTransparency = 1
	tDesc.Text = content
	tDesc.TextColor3 = theme.SubText
	tDesc.Font = Enum.Font.GothamMedium
	tDesc.TextSize = 13
	tDesc.TextWrapped = true
	tDesc.TextXAlignment = Enum.TextXAlignment.Left
	tDesc.AutomaticSize = Enum.AutomaticSize.Y
	tDesc.ZIndex = 999999

	-- ปัดนิ้วสไลด์ขึ้นเพื่อลบแจ้งเตือนเองกะทันหัน (ขี้เกียจรอหมดเวลา)
	local startY = nil
	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			startY = input.Position.Y
		end
	end)

	frame.InputEnded:Connect(function(input)
		if startY and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
			if startY - input.Position.Y > 15 then -- รูดนิ้วขึ้นข้างบนเกิน 15 พิกเซล
				for i, v in ipairs(ActiveNotifications) do
					if v == frame then
						table.remove(ActiveNotifications, i)
						break
					end
				end
				CreateTween(frame, { Position = UDim2.new(0.5, 0, 0, -150), GroupTransparency = 1 }, 0.2, Enum.EasingStyle.QuartIn)
				RepositionActiveNotifications()
				task.delay(0.2, function() frame:Destroy() ProcessQueue() end)
			end
			startY = nil
		end
	end)

	-- ยัดเข้าคิวรอดำเนินการ
	table.insert(NotificationQueue, { Frame = frame, Duration = duration })
	ProcessQueue()
end

-- [[ 6. CONTROLLER API ]]
function WindowAPI:SetStyle(styleName)
	if OS_Themes[styleName] then
		CurrentStyle = styleName
	end
end

return WindowAPI
