local _0x9a83b = Instance.new("ScreenGui")
local _0x8b56d = Instance.new("Frame")
local _0x1c8d2 = Instance.new("TextLabel")
local _0x6b3a5 = Instance.new("TextBox")
local _0x7e4e1 = Instance.new("TextButton")
local _0x3d2d9 = Instance.new("UICorner")
local _0x2f6d1 = Instance.new("UIStroke")
local _0x4d8b7 = game:GetService("RunService")
local _0x6b1a9 = game:GetService("Players").LocalPlayer
local _0x1f32d = 300

_0x9a83b.Parent = _0x6b1a9:WaitForChild("PlayerGui")
_0x9a83b.Name = "MainMenuGui"

_0x3d2d9.CornerRadius = UDim.new(0, 12)
_0x2f6d1.Color = Color3.new(0, 0, 0)
_0x2f6d1.Thickness = 2

local function _0x51d6c(_0x1a9b7, _0x2043b, _0x1f45b, _0x25e9b, _0x3e40c, _0x17d8f)
    local _0x2e01f = Instance.new("TextButton")
    _0x2e01f.Parent = _0x1a9b7
    _0x2e01f.Position = _0x2043b
    _0x2e01f.Size = _0x1f45b
    _0x2e01f.Text = _0x25e9b
    _0x2e01f.BackgroundColor3 = _0x3e40c
    _0x2e01f.TextColor3 = _0x17d8f
    _0x3d2d9:Clone().Parent = _0x2e01f
    _0x2f6d1:Clone().Parent = _0x2e01f
    return _0x2e01f
end

_0x8b56d.Parent = _0x9a83b
_0x8b56d.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
_0x8b56d.Position = UDim2.new(0.5, -200, 0.5, -200)
_0x8b56d.Size = UDim2.new(0, 400, 0, 400)
_0x8b56d.Visible = false
_0x8b56d.BorderSizePixel = 0
_0x3d2d9:Clone().Parent = _0x8b56d

local _0x2e04b = _0x51d6c(_0x9a83b, UDim2.new(0, 0, 0, 0), UDim2.new(0, 100, 0, 50), "Menu", Color3.fromRGB(60, 60, 60), Color3.fromRGB(255, 255, 255))
local _0x2e05b = _0x51d6c(_0x8b56d, UDim2.new(0.5, -50, 1, -40), UDim2.new(0, 100, 0, 30), "Close", Color3.fromRGB(220, 60, 60), Color3.fromRGB(255, 255, 255))
local _0x2e06b = _0x51d6c(_0x8b56d, UDim2.new(0.5, -50, 0, 20), UDim2.new(0, 100, 0, 50), "Freeze", Color3.fromRGB(80, 80, 80), Color3.fromRGB(255, 255, 255))

_0x1c8d2.Parent = _0x8b56d
_0x1c8d2.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
_0x1c8d2.Position = UDim2.new(0.1, 0, 0.4, 0)
_0x1c8d2.Size = UDim2.new(0.8, 0, 0, 30)
_0x1c8d2.Text = "Speed:"
_0x1c8d2.TextColor3 = Color3.fromRGB(255, 255, 255)
_0x1c8d2.Font = Enum.Font.SourceSans
_0x1c8d2.TextSize = 24

_0x6b3a5.Parent = _0x8b56d
_0x6b3a5.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
_0x6b3a5.Position = UDim2.new(0.1, 0, 0.5, 0)
_0x6b3a5.Size = UDim2.new(0.8, 0, 0, 30)
_0x6b3a5.Text = "16"
_0x6b3a5.ClearTextOnFocus = true
_0x6b3a5.PlaceholderText = "Enter Speed"
_0x6b3a5.TextColor3 = Color3.fromRGB(255, 255, 255)
_0x6b3a5.Font = Enum.Font.SourceSans
_0x6b3a5.TextSize = 24
_0x3d2d9:Clone().Parent = _0x6b3a5
_0x2f6d1:Clone().Parent = _0x6b3a5

_0x7e4e1.Parent = _0x8b56d
_0x7e4e1.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
_0x7e4e1.Position = UDim2.new(0.5, -100, 1, -40)
_0x7e4e1.Size = UDim2.new(0, 200, 0, 30)
_0x7e4e1.Text = "Version 1.2"
_0x7e4e1.TextColor3 = Color3.fromRGB(200, 200, 200)
_0x7e4e1.Font = Enum.Font.SourceSans
_0x7e4e1.TextSize = 18
_0x7e4e1.TextXAlignment = Enum.TextXAlignment.Center
local _0x6d99c
local _0x4e7f9 = false
local _0x6e9b5 = 16
local _0x1b3f6 = _0x6e9b5
local _0x8b5a7

_0x6d99c = function()
    local _0x6b1b5 = tonumber(_0x6b3a5.Text)
    if _0x6b1b5 and _0x6b1b5 > 0 then
        _0x1b3f6 = _0x6b1b5
        _0x1c8d2.Text = "Speed: " .. tostring(_0x1b3f6)
    else
        _0x6b3a5.Text = tostring(_0x1b3f6)
    end
end

local function _0x6bcd9()
    local _0x6b1c9 = _0x6b1a9.Character
    if not _0x6b1c9 then return end

    local _0x1e9b5 = _0x6b1c9:FindFirstChild("HumanoidRootPart")
    local _0x8d2b6 = _0x6b1c9:FindFirstChildOfClass("Humanoid")

    if _0x1e9b5 and _0x8d2b6 then
        if not _0x4e7f9 then
            _0x1e9b5.Anchored = true
            _0x8b5a7 = _0x4d8b7.RenderStepped:Connect(function()
                if _0x4e7f9 then
                    _0x1e9b5.CFrame = _0x1e9b5.CFrame + (_0x8d2b6.MoveDirection * _0x1b3f6 / 60)
                end
            end)
            _0x4e7f9 = true
            _0x2e06b.Text = "Unfreeze"
        else
            _0x1e9b5.Anchored = false
            _0x8d2b6.WalkSpeed = _0x6e9b5
            _0x4e7f9 = false
            _0x2e06b.Text = "Freeze"
            if _0x8b5a7 then _0x8b5a7:Disconnect() end
        end
    end
end

_0x6b3a5.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        _0x6d99c()
    end
end)

_0x2e05b.MouseButton1Click:Connect(function()
    _0x8b56d.Visible = false
end)

_0x2e06b.MouseButton1Click:Connect(function()
    _0x6bcd9()
end)

_0x2e04b.MouseButton1Click:Connect(function()
    _0x8b56d.Visible = not _0x8b56d.Visible
end)