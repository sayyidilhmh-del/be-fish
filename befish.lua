-- Gabungan Script Be A Fish dengan Hitbox Modifier (Mobile Version)
local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- ===== KODE AWAL =====
loadstring(game:HttpGet("https://raw.githubusercontent.com/AkinaRulezx/beafish/refs/heads/main/OLD-Swee-Loader", true))()
-- =====================

-- Tunggu sebentar agar script utama load
wait(3)

-- Fungsi untuk memperbesar hitbox
local function EnlargeHitbox(multiplier)
    multiplier = multiplier or 2.0 -- Default 2x lipat
    
    -- Cari semua parts yang perlu diperbesar
    for _, part in ipairs(Character:GetDescendants()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            -- Simpan size original terlebih dahulu
            if not part:FindFirstChild("OriginalSize") then
                local originalSize = Instance.new("Vector3Value")
                originalSize.Name = "OriginalSize"
                originalSize.Value = part.Size
                originalSize.Parent = part
            end
            
            -- Perbesar size part
            local originalSize = part:FindFirstChild("OriginalSize")
            if originalSize then
                part.Size = originalSize.Value * multiplier
            end
        end
    end
    
    -- Perbesar juga collision group jika ada
    if HumanoidRootPart then
        if not HumanoidRootPart:FindFirstChild("OriginalSize") then
            local originalSize = Instance.new("Vector3Value")
            originalSize.Name = "OriginalSize"
            originalSize.Value = HumanoidRootPart.Size
            originalSize.Parent = HumanoidRootPart
        end
        
        local originalSize = HumanoidRootPart:FindFirstChild("OriginalSize")
        if originalSize then
            HumanoidRootPart.Size = originalSize.Value * multiplier
        end
    end
    
    print("Hitbox diperbesar "..multiplier.."x lipat!")
end

-- Fungsi untuk mengembalikan hitbox ke ukuran normal
local function ResetHitbox()
    for _, part in ipairs(Character:GetDescendants()) do
        if part:IsA("BasePart") and part:FindFirstChild("OriginalSize") then
            part.Size = part.OriginalSize.Value
        end
    end
    print("Hitbox dikembalikan ke ukuran normal!")
end

-- GUI Mobile-Friendly dengan button besar
local function CreateMobileGUI()
    -- Hapus GUI lama jika ada
    if Player.PlayerGui:FindFirstChild("MobileHitboxControl") then
        Player.PlayerGui.MobileHitboxControl:Destroy()
    end
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "MobileHitboxControl"
    ScreenGui.Parent = Player.PlayerGui
    
    -- Main Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 200, 0, 250)
    MainFrame.Position = UDim2.new(0, 10, 0.5, -125)
    MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    
    -- Title
    local Title = Instance.new("TextLabel")
    Title.Text = "🐟 Hitbox Control"
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextScaled = true
    Title.Parent = MainFrame
    
    -- Multiplier Display
    local MultiplierLabel = Instance.new("TextLabel")
    MultiplierLabel.Text = "Size: 2.0x"
    MultiplierLabel.Size = UDim2.new(1, 0, 0, 30)
    MultiplierLabel.Position = UDim2.new(0, 0, 0, 45)
    MultiplierLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    MultiplierLabel.BackgroundTransparency = 1
    MultiplierLabel.TextScaled = true
    MultiplierLabel.Parent = MainFrame
    
    local MultiplierValue = 2.0
    
    -- Increase Button (Besar untuk mobile)
    local IncreaseBtn = Instance.new("TextButton")
    IncreaseBtn.Text = "➕ PERBESAR"
    IncreaseBtn.Size = UDim2.new(0.8, 0, 0, 50)
    IncreaseBtn.Position = UDim2.new(0.1, 0, 0, 80)
    IncreaseBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    IncreaseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    IncreaseBtn.TextScaled = true
    IncreaseBtn.Parent = MainFrame
    IncreaseBtn.MouseButton1Click:Connect(function()
        MultiplierValue = math.min(MultiplierValue + 0.5, 5.0)
        MultiplierLabel.Text = "Size: "..MultiplierValue.."x"
        EnlargeHitbox(MultiplierValue)
    end)
    
    -- Decrease Button (Besar untuk mobile)
    local DecreaseBtn = Instance.new("TextButton")
    DecreaseBtn.Text = "➖ KECILKAN"
    DecreaseBtn.Size = UDim2.new(0.8, 0, 0, 50)
    DecreaseBtn.Position = UDim2.new(0.1, 0, 0, 140)
    DecreaseBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    DecreaseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    DecreaseBtn.TextScaled = true
    DecreaseBtn.Parent = MainFrame
    DecreaseBtn.MouseButton1Click:Connect(function()
        MultiplierValue = math.max(MultiplierValue - 0.5, 1.0)
        MultiplierLabel.Text = "Size: "..MultiplierValue.."x"
        EnlargeHitbox(MultiplierValue)
    end)
    
    -- Reset Button
    local ResetBtn = Instance.new("TextButton")
    ResetBtn.Text = "🔄 RESET"
    ResetBtn.Size = UDim2.new(0.8, 0, 0, 50)
    ResetBtn.Position = UDim2.new(0.1, 0, 0, 200)
    ResetBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    ResetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ResetBtn.TextScaled = true
    ResetBtn.Parent = MainFrame
    ResetBtn.MouseButton1Click:Connect(function()
        ResetHitbox()
        MultiplierValue = 2.0
        MultiplierLabel.Text = "Size: "..MultiplierValue.."x"
    end)
    
    -- Toggle Button untuk show/hide GUI
    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Text = "⚙️"
    ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
    ToggleBtn.Position = UDim2.new(1, -60, 0, 10)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
    ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleBtn.TextScaled = true
    ToggleBtn.Parent = ScreenGui
    ToggleBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)
    
    -- Quick Action Buttons (Untuk kontrol cepat)
    local QuickEnlargeBtn = Instance.new("TextButton")
    QuickEnlargeBtn.Text = "🎯 BIG"
    QuickEnlargeBtn.Size = UDim2.new(0, 80, 0, 40)
    QuickEnlargeBtn.Position = UDim2.new(1, -90, 0.5, 60)
    QuickEnlargeBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    QuickEnlargeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    QuickEnlargeBtn.TextScaled = true
    QuickEnlargeBtn.Parent = ScreenGui
    QuickEnlargeBtn.MouseButton1Click:Connect(function()
        EnlargeHitbox(3.0)
        MultiplierValue = 3.0
        MultiplierLabel.Text = "Size: "..MultiplierValue.."x"
    end)
    
    local QuickResetBtn = Instance.new("TextButton")
    QuickResetBtn.Text = "🔁 NORMAL"
    QuickResetBtn.Size = UDim2.new(0, 80, 0, 40)
    QuickResetBtn.Position = UDim2.new(1, -90, 0.5, 110)
    QuickResetBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    QuickResetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    QuickResetBtn.TextScaled = true
    QuickResetBtn.Parent = ScreenGui
    QuickResetBtn.MouseButton1Click:Connect(function()
        ResetHitbox()
        MultiplierValue = 1.0
        MultiplierLabel.Text = "Size: "..MultiplierValue.."x"
    end)
