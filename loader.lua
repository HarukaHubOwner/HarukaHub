-- Haruka Hub | MM2 | created by crnel666 | github.com/HarukaHubOwner
-- pink liquid glass | multi-lang | full features + dup + scam trade

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

local Config = {
    MenuKey = Enum.KeyCode.RightControl,
    SpeedglitchKey = Enum.KeyCode.V,
    AutoClutchKey = Enum.KeyCode.B,
    SpeedValue = 50,
    FlightSpeed = 60,
    AimbotSmooth = 0.15,
    Stretch = 1,
    FPSLimit = 240,
    Language = "en",
    Whitelist = {},
    CustomCursor = "",
    SelectedTarget = nil,
}

local Lang = {
    en = {
        title = "HARUKA HUB", visuals = "Visuals", aim = "Aim", binds = "Binds", other = "Other",
        esp = "ESP by Role", autofarm = "Auto Farm Coins", fling = "Fling", gangbang = "Gang Bang",
        speedglitch = "Speedglitch", flight = "Flight", customcursor = "Custom Cursor", stretch = "Stretch",
        aimbot = "Aimbot", autododge = "Auto Dodge", whitelist = "Whitelist", walls = "Walk Through Walls",
        noclip = "Noclip", visualskin = "Visual Skin", weaponskin = "Weapon Skins", autoclutch = "Auto Clutch",
        fpslimit = "FPS Limit", menukey = "Menu Key", selectplayer = "Select Player", apply = "Apply",
        language = "Language", dup = "Dup Item", dupall = "Dup All Skins", scamtrade = "Scam Trade",
        forceaccept = "Force Accept Scam"
    },
    ru = {
        title = "HARUKA HUB", visuals = "Визуалы", aim = "Аим", binds = "Бинды", other = "Другое",
        esp = "ESP по ролям", autofarm = "Авто Фарм монет", fling = "Флинг", gangbang = "Gang Bang",
        speedglitch = "Speedglitch", flight = "Полёт", customcursor = "Кастом курсор", stretch = "Растяг",
        aimbot = "Аимбот", autododge = "Авто Додж", whitelist = "Белый список", walls = "Проход сквозь стены",
        noclip = "Ноклип", visualskin = "Визуальный скин", weaponskin = "Скины на оружия", autoclutch = "Авто Клатч",
        fpslimit = "ФПС лимит", menukey = "Клавиша меню", selectplayer = "Выбрать игрока", apply = "Применить",
        language = "Язык", dup = "Дюп предмета", dupall = "Дюп всех скинов", scamtrade = "Скам трейд",
        forceaccept = "Форс принять скам"
    },
    jp = {
        title = "HARUKA HUB", visuals = "ビジュアル", aim = "エイム", binds = "バインド", other = "その他",
        esp = "役割ESP", autofarm = "自動コインファーム", fling = "フリング", gangbang = "ギャングバン",
        speedglitch = "スピードグリッチ", flight = "飛行", customcursor = "カスタムカーソル", stretch = "ストレッチ",
        aimbot = "エイムボット", autododge = "オートドッジ", whitelist = "ホワイトリスト", walls = "壁抜け",
        noclip = "ノークリップ", visualskin = "ビジュアルスキン", weaponskin = "武器スキン", autoclutch = "オートクラッチ",
        fpslimit = "FPS制限", menukey = "メニューキー", selectplayer = "プレイヤー選択", apply = "適用",
        language = "言語", dup = "アイテム複製", dupall = "全スキン複製", scamtrade = "スキャムトレード",
        forceaccept = "強制承認"
    },
    es = {
        title = "HARUKA HUB", visuals = "Visuales", aim = "Aim", binds = "Binds", other = "Otros",
        esp = "ESP por rol", autofarm = "Auto Farm monedas", fling = "Fling", gangbang = "Gang Bang",
        speedglitch = "Speedglitch", flight = "Vuelo", customcursor = "Cursor personalizado", stretch = "Stretch",
        aimbot = "Aimbot", autododge = "Auto Dodge", whitelist = "Lista blanca", walls = "Atravesar paredes",
        noclip = "Noclip", visualskin = "Skin visual", weaponskin = "Skins de armas", autoclutch = "Auto Clutch",
        fpslimit = "Límite FPS", menukey = "Tecla menú", selectplayer = "Seleccionar jugador", apply = "Aplicar",
        language = "Idioma", dup = "Dup Item", dupall = "Dup All Skins", scamtrade = "Scam Trade",
        forceaccept = "Forzar Aceptar"
    },
    ar = {
        title = "HARUKA HUB", visuals = "المرئيات", aim = "التصويب", binds = "الاختصارات", other = "أخرى",
        esp = "ESP حسب الدور", autofarm = "مزرعة العملات", fling = "فلينج", gangbang = "جانج بانج",
        speedglitch = "سبيدجليتش", flight = "الطيران", customcursor = "مؤشر مخصص", stretch = "تمدد",
        aimbot = "إيمبوت", autododge = "تفادي تلقائي", whitelist = "القائمة البيضاء", walls = "المرور عبر الجدران",
        noclip = "نوكليب", visualskin = "سكن مرئي", weaponskin = "سكنات الأسلحة", autoclutch = "كلتش تلقائي",
        fpslimit = "حد الإطارات", menukey = "مفتاح القائمة", selectplayer = "اختر لاعب", apply = "تطبيق",
        language = "اللغة", dup = "تكرار العنصر", dupall = "تكرار كل السكنات", scamtrade = "صفقة احتيال",
        forceaccept = "قبول إجباري"
    },
}

