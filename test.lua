-- Создание GUI
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Tabs = Instance.new("Frame")
local AimbotTab = Instance.new("TextButton")
local ESPTab = Instance.new("TextButton")
local MiscTab = Instance.new("TextButton")
local AimbotFrame = Instance.new("Frame")
local ESPFrame = Instance.new("Frame")
local MiscFrame = Instance.new("Frame")
local CloseButton = Instance.new("TextButton")
local OpenButton = Instance.new("TextButton")

-- Настройки GUI
ScreenGui.Name = "CheatMenu"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false -- меню не исчезает при смерти

Frame.Name = "MainFrame"
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Position = UDim2.new(0.3, 0, 0.3, 0)
Frame.Size = UDim2.new(0, 400, 0, 300)
Frame.Visible = true
Frame.Active = true
Frame.Draggable = true -- делаем меню перетаскиваемым
Frame.BorderSizePixel = 0
Frame.BackgroundTransparency = 0.2
Frame.ZIndex = 2
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = Frame

Title.Name = "Title"
Title.Parent = Frame
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Title.Size = UDim2.new(0, 400, 0, 50)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "Roblox Cheat Menu"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 24
Title.ZIndex = 2

Tabs.Name = "Tabs"
Tabs.Parent = Frame
Tabs.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Tabs.Position = UDim2.new(0, 0, 0.2, 0)
Tabs.Size = UDim2.new(0, 400, 0, 50)
Tabs.ZIndex = 2

AimbotTab.Name = "AimbotTab"
AimbotTab.Parent = Tabs
AimbotTab.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
AimbotTab.Position = UDim2.new(0, 0, 0, 0)
AimbotTab.Size = UDim2.new(0, 133, 0, 50)
AimbotTab.Font = Enum.Font.SourceSansBold
AimbotTab.Text = "Aimbot"
AimbotTab.TextColor3 = Color3.fromRGB(255, 255, 255)
AimbotTab.TextSize = 24
AimbotTab.ZIndex = 2

ESPTab.Name = "ESPTab"
ESPTab.Parent = Tabs
ESPTab.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
ESPTab.Position = UDim2.new(0.33, 0, 0, 0)
ESPTab.Size = UDim2.new(0, 133, 0, 50)
ESPTab.Font = Enum.Font.SourceSansBold
ESPTab.Text = "ESP"
ESPTab.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPTab.TextSize = 24
ESPTab.ZIndex = 2

MiscTab.Name = "MiscTab"
MiscTab.Parent = Tabs
MiscTab.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
MiscTab.Position = UDim2.new(0.66, 0, 0, 0)
MiscTab.Size = UDim2.new(0, 133, 0, 50)
MiscTab.Font = Enum.Font.SourceSansBold
MiscTab.Text = "Misc"
MiscTab.TextColor3 = Color3.fromRGB(255, 255, 255)
MiscTab.TextSize = 24
MiscTab.ZIndex = 2

CloseButton.Name = "CloseButton"
CloseButton.Parent = Frame
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.Position = UDim2.new(0.9, 0, 0, 0)
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 24
CloseButton.ZIndex = 2
CloseButton.MouseButton1Click:Connect(function()
    Frame.Visible = false
    OpenButton.Visible = true
end)

OpenButton.Name = "OpenButton"
OpenButton.Parent = ScreenGui
OpenButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
OpenButton.Position = UDim2.new(0.01, 0, 0.01, 0)
OpenButton.Size = UDim2.new(0, 100, 0, 50)
OpenButton.Font = Enum.Font.SourceSansBold
OpenButton.Text = "Open Menu"
OpenButton.TextColor3 = Color3.fromRGB(0, 0, 0)
OpenButton.TextSize = 24
OpenButton.Visible = false
OpenButton.MouseButton1Click:Connect(function()
    Frame.Visible = true
    OpenButton.Visible = false
end)

-- Создание рамок для вкладок
AimbotFrame.Name = "AimbotFrame"
AimbotFrame.Parent = Frame
AimbotFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
AimbotFrame.Position = UDim2.new(0, 0, 0.4, 0)
AimbotFrame.Size = UDim2.new(0, 400, 0, 150)
AimbotFrame.Visible = false
AimbotFrame.ZIndex = 2

ESPFrame.Name = "ESPFrame"
ESPFrame.Parent = Frame
ESPFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ESPFrame.Position = UDim2.new(0, 0, 0.4, 0)
ESPFrame.Size = UDim2.new(0, 400, 0, 150)
ESPFrame.Visible = false
ESPFrame.ZIndex = 2

MiscFrame.Name = "MiscFrame"
MiscFrame.Parent = Frame
MiscFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MiscFrame.Position = UDim2.new(0, 0, 0.4, 0)
MiscFrame.Size = UDim2.new(0, 400, 0, 150)
MiscFrame.Visible = false
MiscFrame.ZIndex = 2

-- Функции переключения вкладок
AimbotTab.MouseButton1Click:Connect(function()
    AimbotFrame.Visible = true
    ESPFrame.Visible = false
    MiscFrame.Visible = false
end)

ESPTab.MouseButton1Click:Connect(function()
    AimbotFrame.Visible = false
    ESPFrame.Visible = true
    MiscFrame.Visible = false
end)

MiscTab.MouseButton1Click:Connect(function()
    AimbotFrame.Visible = false
    ESPFrame.Visible = false
    MiscFrame.Visible = true
end)
-- Aimbot функции
local AimbotToggle = Instance.new("TextButton")
AimbotToggle.Parent = AimbotFrame
AimbotToggle.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
AimbotToggle.Position = UDim2.new(0.1, 0, 0.1, 0)
AimbotToggle.Size = UDim2.new(0, 100, 0, 50)
AimbotToggle.Font = Enum.Font.SourceSansBold
AimbotToggle.Text = "Enable Aimbot"
AimbotToggle.TextColor3 = Color3.fromRGB(0, 0, 0)
AimbotToggle.TextSize = 24
AimbotToggle.ZIndex = 2