end

-- Touch Gesture untuk mobile
local TouchService = game:GetService("TouchService")
local lastTouchTime = 0

TouchService.TouchStarted:Connect(function(touch, processed)
    if not processed then
        local currentTime = tick()
        
        -- Double tap detection (untuk reset)
        if currentTime - lastTouchTime < 0.5 then
            ResetHitbox()
        end
        
        -- Triple tap detection (untuk enlarge maksimal)
        if currentTime - lastTouchTime < 0.3 then
            EnlargeHitbox(5.0)
        end
        
        lastTouchTime = currentTime
    end
end)

-- Auto create GUI dan apply hitbox setelah script utama load
spawn(function()
    wait(5) -- Tunggu lebih lama untuk memastikan script utama fully loaded
    CreateMobileGUI()
    EnlargeHitbox(2.0) -- Auto enlarge 2x saat start
    
    -- Notifikasi untuk pengguna mobile
    print("====================================")
    print("MOBILE BE A FISH LOADED!")
    print("Touch Controls:")
    print("- Double Tap: Reset Hitbox")
    print("- Triple Tap: Max Size (5x)")
    print("- Use Buttons: Fine Control")
    print("====================================")
end)

-- Vibrate feedback untuk mobile (jika supported)
local function Vibrate()
    pcall(function()
        game:GetService("VibrationService"):Vibrate(0.1)
    end)
end

-- Connect vibration ke button actions
game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        Vibrate()
    end
end)