local function T(key)
    return (Lang[Config.Language] and Lang[Config.Language][key]) or Lang.en[key] or key
end

local States = {
    ESP = false, AutoFarm = false, Speedglitch = false, Flight = false,
    Aimbot = false, AutoDodge = false, Noclip = false, AutoClutch = false,
    MenuOpen = true, Walls = false
}

local Connections = {}
local ESPObjects = {}
local SelectedPlayer = nil
local ScamTradeActive = false
local ScamItemName = "Gingerscope"

local function Notify(title, text, duration)
    pcall(function()
        StarterGui:SetCore("SendNotification", {Title = title, Text = text, Duration = duration or 3})
    end)
end

local function GetRole(player)
    local char = player.Character
    if not char then return "Innocent" end
    local backpack = player:FindFirstChild("Backpack")
    local knife = char:FindFirstChild("Knife") or (backpack and backpack:FindFirstChild("Knife"))
    local gun = char:FindFirstChild("Gun") or (backpack and backpack:FindFirstChild("Gun"))
    if knife then return "Murderer" end
    if gun then return "Sheriff" end
    return "Innocent"
end

local function IsAlive(player)
    local char = player.Character
    return char and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0
end

local function GetClosestPlayer(roleFilter)
    local closest, dist = nil, math.huge
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and IsAlive(plr) then
            if not roleFilter or GetRole(plr) == roleFilter then
                local pos = plr.Character.HumanoidRootPart.Position
                local d = (Camera.CFrame.Position - pos).Magnitude
                if d < dist then dist = d; closest = plr end
            end
        end
    end
    return closest
end

-- ====================== FEATURES ======================

local function StartESP()
    StopESP()
    Connections.ESP = RunService.RenderStepped:Connect(function()
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and IsAlive(plr) then
                local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    if not ESPObjects[plr] then
                        local bill = Instance.new("BillboardGui")
                        bill.Size = UDim2.new(0, 130, 0, 40)
                        bill.AlwaysOnTop = true
                        bill.StudsOffset = Vector3.new(0, 3.2, 0)
                        bill.Adornee = hrp
                        bill.Parent = CoreGui
                        local lab = Instance.new("TextLabel")
                        lab.Size = UDim2.new(1, 0, 1, 0)
                        lab.BackgroundTransparency = 1
                        lab.TextStrokeTransparency = 0.3
                        lab.Font = Enum.Font.GothamBold
                        lab.TextSize = 13
                        lab.Parent = bill
                        ESPObjects[plr] = {bill = bill, label = lab}
                    end
                    local role = GetRole(plr)
                    local col = role == "Murderer" and Color3.fromRGB(255, 60, 60)
                        or role == "Sheriff" and Color3.fromRGB(60, 140, 255)
                        or Color3.fromRGB(80, 255, 100)
                    ESPObjects[plr].label.Text = plr.Name .. "\n[" .. role .. "]"
                    ESPObjects[plr].label.TextColor3 = col
                end
            end
        end
    end)
end

