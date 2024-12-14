local cam = workspace.CurrentCamera
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local onMobile = not UIS.KeyboardEnabled
local keysDown = {}
local rotating = false

if not game:IsLoaded() then game.Loaded:Wait() end

cam.CameraType = Enum.CameraType.Scriptable

local speed = 5
local sens = .3
local heightChangeSpeed = 0.5  -- Скорость изменения высоты камеры

speed /= 10
if onMobile then sens*=2 end

local function renderStepped()
    if rotating then
        local delta = UIS:GetMouseDelta()
        local cf = cam.CFrame
        local yAngle = cf:ToEulerAngles(Enum.RotationOrder.YZX)
        local newAmount = math.deg(yAngle)+delta.Y
        if newAmount > 65 or newAmount < -65 then
            if not (yAngle<0 and delta.Y<0) and not (yAngle>0 and delta.Y>0) then
                delta = Vector2.new(delta.X,0)
            end 
        end
        cf *= CFrame.Angles(-math.rad(delta.Y),0,0)
        cf = CFrame.Angles(0,-math.rad(delta.X),0) * (cf - cf.Position) + cf.Position
        cf = CFrame.lookAt(cf.Position, cf.Position + cf.LookVector)
        if delta ~= Vector2.new(0,0) then cam.CFrame = cam.CFrame:Lerp(cf,sens) end
        UIS.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition
    else
        UIS.MouseBehavior = Enum.MouseBehavior.Default
    end

    -- Движение камеры с клавишами W, A, S, D
    if keysDown["Enum.KeyCode.W"] then
        cam.CFrame *= CFrame.new(Vector3.new(0,0,-speed))
    end
    if keysDown["Enum.KeyCode.A"] then
        cam.CFrame *= CFrame.new(Vector3.new(-speed,0,0))
    end
    if keysDown["Enum.KeyCode.S"] then
        cam.CFrame *= CFrame.new(Vector3.new(0,0,speed))
    end
    if keysDown["Enum.KeyCode.D"] then
        cam.CFrame *= CFrame.new(Vector3.new(speed,0,0))
    end

    -- Изменение высоты камеры с помощью Ctrl и Пробела
    if keysDown["Enum.KeyCode.LeftControl"] then
        cam.CFrame *= CFrame.new(0, -heightChangeSpeed, 0)
    end
    if keysDown["Enum.KeyCode.Space"] then
        cam.CFrame *= CFrame.new(0, heightChangeSpeed, 0)
    end
end

RS.RenderStepped:Connect(renderStepped)

local validKeys = {"Enum.KeyCode.W","Enum.KeyCode.A","Enum.KeyCode.S","Enum.KeyCode.D", "Enum.KeyCode.LeftControl", "Enum.KeyCode.Space"}

UIS.InputBegan:Connect(function(Input)
    for i, key in pairs(validKeys) do
        if key == tostring(Input.KeyCode) then
            keysDown[key] = true
        end
    end
    if Input.UserInputType == Enum.UserInputType.MouseButton2 or (Input.UserInputType == Enum.UserInputType.Touch and UIS:GetMouseLocation().X>(cam.ViewportSize.X/2)) then
        rotating = true
    end
end)

UIS.InputEnded:Connect(function(Input)
    for key, v in pairs(keysDown) do
        if key == tostring(Input.KeyCode) then
            keysDown[key] = false
        end
    end
    if Input.UserInputType == Enum.UserInputType.MouseButton2 or (Input.UserInputType == Enum.UserInputType.Touch and UIS:GetMouseLocation().X>(cam.ViewportSize.X/2)) then
        rotating = false
    end
end)