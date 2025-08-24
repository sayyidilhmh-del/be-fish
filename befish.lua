-- Gabungan Script Be A Fish dengan Hitbox Modifier (Fixed Version)
local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- Fungsi untuk menjalankan kode utama dengan error handling
local function LoadMainScript()
    local success, errorMessage = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AkinaRulezx/beafish/refs/heads/main/OLD-Swee-Loader", true))()
    end)
    
    if not success then
        warn("Gagal load script utama: " .. errorMessage)
        -- Fallback ke alternative URL jika utama gagal
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/AkinaRulezx/beafish/main/OLD-Swee-Loader", true))()
        end)
    end
end

-- Fungsi untuk memperbesar hitbox
local function EnlargeHitbox(multiplier)
    multiplier = multiplier or 2.0
    
    -- Pastikan karakter masih ada
    if not Character or not Character.Parent then
        Character = Player.Character
        if not Character then return end
    end
    
    for _, part in ipairs(Character:GetDescendants()) do
        if part:IsA("BasePart") then
            if not part:FindFirstChild("OriginalSize") then
                local originalSize = Instance.new("Vector3Value")
                originalSize.Name = "OriginalSize"
                originalSize.Value = part.Size
                originalSize.Parent = part
            end
            
            local originalSize = part:FindFirstChild("OriginalSize")
            if originalSize then
                part.Size = originalSize.Value * multiplier
            end
        end
    end
    
    print("Hitbox diperbesar "..multiplier.."x lipat!")
end

-- Fungsi untuk reset hitbox
local function ResetHitbox()
    if not Character or not Character.Parent then return end
    
    for _, part in ipairs(Character:GetDescendants()) do
        if part:IsA("BasePart") and part:FindFirstChild("OriginalSize") then
            part.Size = part.OriginalSize.Value
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
    
    -- Increase Button
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
    
    -- Decrease Button
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
        MultiplierValue = 1.0
        MultiplierLabel.Text = "Size: "..MultiplierValue.."x"
    end)
    
    -- Quick Action Buttons
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

-- Main execution sequence
spawn(function()
    print("Memulai load script utama...")
    LoadMainScript()
    
    print("Menunggu 3 detik...")
    wait(3)
    
    print("Membuat GUI...")
    CreateMobileGUI()
    
    print("Memperbesar hitbox awal...")
    EnlargeHitbox(2.0)
    
    print("====================================")
    print("BE A FISH + HITBOX MODIFIER LOADED!")
    print("Mobile Controls Ready!")
    print("====================================")
end)

-- Handle character respawn
Player.CharacterAdded:Connect(function(newChar)
    Character = newChar
    HumanoidRootPart = newChar:WaitForChild("HumanoidRootPart")
    
    wait(2) -- Tunggu karakter fully loaded
    EnlargeHitbox(2.0) -- Re-apply hitbox enlargement
end)