function StopESP()
    if Connections.ESP then Connections.ESP:Disconnect() end
    for _, obj in pairs(ESPObjects) do if obj.bill then obj.bill:Destroy() end end
    ESPObjects = {}
end

local function StartAutoFarm()
    Connections.Farm = RunService.Heartbeat:Connect(function()
        if not States.AutoFarm then return end
        local coins = workspace:FindFirstChild("CoinContainer") or workspace:FindFirstChild("Coins")
        if coins then
            for _, coin in ipairs(coins:GetChildren()) do
                local part = coin:IsA("BasePart") and coin or coin:FindFirstChildWhichIsA("BasePart")
                if part then
                    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        hrp.CFrame = part.CFrame + Vector3.new(0, 3, 0)
                        task.wait(0.12)
                    end
                end
            end
        end
    end)
end

local function StopAutoFarm()
    if Connections.Farm then Connections.Farm:Disconnect() end
end

local function FlingPlayer(target)
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    local thrp = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
    if not hrp or not thrp then return end
    local bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
    bv.Velocity = (thrp.Position - hrp.Position).Unit * 220 + Vector3.new(0, 120, 0)
    bv.Parent = thrp
    task.delay(0.25, function() bv:Destroy() end)
    Notify("Fling", target.Name, 2)
end

local function StartGangBang(target)
    local emoteId = 5938365243
    pcall(function()
        local hum = LocalPlayer.Character.Humanoid
        local anim = Instance.new("Animation")
        anim.AnimationId = "rbxassetid://" .. emoteId
        local track = hum:LoadAnimation(anim)
        track.Looped = true
        track:Play()
    end)
    Connections.Gang = RunService.Heartbeat:Connect(function()
        if not target or not IsAlive(target) then
            if Connections.Gang then Connections.Gang:Disconnect() end
            return
        end
        local thrp = target.Character.HumanoidRootPart
        local hrp = LocalPlayer.Character and LocalPlayer.Character.HumanoidRootPart
        if hrp and thrp then
            hrp.CFrame = thrp.CFrame * CFrame.new(0, 0, 1.9)
        end
    end)
    Notify("GangBang", target.Name, 2)
end

local function StartFlight()
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
    bv.Velocity = Vector3.zero
    bv.Parent = hrp
    Connections.Flight = RunService.RenderStepped:Connect(function()
        if not States.Flight then bv:Destroy() if Connections.Flight then Connections.Flight:Disconnect() end return end
        local dir = Vector3.zero
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir - Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then dir = dir - Vector3.new(0, 1, 0) end
        if dir.Magnitude > 0 then bv.Velocity = dir.Unit * Config.FlightSpeed else bv.Velocity = Vector3.zero end
    end)
end

local function StopFlight()
    if Connections.Flight then Connections.Flight:Disconnect() end
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then for _, v in ipairs(hrp:GetChildren()) do if v:IsA("BodyVelocity") then v:Destroy() end end end
end

local function StartNoclip()
    Connections.Noclip = RunService.Stepped:Connect(function()
        if not States.Noclip then return end
        local char = LocalPlayer.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end)
end

local function StopNoclip()
    if Connections.Noclip then Connections.Noclip:Disconnect() end
end

local function DoAutoClutch()
    local char = LocalPlayer.Character
    if not char then return end
    local backpack = LocalPlayer.Backpack
    local tool = char:FindFirstChild("Bomb") or backpack:FindFirstChild("Bomb")
        or char:FindFirstChild("Firework") or backpack:FindFirstChild("Firework")
    if tool then
        tool.Parent = char
        task.wait(0.05)
        pcall(function() tool:Activate() end)
        Notify("Clutch", "Activated", 1)
    end
end

local function DupItem(itemName)
    local backpack = LocalPlayer.Backpack
    local source = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(itemName) or backpack:FindFirstChild(itemName)
    if not source then
        source = Instance.new("Tool")
        source.Name = itemName
        source.RequiresHandle = true
        local handle = Instance.new("Part")
        handle.Name = "Handle"
        handle.Size = Vector3.new(0.4, 0.4, 1.6)
        handle.Parent = source
        source.Parent = backpack
    end
    for i = 1, 3 do
        local clone = source:Clone()
        clone.Parent = backpack
    end
    Notify("Dup", itemName .. " x3", 2)
end

