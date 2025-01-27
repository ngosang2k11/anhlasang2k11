-- Tạo GUI
local ScreenGui = Instance.new("ScreenGui")
local OpenCloseButton = Instance.new("TextButton")
local MenuFrame = Instance.new("Frame")
local RandomVipToggle = Instance.new("TextLabel")
local ToggleButton = Instance.new("TextButton")

-- Cấu hình ScreenGui
ScreenGui.Name = "SANG_IOS"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Cấu hình nút mở/đóng menu
OpenCloseButton.Name = "OpenCloseButton"
OpenCloseButton.Parent = ScreenGui
OpenCloseButton.BackgroundColor3 = Color3.new(0, 0, 0) -- Nền đen
OpenCloseButton.Size = UDim2.new(0, 200, 0, 50)
OpenCloseButton.Position = UDim2.new(0.1, 0, 0.1, 0)
OpenCloseButton.Font = Enum.Font.SourceSans
OpenCloseButton.Text = "SANG IOS"
OpenCloseButton.TextColor3 = Color3.new(1, 1, 1) -- Chữ trắng
OpenCloseButton.TextSize = 24

-- Cấu hình menu
MenuFrame.Name = "MenuFrame"
MenuFrame.Parent = ScreenGui
MenuFrame.BackgroundColor3 = Color3.new(0, 0, 0) -- Nền đen
MenuFrame.Size = UDim2.new(0, 300, 0, 200)
MenuFrame.Position = UDim2.new(0.1, 0, 0.2, 0)
MenuFrame.Visible = false -- Ẩn menu ban đầu

-- Thêm nhãn "RANDOM VIP" vào menu
RandomVipToggle.Name = "RandomVipToggle"
RandomVipToggle.Parent = MenuFrame
RandomVipToggle.BackgroundColor3 = Color3.new(0, 0, 0)
RandomVipToggle.Size = UDim2.new(0, 300, 0, 50)
RandomVipToggle.Position = UDim2.new(0, 0, 0, 0)
RandomVipToggle.Font = Enum.Font.SourceSans
RandomVipToggle.Text = "RANDOM VIP"
RandomVipToggle.TextColor3 = Color3.new(1, 1, 1)
RandomVipToggle.TextSize = 24

-- Thêm công tắc bật/tắt
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = MenuFrame
ToggleButton.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
ToggleButton.Size = UDim2.new(0, 100, 0, 50)
ToggleButton.Position = UDim2.new(0.5, -50, 0.5, -25)
ToggleButton.Font = Enum.Font.SourceSans
ToggleButton.Text = "OFF"
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.TextSize = 24

-- Logic bật/tắt menu
local menuOpen = false
OpenCloseButton.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    MenuFrame.Visible = menuOpen
end)

-- Tạo NPC và logic random trái ác quỷ
local NPC = Instance.new("Part") -- NPC đơn giản (khối vuông)
NPC.Name = "RandomFruitNPC"
NPC.Parent = workspace
NPC.Size = Vector3.new(4, 6, 4)
NPC.Position = Vector3.new(0, 5, 0)
NPC.BrickColor = BrickColor.new("Bright yellow")

-- Gán chức năng cho NPC
local randomVipEnabled = false
ToggleButton.MouseButton1Click:Connect(function()
    randomVipEnabled = not randomVipEnabled
    ToggleButton.Text = randomVipEnabled and "ON" or "OFF"
    if randomVipEnabled then
        print("RANDOM VIP ĐƯỢC BẬT")
    else
        print("RANDOM VIP ĐÃ TẮT")
    end
end)

-- Phát hiện người chơi chạm vào NPC
NPC.Touched:Connect(function(hit)
    if randomVipEnabled and hit.Parent:FindFirstChild("Humanoid") then
        local player = game.Players:GetPlayerFromCharacter(hit.Parent)
        if player then
            -- Random trái ác quỷ
            local fruits = {"Dough", "Kitsune", "Dragon"}
            local randomFruit = fruits[math.random(#fruits)]
            print(player.Name .. " đã nhận được trái: " .. randomFruit)
            
            -- Thông báo cho người chơi
            player:WaitForChild("PlayerGui"):SetCore("ChatMakeSystemMessage", {
                Text = "Bạn đã nhận được trái: " .. randomFruit;
                Color = Color3.new(1, 1, 0);
            })
        end
    end
end)
