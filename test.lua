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
    frame.Parent = parent
    
    local dragging, dragInput, startPos, startPosRel = false, nil, nil, nil
    
    local function updateInput(input)
        local delta = input.Position - startPos
        parent.Position = UDim2.new(startPosRel.X.Scale, startPosRel.X.Offset + delta.X, startPosRel.Y.Scale, startPosRel.Y.Offset + delta.Y)
    end
    
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            startPos = input.Position
            startPosRel = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    userInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            updateInput(input)
        end
    end)
    
    return frame
end

-- Создание главного фрейма с возможностью перетаскивания и закрытия
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PlayerTrackerGui"
screenGui.Parent = playerGui

local mainFrame = createDraggableFrame(screenGui, UDim2.new(0.3, 0, 0.5, 0), UDim2.new(0.35, 0, 0.25, 0), Color3.fromRGB(50, 50, 50))

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0.1, 0)
titleLabel.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
titleLabel.Text = "Выберите игрока для слежки"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Parent = mainFrame

local playerListLayout = Instance.new("UIListLayout")
playerListLayout.Parent = mainFrame

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0.1, 0, 0.1, 0)
closeButton.Position = UDim2.new(0.9, 0, 0, 0)
closeButton.Text = "X"
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Parent = mainFrame

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Создание фрейма для ползунка
local sliderFrame = Instance.new("Frame")
sliderFrame.Size = UDim2.new(1, 0, 0.2, 0)
sliderFrame.Position = UDim2.new(0, 0, 0.7, 0)
sliderFrame.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
sliderFrame.Parent = mainFrame

local sliderTitle = Instance.new("TextLabel")
sliderTitle.Size = UDim2.new(1, 0, 0.3, 0)
sliderTitle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
sliderTitle.Text = "Расстояние камеры:"
sliderTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
sliderTitle.Parent = sliderFrame

local slider = Instance.new("Frame")
slider.Size = UDim2.new(1, -20, 0.4, 0)
slider.Position = UDim2.new(0, 10, 0.35, 0)
slider.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
slider.Parent = sliderFrame

local sliderButton = Instance.new("Frame")
sliderButton.Size = UDim2.new(0, 10, 1, 0)
sliderButton.Position = UDim2.new(0, 0, 0, 0)
sliderButton.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
sliderButton.Parent = slider

local sliderValue = Instance.new("TextLabel")
sliderValue.Size = UDim2.new(1, 0, 0.3, 0)
sliderValue.Position = UDim2.new(0, 0, 0.7, 0)
sliderValue.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
sliderValue.Text = "20"
sliderValue.TextColor3 = Color3.fromRGB(255, 255, 255)
sliderValue.Parent = sliderFrame

-- Обновление списка игроков
local function updatePlayerList()
    -- Очистка предыдущего списка
    for _, child in ipairs(mainFrame:GetChildren()) do
        if child:IsA("TextButton") and child ~= titleLabel and child ~= closeButton then
            child:Destroy()
        end
    end

    -- Создание новых кнопок для каждого игрока
    for _, p in ipairs(game.Players:GetPlayers()) do
        if p ~= player then
            local playerButton = Instance.new("TextButton")
            playerButton.Size = UDim2.new(1, 0, 0.1, 0)
            playerButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
            playerButton.Text = p.Name
            playerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            playerButton.Parent = mainFrame

            playerButton.MouseButton1Click:Connect(function()
                -- Начать слежку за игроком
                print("Слежу за игроком: " .. p.Name)
                
                -- Смена позиции камеры на выбранного игрока
                camera.CameraSubject = p.Character and p.Character:FindFirstChild("Humanoid") or nil
                camera.CameraType = Enum.CameraType.Scriptable

                -- Функция для обновления камеры
                local function updateCamera()
                    if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        local distance = tonumber(sliderValue.Text) or 20
                        camera.CFrame = CFrame.new(p.Character.HumanoidRootPart.Position + Vector3.new(0, 5, distance), p.Character.HumanoidRootPart.Position)
                    end
                end

                -- Обновление камеры каждый кадр
                game:GetService("RunService").RenderStepped:Connect(updateCamera)
            end)
        end
    end
end

-- Обновление значения ползунка
local function updateSlider(input)
    local sliderSize = slider.AbsoluteSize.X
    local newValue = math.clamp((input.Position.X.Offset - slider.AbsolutePosition.X) / sliderSize * 40 + 10, 10, 50)
    sliderButton.Position = UDim2.new((newValue - 10) / 40 / sliderSize, 0, 0, 0)
    sliderValue.Text = tostring(math.round(newValue))
end

sliderButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        updateSlider(input)
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                local inputConnection = input.InputChanged
                inputConnection:Disconnect()
            end
        end)
    end
end)

userInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and sliderButton.Position.X.Offset then
        updateSlider(input)
    end
end)

-- Обновление списка игроков при запуске
updatePlayerList()

-- Обновление списка при изменении игроков
game.Players.PlayerAdded:Connect(updatePlayerList)
game.Players.PlayerRemoved:Connect(updatePlayerList)
