--[[
    Haruka MM2 Hub
    Creator: crnel666
    UI: Liquid Glass
    Platform: PC / Mobile
]]

local Haruka = {
    Name = "Haruka MM2 Hub",
    Creator = "crnel666",
    Version = "V1",
    Theme = "Liquid Glass"
}

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local IsMobile = UserInputService.TouchEnabled
    and not UserInputService.KeyboardEnabled

local function CreateHarukaUI()
    local Gui = Instance.new("ScreenGui")
    Gui.Name = "HarukaMM2Hub"
    Gui.ResetOnSpawn = false

    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Size = UDim2.fromOffset(600, 390)
    Main.Position = UDim2.new(0.5, -300, 0.5, -195)
    Main.BackgroundColor3 = Color3.fromRGB(20, 24, 34)
    Main.BackgroundTransparency = 0.12
    Main.BorderSizePixel = 0
    Main.Parent = Gui

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 18)
    Corner.Parent = Main

    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(160, 200, 255)
    Stroke.Transparency = 0.55
    Stroke.Thickness = 1
    Stroke.Parent = Main

    local Header = Instance.new("TextLabel")
    Header.Size = UDim2.new(1, -30, 0, 42)
    Header.Position = UDim2.fromOffset(18, 8)
    Header.BackgroundTransparency = 1
    Header.Text = "Haruka  |  MM2 Hub"
    Header.TextColor3 = Color3.fromRGB(235, 242, 255)
    Header.TextSize = 22
    Header.Font = Enum.Font.GothamBold
    Header.TextXAlignment = Enum.TextXAlignment.Left
    Header.Parent = Main

    local Creator = Instance.new("TextLabel")
    Creator.Size = UDim2.new(1, -36, 0, 22)
    Creator.Position = UDim2.fromOffset(18, 48)
    Creator.BackgroundTransparency = 1
    Creator.Text = "Creator: crnel666"
    Creator.TextColor3 = Color3.fromRGB(155, 180, 215)
    Creator.TextSize = 12
    Creator.Font = Enum.Font.Gotham
    Creator.TextXAlignment = Enum.TextXAlignment.Left
    Creator.Parent = Main

    local Sidebar = Instance.new("Frame")
    Sidebar.Position = UDim2.fromOffset(14, 82)
    Sidebar.Size = UDim2.new(0, 155, 1, -96)
    Sidebar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Sidebar.BackgroundTransparency = 0.94
    Sidebar.BorderSizePixel = 0
    Sidebar.Parent = Main

    local SideCorner = Instance.new("UICorner")
    SideCorner.CornerRadius = UDim.new(0, 12)
    SideCorner.Parent = Sidebar

    local SideLayout = Instance.new("UIListLayout")
    SideLayout.Padding = UDim.new(0, 7)
    SideLayout.SortOrder = Enum.SortOrder.LayoutOrder
    SideLayout.Parent = Sidebar

    local SidePadding = Instance.new("UIPadding")
    SidePadding.PaddingTop = UDim.new(0, 10)
    SidePadding.PaddingLeft = UDim.new(0, 8)
    SidePadding.PaddingRight = UDim.new(0, 8)
    SidePadding.Parent = Sidebar

    local Content = Instance.new("Frame")
    Content.Position = UDim2.fromOffset(182, 82)
    Content.Size = UDim2.new(1, -196, 1, -96)
    Content.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Content.BackgroundTransparency = 0.96
    Content.BorderSizePixel = 0
    Content.Parent = Main

    local ContentCorner = Instance.new("UICorner")
    ContentCorner.CornerRadius = UDim.new(0, 12)
    ContentCorner.Parent = Content

    local PageTitle = Instance.new("TextLabel")
    PageTitle.Size = UDim2.new(1, -24, 0, 35)
    PageTitle.Position = UDim2.fromOffset(12, 8)
    PageTitle.BackgroundTransparency = 1
    PageTitle.Text = "Welcome to Haruka"
    PageTitle.TextColor3 = Color3.fromRGB(235, 242, 255)
    PageTitle.TextSize = 18
    PageTitle.Font = Enum.Font.GothamSemibold
    PageTitle.TextXAlignment = Enum.TextXAlignment.Left
    PageTitle.Parent = Content

    local Description = Instance.new("TextLabel")
    Description.Size = UDim2.new(1, -24, 0, 70)
    Description.Position = UDim2.fromOffset(12, 48)
    Description.BackgroundTransparency = 1
    Description.TextWrapped = true
    Description.Text = "Liquid Glass interface\nPlatform: "
        .. (IsMobile and "Android / Touch" or "PC / Keyboard")
    Description.TextColor3 = Color3.fromRGB(185, 198, 220)
    Description.TextSize = 13
    Description.Font = Enum.Font.Gotham
    Description.TextXAlignment = Enum.TextXAlignment.Left
    Description.TextYAlignment = Enum.TextYAlignment.Top
    Description.Parent = Content

    local Pages = {
        "Home",
        "Visuals",
        "Gameplay",
        "Teleport",
        "Settings"
    }

    local function ShowPage(Name)
        PageTitle.Text = Name

        if Name == "Home" then
            Description.Text =
                "Haruka MM2 Hub\nCreator: crnel666\nUI Version: V1"
        elseif Name == "Visuals" then
            Description.Text =
                "Visual settings and player information."
        elseif Name == "Gameplay" then
            Description.Text =
                "Safe gameplay tools for supported test environments."
        elseif Name == "Teleport" then
            Description.Text =
                "Movement tools for authorized test environments."
        elseif Name == "Settings" then
            Description.Text =
                "Theme: Liquid Glass\nPlatform: "
                .. (IsMobile and "Mobile" or "Desktop")
        end
    end

    for Index, Name in ipairs(Pages) do
        local Button = Instance.new("TextButton")
        Button.Name = Name .. "Button"
        Button.Size = UDim2.new(1, 0, 0, 40)
        Button.BackgroundColor3 = Color3.fromRGB(120, 165, 255)
        Button.BackgroundTransparency = 0.82
        Button.BorderSizePixel = 0
        Button.Text = Name
        Button.TextColor3 = Color3.fromRGB(235, 242, 255)
        Button.TextSize = 13
        Button.Font = Enum.Font.GothamMedium
        Button.LayoutOrder = Index
        Button.Parent = Sidebar

        local ButtonCorner = Instance.new("UICorner")
        ButtonCorner.CornerRadius = UDim.new(0, 9)
        ButtonCorner.Parent = Button

        Button.Activated:Connect(function()
            ShowPage(Name)
        end)
    end

    Gui.Parent = Player:WaitForChild("PlayerGui")

    return Gui
end

CreateHarukaUI()