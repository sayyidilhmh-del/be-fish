--// Be A Fish Updated UI Script
--// Made by Queen

-- Load OrionLib
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = " Be a Fish Hub | Queen", HidePremium = false, SaveConfig = true, ConfigFolder = "BeAFishHub"})

-- Variables
local ESPEnabled = false
local TracerEnabled = false
local MaxDistance = 200
local SpeedEnabled = false
local SpeedValue = 50
local SavedCoords = {}
local EatRangeEnabled = false
local EatRangeValue = 20

-- Watermark (Notifikasi saat dijalankan)
OrionLib:MakeNotification({
    Name = "Made by Queen",
    Content = "Be a Fish Hub berhasil dijalankan!",
    Image = "rbxassetid://4483345998",
    Time = 5
})

-- ESP + Tracer
local function CreateESP(player)
    if player.Character and player.Character:FindFirstChild("Head") then
        local Billboard = Instance.new("BillboardGui", player.Character.Head)
        Billboard.Name = "Queen_ESP"
        Billboard.Size = UDim2.new(0, 200, 0, 50)
        Billboard.AlwaysOnTop = true

        local Label = Instance.new("TextLabel", Billboard)
        Label.Size = UDim2.new(1,0,1,0)
        Label.BackgroundTransparency = 1
        Label.Text = player.Name
        Label.TextColor3 = Color3.fromRGB(0,255,0)
        Label.TextScaled = true
    end
end

game.Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function()
        if ESPEnabled then
            CreateESP(plr)
        end
    end)
end)

-- Speed Hack
game:GetService("RunService").Heartbeat:Connect(function()
    if SpeedEnabled and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = SpeedValue
    end
end)

-- Wide Eat Range
game:GetService("RunService").Heartbeat:Connect(function()
    if EatRangeEnabled then
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            for _,v in pairs(workspace:GetDescendants()) do
                if v:IsA("Part") and v.Name == "FishHitbox" then
                    if (v.Position - char.HumanoidRootPart.Position).Magnitude <= EatRangeValue then
                        firetouchinterest(char.HumanoidRootPart, v, 0)
                        firetouchinterest(char.HumanoidRootPart, v, 1)
                    end
                end
            end
        end
    end
end)

-- Tabs
local MainTab = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

MainTab:AddToggle({
	Name = "ESP",
	Default = false,
	Callback = function(Value)
		ESPEnabled = Value
	end    
})

MainTab:AddToggle({
	Name = "Tracer ESP",
	Default = false,
	Callback = function(Value)
		TracerEnabled = Value
	end    
})

MainTab:AddSlider({
	Name = "Tracer Max Distance",
	Min = 50,
	Max = 500,
	Default = 200,
	Color = Color3.fromRGB(255,255,255),
	Increment = 10,
	ValueName = "Studs",
	Callback = function(Value)
		MaxDistance = Value
	end    
})

MainTab:AddToggle({
	Name = "Speed Hack",
	Default = false,
	Callback = function(Value)
		SpeedEnabled = Value
	end    
})

MainTab:AddSlider({
	Name = "Speed Value",
	Min = 16,
	Max = 100,
	Default = 50,
	Color = Color3.fromRGB(0,255,0),
	Increment = 1,
	ValueName = "WalkSpeed",
	Callback = function(Value)
		SpeedValue = Value
	end    
})

MainTab:AddToggle({
	Name = "Wide Eat Range",
	Default = false,
	Callback = function(Value)
		EatRangeEnabled = Value
	end    
})

MainTab:AddSlider({
	Name = "Eat Range Distance",
	Min = 10,
	Max = 200,
	Default = 20,
	Color = Color3.fromRGB(255,100,100),
	Increment = 5,
	ValueName = "Studs",
	Callback = function(Value)
		EatRangeValue = Value
	end    
})

-- Teleport Tab
local TeleTab = Window:MakeTab({
	Name = "Teleport",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

TeleTab:AddButton({
	Name = "Save Current Position",
	Callback = function()
		local pos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
		table.insert(SavedCoords, pos)
		OrionLib:MakeNotification({Name="Saved!",Content="Koordinat berhasil disimpan.",Time=3})
	end    
})

TeleTab:AddDropdown({
	Name = "Teleport to Saved Coords",
	Default = "",
	Options = {},
	Callback = function(Value)
		for _,pos in pairs(SavedCoords) do
			if tostring(pos) == Value then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos)
			end
		end
	end    
})

-- Misc Tab
local MiscTab = Window:MakeTab({
	Name = "Misc",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

MiscTab:AddButton({
	Name = "Remove Laggy Visuals",
	Callback = function()
		for _,v in pairs(workspace:GetDescendants()) do
			if v:IsA("Texture") or v:IsA("Decal") or v:IsA("ParticleEmitter") then
				v:Destroy()
			end
		end
	end    
})

MiscTab:AddLabel("FPS Counter otomatis aktif")

-- FPS Counter
local RunService = game:GetService("RunService")
local fpsLabel = Drawing.new("Text")
fpsLabel.Size = 18
fpsLabel.Position = Vector2.new(10, 50)
fpsLabel.Color = Color3.fromRGB(0,255,0)
fpsLabel.Text = "FPS: 0"

RunService.RenderStepped:Connect(function()
    local fps = math.floor(1 / RunService.RenderStepped:Wait())
    fpsLabel.Text = "FPS: "..tostring(fps)
end)

-- Init
OrionLib:Init()
