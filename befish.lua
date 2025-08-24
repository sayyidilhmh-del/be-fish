-- Be A Fish Hitbox Modifier (AGGRESSIVE VERSION)
local Player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")

-- Load script utama dulu
loadstring(game:HttpGet("https://raw.githubusercontent.com/AkinaRulezx/beafish/refs/heads/main/OLD-Swee-Loader", true))()

-- Tunggu sebentar untuk script utama load
wait(3)

-- ========== FITUR ANTI-AFK SILENT (10 MENIT) ==========
local function setupSilentAntiAFK()
    -- Nonaktifkan event AFK default Roblox
    local function disableIdleEvent()
        local GC = getconnections or get_signal_connections
        if GC then
            for _, connection in pairs(GC(Player.Idled)) do
                connection:Disable()
                print("AFK idle event dinonaktifkan")
            end
        end
    end

    -- Gerakan anti-AFK yang sangat jarang (setiap 10 menit)
    local function performAntiAFKMovement()
        -- Simulasikan input keyboard sangat singkat
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.LeftShift, false, nil)
        task.wait(0.05)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, nil)
        
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.W, false, nil)
        task.wait(0.1)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.W, false, nil)
        
        print("Anti-AFK: Gerakan terdeteksi - " .. os.date("%H:%M:%S"))
    end

    -- Setup utama anti-AFK
    disableIdleEvent()
    
    -- Jalankan gerakan setiap 10 menit (600 detik)
    while true do
        performAntiAFKMovement()
        wait(600) -- Tunggu 10 menit
    end
end

-- ========== FUNGSI UTAMA HITBOX ==========
local function ForceHitbox()
    while true do
        pcall(function()
            -- ... (seluruh kode lengkap hitbox modifier yang Anda miliki)
            -- Di sini akan berisi kode modifikasi hitbox Anda
            
            -- Contoh placeholder (harap ganti dengan kode asli Anda)
            local characters = game:GetService("Workspace"):FindFirstChildWhichIsA("Model")
            if characters then
                -- Logika modifikasi hitbox Anda di sini
            end
        end)
        wait(0.5) -- Tunggu sebentar sebelum loop berikutnya
    end
end

-- ========== JALANKAN SEMUA FITUR DI BACKGROUND ==========
print("Memulai Script: Hitbox Modifier + Anti-AFK Silent")

-- Jalankan Anti-AFK dalam thread terpisah (silent)
task.spawn(function()
    pcall(function()
        setupSilentAntiAFK()
    end)
end)

-- Jalankan fungsi utama hitbox dalam thread terpisah
task.spawn(function()
    pcall(function()
        ForceHitbox()
    end)
end)

-- Notifikasi sederhana di console
print("✓ Fitur Anti-AFK Silent diaktifkan (10 menit sekali)")
print("✓ Script berjalan otomatis di background")
print("✓ Tidak ada GUI yang ditampilkan")
