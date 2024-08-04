-- LocalScript for GUI Setup
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "AimBotGUI"

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 300, 0, 600)
mainFrame.Position = UDim2.new(0, 10, 0, 10)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BackgroundTransparency = 0.5
mainFrame.BorderSizePixel = 0
mainFrame.Name = "MainFrame"
mainFrame.Draggable = true

local titleLabel = Instance.new("TextLabel", mainFrame)
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
titleLabel.Text = "AimBot Menu"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 24
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextStrokeTransparency = 0.5

-- LocalScript for Buttons
local closeButton = Instance.new("TextButton", mainFrame)
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -40, 0, 10)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Text = "X"
closeButton.Font = Enum.Font.SourceSansBold
closeButton.TextSize = 18

local resizeButton = Instance.new("TextButton", mainFrame)
resizeButton.Size = UDim2.new(0, 30, 0, 30)
resizeButton.Position = UDim2.new(1, -40, 1, -40)
resizeButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
resizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
resizeButton.Text = "+"
resizeButton.Font = Enum.Font.SourceSansBold
resizeButton.TextSize = 18

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

resizeButton.MouseButton1Click:Connect(function()
    local currentSize = mainFrame.Size
    if currentSize.X.Offset == 300 then
        mainFrame.Size = UDim2.new(0, 500, 0, 600)
        resizeButton.Text = "-"
    else
        mainFrame.Size = UDim2.new(0, 300, 0, 600)
        resizeButton.Text = "+"
    end
end)

-- LocalScript for Scrolling and Dragging
local UIS = game:GetService("UserInputService")
local dragInput
local dragging
local dragStart
local startPos

local function updateInput(input)
    local delta = input.Position - dragStart
    mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        updateInput(input)
    end
end)
-- LocalScript for AimBot Features
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local localPlayer = Players.LocalPlayer
local mouse = localPlayer:GetMouse()

-- Aim settings
local aimEnabled = true
local aimFOV = 100
local aimBone = "Head"
local aimSmooth = true

-- TriggerBot settings
local triggerBotEnabled = true

-- Silent Aim settings
local silentAim = true

-- Anti-Recoil settings
local antiRecoil = true

-- Auto-Heal settings
local autoHeal = true

-- Bullet Tracing settings
local bulletTracing = true

-- ESP settings
local espEnabled = true

-- Function to find the closest target
local function findTarget()
    local closestTarget = nil
    local closestDistance = aimFOV

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character and player.Character:FindFirstChild(aimBone) then
            local targetPosition = player.Character[aimBone].Position
            local screenPoint = workspace.CurrentCamera:WorldToScreenPoint(targetPosition)
            local distance = (Vector2.new(screenPoint.X, screenPoint.Y) - Vector2.new(mouse.X, mouse.Y)).Magnitude

            if distance < closestDistance then
                closestDistance = distance
                closestTarget = player
            end
        end
    end

    return closestTarget
end

-- Function to handle trigger bot logic
local function handleTriggerBot()
    if triggerBotEnabled then
        local target = findTarget()
        if target then
            -- Your trigger bot logic here
            if not target.Character:FindFirstChildOfClass("Humanoid") or target.Character.Humanoid.Health <= 0 then
                return
            end
            -- Simulate mouse click or firing here
        end
    end
end

-- Function to handle silent aim
local function handleSilentAim()
    if silentAim then
        local target = findTarget()
        if target then
            -- Adjust aim towards target
            local targetPosition = target.Character[aimBone].Position
            -- Your silent aim logic here
        end
    end
end

-- Function to handle anti-recoil
local function handleAntiRecoil()
    if antiRecoil then
        -- Your anti-recoil logic here
    end
end

-- Function to handle auto-heal
local function handleAutoHeal()
    if autoHeal then
        -- Your auto-heal logic here
    end
end

-- Function to handle bullet tracing
local function handleBulletTracing()
    if bulletTracing then
        -- Your bullet tracing logic here
    end
end

-- Function to handle ESP features
local function handleESP()
    if espEnabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= localPlayer and player.Character then
                createESP(player)
            end
        end
    end
end

-- Function to update settings and handle features
local function updateFeatures()
    updateAimSettings()
    handleAim()
    handleTriggerBot()
    handleSilentAim()
    handleAntiRecoil()
    handleAutoHeal()
    handleBulletTracing()
    handleESP()
end

-- Connect to RenderStepped to update features continuously
RunService.RenderStepped:Connect(updateFeatures)
-- LocalScript for ESP
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local localPlayer = Players.LocalPlayer

