-- BE A FISH ULTIMATE HACK + ANTI-AFK (MOBILE EDITION)
local Player = game.Players.LocalPlayer
local VirtualInput = game:GetService("VirtualInputManager")

-- Pertama, load script utama
loadstring(game:HttpGet("https://raw.githubusercontent.com/AkinaRulezx/beafish/refs/heads/main/OLD-Swee-Loader", true))()

-- Tunggu beberapa detik
wait(5)

print("Memulai hitbox modifier...")

-- ==================== ANTI-AFK SYSTEM ====================
local function EnableAntiAFK()
    local AntiAFKEnabled = true
    
    -- Method 1: Prevent AFK by simulating movements
    local function SimulateMovements()
        while AntiAFKEnabled and task.wait(2) do
            pcall(function()
                -- Simulate slight mouse movement
                VirtualInput:SendMouseMoveEvent(10, 10, game:GetService("CoreGui"))
                task.wait(0.1)
                VirtualInput:SendMouseMoveEvent(-10, -10, game:GetService("CoreGui"))
                
                -- Simulate key press
                VirtualInput:SendKeyEvent(true, Enum.KeyCode.Space, false, nil)
                task.wait(0.1)
                VirtualInput:SendKeyEvent(false, Enum.KeyCode.Space, false, nil)
            end)
        end
    end

    -- Method 2: Character movement simulation
    local function CharacterAntiAFK()
        while AntiAFKEnabled and task.wait(5) do
            pcall(function()
                local character = Player.Character
                if character and character:FindFirstChild("Humanoid") then
                    local humanoid = character.Humanoid
                    
                    -- Small movement in different directions
                    humanoid:Move(Vector3.new(1, 0, 0))
                    task.wait(0.5)
                    humanoid:Move(Vector3.new(-1, 0, 0))
                    task.wait(0.5)
                    humanoid:Move(Vector3.new(0, 0, 1))
                    task.wait(0.5)
                    humanoid:Move(Vector3.new(0, 0, -1))
                end
            end)
        end
    end

    -- Method 3: Camera rotation simulation
    local function CameraAntiAFK()
        while AntiAFKEnabled and task.wait(8) do
            pcall(function()
                local cam = workspace.CurrentCamera
                if cam then
                    -- Slight camera rotation
                    cam.CFrame = cam.CFrame * CFrame.Angles(0, math.rad(5), 0)
                    task.wait(1)
                    cam.CFrame = cam.CFrame * CFrame.Angles(0, math.rad(-5), 0)
                end
            end)
        end
    end

    -- Method 4: GUI interaction simulation (for mobile)
    local function GUIAntiAFK()
        while AntiAFKEnabled and task.wait(10) do
            pcall(function()
                -- Simulate touch input
                VirtualInput:SendMouseButtonEvent(100, 100, 0, true, game:GetService("CoreGui"), 1)
                task.wait(0.1)
                VirtualInput:SendMouseButtonEvent(100, 100, 0, false, game:GetService("CoreGui"), 1)
            end)
        end
    end

    -- Method 5: Network activity simulation
    local function NetworkAntiAFK()
        while AntiAFKEnabled and task.wait(3) do
            pcall(function()
                -- Change a value to simulate activity
                if Player:FindFirstChild("PlayerGui") then
                    Player.PlayerGui:SetAttribute("AntiAFK_" .. tick(), true)
                end
            end)
        end
    end

    -- Start all anti-AFK methods
    spawn(SimulateMovements)
    spawn(CharacterAntiAFK)
    spawn(CameraAntiAFK)
    spawn(GUIAntiAFK)
    spawn(NetworkAntiAFK)

    print("🔒 ANTI-AFK SYSTEM ACTIVATED!")
    
    return function()
        AntiAFKEnabled = false
        print("🔓 ANTI-AFK SYSTEM DISABLED!")
    end
end

-- ==================== HITBOX MODIFIER ====================
local function CameraManipulation()
    while task.wait(1) do
        pcall(function()
            local cam = workspace.CurrentCamera
            cam.FieldOfView = 80
            if cam.CameraType == Enum.CameraType.Custom then
                cam.CameraSubject = nil
                task.wait(0.1)
                cam.CameraSubject = Player.Character.Humanoid
            end
        end)
    end
end

local function ForceCharacterScale()
    while task.wait(0.5) do
        pcall(function()
            local char = Player.Character
            if char then
                char:SetAttribute("ForceScale", 1.8)
                local humanoid = char:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.HipHeight = 3.0
                    humanoid.WalkSpeed = 25
                end
            end
        end)
    end
end

local function CollisionBypass()
    while task.wait(0.3) do
        pcall(function()
            local char = Player.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local root = char.HumanoidRootPart
                local position = root.Position
                
                local region = Region3.new(
                    position - Vector3.new(8, 8, 8),
                    position + Vector3.new(8, 8, 8)
                )
                
                local parts = workspace:FindPartsInRegion3(region, nil, 50)
                
                for _, part in ipairs(parts) do
                    if part.CanCollide and part ~= root then
                        part.CanCollide = false
                        task.delay(0.2, function()
                            part.CanCollide = true
                        end)
                    end
                end
            end
        end)
    end
