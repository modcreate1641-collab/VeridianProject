local folderName = "furlogo"
local fileName = folderName .. "/mascot_clean.png"
local imageUrl = "https://raw.githubusercontent.com/modcreate1641-collab/Veridian/refs/heads/main/1000109193-01.jpeg"

if not isfolder(folderName) then makefolder(folderName) end
if not isfile(fileName) then
    local s, content = pcall(game.HttpGet, game, imageUrl)
    if s and #content > 5000 then writefile(fileName, content) end
end

local function ToRawURL(url)
    if type(url) ~= "string" then return url end
    if url:find("github.com") and not url:find("raw.githubusercontent.com") then
        url = url:gsub("github.com", "raw.githubusercontent.com")
        url = url:gsub("/blob/", "/")
    end
    return url
end

local function SafeExecuteURL(url)
    local targetURL = ToRawURL(url)
    local success, result = pcall(function()
        return game:HttpGet(targetURL)
    end)
    if success then
        local func, err = loadstring(result)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Parse Error: " .. tostring(err)) 
        end
    else
        warn("Fetch Error: " .. tostring(result))
    end
end

local SuccessNotify, NeonNotify = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/modcreate1641-collab/VeridianProject/refs/heads/main/Notification-OS-library.lua"))()
end)

local Success, VeridianLibrary = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/modcreate1641-collab/VeridianProject/refs/heads/main/Tester.lua"))()
end)

if not Success or type(VeridianLibrary) ~= "table" then 
    return warn("❌ โหลด UI Library ไม่ขึ้น หรือลิงก์ตายวะเนี่ย!") 
end

local Window = VeridianLibrary:CreateWindow({  
    Name = "VeridianHub",  
    loadscreen = true,
    Logo = "https://raw.githubusercontent.com/modcreate1641-collab/Fluffy/refs/heads/main/1779757802572.png",  
    Discord = "https://discord.gg/WKWDuYMVRN"
})  

Window:CreateTab("💎 Credits", function(p)
    local layout = p:FindFirstChildOfClass("UIListLayout") or Instance.new("UIListLayout", p)
    layout.Padding = UDim.new(0, 10)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

    local Mascot = Instance.new("ImageLabel", p)
    Mascot.Size = UDim2.new(0.9, 0, 0, 220)
    Mascot.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    if isfile(fileName) then Mascot.Image = getcustomasset(fileName) end
    Mascot.ScaleType = Enum.ScaleType.Fit
    Mascot.ZIndex = 15
    Instance.new("UICorner", Mascot).CornerRadius = UDim.new(0, 10)

    local info = Instance.new("TextLabel", p)
    info.Size = UDim2.new(0.95, 0, 0, 50)
    info.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    info.Text = "Veridian Hub | Dev: EllenGroqAI"
    info.TextColor3 = Color3.new(1, 1, 1)
    info.Font = Enum.Font.GothamBold
    info.TextSize = 18
    info.ZIndex = 15
    Instance.new("UICorner", info)
end, true)

-----------------------------------------------------------------------
-- 🎹 แท็บรวมสคริปต์ Auto Piano จากไฟล์ TXT (Clean & Compact)
-----------------------------------------------------------------------
local PianoTab = Window:CreateTab("🎹 Auto Piano")
PianoTab:CreateLabel("📄 สคริปต์เพลงที่รวมมาจากไฟล์ TXT")


