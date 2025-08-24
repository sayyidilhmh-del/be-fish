-- Be A Fish dengan Hitbox Modifier yang Bekerja
local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- Load script utama dengan delay
spawn(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/AkinaRulezx/beafish/refs/heads/main/OLD-Swee-Loader", true))()
    print("Script utama loaded!")
end)

-- Tunggu sebentar sebelum setup hitbox
wait(5)

-- Variabel untuk menyimpan original sizes
local OriginalSizes = {}

-- Fungsi untuk memperbesar hitbox (METHOD 1: Scale langsung)
local function EnlargeHitbox(multiplier)
    multiplier = multiplier or 2.0
    
    -- Pastikan karakter masih ada
    if not Character or not Character.Parent then
        Character = Player.Character
        if not Character then return end
        HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
    end
    
    -- Simpan ukuran original jika belum disimpan
    for _, part in ipairs(Character:GetDescendants()) do
        if part:IsA("BasePart") then
            if not OriginalSizes[part] then
                OriginalSizes[part] = part.Size
            end
            
            -- Method 1: Ubah size langsung
            part.Size = OriginalSizes[part] * multiplier
            
            -- Method 2: Ubah collision group (lebih efektif)
            if part:FindFirstChildOfClass("BodyVelocity") or part:FindFirstChildOfClass("BodyThrust") then
                part.CanCollide = false
                delay(0.1, function()
                    part.CanCollide = true
                end)
            end
        end
    end
    
    -- Method 3: Ubah melalui Humanoid (jika ada)
    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    if Humanoid then
        -- Coba ubah melalui hip height dll
        pcall(function()
            if not OriginalSizes["HipHeight"] then
                OriginalSizes["HipHeight"] = Humanoid.HipHeight
            end
            Humanoid.HipHeight = OriginalSizes["HipHeight"] * multiplier
        end)
    end
    
    print("Hitbox diperbesar "..multiplier.."x lipat!")
    
    -- Loop terus menerus untuk maintain size (karena script utama mungkin override)
    while task.wait(0.5) do
        for part, originalSize in pairs(OriginalSizes) do
            if part:IsA("BasePart") and part.Parent then
                if part.Size ~= originalSize * multiplier then
                    part.Size = originalSize * multiplier
                end
            end
        end
    end
end

-- Fungsi untuk reset hitbox
local function ResetHitbox()
    for part, originalSize in pairs(OriginalSizes) do
        if part:IsA("BasePart") and part.Parent then
            part.Size = originalSize
        elseif part == "HipHeight" and Character:FindFirstChildOfClass("Humanoid") then
            Character.Humanoid.HipHeight = originalSize
        end
    end
    print("Hitbox dikembalikan ke ukuran normal!")
end

-- GUI Mobile-Friendly
local function CreateMobileGUI()
    if Player.PlayerGui:FindFirstChild("MobileHitboxControl") then
        Player.PlayerGui.MobileHitboxControl:Destroy()
    end
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "MobileHitboxControl"
    ScreenGui.Parent = Player.PlayerGui
    
    -- Main Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 220, 0, 280)
    MainFrame.Position = UDim2.new(0, 10, 0.5, -140)
    MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    
    -- Title
    local Title = Instance.new("TextLabel")
    Title.Text = "🐟 HITBOX CONTROL"
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextScaled = true
    Title.Parent = MainFrame
    
    -- Size Buttons
    local sizes = {
        {"SMALL", 1.5, Color3.fromRGB(100, 100, 255)},
        {"MEDIUM", 2.0, Color3.fromRGB(100, 255, 100)},
        {"LARGE", 3.0, Color3.fromRGB(255, 150, 50)},
        {"XL", 4.0, Color3.fromRGB(255, 100, 100)},
        {"RESET", 1.0, Color3.fromRGB(200, 200, 200)}
    }
    
    for i, sizeData in ipairs(sizes) do
        local btn = Instance.new("TextButton")
        btn.Text = sizeData[1]
        btn.Size = UDim2.new(0.8, 0, 0, 40)
        btn.Position = UDim2.new(0.1, 0, 0, 45 + (i * 45))
        btn.BackgroundColor3 = sizeData[3]
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextScaled = true
        btn.Parent = MainFrame
        
        btn.MouseButton1Click:Connect(function()
            if sizeData[1] == "RESET" then
                ResetHitbox()
            else
                EnlargeHitbox(sizeData[2])
            end
        end)
    end
end

-- Alternative Method: Ubah melalui Camera (lebih reliable)
local function ChangeCameraDistance()
    while task.wait(1) do
        pcall(function()
            local cam = game.Workspace.CurrentCamera
            cam.FieldOfView = 70 -- Lebar field of view
            if cam:FindFirstChild("CameraSubject") then
                -- Coba manipulasi camera distance
                cam.CameraType = Enum.CameraType.Scriptable
                task.wait(0.1)
                cam.CameraType = Enum.CameraType.Custom
            end
        end)
    end
end

-- Alternative Method: Ubah collision groups
local function ModifyCollisionGroups()
    while task.wait(0.5) do
        pcall(function()
            -- Cari semua part di sekitar karakter
            local characterPos = HumanoidRootPart.Position
            local parts = workspace:FindPartsInRegion3(
                Region3.new(characterPos - Vector3.new(10, 10, 10), characterPos + Vector3.new(10, 10, 10)),
                nil,
                100
            )
            
            for _, part in ipairs(parts) do
                if part:IsA("BasePart") and part.CanCollide then
                    -- Coba ubah collision untuk part sekitar
                    part.CanCollide = false
                    task.wait(0.01)
                    part.CanCollide = true
                end
            end
        end)
    end
end

-- Main execution
spawn(function()
    wait(3) -- Tunggu script utama load dulu
    CreateMobileGUI()
    
    -- Coba semua method
    EnlargeHitbox(2.0)
    spawn(ChangeCameraDistance)
    spawn(ModifyCollisionGroups)
    
    print("Hitbox modifier activated!")
    print("Try different sizes from the GUI")
end)

-- Handle character changes
Player.CharacterAdded:Connect(function(newChar)
    Character = newChar
    HumanoidRootPart = newChar:WaitForChild("HumanoidRootPart")
    wait(2)
    EnlargeHitbox(2.0)
end)
