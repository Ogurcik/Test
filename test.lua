
task.wait(1)

-- // Переменные.
local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local LocalPlayer = Players.LocalPlayer
local PlayerBackpack = LocalPlayer.Backpack

-- // Функция, которая выдаёт все доступные для игрока предметы без повторяющихся эпизодов.
local function GetAllAvailableItems()
    for _index, asset in game:GetDescendants() do
        if asset:IsA("Tool") and not PlayerBackpack:FindFirstChild(asset.Name) then
            asset:Clone().Parent = PlayerBackpack
        end
    end
end

-- // Если игрок написал что-то.
local function onPlayerChatted(textChatMessage: TextChatMessage | string)
    local context

    if typeof(textChatMessage) == "string" then
        context = textChatMessage
    else
        context = textChatMessage.Text
    end

    if string.find(context, ";give me all") then
        GetAllAvailableItems()
    end
end

-- // Коннекты.
TextChatService.MessageReceived:Connect(onPlayerChatted)
LocalPlayer.Chatted:Connect(onPlayerChatted)
