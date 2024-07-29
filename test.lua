local function createUI()
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local ToggleButton = Instance.new("TextButton")
    local CloseButton = Instance.new("TextButton")
    local FreezeButton = Instance.new("TextButton")
    local SpeedLabel = Instance.new("TextLabel")
    local SpeedInput = Instance.new("TextBox")
    local LocalItemsButton = Instance.new("TextButton")
    local VersionLabel = Instance.new("TextLabel")
    local ESPButton = Instance.new("TextButton")

    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.Name = "MainMenuGui"

    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
    MainFrame.Size = UDim2.new(0, 600, 0, 400)
    MainFrame.Visible = false
    MainFrame.BorderSizePixel = 0

    ToggleButton.Parent = ScreenGui
    ToggleButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    ToggleButton.Position = UDim2.new(0, 0, 0, 0)
    ToggleButton.Size = UDim2.new(0, 120, 0, 60)
    ToggleButton.Text = "Menu"
    ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleButton.Font = Enum.Font.GothamBold
    ToggleButton.TextSize = 20

    CloseButton.Parent = MainFrame
    CloseButton.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
    CloseButton.Position = UDim2.new(0.5, -100, 1, -50)
    CloseButton.Size = UDim2.new(0, 100, 0, 40)
    CloseButton.Text = "Close"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.TextSize = 20

    FreezeButton.Parent = MainFrame
    FreezeButton.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
    FreezeButton.Position = UDim2.new(0.05, 0, 0.1, 0)
    FreezeButton.Size = UDim2.new(0, 120, 0, 50)
    FreezeButton.Text = "Freeze"
    FreezeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    FreezeButton.Font = Enum.Font.GothamBold
    FreezeButton.TextSize = 20

    SpeedLabel.Parent = MainFrame
    SpeedLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    SpeedLabel.Position = UDim2.new(0.25, 0, 0.4, 0)
    SpeedLabel.Size = UDim2.new(0, 120, 0, 30)
    SpeedLabel.Text = "Speed:"
    SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    SpeedLabel.Font = Enum.Font.GothamBold
    SpeedLabel.TextSize = 20

    SpeedInput.Parent = MainFrame
    SpeedInput.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    SpeedInput.Position = UDim2.new(0.45, 0, 0.4, 0)
    SpeedInput.Size = UDim2.new(0, 120, 0, 30)
    SpeedInput.Text = "16"
    SpeedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    SpeedInput.Font = Enum.Font.GothamBold
    SpeedInput.TextSize = 20

    LocalItemsButton.Parent = MainFrame
    LocalItemsButton.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
    LocalItemsButton.Position = UDim2.new(0.35, 0, 0.1, 0)
    LocalItemsButton.Size = UDim2.new(0, 120, 0, 50)
    LocalItemsButton.Text = "Local Items"
    LocalItemsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    LocalItemsButton.Font = Enum.Font.GothamBold
    LocalItemsButton.TextSize = 20

    VersionLabel.Parent = MainFrame
    VersionLabel.BackgroundTransparency = 1
    VersionLabel.Position = UDim2.new(1, -120, 1, -30)
    VersionLabel.Size = UDim2.new(0, 100, 0, 20)
    VersionLabel.Text = "Version 1.0"
    VersionLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    VersionLabel.Font = Enum.Font.GothamBold
    VersionLabel.TextSize = 16
    VersionLabel.BorderSizePixel = 1
    VersionLabel.BorderColor3 = Color3.fromRGB(0, 255, 0)

    ESPButton.Parent = MainFrame
    ESPButton.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
    ESPButton.Position = UDim2.new(0.65, 0, 0.1, 0)
    ESPButton.Size = UDim2.new(0, 120, 0, 50)
    ESPButton.Text = "ESP"
    ESPButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ESPButton.Font = Enum.Font.GothamBold
    ESPButton.TextSize = 20

    return {
        ScreenGui = ScreenGui,
        MainFrame = MainFrame,
        ToggleButton = ToggleButton,
        CloseButton = CloseButton,
        FreezeButton = FreezeButton,
        SpeedLabel = SpeedLabel,
        SpeedInput = SpeedInput,
        LocalItemsButton = LocalItemsButton,
        VersionLabel = VersionLabel,
        ESPButton = ESPButton
    }
