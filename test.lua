-- Ensure the script runs only on the client
if not game:GetService("RunService"):IsClient() then
    return
end

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local camera = workspace.CurrentCamera

-- Function to create draggable frames
local function createDraggableFrame(parent, size, position, backgroundColor)
    local frame = Instance.new("Frame")
    frame.Size = size
    frame.Position = position
    frame.BackgroundColor3 = backgroundColor
    frame.BackgroundTransparency = 0.3
    frame.BorderSizePixel = 0
    frame.Parent = parent
    frame.Active = true
    frame.Draggable = true
    return frame
end

-- Create main GUI frame
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PlayerTrackerGui"
screenGui.Parent = playerGui

local mainFrame = createDraggableFrame(screenGui, UDim2.new(0.4, 0, 0.6, 0), UDim2.new(0.3, 0, 0.2, 0), Color3.fromRGB(50, 50, 50))

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0.1, 0)
titleLabel.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
titleLabel.BorderSizePixel = 0
titleLabel.Text = "Select a player to track"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextScaled = true
titleLabel.Parent = mainFrame

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0.1, 0, 0.1, 0)
closeButton.Position = UDim2.new(0.9, 0, 0, 0)
closeButton.Text = "X"
closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeButton.BorderSizePixel = 0
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Font = Enum.Font.SourceSansBold
closeButton.TextScaled = true
closeButton.Parent = mainFrame

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, 0, 0.8, 0)
scrollFrame.Position = UDim2.new(0, 0, 0.1, 0)
scrollFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
scrollFrame.ScrollBarThickness = 10
scrollFrame.BackgroundTransparency = 1
scrollFrame.Parent = mainFrame

local playerListLayout = Instance.new("UIListLayout")
playerListLayout.Parent = scrollFrame

local backButton = Instance.new("TextButton")
backButton.Size = UDim2.new(0.3, 0, 0.1, 0)
backButton.Position = UDim2.new(0.35, 0, 0.9, 0)
backButton.Text = "Back"
backButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
backButton.BorderSizePixel = 0
backButton.TextColor3 = Color3.fromRGB(255, 255, 255)
backButton.Font = Enum.Font.SourceSansBold
backButton.TextScaled = true
backButton.Parent = mainFrame

backButton.MouseButton1Click:Connect(function()
    camera.CameraSubject = player.Character and player.Character:FindFirstChild("Humanoid") or nil
    camera.CameraType = Enum.CameraType.Custom
end)

local trackedPlayer

local function setCameraToFreeView(targetPlayer)
    trackedPlayer = targetPlayer
    camera.CameraSubject = trackedPlayer.Character and trackedPlayer.Character:FindFirstChild("Humanoid") or nil
    camera.CameraType = Enum.CameraType.Custom
end

-- Update player list
local function updatePlayerList()
    -- Clear previous list
    for _, child in ipairs(scrollFrame:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end

    -- Create new buttons for each player
    for _, p in ipairs(game.Players:GetPlayers()) do
        if p ~= player then
            local playerButton = Instance.new("TextButton")
            playerButton.Size = UDim2.new(1, 0, 0.07, 0) -- Slightly increased button size
            playerButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
            playerButton.BorderSizePixel = 0
            playerButton.Text = p.Name
            playerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            playerButton.Font = Enum.Font.SourceSansBold
            playerButton.TextScaled = true
            playerButton.Parent = scrollFrame

            playerButton.MouseButton1Click:Connect(function()
                -- Start tracking the player
                print("Tracking player: " .. p.Name)
                setCameraToFreeView(p)
            end)
        end
    end

    -- Update CanvasSize for scrolling
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0.07 * (#game.Players:GetPlayers() - 1), 0)
end

-- Update player list on start
updatePlayerList()

-- Update player list when players are added or removed
game.Players.PlayerAdded:Connect(updatePlayerList)
game.Players.PlayerRemoving:Connect(updatePlayerList)

-- Function to update camera position based on tracked player
local function updateCameraPosition()
    if trackedPlayer and trackedPlayer.Character and trackedPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local rootPart = trackedPlayer.Character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            camera.CameraType = Enum.CameraType.Custom
            camera.CameraSubject = rootPart
        end
    end
end

-- Update camera position periodically
game:GetService("RunService").RenderStepped:Connect(updateCameraPosition)
