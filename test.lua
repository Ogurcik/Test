-- Проверка, чтобы скрипт работал только на клиенте
if not game:GetService("RunService"):IsClient() then
    return
end

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local camera = workspace.CurrentCamera
local userInputService = game:GetService("UserInputService")

-- Функция для создания draggable фрейма
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

-- Создание главного фрейма с возможностью перетаскивания и закрытия
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PlayerTrackerGui"
screenGui.Parent = playerGui

local mainFrame = createDraggableFrame(screenGui, UDim2.new(0.3, 0, 0.6, 0), UDim2.new(0.35, 0, 0.2, 0), Color3.fromRGB(50, 50, 50))
mainFrame.Visible = false

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0.1, 0)
titleLabel.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
titleLabel.BorderSizePixel = 0
titleLabel.Text = "Выберите игрока для слежки"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextScaled = true
titleLabel.Parent = mainFrame

local playerListLayout = Instance.new("UIListLayout")
playerListLayout.Parent = mainFrame

local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0.1, 0, 0.1, 0)
toggleButton.Position = UDim2.new(0, 0, 0, 0)
toggleButton.Text = ">"
toggleButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.TextScaled = true
toggleButton.Parent = screenGui

toggleButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
    if mainFrame.Visible then
        toggleButton.Text = "<"
    else
        toggleButton.Text = ">"
    end
end)

local backButton = Instance.new("TextButton")
backButton.Size = UDim2.new(0.3, 0, 0.1, 0)
backButton.Position = UDim2.new(0.35, 0, 0.9, 0)
backButton.Text = "Назад"
backButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
backButton.BorderSizePixel = 0
backButton.TextColor3 = Color3.fromRGB(255, 255, 255)
backButton.Font = Enum.Font.SourceSansBold
backButton.TextScaled = true
backButton.Parent = mainFrame

backButton.MouseButton1Click:Connect(function()
    camera.CameraSubject = player.Character and player.Character:FindFirstChild("Humanoid") or nil
    camera.CameraType = Enum.CameraType.Custom
end)

local function setCameraToFirstPerson(targetPlayer)
    local humanoid = targetPlayer.Character and targetPlayer.Character:FindFirstChild("Humanoid")
    if humanoid then
        camera.CameraSubject = humanoid
        camera.CameraType = Enum.CameraType.Custom
        camera.CFrame = CFrame.new(humanoid.Head.Position)
    end
end

local function setCameraToThirdPerson(targetPlayer)
    local humanoid = targetPlayer.Character and targetPlayer.Character:FindFirstChild("Humanoid")
    if humanoid then
        camera.CameraSubject = humanoid
        camera.CameraType = Enum.CameraType.Custom
        camera.CFrame = CFrame.new(humanoid.Head.Position + Vector3.new(0, 5, -10), humanoid.Head.Position)
    end
end

local function setCameraToFreeView(targetPlayer)
    local humanoid = targetPlayer.Character and targetPlayer.Character:FindFirstChild("Humanoid")
    if humanoid then
        camera.CameraSubject = nil
        camera.CameraType = Enum.CameraType.Scriptable
    end
end

-- Обновление списка игроков
local function updatePlayerList()
    -- Очистка предыдущего списка
    for _, child in ipairs(mainFrame:GetChildren()) do
        if child:IsA("TextButton") and child ~= titleLabel and child ~= backButton then
            child:Destroy()
        end
    end

    -- Создание новых кнопок для каждого игрока
    for _, p in ipairs(game.Players:GetPlayers()) do
        if p ~= player then
            local playerButton = Instance.new("TextButton")
            playerButton.Size = UDim2.new(1, 0, 0.1, 0)
            playerButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
            playerButton.BorderSizePixel = 0
            playerButton.Text = p.Name
            playerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            playerButton.Font = Enum.Font.SourceSansBold
            playerButton.TextScaled = true
            playerButton.Parent = mainFrame

            local viewButton1 = Instance.new("TextButton")
            viewButton1.Size = UDim2.new(1, 0, 0.1, 0)
            viewButton1.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
            viewButton1.BorderSizePixel = 0
            viewButton1.Text = "1 лицо"
            viewButton1.TextColor3 = Color3.fromRGB(255, 255, 255)
            viewButton1.Font = Enum.Font.SourceSansBold
            viewButton1.TextScaled = true
            viewButton1.Parent = mainFrame

            viewButton1.MouseButton1Click:Connect(function()
                setCameraToFirstPerson(p)
            end)

            local viewButton2 = Instance.new("TextButton")
            viewButton2.Size = UDim2.new(1, 0, 0.1, 0)
            viewButton2.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
            viewButton2.BorderSizePixel = 0
            viewButton2.Text = "3 лицо"
            viewButton2.TextColor3 = Color3.fromRGB(255, 255, 255)
            viewButton2.Font = Enum.Font.SourceSansBold
            viewButton2.TextScaled = true
            viewButton2.Parent = mainFrame

            viewButton2.MouseButton1Click:Connect(function()
                setCameraToThirdPerson(p)
            end)

            local freeViewButton = Instance.new("TextButton")
            freeViewButton.Size = UDim2.new(1, 0, 0.1, 0)
            freeViewButton.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
            freeViewButton.BorderSizePixel = 0
            freeViewButton.Text = "Свободный вид"
            freeViewButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            freeViewButton.Font = Enum.Font.SourceSansBold
            freeViewButton.TextScaled = true
            freeViewButton.Parent = mainFrame

            freeViewButton.MouseButton1Click:Connect(function()
                setCameraToFreeView(p)
            end)

            playerButton.MouseButton1Click:Connect(function()
                -- Начать слежку за игроком
                print("Слежу за игроком: " .. p.Name)
                setCameraToThirdPerson(p)
            end)
        end
    end
end

-- Обновление списка игроков при запуске
updatePlayerList()

-- Обновление списка при изменении игроков
game.Players.PlayerAdded:Connect(updatePlayerList)
game.Players.PlayerRemoving:Connect(updatePlayerList)
