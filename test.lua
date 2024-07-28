local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local localPlayer = Players.LocalPlayer
local Storage = Instance.new("Folder", CoreGui)
Storage.Name = "Highlight_Storage"

local function lerp(a, b, t)
    return a + (b - a) * t
end

local function createColorGradient(health)
    local green = Color3.fromRGB(0, 255, 0)
    local red = Color3.fromRGB(255, 0, 0)
    local fraction = health / 100
    return Color3.new(
        lerp(red.R, green.R, fraction),
        lerp(red.G, green.G, fraction),
        lerp(red.B, green.B, fraction)
    )
end

local function updateHighlightColor(highlight, health)
    highlight.FillColor = createColorGradient(health)
end

local function createHighlight(plr)
    local highlight = Instance.new("Highlight")
    highlight.Name = plr.Name
    highlight.DepthMode = "AlwaysOnTop"
    highlight.FillTransparency = 0.5
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.OutlineTransparency = 0
    highlight.Parent = Storage

    local function onCharacterAdded(character)
        highlight.Adornee = character
        local humanoid = character:WaitForChild("Humanoid")
        RunService.RenderStepped:Connect(function()
            updateHighlightColor(highlight, humanoid.Health)
        end)
    end

    plr.CharacterAdded:Connect(onCharacterAdded)
    if plr.Character then
        onCharacterAdded(plr.Character)
    end

    Players.PlayerRemoving:Connect(function()
        if Storage:FindFirstChild(plr.Name) then
            Storage[plr.Name]:Destroy()
        end
    end)
end

for _, player in ipairs(Players:GetPlayers()) do
    if player ~= localPlayer then
        createHighlight(player)
    end
end

Players.PlayerAdded:Connect(createHighlight)

-- ESP для ника и здоровья
local function createESP(player)
    if player == localPlayer then return end

    local function onCharacterAdded(character)
        local head = character:WaitForChild("Head", 10)
        if not head then return end

        -- Удаление старых ESP элементов, если они есть
        for _, child in pairs(head:GetChildren()) do
            if child:IsA("BillboardGui") then
                child:Destroy()
            end
        end

        -- Создание надписей с именем и здоровьем
        local billboard = Instance.new("BillboardGui", head)
        billboard.Name = "ESP"
        billboard.AlwaysOnTop = true
        billboard.Size = UDim2.new(0, 100, 0, 50)
        billboard.StudsOffset = Vector3.new(0, 3, 0)

        local frame = Instance.new("Frame", billboard)
        frame.Size = UDim2.new(1, 0, 1, 0)
        frame.BackgroundTransparency = 1

        local nameLabel = Instance.new("TextLabel", frame)
        nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = player.Name
        nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        nameLabel.TextStrokeTransparency = 0
        nameLabel.Font = Enum.Font.SourceSansBold
        nameLabel.TextScaled = true
        nameLabel.TextSize = 14

        local healthLabel = Instance.new("TextLabel", frame)
        healthLabel.Size = UDim2.new(1, 0, 0.5, 0)
        healthLabel.Position = UDim2.new(0, 0, 0.5, 0)
        healthLabel.BackgroundTransparency = 1
        healthLabel.TextStrokeTransparency = 0
        healthLabel.Font = Enum.Font.SourceSansBold
        healthLabel.TextScaled = true
        healthLabel.TextSize = 14

        local function updateESP()
            if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                local health = humanoid.Health
                healthLabel.Text = "HP: " .. math.floor(health)
                healthLabel.TextColor3 = createColorGradient(health)
            end
        end

        RunService.RenderStepped:Connect(updateESP)
        updateESP()
    end

    if player.Character then
        onCharacterAdded(player.Character)
    end
    player.CharacterAdded:Connect(onCharacterAdded)
end

for _, player in pairs(Players:GetPlayers()) do
    if player ~= localPlayer then
        createESP(player)
    end
end

Players.PlayerAdded:Connect(createESP)