end
local function setupElement(element)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 5)
    corner.Parent = element

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(0, 0, 0)
    stroke.Thickness = 1
    stroke.Parent = element
end

local function applyStyling(elements)
    setupElement(elements.ToggleButton)
    setupElement(elements.CloseButton)
    setupElement(elements.FreezeButton)
    setupElement(elements.SpeedInput)
    setupElement(elements.LocalItemsButton)
    setupElement(elements.ESPButton)
end

local function updateSpeedFromInput(SpeedInput, SpeedLabel, currentSpeed)
    local inputSpeed = tonumber(SpeedInput.Text)
    if inputSpeed and inputSpeed > 0 then
        SpeedLabel.Text = "Speed: " .. tostring(inputSpeed)
        return inputSpeed
    else
        SpeedInput.Text = tostring(currentSpeed)
        return currentSpeed
    end
end

local function setupFreezeButton(FreezeButton, SpeedLabel, SpeedInput)
    local isFrozen = false
    local currentSpeed = 16
    local connection

    local function toggleFreeze()
        local player = game.Players.LocalPlayer
        local character = player.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")

        if humanoid then
            if not isFrozen then
                character.HumanoidRootPart.Anchored = true
                connection = game:GetService("RunService").RenderStepped:Connect(function()
                    if isFrozen then
                        local moveDirection = humanoid.MoveDirection
                        local delta = moveDirection * currentSpeed / 60
                        character.HumanoidRootPart.CFrame = character.HumanoidRootPart.CFrame + delta
                    end
                end)
                isFrozen = true
                FreezeButton.Text = "Unfreeze"
                SpeedLabel.Visible = true
                SpeedInput.Visible = true
            else
                character.HumanoidRootPart.Anchored = false
                humanoid.WalkSpeed = 16
                isFrozen = false
                FreezeButton.Text = "Freeze"
                if connection then connection:Disconnect() end
                SpeedLabel.Visible = false
                SpeedInput.Visible = false
            end
        end
    end

    FreezeButton.MouseButton1Click:Connect(function()
        toggleFreeze()
    end)

    SpeedInput.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            currentSpeed = updateSpeedFromInput(SpeedInput, SpeedLabel, currentSpeed)
        end
    end)
end

local function giveAllItems()
    local player = game.Players.LocalPlayer
    local backpack = player.Backpack
    for _, asset in ipairs(game:GetDescendants()) do
        if asset:IsA("Tool") and not backpack:FindFirstChild(asset.Name) then
            asset:Clone().Parent = backpack
        end
    end
end

local function setupLocalItemsButton(LocalItemsButton)
    LocalItemsButton.MouseButton1Click:Connect(giveAllItems)
end

local function setupToggleButtons(ToggleButton, CloseButton, MainFrame)
    ToggleButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)

    CloseButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = false
    end)
end

local function setupESPButton(ESPButton)
    ESPButton.MouseButton1Click:Connect(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Ogurcik/esp-original/main/ESP%20script%20original.lua"))()
    end)
end
local function makeDraggable(gui)
    local dragging
    local dragInput
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart
        gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = gui.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    gui.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

local function initializeUI()
    -- Create UI elements
    local elements = createUI()

    -- Apply styling to elements
    applyStyling(elements)

    -- Set up functionality
    setupFreezeButton(elements.FreezeButton, elements.SpeedLabel, elements.SpeedInput)
    setupLocalItemsButton(elements.LocalItemsButton)
    setupToggleButtons(elements.ToggleButton, elements.CloseButton, elements.MainFrame)
    setupESPButton(elements.ESPButton)

    -- Make MainFrame draggable
    makeDraggable(elements.MainFrame)
end

-- Initialize UI
initializeUI()