PianoTab:CreateButton({
    Name = "🎵  Mesmerizer",
    Callback = function()
        local scriptCode = "bpm = 178  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/30d5743f57097875bbc8ddfc4a84182d/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in  Mesmerizer: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 A World of Nightmares",
    Callback = function()
        local scriptCode = "bpm = 171  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/0c72104590ce4dc592386b84276cb65e/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in A World of Nightmares: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 blue",
    Callback = function()
        local scriptCode = "bpm = 97  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/880c90d51ca01da62554c77188011f84/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in blue: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Brain Power",
    Callback = function()
        local scriptCode = "bpm = 170  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/61eea1da483c22fff8c041261c1f00ae/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Brain Power: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Caramelldansen",
    Callback = function()
        local scriptCode = "bpm = 160  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/6d27044cc6aad5c9225091c55179cb1c/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Caramelldansen: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 War Thunder",
    Callback = function()
        local scriptCode = "bpm = 115  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/5db5e2664d9fbcf6828cce39c25ca6ae/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in War Thunder: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Constant Moderato",
    Callback = function()
        local scriptCode = "bpm = 112  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/77bdff67457d10dc4031ab2d5531b4f8/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Constant Moderato: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Counting Stars",
    Callback = function()
        local scriptCode = "bpm = 115  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/c910f570c1ce02a45cdb73f9969c72e3/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Counting Stars: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 DESIRE-tony ann",
    Callback = function()
        local scriptCode = "bpm = 130  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/f9bbdf9246d5132a03efc1dacc0291a1/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in DESIRE-tony ann: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Despacito",
    Callback = function()
        local scriptCode = "bpm = 89  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/71c8d171025799619bb47001a3e5982c/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Despacito: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 devourer of gods",
    Callback = function()
        local scriptCode = "bpm = 190  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/5d7c6f6ea56f303702da4d88fd400c8d/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in devourer of gods: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 DNA",
    Callback = function()
        local scriptCode = "bpm = 150  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/bb09492e926f4c176ccf21920c09ed83/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in DNA: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Experience Flows in You – Tony Ann",
    Callback = function()
        local scriptCode = "bpm = 85  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/fe4df12c7eae969d663fa0dbd4c20813/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Experience Flows in You – Tony Ann: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Experience the Rain – Tony Ann",
    Callback = function()
        local scriptCode = "bpm = 77  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/54c8437ee4b55e2aaa67d0ad154feca7/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Experience the Rain – Tony Ann: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Fabulous beasts themes(furry music)",
    Callback = function()
        local scriptCode = "bpm = 142  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/179effe944af492e00f1f715157b8095/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Fabulous beasts themes(furry music): " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Field of Memories",
    Callback = function()
        local scriptCode = "bpm = 130  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/3e2052ce28f78b5e084e803513f77f0e/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Field of Memories: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 First_Song",
    Callback = function()
        local scriptCode = "bpm = 120  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/ba605089a84c89691ff8fb664d032b14/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in First_Song: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 ICARUS-Interstellar",
    Callback = function()
        local scriptCode = "bpm = 100  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/320d0e986f37232ef8eacb11fbdef30d/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in ICARUS-Interstellar: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 fly away me",
    Callback = function()
        local scriptCode = "bpm = 148  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/ba3198d62534805dbf48a6bb32bfc608/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in fly away me: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Frieren OST - Zoltraak",
    Callback = function()
        local scriptCode = "bpm = 142  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/49143f18d11bbc93b1916e45343a982b/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Frieren OST - Zoltraak: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 happy birthday beginner",
    Callback = function()
        local scriptCode = "bpm = 120  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/0a0111e681a9b05159a8432a170676c9/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in happy birthday beginner: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 iPhone Alarm as a Piano Ballad",
    Callback = function()
        local scriptCode = "bpm = 139  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/2a56ccf77beb688286f0f8771f6f45ee/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in iPhone Alarm as a Piano Ballad: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 ISpyWithMyLittleEye",
    Callback = function()
        local scriptCode = "bpm = 50  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/9fed0758ef4f4ab7215a5e6e0a5dde3e/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in ISpyWithMyLittleEye: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Jim Yosef - Eclipse",
    Callback = function()
        local scriptCode = "bpm = 125  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/63c3d285840fa97ad1941bf9b25f805c/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Jim Yosef - Eclipse: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Jim Yosef - flyfire",
    Callback = function()
        local scriptCode = "bpm = 130  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/ff3815c353e009c8043f12484ae08b38/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Jim Yosef - flyfire: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Jim Yosef - Lights",
    Callback = function()
        local scriptCode = "bpm = 128  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/a9c6d937f081b1b353070d5e6d3cf9ba/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Jim Yosef - Lights: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Jim Yosef link",
    Callback = function()
        local scriptCode = "bpm = 120  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/ade591f393876914d2a0ace212df8f7a/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Jim Yosef link: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 jjd sky high",
    Callback = function()
        local scriptCode = "bpm = 130  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/3022a028b3aafc4bdc61f2c408929a43/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in jjd sky high: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 KATYUSHA",
    Callback = function()
        local scriptCode = "bpm = 120  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/9679555b4ff5ff3f938ff1e0204eaa52/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in KATYUSHA: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Sad Song - We The Kings",
    Callback = function()
        local scriptCode = "bpm = 90  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/7cac1ef2a08ddafd636cb3fa83c5b26b/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Sad Song - We The Kings: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Konton Boogie",
    Callback = function()
        local scriptCode = "bpm = 190  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/724897ff473af74719bae5a509198cbe/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Konton Boogie: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Love Story",
    Callback = function()
        local scriptCode = "bpm = 190  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/6daf66b079bd88b0b77688aebe4cc680/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Love Story: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Love Story x Golden Brown",
    Callback = function()
        local scriptCode = "bpm = 120  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/06a9d60a450654c5656b33650add2e77/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Love Story x Golden Brown: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 low cortisol",
    Callback = function()
        local scriptCode = "bpm = 120  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/618de5ea15c82896ca090b9fe192b086/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in low cortisol: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Luminous Memory",
    Callback = function()
        local scriptCode = "bpm = 100  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/301b4bd24d65eb07df57292b1d2c0469/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Luminous Memory: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Meme Medley",
    Callback = function()
        local scriptCode = "bpm = 180  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/838300197ee04397f28e9e1a75453844/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Meme Medley: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Mesmerizer – 32ki",
    Callback = function()
        local scriptCode = "bpm = 185  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/f889ac5e1b241251ba5b29b463dcdc46/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Mesmerizer – 32ki: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Midu Folksnog",
    Callback = function()
        local scriptCode = "bpm = 130  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/e9ac50aff5d65bd1cccc72be79147cc8/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Midu Folksnog: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 MONTAGEM HIKARI",
    Callback = function()
        local scriptCode = "bpm = 130  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/6a9b0572a978f907c8f5410db9a5a67f/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in MONTAGEM HIKARI: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Montagem Miau",
    Callback = function()
        local scriptCode = "bpm = 130  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/a97612eb296449b1a5e3a47a907d9614/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Montagem Miau: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Moonstellar – Tony Ann",
    Callback = function()
        local scriptCode = "bpm = 160  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/41a8d674cc0f1898025633db61259ae8/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Moonstellar – Tony Ann: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Murder on My Mind",
    Callback = function()
        local scriptCode = "bpm = 57  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/380d5fb4eab54f366fbaa6f4b725d488/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Murder on My Mind: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 My neighbour's car alarm",
    Callback = function()
        local scriptCode = "bpm = 87  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/3805dde7ffcee003eefa339b31becd6c/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in My neighbour's car alarm: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 neko",
    Callback = function()
        local scriptCode = "bpm = 77  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/738d2942b2ca1f34e03b49380234f2c4/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in neko: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Interstellar - Cornfield Chase",
    Callback = function()
        local scriptCode = "bpm = 80  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/b9ff708848274b8a03f34073142d271c/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Interstellar - Cornfield Chase: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Touhou U.N. Owen Was Her",
    Callback = function()
        local scriptCode = "bpm = 170  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/33e1043a714799f104250f81faca4109/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Touhou U.N. Owen Was Her: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 No Game No Life OP - This Game ",
    Callback = function()
        local scriptCode = "bpm = 142  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/00e737fa31466fbbb116641f933bcf52/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in No Game No Life OP - This Game : " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Nyan Cat",
    Callback = function()
        local scriptCode = "bpm = 140  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/e38bb342213abfde6ae7b04e1c9ff11b/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Nyan Cat: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 pi the song",
    Callback = function()
        local scriptCode = "https://pastebin.com/raw/6kac0XSz"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in pi the song: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Prezioso - Thunder",
    Callback = function()
        local scriptCode = "bpm = 200  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/acb6a285556042d2dc1d06b3b8290c15/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Prezioso - Thunder: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Re Aoharu",
    Callback = function()
        local scriptCode = "bpm = 87  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/9e9666ec71364410588e2a6740fb341b/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Re Aoharu: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Last Sahur ",
    Callback = function()
        local scriptCode = "bpm = 180  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/7552ce9b34ef355cd3a259a874896002/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Last Sahur : " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Senbonzakura",
    Callback = function()
        local scriptCode = "bpm = 154  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/67988ae778fa8e6216364b55b26b277d/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Senbonzakura: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 sky high 2",
    Callback = function()
        local scriptCode = "bpm = 128  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/eead5168abb6a02d793830bc0e41bdd7/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in sky high 2: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Sky High – Elektronomia advance",
    Callback = function()
        local scriptCode = "bpm = 128  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/687f401eb1fe4001b77c67943b55dc29/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Sky High – Elektronomia advance: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Sky High – Elektronomia normal version",
    Callback = function()
        local scriptCode = "bpm = 128  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/65d3397b57cf70a9e92202ac87e46452/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Sky High – Elektronomia normal version: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Sneaky Snitch",
    Callback = function()
        local scriptCode = "bpm = 180  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/4f946343822868ae8653e1196c8bdb80/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Sneaky Snitch: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Soviet March",
    Callback = function()
        local scriptCode = "bpm = 120  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/6d4d66f27c7a673b45d5e907ddc2bceb/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Soviet March: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 subject 3 一笑江湖",
    Callback = function()
        local scriptCode = "bpm = 120  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/85787ce3dd178e9fe86d27fd269461a6/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in subject 3 一笑江湖: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 summertime 2018",
    Callback = function()
        local scriptCode = "bpm = 100  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/12e836e8da53983a52066c818252687b/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in summertime 2018: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Target for Love ",
    Callback = function()
        local scriptCode = "bpm = 103  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/fc8601258ccb2a46ba1cc97219eac04c/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Target for Love : " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Tetris Theme",
    Callback = function()
        local scriptCode = "bpm = 150  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/9cb208e443337a8f9e68bbc4c79e8216/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Tetris Theme: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Thai National Anthem",
    Callback = function()
        local scriptCode = "bpm = 100  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/02ed0ebcdcbcb029c5c2eb253d1951b8/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Thai National Anthem: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 The Interstellar Experience",
    Callback = function()
        local scriptCode = "bpm = 99  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/a5ba14d03d3fa6eb5437a097489145ac/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in The Interstellar Experience: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Through Patches of Violet hacklord",
    Callback = function()
        local scriptCode = "bpm = 120  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/22aea70fb22bc86ae1a1034e53d7099e/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Through Patches of Violet hacklord: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Time – Tony Ann",
    Callback = function()
        local scriptCode = "bpm = 289  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/ab487181e01793aa0d1a268cf48a095b/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Time – Tony Ann: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 tony ann awakening",
    Callback = function()
        local scriptCode = "bpm = 130  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/87aee0e9c501343a8b6dac71eded1254/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in tony ann awakening: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 すずめ",
    Callback = function()
        local scriptCode = "bpm = 120  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/f26c137d3b91f61709d918889b3ac103/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in すずめ: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Took Her To The O",
    Callback = function()
        local scriptCode = "bpm = 80  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/b030bf38b774607cde03bf39ffb2f350/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Took Her To The O: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Trap Royalty (Trap Queen - Fetty Wap Royalty Remix)",
    Callback = function()
        local scriptCode = "bpm = 151  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/6769559ce4026e3d19e959050e99244d/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Trap Royalty (Trap Queen - Fetty Wap Royalty Remix): " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 universe collapse",
    Callback = function()
        local scriptCode = "bpm = 100  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/47494099c2b4450c8f88fed1e87641aa/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in universe collapse: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Boom, boom, boom, boom!! – Vengaboys",
    Callback = function()
        local scriptCode = "bpm = 120  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/4a83c13c4c223a161ec1e92c8a69a71c/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Boom, boom, boom, boom!! – Vengaboys: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 tau-HDSG",
    Callback = function()
        local scriptCode = "bpm = 120  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/8e44816a17bb9b2c841cc4066ecb3289/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in tau-HDSG: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 tau the song",
    Callback = function()
        local scriptCode = "bpm = 70  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/67a76ef4482b96ade374bc7d6c487bd4/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in tau the song: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 OMFG - Hello",
    Callback = function()
        local scriptCode = "bpm = 104  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/516dbe30d1192b69a70ecaed9048417e/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in OMFG - Hello: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Sweet little Bumblebee",
    Callback = function()
        local scriptCode = "bpm = 166  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/42ac52d2f6be7e25980f2221eb6bc0e8/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Sweet little Bumblebee: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 HEAVENLY JUMPSTYLE",
    Callback = function()
        local scriptCode = "bpm = 130  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/043462a3dbb63a8c822c8f9d798939ab/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in HEAVENLY JUMPSTYLE: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 bumblebee - bambee",
    Callback = function()
        local scriptCode = "bpm = 166  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/592394a064a0d6afb547b562b3430b2c/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in bumblebee - bambee: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 rush e",
    Callback = function()
        local scriptCode = "bpm = 160  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/c308d092479806259e14ce8ce1eb9d58/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in rush e: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Rush E – Sheet Music Boss",
    Callback = function()
        local scriptCode = "bpm = 120  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/da88d2b5e6857583290e655ece2e1607/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Rush E – Sheet Music Boss: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 golden hour ",
    Callback = function()
        local scriptCode = "bpm = 96  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/9c3063709ffa9093a904e269027b6366/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in golden hour : " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 runaway ",
    Callback = function()
        local scriptCode = "bpm = 160  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/5c3fd3e0f651408b0c01c982e42bf198/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in runaway : " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 red zone 2",
    Callback = function()
        local scriptCode = "bpm = 139  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/4c5c33d4264ae62006b93d6e14304445/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in red zone 2: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 the wolf",
    Callback = function()
        local scriptCode = "bpm = 96  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/d6fa458e68ee64a4dde0357c4caf5022/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in the wolf: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 kiss me again ",
    Callback = function()
        local scriptCode = "bpm = 167  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/73562b5770fcae9016f15461870e286e/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in kiss me again : " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 VEM NO PIQUE",
    Callback = function()
        local scriptCode = "bpm = 60  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/876ae0a92f86c44c29c31b0d6b34e2b0/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in VEM NO PIQUE: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 ICARUS – Tony Ann",
    Callback = function()
        local scriptCode = "bpm = 100  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/02b3b266547ad6d0d901f7799e7ddb06/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in ICARUS – Tony Ann: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Tobu - Infectious",
    Callback = function()
        local scriptCode = "https://pastebin.com/raw/kGv7Budf"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Tobu - Infectious: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Another Love",
    Callback = function()
        local scriptCode = "bpm = 120  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/525b0dd3163527ccce8e422f05cbc22d/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Another Love: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 furry",
    Callback = function()
        local scriptCode = "bpm = 139  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/ad6dc994f1ff92be6f1b29dcf06c71a7/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in furry: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Touhou Flowering Night",
    Callback = function()
        local scriptCode = "bpm = 153  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/d6f3910df72e3455e444053b11326aa2/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Touhou Flowering Night: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 สดุดีจอมราชา",
    Callback = function()
        local scriptCode = "bpm = 120  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/f03e771a73db19279e15fc3e38ce020e/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in สดุดีจอมราชา: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Touhou Night of Night",
    Callback = function()
        local scriptCode = "bpm = 180  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/3e5b718df0d6f04c58e6f94c1b2a30a5/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Touhou Night of Night: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Touhou Voile, the Magic Library",
    Callback = function()
        local scriptCode = "bpm = 140  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/c372626be380287abf363db60133410d/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Touhou Voile, the Magic Library: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Touhou-Lunar Clock ~ Luna Dial",
    Callback = function()
        local scriptCode = "bpm = 120  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/31d65e869cf221a5d3e9193311f1e22a/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Touhou-Lunar Clock ~ Luna Dial: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Erika - Herms Niel",
    Callback = function()
        local scriptCode = "bpm = 240  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/89dc24bd462f1bf1084b591dabfb63bd/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Erika - Herms Niel: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 moonlight sonata 3rd movement",
    Callback = function()
        local scriptCode = "bpm = 170  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/2cdd6245515ac4335ef5fc8ac7cc1891/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in moonlight sonata 3rd movement: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Experience - Ludovico Enaudi",
    Callback = function()
        local scriptCode = "bpm = 92  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/0a2464cee6275fe7c89721109199d5cd/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Experience - Ludovico Enaudi: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 RUSH PIGGIES ",
    Callback = function()
        local scriptCode = "bpm = 200  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/ec77b332be1c192c7c66c4561e927754/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in RUSH PIGGIES : " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Rokudenashi-one voice",
    Callback = function()
        local scriptCode = "bpm = 129  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/811e18b1c36d5697c991366caf9fe0e6/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Rokudenashi-one voice: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Nevada – Vicetone Nevada",
    Callback = function()
        local scriptCode = "bpm = 120  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/5df0f83b4312a64e18dad589fa6584e4/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Nevada – Vicetone Nevada: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Rokudenashi-Ambiguous",
    Callback = function()
        local scriptCode = "bpm = 92  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/795089f56530528c0f88e291e02b379e/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Rokudenashi-Ambiguous: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Rokudenashi-The Flame of Love",
    Callback = function()
        local scriptCode = "bpm = 88  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/5fb342cf65ac7fa07b9ffde033903f52/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Rokudenashi-The Flame of Love: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Rokudenashi-Spica",
    Callback = function()
        local scriptCode = "bpm = 136  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/61f67ff39bbca332f6d1fea8ac32cb8b/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Rokudenashi-Spica: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Rokudenashi-Starry silent night ",
    Callback = function()
        local scriptCode = "bpm = 166  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/eee396b8e1df0a1b5e5fe4763f19364b/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Rokudenashi-Starry silent night : " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Victory (Battlecry) Two Steps From Hell",
    Callback = function()
        local scriptCode = "bpm = 128  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/194dcb6c34ab95ab5dce2f4a3567d73f/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Victory (Battlecry) Two Steps From Hell: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Alan Walker - Fade",
    Callback = function()
        local scriptCode = "bpm = 90  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/a5cfbd405f0465fcd8510283cf97d7c8/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Alan Walker - Fade: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Alan Walker - Spectre",
    Callback = function()
        local scriptCode = "bpm = 128  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/c24c26f3351939e00d88a18d597d7297/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Alan Walker - Spectre: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Numbers – Temporex",
    Callback = function()
        local scriptCode = "bpm = 96  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/291bab28f41eb32e2912aac28d8c64bc/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Numbers – Temporex: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 two steps from hell star sky",
    Callback = function()
        local scriptCode = "bpm = 130  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/98e4fbcfc01ce5582c17d7d790aec084/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in two steps from hell star sky: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Execution Clap (Kasane Teto)",
    Callback = function()
        local scriptCode = "bpm = 137  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/b8eb2edaf204ac65e6eb3bbd4dac475b/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Execution Clap (Kasane Teto): " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 tau the song- HDSG ",
    Callback = function()
        local scriptCode = "bpm = 60  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/1fe4ecf33cfa1ffbfaae4be1c6a5039c/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in tau the song- HDSG : " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Angel With A Shotgun – Ericovich",
    Callback = function()
        local scriptCode = "bpm = 120  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/5cf60712f400306e435b3d1d4296a6a4/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Angel With A Shotgun – Ericovich: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 ใจผูกเจ็บ - Heartrocker ft ToNy_gospel",
    Callback = function()
        local scriptCode = "bpm = 105  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/0d143479223546677ad998cee48c90e3/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in ใจผูกเจ็บ - Heartrocker ft ToNy_gospel: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Pirates of the Moonlight – Tony Ann",
    Callback = function()
        local scriptCode = "bpm = 57  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/df1e8337860f8ed4436c413a78ca59e0/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Pirates of the Moonlight – Tony Ann: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 The chase – Tony Ann",
    Callback = function()
        local scriptCode = "bpm = 112  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/bdee25fff655f321757fbac876f76fef/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in The chase – Tony Ann: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Rush Of Life – Tony Ann",
    Callback = function()
        local scriptCode = "bpm = 120  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/736f416c5e177421fca7dd510b39f41b/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Rush Of Life – Tony Ann: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Moonlight Sonata 1st movement",
    Callback = function()
        local scriptCode = "bpm = 51  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/fa4b54c090ea53dfdfc3ecd5df4227f7/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Moonlight Sonata 1st movement: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 two step from hell never back down",
    Callback = function()
        local scriptCode = "bpm = 118  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/f2051d275d91647ad71802608ae2df42/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in two step from hell never back down: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Cry For Me – Ironmouse playable ver",
    Callback = function()
        local scriptCode = "bpm = 124  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/cbfcaea5a175b0be4a34f9c7aab56c7d/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Cry For Me – Ironmouse playable ver: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 indihome paket phoenix",
    Callback = function()
        local scriptCode = "bpm = 130  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/d3ad6046d2ac77cb54967b7838009365/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in indihome paket phoenix: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 what the hell",
    Callback = function()
        local scriptCode = "bpm = 140  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/459d107cddb6205b87f8e67419d22c0a/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in what the hell: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Tom and Jerry Theme",
    Callback = function()
        local scriptCode = "bpm = 165  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/9925ec6ce99991883b2d9a8dd4e32ef5/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Tom and Jerry Theme: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Blue Archive Theme 87+1 Our Story -constant - Torisu Firma",
    Callback = function()
        local scriptCode = "bpm = 90  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/36092da770429a424e42b96458f1b670/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Blue Archive Theme 87+1 Our Story -constant - Torisu Firma: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Blue Archive-Luminous Memory",
    Callback = function()
        local scriptCode = "bpm = 100  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/301b4bd24d65eb07df57292b1d2c0469/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Blue Archive-Luminous Memory: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 music using only sounds from windows xp and 98",
    Callback = function()
        local scriptCode = "bpm = 115  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/245bbd6f3a37b4dedf97ebbae049f52f/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in music using only sounds from windows xp and 98: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 辞九门回忆_–_银监;林伟",
    Callback = function()
        local scriptCode = "https://pastebin.com/raw/B1WAdxYZ"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in 辞九门回忆_–_银监;林伟: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 SHAUN - Way Back Home",
    Callback = function()
        local scriptCode = "bpm = 120  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/52effb41aba4663f8a14052c8689511b/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in SHAUN - Way Back Home: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Carol of the Bells - Piano Version – Tony Ann",
    Callback = function()
        local scriptCode = "bpm = 100  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/17ec1bb0f5761cd111a62504a9ad8d94/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Carol of the Bells - Piano Version – Tony Ann: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Ed Sheeran-Shape of you",
    Callback = function()
        local scriptCode = "bpm = 190  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/0e2b69f3a0a5c1d7be374da1c769f980/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Ed Sheeran-Shape of you: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Sunroof – Nicky Youre",
    Callback = function()
        local scriptCode = "bpm = 131  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/eb6d1b2b936523a466c15c0936260a51/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Sunroof – Nicky Youre: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Blue Archive-Constant Moderato",
    Callback = function()
        local scriptCode = "bpm = 112  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/77bdff67457d10dc4031ab2d5531b4f8/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Blue Archive-Constant Moderato: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Blue Archive-Re Aoharu",
    Callback = function()
        local scriptCode = "bpm = 87  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/9e9666ec71364410588e2a6740fb341b/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Blue Archive-Re Aoharu: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 unify",
    Callback = function()
        local scriptCode = "bpm = 150  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/9f985a1841969fe7aeb8ff41f50e9011/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in unify: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Starset My Demons",
    Callback = function()
        local scriptCode = "bpm = 90  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/13436044b8b1af40384437e59a4bafca/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Starset My Demons: " .. tostring(err)) 
        end
    end
})