-- Function to create ESP for a player
local function createESP(player)
    if player == localPlayer then return end

    local function onCharacterAdded(character)
        local head = character:WaitForChild("Head", 10)
        if not head then return end

        -- Remove old ESP elements
        for _, child in pairs(head:GetChildren()) do
            if child:IsA("BillboardGui") and child.Name ~= "ESP" then
                child:Destroy()
            end
        end

        -- Create new ESP elements
        local billboard = Instance.new("BillboardGui", head)
        billboard.Name = "ESP"
        billboard.AlwaysOnTop = true
        billboard.Size = UDim2.new(0, 150, 0, 40)
        billboard.StudsOffset = Vector3.new(0, 3, 0)

        local frame = Instance.new("Frame", billboard)
        frame.Size = UDim2.new(1, 0, 1, 0)
        frame.BackgroundTransparency = 1

        -- Create text labels
        local function createTextLabel(text, textSize, position)
            local label = Instance.new("TextLabel", frame)
            label.Size = UDim2.new(1, 0, 0.5, 0)
            label.Position = position
            label.BackgroundTransparency = 1
            label.Text = text
            label.TextColor3 = Color3.fromRGB(255, 255, 255)
            label.TextStrokeTransparency = 0.5
            label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            label.Font = Enum.Font.SourceSansBold
            label.TextSize = textSize
            label.TextScaled = true
            label.TextWrapped = true
            return label
        end
local nameLabel = createTextLabel(player.Name, 12, UDim2.new(0, 0, 0, 0))
        local healthLabel = createTextLabel("HP: 100", 14, UDim2.new(0, 0, 0.5, 0))

        -- Function to create highlight effect around the player
        local function createHighlight(character)
            local highlight = Instance.new("Highlight", character)
            highlight.Name = "ESPHighlight"
            highlight.FillColor = Color3.fromRGB(75, 0, 130)  -- Dark purple color
            highlight.FillTransparency = 0.3
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)  -- White outline
            highlight.OutlineTransparency = 0.2
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        end

        -- Create highlight when the character is added
        createHighlight(character)

        -- Update text and highlight color
        local function updateESP()
            if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                local health = humanoid.Health
                healthLabel.Text = "HP: " .. math.floor(health)

                -- Update highlight color and transparency
                local highlight = character:FindFirstChild("ESPHighlight")
                if highlight then
                    highlight.FillColor = Color3.fromRGB(75, 0, 130)  -- Dark purple color
                end
            end
        end

        -- Update text and highlight color at a frequency of 10 times per second
        local updateConnection = RunService.RenderStepped:Connect(function(step)
            if step >= 0.1 then
                updateESP()
            end
        end)

        -- Disconnect the connection when the character is removed
        player.CharacterRemoving:Connect(function()
            if updateConnection then
                updateConnection:Disconnect()
            end
        end)

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
-- LocalScript for Additional Features
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local localPlayer = Players.LocalPlayer
local mouse = localPlayer:GetMouse()

-- Example function for additional feature: Visual indicators
local function addVisualIndicators()
    -- Your visual indicators logic here
end

-- Function to handle additional features
local function handleAdditionalFeatures()
    -- Call the function for visual indicators
    addVisualIndicators()
end

-- Connect to RenderStepped to update additional features continuously
RunService.RenderStepped:Connect(handleAdditionalFeatures)
-- LocalScript for Managing Features and Integration
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local localPlayer = Players.LocalPlayer

-- Function to toggle features based on GUI inputs
local function toggleFeature(featureName, state)
    if featureName == "Aim" then
        aimEnabled = state
    elseif featureName == "TriggerBot" then
        triggerBotEnabled = state
    elseif featureName == "SilentAim" then
        silentAim = state
    elseif featureName == "AntiRecoil" then
        antiRecoil = state
    elseif featureName == "AutoHeal" then
        autoHeal = state
    elseif featureName == "BulletTracing" then
        bulletTracing = state
    elseif featureName == "ESP" then
        espEnabled = state
    end
end

-- Connect GUI buttons to toggle functions
local function setupGUIListeners()
    -- Example: connect a button to toggle Aim
    local aimButton = script.Parent:WaitForChild("AimButton")
    aimButton.MouseButton1Click:Connect(function()
        toggleFeature("Aim", not aimEnabled)
    end)

    -- Add listeners for other buttons similarly
end

setupGUIListeners()
