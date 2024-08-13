local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Key System", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})


local KeyTab = Window:MakeTab({
	Name = "Key",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})


function makehub() 
	local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
	local Window = OrionLib:MakeWindow({Name = "CoronaVirus RP", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})
	local PlayerTab = Window:MakeTab({
		Name = "Player",
		Icon = "rbxassetid://4483345998",
		PremiumOnly = false
	})

	PlayerTab:AddSlider({
		Name = "Speed",
		Min = 0,
		Max = 500,
		Default = 5,
		Color = Color3.fromRGB(255,255,255),
		Increment = 1,
		ValueName = "Walk Speed",
		Callback = function(Value)
			game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
		end    
	})
	 
	PlayerTab:AddSlider({
		Name = "Jump Power ",
		Min = 0,
		Max = 500,
		Default = 5,
		Color = Color3.fromRGB(255,255,255),
		Increment = 1,
		ValueName = "JumpPower",
		Callback = function(Value)
			game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
		end    
	})
	 
	local MainTab = Window:MakeTab({
		Name = "Main",
		Icon = "rbxassetid://4483345998",
		PremiumOnly = false
	})
	
	
	MainTab:AddButton({
		Name = "Spy on chat",
		Callback = function()
			enabled = true
			--if true will xhexk your messages too
			spyOnMyself = true
			--if true will xhat the logs publikly (fun, risky)
			public = false
			--if true will use /me to stand out
			publicItalics = false
			--KUSTOMIZE private logs
			privateProperties = {
				Color = Color3.fromRGB(0,255,255); 
				Font = Enum.Font.SourceSansBold;
				TextSize = 18;
			}
			--////////////////////////////////////////////////////////////////
			local StarterGui = game:GetService("StarterGui")
			local Players = game:GetService("Players")
			local player = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait() or Players.LocalPlayer
			local saymsg = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest")
			local getmsg = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("OnMessageDoneFiltering")
			local instance = (_G.chatSpyInstance or 0) + 1
			_G.chatSpyInstance = instance
	 
			local function onChatted(p,msg)
				if _G.chatSpyInstance == instance then
					if p==player and msg:lower():sub(1,6)==".lu" then
						enabled = not enabled
						wait(0.3)
						privateProperties.Text = "{LOLLYPOP SPY "..(enabled and "EN" or "DIS").."ABLED}"
						StarterGui:SetCore("ChatMakeSystemMessage",privateProperties)
					elseif enabled and (spyOnMyself==true or p~=player) then
						msg = msg:gsub("[\n\r]",''):gsub("\t",' '):gsub("[ ]+",' ')
						local hidden = true
						local conn = getmsg.OnClientEvent:Connect(function(packet,channel)
							if packet.SpeakerUserId==p.UserId and packet.Message==msg:sub(#msg-#packet.Message+1) and (channel=="All" or (channel=="Team" and public==false and p.Team==player.Team)) then
								hidden = false
							end
						end)
						wait(1)
						conn:Disconnect()
						if hidden and enabled then
							if public then
								saymsg:FireServer((publicItalics and "/me " or '').."{SPY} [".. p.Name .."]: "..msg,"All")
							else
								privateProperties.Text = "{SPY} [".. p.Name .."]: "..msg
								StarterGui:SetCore("ChatMakeSystemMessage",privateProperties)
							end
						end
					end
				end
			end
	 
			for _,p in ipairs(Players:GetPlayers()) do
				p.Chatted:Connect(function(msg) onChatted(p,msg) end)
			end
			Players.PlayerAdded:Connect(function(p)
				p.Chatted:Connect(function(msg) onChatted(p,msg) end)
			end)
			privateProperties.Text = "{LOLLYPOP SPY "..(enabled and "EN" or "DIS").."ABLED}"
			player:WaitForChild("PlayerGui"):WaitForChild("Chat")
			StarterGui:SetCore("ChatMakeSystemMessage",privateProperties)
			wait(3)
			local chatFrame = player.PlayerGui.Chat.Frame
			chatFrame.ChatChannelParentFrame.Visible = true
			chatFrame.ChatBarParentFrame.Position = chatFrame.ChatChannelParentFrame.Position+UDim2.new(UDim.new(),chatFrame.ChatChannelParentFrame.Size.Y)
		  end    
	})
	 
	MainTab:AddButton({
		Name = "View Dropped Tools!",
		Callback = function()
			local Workspace1 = game:GetService("Workspace")
			Workspace1.ChildAdded:Connect(function(e)
				if e:IsA("Tool") and e.Parent == workspace then
					wait(0.5)
					local Highlight = Instance.new("Highlight")
					Highlight.FillColor = Color3.fromRGB(21,0,255)
					Highlight.FillTransparency = 0.25
					Highlight.OutlineColor = Color3.fromRGB(255,0,0)
					Highlight.OutlineTransparency = 0
					Highlight.Parent = e.Handle
				end
			end)
	 
			Workspace1.ChildRemoved:Connect(function(e)
				if e:IsA("Tool") then
	 
					local Highlight = Instance.new("Highlight")
					Highlight.FillColor = Color3.fromRGB(21,0,255)
					Highlight.FillTransparency = 0.25
					Highlight.OutlineColor = Color3.fromRGB(255,0,0)
					Highlight.OutlineTransparency = 0
					e.Handle.Highlight:Destroy()
				end
		  end)
	end    
	})
	 
	MainTab:AddButton({
		Name = "Remove Doors",
		Callback = function()
		game.workspace.Doors:Destroy()
	end    
	})
	
	MainTab:AddButton({
		Name = "Infinity Yield",
		Callback = function()
			loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
	end    
	})
	
	local IYMouse = game.Players.LocalPlayer:GetMouse()
	
	MainTab:AddButton({
		Name = "Tp tool",
		Callback = function()
			local TpTool = Instance.new("Tool")
		
		 TpTool.Name = "Teleport Tool"
		 TpTool.RequiresHandle = false
		 TpTool.Parent =  game.Players.LocalPlayer.Backpack
		 TpTool.Activated:Connect(function()
			local Char =  game.Players.LocalPlayer.Character
			local HRP = Char and Char:FindFirstChild("HumanoidRootPart")
			if not Char or not HRP then
				return warn("Failed to find HumanoidRootPart")
			end
			HRP.CFrame = CFrame.new(IYMouse.Hit.X, IYMouse.Hit.Y + 3, IYMouse.Hit.Z, select(4, HRP.CFrame:components()))
		end)
	end    
	})
	 
	
	
	local HitBoxTab = Window:MakeTab({
		Name = "HitBox Tab",
		Icon = "rbxassetid://4483345998",
		PremiumOnly = false
	})
	 
	local HitboxSize = 0 
	 
	 
	HitBoxTab:AddSlider({
		Name = "HitBox Size",
		Min = 0,
		Max = 500,
		Default = 0,
		Color = Color3.fromRGB(255,255,255),
		Increment = 1,
		ValueName = "",
		Callback = function(Value)
			HitboxSize = Value
		end    
	})
	 
	function Antilag()
		local Terrain = workspace:FindFirstChildOfClass('Terrain')
		local Lighting = game:GetService("Lighting")
		Terrain.WaterWaveSize = 0
		Terrain.WaterWaveSpeed = 0
		Terrain.WaterReflectance = 0
		Terrain.WaterTransparency = 0
		Lighting.GlobalShadows = false
		Lighting.FogEnd = 9e9
		settings().Rendering.QualityLevel = 1
		for i,v in pairs(game:GetDescendants()) do
			if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
				v.Material = "Plastic"
				v.Reflectance = 0
			elseif v:IsA("Decal") then
				v.Transparency = 1
			elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
				v.Lifetime = NumberRange.new(0)
			elseif v:IsA("Explosion") then
				v.BlastPressure = 1
				v.BlastRadius = 1
			end
		end
		for i,v in pairs(Lighting:GetDescendants()) do
			if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
				v.Enabled = false
			end
		end
		workspace.DescendantAdded:Connect(function(child)
			task.spawn(function()
				if child:IsA('ForceField') then
					RunService.Heartbeat:Wait()
					child:Destroy()
				elseif child:IsA('Sparkles') then
					RunService.Heartbeat:Wait()
					child:Destroy()
				elseif child:IsA('Smoke') or child:IsA('Fire') then
					RunService.Heartbeat:Wait()
					child:Destroy()
				end
			end)
		end)
	 end   
	
	
	HitBoxTab:AddButton({
		Name = "Hitbox expander(click again if its not works)",
		Callback = function()
		_G.HeadSize = HitboxSize
		_G.Disabled = true
	   
	   game:GetService('RunService').RenderStepped:connect(function()
	 if _G.Disabled then
	 for i,v in next, game:GetService('Players'):GetPlayers() do
	 if v.Name ~= game:GetService('Players').LocalPlayer.Name then
	 pcall(function()
	 v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)
	 v.Character.HumanoidRootPart.CanCollide = false
	 v.Character.HumanoidRootPart.CanTouch = true
	 v.Character.HumanoidRootPart.Transparency = 0.7
	 v.Character.HumanoidRootPart.CashShadow = false
	 v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Mid gray")
	 
	 
	end)
	end
	end
	end
	end)
	end    
	})
	 
	
	
	local ShteinWhereOptimizachia = Window:MakeTab({
		Name = "optimization",
		Icon = "rbxassetid://4483345998",
		PremiumOnly = false
	})
	 
	ShteinWhereOptimizachia:AddButton({
		Name = "Remove terrain",
		Callback = function(Value)
			workspace:FindFirstChildOfClass('Terrain'):Clear()
			
		end  
	 
	})
	
	ShteinWhereOptimizachia:AddButton({
		Name = "Anti Lag",
		Callback = function(Value)
			Antilag()
			
		end  
	 
	})
	
	
	
	local TeleportTab = Window:MakeTab({
		Name = "Teleport Tab",
		Icon = "rbxassetid://4483345998",
		PremiumOnly = false
	})
	 
	 
	TeleportTab:AddButton({
		Name = "Teleport To Kitchen",
		Callback = function(Value)
	 
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1275.59,-21.53,633.01)
		end  
	 
	})
	 
	TeleportTab:AddButton({
		Name = "Teleport To Exit",
		Callback = function(Value)
	 
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-100.67,-20.5,752.7)
		end  
	 
	})
	 
	
	 
	 
	TeleportTab:AddButton({
		Name = "Teleport To TFB Base",
		Callback = function(Value)
	 
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1033.42,-27.93,709.90)
		end  
	 
	})
	 
	TeleportTab:AddButton({
		Name = "Teleport To Secret room",
		Callback = function(Value)
	 
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-751.84,-10.95, 843.03)
	 
		end  
	 
	})
 end



function notify()
	OrionLib:MakeNotification({
		Name = "Key System",
		Content = "Key is correct. Loading hub.",
		Image = "rbxassetid://4483345998",
		Time = 5
	})
 end	

_G.Key = "RDC23"
_G.KeyInput = "string"

KeyTab:AddTextbox({
	Name = "Key",
	Default = "Key Here",
	TextDisappear = true,
	Callback = function(Value)
		_G.KeyInput = Value
	end	  
})



KeyTab:AddButton({
	Name = "Button!",
	Callback = function()
      	if _G.KeyInput == _G.Key then
			
			notify()
		    makehub()
			

            else
            game.Players.LocalPlayer:Kick("Ð°Ñ…Ð°Ñ…Ð° Ð±ÐµÐ·Ð´Ð°Ñ€ÑŒ Ð¸Ð´Ð¸ Ð¸Ñ‰Ð¸ Ð½Ð¾Ð²Ñ‹Ð¹ ÐºÐ»ÑŽÑ‡Ð¸Ðº")

		 end	
  	end    
})

OrionLib:Init()