PianoTab:CreateButton({
    Name = "🎵 Tornado Season Theme",
    Callback = function()
        local scriptCode = "bpm = 120  loadstring(game:HttpGet(\"https://hellohellohell0.com/talentless-raw/loader_main.lua\", true))()  loadstring(game:HttpGet(\"https://gist.githack.com/talentless-custom-songs/752e7ab16d84a0892ed5136a2eba0a8f/raw/custom_song.lua\", true))()"
        local func, err = loadstring(scriptCode)
        if func then 
            task.spawn(func) 
        else 
            warn("Lua Error in Tornado Season Theme: " .. tostring(err)) 
        end
    end
})


-----------------------------------------------------------------------
-- Standard Scripts Tab
-----------------------------------------------------------------------
local StandardScripts = {
    {Name = "MUSIC PLAYER", URL = "https://pastebin.com/raw/e5K8UiTz"},
    {Name = "CUSTOM INVENTORY", URL = "https://pastebin.com/raw/bjcHd25N"},
    {Name = "CIRCLE WHEEL MENU", URL = "https://pastebin.com/raw/ePjZRMUa"},
    {Name = "FE R6 DASH AND S-JUMP", URL = "https://raw.githubusercontent.com/modcreate1641-collab/Veridian/refs/heads/main/Main.lua"}
}

