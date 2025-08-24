-- BE A FISH ULTIMATE HACK + ANTI-AFK + MINIMIZABLE GUI
local Player = game.Players.LocalPlayer
local VirtualInput = game:GetService("VirtualInputManager")
local UIS = game:GetService("UserInputService")

-- Pertama, load script utama
loadstring(game:HttpGet("https://raw.githubusercontent.com/AkinaRulezx/beafish/refs/heads/main/OLD-Swee-Loader", true))()

-- Tunggu beberapa detik
wait(5)

print("Memulai hitbox modifier...")

-- ==================== ANTI-AFK SYSTEM ====================
local function EnableAntiAFK()
    local AntiAFKEnabled = true
    
    local function SimulateMovements()
        while AntiAFKEnabled and task.wait(2) do
            pcall(function()
                VirtualInput:SendMouseMoveEvent(10, 10, game:GetService("CoreGui"))
                task.wait(0.1)
                VirtualInput:SendMouseMoveEvent(-10, -10, game:GetService("CoreGui"))
                
                VirtualInput:SendKeyEvent(true, Enum.KeyCode.Space, false, nil)
                task.wait(0.1)
                VirtualInput:SendKeyEvent(false, Enum.KeyCode.Space, false, nil)
            end)
        end
    end

    local function CharacterAntiAFK()
        while AntiAFKEnabled and task.wait(5) do
            pcall(function()
                local character = Player.Character
                if character and character:FindFirstChild("Humanoid") then
                    local humanoid = character.Humanoid
                    humanoid:Move(Vector3.new(1, 0, 0))
                    task.wait(0.5)
                    humanoid:Move(Vector3.new(-1, 0, 0))
                end
            end)
        end
    end

    spawn(SimulateMovements)
    spawn(CharacterAntiAFK)

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
        end)
    end
end

local function ForceCharacterScale()
    while task.wait(0.5) do
        pcall(function()
            local char = Player.Character
            if char then
                local humanoid = char:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.WalkSpeed = 25
                end
            end
        end)
    end
end

-- ==================== ADVANCED MINIMIZABLE GUI ====================
local disableAntiAFK = nil
local MainFrame = nil
local MinimizedFrame = nil
local isMinimized = false

