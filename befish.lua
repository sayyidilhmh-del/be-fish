-- ULTIMATE HITBOX MODIFIER
local Player = game.Players.LocalPlayer

-- Load script utama
loadstring(game:HttpGet("https://raw.githubusercontent.com/AkinaRulezx/beafish/refs/heads/main/OLD-Swee-Loader", true))()

wait(2)

-- Nuclear option: Hack the game physics
spawn(function()
    while task.wait(0.1) do
        pcall(function()
            local char = Player.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                -- Force character scale
                char:SetScale(2.5) -- Coba scale langsung
                
                -- Override semua physics
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.Size = Vector3.new(8, 8, 8)
                        part.Shape = Enum.PartType.Ball -- Ubah bentuk jadi bola
                    end
                end
            end
        end)
    end
end)

print("ULTIMATE HITBOX ACTIVATED!")