local ScriptTab = Window:CreateTab("🐾 Standard Script")
for _, s in pairs(StandardScripts) do
    ScriptTab:CreateButton({
        Name = "⭐ " .. s.Name,
        Callback = function()
            SafeExecuteURL(s.URL)
        end
    })
end

-----------------------------------------------------------------------
-- Piano Crasher & Utilities Tab
-----------------------------------------------------------------------
local CrashTab = Window:CreateTab("▶ Piano Crasher")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local plr = Players.LocalPlayer
local pianoRemote = game:GetService("Workspace"):FindFirstChild("GlobalPianoConnector")

if not pianoRemote and SuccessNotify then
    NeonNotify({
        Title = "Error!",
        Content = "Piano remote not found! Either patched or you didn't join the right game.",
        Duration = 10
    })
end

_G.crash = false
_G.fling = false
local flinging = false
local flingDied

CrashTab:CreateLabel("Ctrl + Shift + F7 to see ping!")

CrashTab:CreateToggle({
    Name = "Crash Everyone (Server Too)",
    CurrentValue = false,
    Callback = function(Value)
        _G.crash = Value
        if Value then
            if plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Sit then
                if SuccessNotify then
                    NeonNotify({
                        Title = "Enabled!",
                        Content = "The server will get laggier and people will freeze!",
                        Duration = 5
                    })
                end
            else
                if SuccessNotify then
                    NeonNotify({
                        Title = "Error!",
                        Content = "You must sit behind a piano to use this!",
                        Duration = 2.5
                    })
                end
                _G.crash = false
                return
            end
            
            while _G.crash do
                for i = 1, 61 do
                    if pianoRemote then pianoRemote:FireServer("play", i) end
                end
                task.wait()
            end
            
            if pianoRemote then pianoRemote:FireServer("abort") end
            
            if SuccessNotify then
                NeonNotify({
                    Title = "Disabled!",
                    Content = "Hope you had fun using it ;)",
                    Duration = 2.5
                })
            end
        end
    end
})