local function CreateAdvancedGUI()
    -- Hapus GUI lama jika ada
    if Player.PlayerGui:FindFirstChild("AdvancedHitboxControl") then
        Player.PlayerGui.AdvancedHitboxControl:Destroy()
    end
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "AdvancedHitboxControl"
    ScreenGui.Parent = Player.PlayerGui
    ScreenGui.ResetOnSpawn = false
    
    -- ===== MAIN FRAME (Maximized View) =====
    MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 300, 0, 350)
    MainFrame.Position = UDim2.new(0, 10, 0.5, -175)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    MainFrame.BorderSizePixel = 2
    MainFrame.BorderColor3 = Color3.fromRGB(100, 100, 200)
    MainFrame.Parent = ScreenGui
    
    -- Title Bar dengan drag functionality
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Size = UDim2.new(1, 0, 0, 30)
    TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = MainFrame
    
    local TitleText = Instance.new("TextLabel")
    TitleText.Text = "🎯 FISH HACK v3.0"
    TitleText.Size = UDim2.new(0.7, 0, 1, 0)
    TitleText.Position = UDim2.new(0, 10, 0, 0)
    TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleText.BackgroundTransparency = 1
    TitleText.TextXAlignment = Enum.TextXAlignment.Left
    TitleText.Parent = TitleBar
    
    -- Minimize Button
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Text = "─"
    MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
    MinimizeButton.Position = UDim2.new(1, -60, 0, 0)
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
    MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeButton.Font = Enum.Font.Bold
    MinimizeButton.Parent = TitleBar
    MinimizeButton.MouseButton1Click:Connect(function()
        isMinimized = true
        MainFrame.Visible = false
        MinimizedFrame.Visible = true
    end)
    
    -- Close Button (Hide saja, tidak destroy)
    local CloseButton = Instance.new("TextButton")
    CloseButton.Text = "×"
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -30, 0, 0)
    CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.Font = Enum.Font.Bold
    CloseButton.Parent = TitleBar
    CloseButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = false
        MinimizedFrame.Visible = true
        isMinimized = true
    end)
    
    -- Drag functionality untuk TitleBar
    local dragging = false
    local dragInput, dragStart, startPos

    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    TitleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    -- Content Area
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Size = UDim2.new(1, 0, 1, -30)
    ContentFrame.Position = UDim2.new(0, 0, 0, 30)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.Parent = MainFrame
    
    -- Anti-AFK Status
    local AFKStatus = Instance.new("TextLabel")
    AFKStatus.Text = "🔴 ANTI-AFK: OFF"
    AFKStatus.Size = UDim2.new(0.9, 0, 0, 30)
    AFKStatus.Position = UDim2.new(0.05, 0, 0, 10)
    AFKStatus.TextColor3 = Color3.fromRGB(255, 100, 100)
    AFKStatus.BackgroundTransparency = 1
    AFKStatus.TextScaled = true
    AFKStatus.Parent = ContentFrame
    
    -- Action Buttons
    local buttons = {
        {"🚀 ENABLE HACK", Color3.fromRGB(0, 150, 0), function()
            spawn(CameraManipulation)
            spawn(ForceCharacterScale)
            print("HACKS ACTIVATED!")
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
        {"⚡ SPEED BOOST", Color3.fromRGB(200, 150, 0), function()
            pcall(function()
                local humanoid = Player.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.WalkSpeed = 35
                end
            end)
        end},
        {"💤 AUTO MODE", Color3.fromRGB(0, 100, 200), function()
            spawn(CameraManipulation)
            spawn(ForceCharacterScale)
            if not disableAntiAFK then
                disableAntiAFK = EnableAntiAFK()
                AFKStatus.Text = "🟢 ANTI-AFK: ON"
                AFKStatus.TextColor3 = Color3.fromRGB(100, 255, 100)
            end
        end}
    }
    
    for i, btnData in ipairs(buttons) do
        local btn = Instance.new("TextButton")
        btn.Text = btnData[1]
        btn.Size = UDim2.new(0.9, 0, 0, 50)
        btn.Position = UDim2.new(0.05, 0, 0, 50 + (i * 60))
        btn.BackgroundColor3 = btnData[2]
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextScaled = true
        btn.Parent = ContentFrame
        
        -- Hover effect
        btn.MouseEnter:Connect(function()
            btn.BackgroundColor3 = btnData[2] * Color3.new(1.2, 1.2, 1.2)
        end)
        btn.MouseLeave:Connect(function()
            btn.BackgroundColor3 = btnData[2]
        end)
        
        btn.MouseButton1Click:Connect(btnData[3])
    end
    
    -- ===== MINIMIZED FRAME =====
    MinimizedFrame = Instance.new("Frame")
    MinimizedFrame.Name = "MinimizedFrame"
    MinimizedFrame.Size = UDim2.new(0, 100, 0, 40)
    MinimizedFrame.Position = UDim2.new(0, 10, 0.5, -20)
    MinimizedFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    MinimizedFrame.BorderSizePixel = 2
    MinimizedFrame.BorderColor3 = Color3.fromRGB(100, 100, 200)
    MinimizedFrame.Visible = false
    MinimizedFrame.Parent = ScreenGui
    
    local MinimizedTitle = Instance.new("TextLabel")
    MinimizedTitle.Text = "🎯 MENU"
    MinimizedTitle.Size = UDim2.new(0.7, 0, 1, 0)
    MinimizedTitle.Position = UDim2.new(0, 10, 0, 0)
    MinimizedTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizedTitle.BackgroundTransparency = 1
    MinimizedTitle.TextXAlignment = Enum.TextXAlignment.Left
    MinimizedTitle.Parent = MinimizedFrame
    
    local MaximizeButton = Instance.new("TextButton")
    MaximizeButton.Text = "＋"
    MaximizeButton.Size = UDim2.new(0, 30, 0, 30)
    MaximizeButton.Position = UDim2.new(1, -35, 0.5, -15)
    MaximizeButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    MaximizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    MaximizeButton.Font = Enum.Font.Bold
    MaximizeButton.Parent = MinimizedFrame
    MaximizeButton.MouseButton1Click:Connect(function()
        isMinimized = false
        MainFrame.Visible = true
        MinimizedFrame.Visible = false
    end)
    
    -- Drag functionality untuk minimized frame
    local minDragging = false
    local minDragInput, minDragStart, minStartPos

    MinimizedFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            minDragging = true
            minDragStart = input.Position
            minStartPos = MinimizedFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    minDragging = false
                end
            end)
        end
    end)

    MinimizedFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            minDragInput = input
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if input == minDragInput and minDragging then
            local delta = input.Position - minDragStart
            MinimizedFrame.Position = UDim2.new(minStartPos.X.Scale, minStartPos.X.Offset + delta.X, minStartPos.Y.Scale, minStartPos.Y.Offset + delta.Y)
        end
    end)
    
    -- Toggle GUI dengan keypress (Mobile friendly)
    spawn(function()
        while task.wait(0.5) do
            pcall(function()
                -- Double tap untuk toggle GUI
                if UIS:GetKeysPressed()[Enum.KeyCode.LeftControl] then
                    if isMinimized then
                        isMinimized = false
                        MainFrame.Visible = true
                        MinimizedFrame.Visible = false
                    else
                        isMinimized = true
                        MainFrame.Visible = false
                        MinimizedFrame.Visible = true
                    end
                    wait(1) -- Cooldown
                end
            end)
        end
    end)
end

-- ==================== AUTO START ====================
spawn(function()
    wait(8)
    if not disableAntiAFK then
        disableAntiAFK = EnableAntiAFK()
        print("🟢 ANTI-AFK AUTO-ENABLED!")
    end
end)

-- Main GUI setup
wait(3)
CreateAdvancedGUI()

print("==========================================")
print("ADVANCED HACK GUI LOADED!")
print("Features: Minimize/Maximize, Draggable")
print("Double-tap Ctrl to toggle GUI")
print("==========================================")

-- Handle character respawn
Player.CharacterAdded:Connect(function()
    wait(3)
    CreateAdvancedGUI()
    if disableAntiAFK then
        disableAntiAFK = EnableAntiAFK()
    end
end)