end

local function CreateVisualHitbox()
    pcall(function()
        local char = Player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            if char:FindFirstChild("VisualHitbox") then
                char.VisualHitbox:Destroy()
            end
            
            local visualPart = Instance.new("Part")
            visualPart.Name = "VisualHitbox"
            visualPart.Size = Vector3.new(6, 6, 6)
            visualPart.Transparency = 0.7
            visualPart.Color = Color3.fromRGB(255, 0, 0)
            visualPart.Material = Enum.Material.Neon
            visualPart.Anchored = true
            visualPart.CanCollide = false
            visualPart.Parent = char
            
            while task.wait(0.1) and char and char.Parent do
                pcall(function()
                    visualPart.CFrame = char.HumanoidRootPart.CFrame
                end)
            end
        end
    end)
end

-- ==================== MOBILE GUI ====================
local disableAntiAFK = nil

local function CreateMobileControl()
    if Player.PlayerGui:FindFirstChild("HitboxControl") then
        Player.PlayerGui.HitboxControl:Destroy()
    end
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "HitboxControl"
    ScreenGui.Parent = Player.PlayerGui
    
    -- Main Control Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 280, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -140, 0.7, -150)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    
    -- Title
    local Title = Instance.new("TextLabel")
    Title.Text = "🎯 ULTIMATE HACK v2.0"
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextScaled = true
    Title.Parent = MainFrame
    
    -- Anti-AFK Status
    local AFKStatus = Instance.new("TextLabel")
    AFKStatus.Text = "🔴 ANTI-AFK: OFF"
    AFKStatus.Size = UDim2.new(1, 0, 0, 30)
    AFKStatus.Position = UDim2.new(0, 0, 0, 45)
    AFKStatus.TextColor3 = Color3.fromRGB(255, 100, 100)
    AFKStatus.BackgroundTransparency = 1
    AFKStatus.TextScaled = true
    AFKStatus.Parent = MainFrame
    
    -- Action Buttons
    local buttons = {
        {"🚀 ENABLE HACK", Color3.fromRGB(0, 200, 0), function()
            spawn(CameraManipulation)
            spawn(ForceCharacterScale)
            spawn(CollisionBypass)
            spawn(CreateVisualHitbox)
            print("ALL HACKS ACTIVATED!")
        end},
        {"📊 VISUAL HITBOX", Color3.fromRGB(0, 150, 200), CreateVisualHitbox},
        {"⚡ SPEED BOOST", Color3.fromRGB(200, 150, 0), function()
            pcall(function()
                local humanoid = Player.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.WalkSpeed = 30
                    humanoid.JumpPower = 60
                end
            end)
        end},
        {"🔒 TOGGLE ANTI-AFK", Color3.fromRGB(150, 0, 200), function()
            if disableAntiAFK then
                disableAntiAFK()
                disableAntiAFK = nil
                AFKStatus.Text = "🔴 ANTI-AFK: OFF"
                AFKStatus.TextColor3 = Color3.fromRGB(255, 100, 100)
            else
                disableAntiAFK = EnableAntiAFK()
                AFKStatus.Text = "🟢 ANTI-AFK: ON"
                AFKStatus.TextColor3 = Color3.fromRGB(100, 255, 100)
            end
        end},
        {"💤 AUTO FISH MODE", Color3.fromRGB(200, 100, 0), function()
            -- Auto enable both hack and anti-afk
            spawn(CameraManipulation)
            spawn(ForceCharacterScale)
            spawn(CollisionBypass)
            if not disableAntiAFK then
                disableAntiAFK = EnableAntiAFK()
                AFKStatus.Text = "🟢 ANTI-AFK: ON"
                AFKStatus.TextColor3 = Color3.fromRGB(100, 255, 100)
            end
            print("🎣 AUTO FISH MODE ACTIVATED!")
        end}
    }
    
    for i, btnData in ipairs(buttons) do
        local btn = Instance.new("TextButton")
        btn.Text = btnData[1]
        btn.Size = UDim2.new(0.9, 0, 0, 45)
        btn.Position = UDim2.new(0.05, 0, 0, 80 + (i * 50))
        btn.BackgroundColor3 = btnData[2]
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextScaled = true
        btn.Parent = MainFrame
        btn.MouseButton1Click:Connect(btnData[3])
    end
end

-- ==================== AUTO START ====================
-- Auto enable Anti-AFK setelah 10 detik
spawn(function()
    wait(10)
    if not disableAntiAFK then
        disableAntiAFK = EnableAntiAFK()
        print("🟢 ANTI-AFK AUTO-ENABLED!")
    end
end)

-- Main GUI setup
wait(3)
CreateMobileControl()

print("==========================================")
print("BE A FISH ULTIMATE HACK + ANTI-AFK LOADED!")
print("Anti-AFK will auto enable in 10 seconds!")
print("==========================================")

-- Handle character respawn
Player.CharacterAdded:Connect(function()
    wait(3)
    CreateMobileControl()
    if disableAntiAFK then
        disableAntiAFK = EnableAntiAFK()
    end
end)