CrashTab:CreateLabel("^^^ Works best against low-end devices! ^^^")

CrashTab:CreateToggle({
    Name = "Flinger",
    CurrentValue = false,
    Callback = function(Value)
        _G.fling = Value
        if Value then
            if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                flinging = true
                for _, child in pairs(plr.Character:GetDescendants()) do
                    if child:IsA("BasePart") then
                        child.CustomPhysicalProperties = PhysicalProperties.new(math.huge, 0.3, 0.5)
                    end
                end

                local bambam = Instance.new("BodyAngularVelocity")
                bambam.Name = "FlingAngularVelocity"
                bambam.Parent = plr.Character:FindFirstChild("HumanoidRootPart")
                bambam.AngularVelocity = Vector3.new(0, 99999, 0)
                bambam.MaxTorque = Vector3.new(0, math.huge, 0)
                bambam.P = math.huge

                for _, part in pairs(plr.Character:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                        part.Massless = true
                        part.Velocity = Vector3.new(0, 0, 0)
                    end
                end

                flingDied = plr.Character:FindFirstChildOfClass("Humanoid").Died:Connect(function()
                    flinging = false
                    if flingDied then flingDied:Disconnect() end
                    
                    local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        for _, child in pairs(hrp:GetChildren()) do
                            if child.ClassName == "BodyAngularVelocity" then child:Destroy() end
                        end
                    end

                    for _, part in pairs(plr.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5)
                        end
                    end
                end)

                task.spawn(function()
                    while flinging do
                        if bambam.Parent then bambam.AngularVelocity = Vector3.new(0, 99999, 0) end
                        task.wait(0.2)
                        if bambam.Parent then bambam.AngularVelocity = Vector3.new(0, 0, 0) end
                        task.wait(0.1)
                    end
                end)
            end
        else
            flinging = false
            if flingDied then flingDied:Disconnect() end
            if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                for _, child in pairs(plr.Character:FindFirstChild("HumanoidRootPart"):GetChildren()) do
                    if child.ClassName == "BodyAngularVelocity" then child:Destroy() end
                end

                for _, part in pairs(plr.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5)
                    end
                end
            end
        end
    end
})

CrashTab:CreateSlider({
    Name = "Walkspeed",
    Min = 16,
    Max = 160,
    CurrentValue = 16,
    Callback = function(Value)
        if plr.Character and plr.Character:FindFirstChild("Humanoid") then
            plr.Character.Humanoid.WalkSpeed = Value
        end
    end
})