local function DupAllSkins()
    local list = {
        "Gingerscope","Gingerscythe","Corrupt","SharkSeeker","Dartbringer","Candy","Hallow","Sugar",
        "Elderwood","Minty","Vampire's Edge","Icebreaker","Iceblaster","Harvester","Swirly","Celestial",
        "Constellation","Synthwave","Raygun","Batwing","Reaver","Chroma Rainbow","Chroma Eternal","Chroma Sakura"
    }
    for _, name in ipairs(list) do
        DupItem(name)
        task.wait(0.06)
    end
    Notify("Dup", "All skins done", 3)
end

local function StartScamTrade(target, fakeItem)
    if not target then Notify("Scam", "Select player first", 2) return end
    ScamItemName = fakeItem or "Gingerscope"
    ScamTradeActive = true
    local backpack = LocalPlayer.Backpack
    if not backpack:FindFirstChild(ScamItemName) then
        local fake = Instance.new("Tool")
        fake.Name = ScamItemName
        fake.RequiresHandle = true
        local h = Instance.new("Part")
        h.Name = "Handle"
        h.Size = Vector3.new(0.4, 0.4, 1.6)
        h.BrickColor = BrickColor.new("Bright orange")
        h.Parent = fake
        fake.Parent = backpack
    end
    Notify("Scam Trade", "Fake " .. ScamItemName .. " ready. Trade with " .. target.Name, 4)
end

local function ForceAcceptScam()
    pcall(function()
        local r = ReplicatedStorage:FindFirstChild("AcceptTrade", true) or ReplicatedStorage:FindFirstChild("ConfirmTrade", true)
        if r then r:FireServer(true) end
    end)
    Notify("Scam", "Force accept sent", 2)
    ScamTradeActive = false
end

-- ====================== UI ======================

local function CreateUI()
    if CoreGui:FindFirstChild("HarukaHub") then CoreGui.HarukaHub:Destroy() end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "HarukaHub"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = CoreGui

    -- Language select
    local LangFrame = Instance.new("Frame")
    LangFrame.Size = UDim2.new(0, 300, 0, 270)
    LangFrame.Position = UDim2.new(0.5, -150, 0.5, -135)
    LangFrame.BackgroundColor3 = Color3.fromRGB(40, 10, 30)
    LangFrame.BackgroundTransparency = 0.2
    LangFrame.BorderSizePixel = 0
    LangFrame.Parent = ScreenGui
    Instance.new("UICorner", LangFrame).CornerRadius = UDim.new(0, 16)
    local stroke = Instance.new("UIStroke", LangFrame)
    stroke.Color = Color3.fromRGB(255, 130, 180)
    stroke.Thickness = 1.5

    local title = Instance.new("TextLabel", LangFrame)
    title.Size = UDim2.new(1, 0, 0, 40)
    title.BackgroundTransparency = 1
    title.Text = "HARUKA HUB • Language"
    title.TextColor3 = Color3.fromRGB(255, 200, 230)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 16

    local langs = {{"en","English"},{"ru","Русский"},{"jp","日本語"},{"es","Español"},{"ar","العربية"}}
    for i, l in ipairs(langs) do
        local btn = Instance.new("TextButton", LangFrame)
        btn.Size = UDim2.new(0.84, 0, 0, 34)
        btn.Position = UDim2.new(0.08, 0, 0, 48 + (i-1)*38)
        btn.BackgroundColor3 = Color3.fromRGB(255, 110, 170)
        btn.BackgroundTransparency = 0.35
        btn.Text = l[2]
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 14
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
        btn.MouseButton1Click:Connect(function()
            Config.Language = l[1]
            LangFrame:Destroy()
            BuildMain(ScreenGui)
        end)
    end
end