local AimbotSettings = {
    Enabled = false,
    Smoothness = 0.2,
    FOV = 100
}

AimbotToggle.MouseButton1Click:Connect(function()
    AimbotSettings.Enabled = not AimbotSettings.Enabled
    if AimbotSettings.Enabled then
        AimbotToggle.Text = "Disable Aimbot"
    else
        AimbotToggle.Text = "Enable Aimbot"
    end
end)

-- Функция для aimbot
local function AimAt(target)
    local player = game.Players.LocalPlayer
    local mouse = player:GetMouse()
    
    local function getClosestPlayer()
        local closestPlayer = nil
        local shortestDistance = AimbotSettings.FOV
        
        for i, v in pairs(game.Players:GetPlayers()) do
if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local characterPos = v.Character.HumanoidRootPart.Position
                local screenPos, onScreen = workspace.CurrentCamera:WorldToScreenPoint(characterPos)
                local distance = (Vector2.new(screenPos.X, screenPos.Y) - mouse.ViewSize / 2).magnitude
                
                if distance < shortestDistance then
                    shortestDistance = distance
                    closestPlayer = v
                end
            end
        end
        
        return closestPlayer
    end
    
    local function aim()
        while AimbotSettings.Enabled do
            local closestPlayer = getClosestPlayer()
            if closestPlayer and closestPlayer.Character and closestPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local targetPosition = closestPlayer.Character.HumanoidRootPart.Position
                local camera = workspace.CurrentCamera
                camera.CFrame = CFrame.new(camera.CFrame.Position, targetPosition)
            end
            wait(AimbotSettings.Smoothness)
        end
    end
    
    aim()
end

-- Запуск функции aimbot
AimbotToggle.MouseButton1Click:Connect(function()
    if AimbotSettings.Enabled then
        AimAt()
    end
end)
-- ESP функции
local function createESP(object)
    local esp = Instance.new("BillboardGui")
    esp.Name = "ESP"
    esp.Adornee = object
    esp.Size = UDim2.new(0, 200, 0, 50)
    esp.AlwaysOnTop = true
    esp.Parent = object:FindFirstChild("Head") or object:FindFirstChild("HumanoidRootPart")
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Parent = esp
    textLabel.BackgroundTransparency = 1
    textLabel.Text = object.Name
    textLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
    textLabel.TextStrokeTransparency = 0.5
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.TextSize = 24
end

local ESPToggle = Instance.new("TextButton")
ESPToggle.Parent = ESPFrame
ESPToggle.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
ESPToggle.Position = UDim2.new(0.1, 0, 0.1, 0)
ESPToggle.Size = UDim2.new(0, 100, 0, 50)
ESPToggle.Font = Enum.Font.SourceSansBold
ESPToggle.Text = "Enable ESP"
ESPToggle.TextColor3 = Color3.fromRGB(0, 0, 0)
ESPToggle.TextSize = 24
ESPToggle.ZIndex = 2

local function toggleESP()
    local espEnabled = false
    
    ESPToggle.MouseButton1Click:Connect(function()
        espEnabled = not espEnabled
        ESPToggle.Text = espEnabled and "Disable ESP" or "Enable ESP"
        
        if espEnabled then
            for _, player in pairs(game.Players:GetPlayers()) do
                if player.Character then
                    createESP(player.Character)
                end
            end
        else
            for _, esp in pairs(workspace:FindFirstChildOfClass("BillboardGui")) do
                if esp.Name == "ESP" then
                    esp:Destroy()
                end
            end
        end
    end)
end

toggleESP()
-- Функция для стрельбы через стены
local function shootThroughWalls()
    local player = game.Players.LocalPlayer
    local mouse = player:GetMouse()

    mouse.Button1Down:Connect(function()
        if not AimbotSettings.Enabled then return end
        
        local target = getClosestPlayer()
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            -- Пример стрельбы через стены
            local ray = Ray.new(mouse.UnitRay.Origin, mouse.UnitRay.Direction * 500)
            local hitPart, hitPosition = workspace:FindPartOnRay(ray, player.Character)
            
            if hitPart and hitPart.Parent:FindFirstChild("Humanoid") then
                -- Логика стрельбы
                print("Shooting through walls!")
                -- Можете добавить здесь код для стрельбы
            end
        end
    end)
end

-- Запуск функции стрельбы через стены
shootThroughWalls()
-- Функция изменения скорости
local SpeedHackToggle = Instance.new("TextButton")
SpeedHackToggle.Parent = MiscFrame
SpeedHackToggle.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
SpeedHackToggle.Position = UDim2.new(0.1, 0, 0.1, 0)
SpeedHackToggle.Size = UDim2.new(0, 100, 0, 50)
SpeedHackToggle.Font = Enum.Font.SourceSansBold
SpeedHackToggle.Text = "Enable Speed Hack"
SpeedHackToggle.TextColor3 = Color3.fromRGB(0, 0, 0)
SpeedHackToggle.TextSize = 24
SpeedHackToggle.ZIndex = 2

local SpeedHackSettings = {
    Enabled = false,
    Speed = 50
}

SpeedHackToggle.MouseButton1Click:Connect(function()
    SpeedHackSettings.Enabled = not SpeedHackSettings.Enabled
    if SpeedHackSettings.Enabled then
        SpeedHackToggle.Text = "Disable Speed Hack"
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = SpeedHackSettings.Speed
    else
        SpeedHackToggle.Text = "Enable Speed Hack"
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end
end)