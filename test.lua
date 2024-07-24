-- Создание интерфейса
local ScreenGui = Instance.new("ScreenGui")
local WeaponFrame = Instance.new("Frame")
local WeaponButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.Name = "WeaponMenuGui"

-- Настройка рамки выбора оружия
WeaponFrame.Parent = ScreenGui
WeaponFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
WeaponFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
WeaponFrame.Size = UDim2.new(0, 300, 0, 200)
WeaponFrame.Visible = true
WeaponFrame.BorderSizePixel = 0

-- Настройка кнопки выбора оружия
WeaponButton.Parent = WeaponFrame
WeaponButton.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
WeaponButton.Position = UDim2.new(0.1, 0, 0.2, 0)
WeaponButton.Size = UDim2.new(0.8, 0, 0, 50)
WeaponButton.Text = "Get SuperGun"
WeaponButton.TextColor3 = Color3.new(1, 1, 1)
WeaponButton.Font = Enum.Font.SourceSans
WeaponButton.TextSize = 24

-- Настройка кнопки закрытия меню
CloseButton.Parent = WeaponFrame
CloseButton.BackgroundColor3 = Color3.new(0.7, 0.1, 0.1)
CloseButton.Position = UDim2.new(0.1, 0, 0.8, 0)
CloseButton.Size = UDim2.new(0.8, 0, 0, 50)
CloseButton.Text = "Close Menu"
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.Font = Enum.Font.SourceSans
CloseButton.TextSize = 24

-- Настройка углов кнопок
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = WeaponButton
UICorner:Clone().Parent = CloseButton

-- Функция для создания оружия с бесконечными патронами и высоким уроном
local function createPowerfulWeapon(name, damage)
    local tool = Instance.new("Tool")
    tool.Name = name
    tool.RequiresHandle = true
    tool.CanBeDropped = true

    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(1, 5, 1)
    handle.Anchored = false
    handle.CanCollide = false
    handle.BrickColor = BrickColor.new("Bright red")
    handle.Parent = tool

    -- Добавление скрипта для стрельбы и нанесения урона
    local weaponScript = Instance.new("Script")
    weaponScript.Source = [[
        local tool = script.Parent
        local damage = tool:GetAttribute("Damage") or 1000000000
        local shooting = false

        tool.Activated:Connect(function()
            if not shooting then
                shooting = true
                
                -- Определение зоны поражения
                local player = game.Players.LocalPlayer
                local character = player.Character
                local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

                if humanoidRootPart then
                    local direction = humanoidRootPart.CFrame.LookVector * 100
                    local ray = Ray.new(humanoidRootPart.Position, direction)
                    local part, position = workspace:FindPartOnRay(ray, character)
                    
                    -- Наносим урон всем сущностям в зоне попадания
                    local hitHumanoids = {}
                    for _, obj in ipairs(workspace:FindPartsInRegion3(workspace.CurrentCamera:WorldToViewportPoint(humanoidRootPart.Position), Vector3.new(100, 100, 100), nil)) do
                        local humanoid = obj.Parent:FindFirstChildOfClass("Humanoid")
                        if humanoid and humanoid ~= character:FindFirstChildOfClass("Humanoid") then
                            table.insert(hitHumanoids, humanoid)
                        end
                    end
                    for _, hitHumanoid in ipairs(hitHumanoids) do
                        hitHumanoid:TakeDamage(damage)
                    end
                end

                shooting = false
            end
        end)
    ]]
    weaponScript.Parent = tool
    tool:SetAttribute("Damage", damage)

    return tool
end

-- Функция для выдачи оружия игроку
local function giveWeapon(weaponName, damage)
    local player = game.Players.LocalPlayer
    local backpack = player:FindFirstChild("Backpack")

    if backpack then
        local weapon = createPowerfulWeapon(weaponName, damage)
        weapon.Parent = backpack
    end
end

-- Обработчик нажатия кнопки для получения оружия
WeaponButton.MouseButton1Click:Connect(function()
    giveWeapon("SuperGun", 1000000000)  -- Выдает оружие с уронным значением 1 миллиард
end)

-- Обработчик нажатия кнопки для закрытия меню
CloseButton.MouseButton1Click:Connect(function()
    WeaponFrame.Visible = false
end)