function BuildMain(ScreenGui)
    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Size = UDim2.new(0, 560, 0, 400)
    Main.Position = UDim2.new(0.5, -280, 0.5, -200)
    Main.BackgroundColor3 = Color3.fromRGB(35, 8, 28)
    Main.BackgroundTransparency = 0.18
    Main.BorderSizePixel = 0
    Main.Parent = ScreenGui
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 18)
    local ms = Instance.new("UIStroke", Main)
    ms.Color = Color3.fromRGB(255, 120, 180)
    ms.Thickness = 1.6

    local Title = Instance.new("TextLabel", Main)
    Title.Size = UDim2.new(1, 0, 0, 38)
    Title.BackgroundTransparency = 1
    Title.Text = "✦ " .. T("title") .. " ✦"
    Title.TextColor3 = Color3.fromRGB(255, 180, 220)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 18

    local Credit = Instance.new("TextLabel", Main)
    Credit.Size = UDim2.new(1, -16, 0, 16)
    Credit.Position = UDim2.new(0, 8, 1, -20)
    Credit.BackgroundTransparency = 1
    Credit.Text = "created by crnel666  •  github.com/HarukaHubOwner"
    Credit.TextColor3 = Color3.fromRGB(255, 150, 200)
    Credit.Font = Enum.Font.Gotham
    Credit.TextSize = 11
    Credit.TextXAlignment = Enum.TextXAlignment.Right

    local Side = Instance.new("Frame", Main)
    Side.Size = UDim2.new(0, 130, 1, -60)
    Side.Position = UDim2.new(0, 10, 0, 42)
    Side.BackgroundColor3 = Color3.fromRGB(55, 12, 40)
    Side.BackgroundTransparency = 0.3
    Side.BorderSizePixel = 0
    Instance.new("UICorner", Side).CornerRadius = UDim.new(0, 12)

    local Content = Instance.new("Frame", Main)
    Content.Size = UDim2.new(1, -155, 1, -65)
    Content.Position = UDim2.new(0, 148, 0, 44)
    Content.BackgroundTransparency = 1

    local TabFrames = {}
    local cats = {{"visuals","👁"},{"aim","🎯"},{"binds","⌨"},{"other","ℹ"}}

    for _, c in ipairs(cats) do
        local f = Instance.new("ScrollingFrame", Content)
        f.Name = c[1]
        f.Size = UDim2.new(1, 0, 1, 0)
        f.BackgroundTransparency = 1
        f.ScrollBarThickness = 3
        f.ScrollBarImageColor3 = Color3.fromRGB(255, 130, 180)
        f.CanvasSize = UDim2.new(0, 0, 0, 900)
        f.Visible = c[1] == "visuals"
        TabFrames[c[1]] = f
    end

    for i, c in ipairs(cats) do
        local btn = Instance.new("TextButton", Side)
        btn.Size = UDim2.new(1, -10, 0, 36)
        btn.Position = UDim2.new(0, 5, 0, 8 + (i-1)*44)
        btn.BackgroundColor3 = Color3.fromRGB(255, 100, 160)
        btn.BackgroundTransparency = 0.5
        btn.Text = c[2] .. "  " .. T(c[1])
        btn.TextColor3 = Color3.fromRGB(255, 240, 250)
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 13
        btn.TextXAlignment = Enum.TextXAlignment.Left
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 9)
        btn.MouseButton1Click:Connect(function()
            for name, frame in pairs(TabFrames) do frame.Visible = name == c[1] end
        end)
    end

    local function AddToggle(parent, text, key, cb)
        local row = Instance.new("Frame", parent)
        row.Size = UDim2.new(1, -8, 0, 32)
        row.BackgroundTransparency = 1
        local lab = Instance.new("TextLabel", row)
        lab.Size = UDim2.new(0.72, 0, 1, 0)
        lab.BackgroundTransparency = 1
        lab.Text = text
        lab.TextColor3 = Color3.fromRGB(255, 230, 245)
        lab.Font = Enum.Font.Gotham
        lab.TextSize = 13
        lab.TextXAlignment = Enum.TextXAlignment.Left
        local tog = Instance.new("TextButton", row)
        tog.Size = UDim2.new(0, 48, 0, 22)
        tog.Position = UDim2.new(1, -52, 0.5, -11)
        tog.BackgroundColor3 = States[key] and Color3.fromRGB(255, 120, 180) or Color3.fromRGB(70, 30, 55)
        tog.Text = States[key] and "ON" or "OFF"
        tog.TextColor3 = Color3.fromRGB(255, 255, 255)
        tog.Font = Enum.Font.GothamBold
        tog.TextSize = 11
        Instance.new("UICorner", tog).CornerRadius = UDim.new(0, 7)
        tog.MouseButton1Click:Connect(function()
            States[key] = not States[key]
            tog.BackgroundColor3 = States[key] and Color3.fromRGB(255, 120, 180) or Color3.fromRGB(70, 30, 55)
            tog.Text = States[key] and "ON" or "OFF"
            if cb then cb(States[key]) end
        end)
        return row
    end

    local function AddBtn(parent, text, cb)
        local b = Instance.new("TextButton", parent)
        b.Size = UDim2.new(1, -8, 0, 30)
        b.BackgroundColor3 = Color3.fromRGB(255, 110, 170)
        b.BackgroundTransparency = 0.3
        b.Text = text
        b.TextColor3 = Color3.fromRGB(255, 255, 255)
        b.Font = Enum.Font.GothamBold
        b.TextSize = 13
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 9)
        b.MouseButton1Click:Connect(cb)
        return b
    end

    local function AddBox(parent, placeholder, cb)
        local box = Instance.new("TextBox", parent)
        box.Size = UDim2.new(1, -8, 0, 28)
        box.BackgroundColor3 = Color3.fromRGB(55, 18, 42)
        box.BackgroundTransparency = 0.25
        box.PlaceholderText = placeholder
        box.Text = ""
        box.TextColor3 = Color3.fromRGB(255, 230, 245)
        box.Font = Enum.Font.Gotham
        box.TextSize = 12
        Instance.new("UICorner", box).CornerRadius = UDim.new(0, 8)
        box.FocusLost:Connect(function() if cb then cb(box.Text) end end)
        return box
    end

    local function AddSlider(parent, text, min, max, def, cb)
        local row = Instance.new("Frame", parent)
        row.Size = UDim2.new(1, -8, 0, 48)
        row.BackgroundTransparency = 1
        local lab = Instance.new("TextLabel", row)
        lab.Size = UDim2.new(1, 0, 0, 18)
        lab.BackgroundTransparency = 1
        lab.Text = text .. ": " .. def
        lab.TextColor3 = Color3.fromRGB(255, 230, 245)
        lab.Font = Enum.Font.Gotham
        lab.TextSize = 13
        lab.TextXAlignment = Enum.TextXAlignment.Left
        local bar = Instance.new("Frame", row)
        bar.Size = UDim2.new(1, 0, 0, 6)
        bar.Position = UDim2.new(0, 0, 0, 26)
        bar.BackgroundColor3 = Color3.fromRGB(70, 25, 50)
        bar.BorderSizePixel = 0
        Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)
        local fill = Instance.new("Frame", bar)
        fill.Size = UDim2.new((def-min)/(max-min), 0, 1, 0)
        fill.BackgroundColor3 = Color3.fromRGB(255, 130, 180)
        fill.BorderSizePixel = 0
        Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)
        local drag = false
        bar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = true end end)
        UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end end)
        UserInputService.InputChanged:Connect(function(i)
            if drag and i.UserInputType == Enum.UserInputType.MouseMovement then
                local rel = math.clamp((i.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
                fill.Size = UDim2.new(rel, 0, 1, 0)
                local val = math.floor(min + (max-min)*rel)
                lab.Text = text .. ": " .. val
                if cb then cb(val) end
            end
        end)
        return row
    end

    -- VISUALS
    local vis = TabFrames.visuals
    local y = 6
    local function ny(h) local r = y; y = y + (h or 36); return UDim2.new(0,0,0,r) end
    AddToggle(vis, T("esp"), "ESP", function(v) if v then StartESP() else StopESP() end end).Position = ny()
    AddBox(vis, "Custom Cursor URL", function(url) if url ~= "" then pcall(function() Mouse.Icon = url end) end end).Position = ny(34)
    AddSlider(vis, T("stretch"), 0.5, 2, 1, function(v) Config.Stretch = v; Camera.FieldOfView = 70 / v end).Position = ny(52)
    AddSlider(vis, T("fpslimit"), 30, 9999, 240, function(v) Config.FPSLimit = v; pcall(setfpscap, v) end).Position = ny(52)

    -- AIM
    y = 6
    local aimf = TabFrames.aim
    AddToggle(aimf, T("aimbot"), "Aimbot").Position = ny()
    AddToggle(aimf, T("autododge"), "AutoDodge").Position = ny()
    AddBox(aimf, "Whitelist name", function(n) if n ~= "" then table.insert(Config.Whitelist, n:lower()) Notify("WL", n, 2) end end).Position = ny(34)

    -- BINDS
    y = 6
    local binf = TabFrames.binds
    local menuBtn = AddBtn(binf, T("menukey") .. ": " .. Config.MenuKey.Name, function()
        Notify("Bind", "Press any key...", 3)
        local c; c = UserInputService.InputBegan:Connect(function(i, g)
            if g then return end
            if i.UserInputType == Enum.UserInputType.Keyboard then
                Config.MenuKey = i.KeyCode
                menuBtn.Text = T("menukey") .. ": " .. i.KeyCode.Name
                c:Disconnect()
            end
        end)
    end)
    menuBtn.Position = ny()
    AddToggle(binf, T("speedglitch") .. " (V)", "Speedglitch").Position = ny()
    AddSlider(binf, "Speed", 16, 200, 50, function(v) Config.SpeedValue = v end).Position = ny(52)
    AddToggle(binf, T("autoclutch") .. " (B)", "AutoClutch").Position = ny()
    AddToggle(binf, T("flight"), "Flight", function(v) if v then StartFlight() else StopFlight() end end).Position = ny()
    AddToggle(binf, T("noclip"), "Noclip", function(v) if v then StartNoclip() else StopNoclip() end end).Position = ny()

    -- OTHER
    y = 6
    local oth = TabFrames.other
    AddToggle(oth, T("autofarm"), "AutoFarm", function(v) if v then StartAutoFarm() else StopAutoFarm() end end).Position = ny()
    local pbox = AddBox(oth, T("selectplayer"), function(n)
        for _, p in ipairs(Players:GetPlayers()) do
            if p.Name:lower():find(n:lower()) then SelectedPlayer = p; Notify("Target", p.Name, 2) break end
        end
    end)
    pbox.Position = ny(34)
    AddBtn(oth, T("fling"), function() if SelectedPlayer then FlingPlayer(SelectedPlayer) else Notify("Fling", "Select player", 2) end end).Position = ny()
    AddBtn(oth, T("gangbang"), function() if SelectedPlayer then StartGangBang(SelectedPlayer) else Notify("GB", "Select player", 2) end end).Position = ny()
    local skinBox = AddBox(oth, "Skin name for dup", function() end)
    skinBox.Position = ny(34)
    AddBtn(oth, T("dup"), function() if skinBox.Text ~= "" then DupItem(skinBox.Text) end end).Position = ny()
    AddBtn(oth, T("dupall"), function() DupAllSkins() end).Position = ny()
    AddBtn(oth, T("scamtrade") .. " (Gingerscope)", function() StartScamTrade(SelectedPlayer, "Gingerscope") end).Position = ny()
    AddBtn(oth, T("forceaccept"), function() ForceAcceptScam() end).Position = ny()

    -- drag
    local drag, start, startPos
    Title.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            drag = true; start = i.Position; startPos = Main.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if drag and i.UserInputType == Enum.UserInputType.MouseMovement then
            local d = i.Position - start
            Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end
    end)

    UserInputService.InputBegan:Connect(function(i, g)
        if g then return end
        if i.KeyCode == Config.MenuKey then Main.Visible = not Main.Visible end
        if i.KeyCode == Config.SpeedglitchKey then States.Speedglitch = not States.Speedglitch end
        if i.KeyCode == Config.AutoClutchKey then DoAutoClutch() end
    end)

    Main.Visible = true
    Notify("Haruka Hub", "Loaded • crnel666", 4)
end

-- loops
RunService.Heartbeat:Connect(function()
    if States.Speedglitch then
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
        if hum then hum.WalkSpeed = Config.SpeedValue end
    end
end)

RunService.RenderStepped:Connect(function()
    if not States.Aimbot then return end
    local myRole = GetRole(LocalPlayer)
    local targetRole = myRole == "Sheriff" and "Murderer" or "Sheriff"
    local target = GetClosestPlayer(targetRole)
    if target and IsAlive(target) then
        local head = target.Character:FindFirstChild("Head")
        if head then
            Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, head.Position), Config.AimbotSmooth)
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if not States.AutoDodge then return end
    for _, obj in ipairs(workspace:GetChildren()) do
        if obj.Name == "Knife" and obj:IsA("BasePart") then
            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp and (obj.Position - hrp.Position).Magnitude < 14 then
                States.Speedglitch = true
                hrp.CFrame = hrp.CFrame + (hrp.Position - obj.Position).Unit * 9
                task.delay(0.35, function() States.Speedglitch = false end)
            end
        end
    end
end)

CreateUI()