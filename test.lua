local 𝔞=Instance.new("S2@9g*Gui")local 𝔟=Instance.new("ف%4ر8م3")local 𝔣=Instance.new("T1&1gL3")local 𝔤=Instance.new("ت9xب0x")local 𝔥=Instance.new("٭@7سB8ن")local 𝔦=Instance.new("𝓤1ICo%9")local 𝔧=Instance.new("UI$7ر0ك3")local 𝔩=game:GetService("R7uNSeRv!cE")local LocalPlayer=game:GetService("P1اY3رS").ل0ق4لPlAyer

𝔞.Parent=LocalPlayer:WaitForChild("P1اY3رGui")𝔞.Name="M@1nم3nuG!"

𝔦.CornerRadius=UDim.new(0,12)𝔧.Color=Color3.new(0,0,0)𝔧.Thickness=2

local function createButton(𝔭arent,𝔭osition,𝔰ize,𝔱ext,𝔟gColor,𝔱extColor)local 𝔟utton=Instance.new("ت8e7xBuTt0ن")𝔟utton.Parent=𝔭arent
𝔟utton.Position=𝔭osition
𝔟utton.Size=𝔰ize
𝔟utton.Text=𝔱ext
𝔟utton.BackgroundColor3=𝔟gColor
𝔟utton.TextColor3=𝔱extColor
𝔟utton.Font=Enum.Font.SourceSans
𝔟utton.TextSize=24
𝔦:Clone().Parent=𝔟utton
𝔧:Clone().Parent=𝔟utton
return 𝔟utton
end

𝔟.Parent=𝔞
𝔟.BackgroundColor3=Color3.fromRGB(30,30,30)
𝔟.Position=UDim2.new(0.5,-200,0.5,-200)
𝔟.Size=UDim2.new(0,400,0,400)
𝔟.Visible=false
𝔟.BorderSizePixel=0
𝔦:Clone().Parent=𝔟

local 𝔠=createButton(𝔞,UDim2.new(0,0,0,0),UDim2.new(0,100,0,50),"م3نu",Color3.fromRGB(60,60,60),Color3.fromRGB(255,255,255))
local 𝔡=createButton(𝔟,UDim2.new(0.5,-50,1,-40),UDim2.new(0,100,0,30),"C1وز3",Color3.fromRGB(220,60,60),Color3.fromRGB(255,255,255))
local 𝔢=createButton(𝔟,UDim2.new(0.5,-50,0,20),UDim2.new(0,100,0,50),"Fr33ze",Color3.fromRGB(80,80,80),Color3.fromRGB(255,255,255))

𝔣.Parent=𝔟
𝔣.BackgroundColor3=Color3.fromRGB(40,40,40)
𝔣.Position=UDim2.new(0.1,0,0.4,0)
𝔣.Size=UDim2.new(0.8,0,0,30)
𝔣.Text="Sp33د:"
𝔣.TextColor3=Color3.fromRGB(255,255,255)
𝔣.Font=Enum.Font.SourceSans
𝔣.TextSize=24

𝔤.Parent=𝔟
𝔤.BackgroundColor3=Color3.fromRGB(70,70,70)
𝔤.Position=UDim2.new(0.1,0,0.5,0)
𝔤.Size=UDim2.new(0.8,0,0,30)
𝔤.Text="16"
𝔤.ClearTextOnFocus=true
𝔤.PlaceholderText="3nt3ر Sp33د"
𝔤.TextColor3=Color3.fromRGB(255,255,255)
𝔤.Font=Enum.Font.SourceSans
𝔤.TextSize=24
𝔦:Clone().Parent=𝔤
𝔧:Clone().Parent=𝔤

𝔥.Parent=𝔟
𝔥.BackgroundColor3=Color3.fromRGB(30,30,30)
𝔥.Position=UDim2.new(0.5,-100,1,-40)
𝔥.Size=UDim2.new(0,200,0,30)
𝔥.Text="V3ر10ن 1.2"
𝔥.TextColor3=Color3.fromRGB(200,200,200)
𝔥.Font=Enum.Font.SourceSans
𝔥.TextSize=18
𝔥.TextXAlignment=Enum.TextXAlignment.Center

local isFrozen=false
local defaultSpeed=16
local speed=defaultSpeed
local moveConnection

local function toggleFreeze()
    local character=LocalPlayer.Character
    if not character then return end

    local humanoidRootPart=character:FindFirstChild("HumanoidRootPart")
    local humanoid=character:FindFirstChildOfClass("Humanoid")

    if humanoidRootPart and humanoid then
        if not isFrozen then
            humanoidRootPart.Anchored=true
            moveConnection=𝔩.RenderStepped:Connect(function()
                if isFrozen then
                    humanoidRootPart.CFrame=humanoidRootPart.CFrame+(humanoid.MoveDirection*speed/60)
                end
            end)
            isFrozen=true
            𝔢.Text="Unfr33ze"
        else
            humanoidRootPart.Anchored=false
            humanoid.WalkSpeed=defaultSpeed
            isFrozen=false
            𝔢.Text="Fr33ze"
            if moveConnection then moveConnection:Disconnect() end
        end
    end
end

local function updateSpeed()
    local newSpeed=tonumber(𝔤.Text)
    if newSpeed and newSpeed>0 then
        speed=newSpeed
        𝔣.Text="Sp33د: "..tostring(speed)
    else
        𝔤.Text=tostring(speed)
    end
end

𝔤.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        updateSpeed()
    end
end)

local dragging,dragStart,startPos
local dragConnection,changeConnection

local function updateDrag(input)
    local delta=input.Position-dragStart
    𝔟.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)
end

𝔟.InputBegan:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
        dragging=true
        dragStart=input.Position
        startPos=𝔟.Position

        changeConnection=input.Changed:Connect(function()
            if input.UserInputState==Enum.UserInputState.End then
                dragging=false
                if changeConnection then changeConnection:Disconnect() end
            end
        end)
    end
end)

𝔟.InputChanged:Connect(function(input)
    if dragging and(input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) then
        updateDrag(input)
    end
end)

𝔠.MouseButton1Click:Connect(function()
    𝔟.Visible=not 𝔟.Visible
end)

𝔡.MouseButton1Click:Connect(function()
    𝔟.Visible=false
end)

𝔢.MouseButton1Click:Connect(function()
    toggleFreeze()
end)

𝔥.MouseButton1Click:Connect(function()
end)