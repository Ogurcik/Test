local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local localPlayer = Players.LocalPlayer

-- Функция для создания плавного градиента цвета в зависимости от здоровья
local function createColorGradient(health)
    local red = math.clamp(255 - (health * 2.55), 0, 255)
    local green = math.clamp(health * 2.55, 0, 255)
    return Color3.fromRGB(red, green, 0)
end

-- Функция для создания ESP для игрока
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
        nameLabel.TextSize = 14 -- Начальный размер текста для никнейма
        nameLabel.TextScaled = true
        nameLabel.TextWrapped = true

        -- Уменьшение размера текста, если никнейм слишком длинный
        nameLabel:GetPropertyChangedSignal("TextBounds"):Connect(function()
            if nameLabel.TextBounds.X > nameLabel.AbsoluteSize.X then
                nameLabel.TextSize = 14 * (nameLabel.AbsoluteSize.X / nameLabel.TextBounds.X)
            end
        end)

        local healthLabel = Instance.new("TextLabel", frame)
        healthLabel.Size = UDim2.new(1, 0, 0.5, 0)
        healthLabel.Position = UDim2.new(0, 0, 0.5, 0)
        healthLabel.BackgroundTransparency = 1
        healthLabel.TextStrokeTransparency = 0
        healthLabel.Font = Enum.Font.SourceSansBold
        healthLabel.TextSize = 14 -- Размер текста для здоровья

        -- Локальная переменная для хранения предыдущего значения здоровья
        local lastHealth = -1

        local function updateESP()
            if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                local health = humanoid.Health

                -- Обновляем текст только при изменении здоровья
                if math.floor(health) ~= lastHealth then
                    healthLabel.Text = "HP: " .. math.floor(health)
                    healthLabel.TextColor3 = createColorGradient(health)
                    lastHealth = math.floor(health)
                end
            end
        end

        -- Обновляем текст с частотой 10 раз в секунду
        local updateConnection = RunService.RenderStepped:Connect(function(step)
            if step >= 0.1 then
                updateESP()
            end
        end)

        -- Убедитесь, что соединение отключено при удалении персонажа
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
