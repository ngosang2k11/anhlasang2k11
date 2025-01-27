-- Tạo GUI và các thành phần giao diện người dùng
local player = game.Players.LocalPlayer
local playerGui = player.PlayerGui

-- Tạo ScreenGui chứa Frame
local gui = Instance.new("ScreenGui")
gui.Parent = playerGui

-- Tạo Frame chứa các nút và thông tin
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.Visible = false  -- Mặc định ẩn GUI
frame.Parent = gui

-- Tạo Nút "SANG IOS"
local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 300, 0, 50)
button.Position = UDim2.new(0, 0, 0, 0)
button.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
button.Text = "SANG IOS"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.Gotham
button.TextSize = 24
button.Parent = frame

-- Tạo Nút "RD FRUIT"
local rdFruitButton = Instance.new("TextButton")
rdFruitButton.Size = UDim2.new(0, 300, 0, 50)
rdFruitButton.Position = UDim2.new(0, 0, 0, 60)
rdFruitButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
rdFruitButton.Text = "RD FRUIT: OFF"
rdFruitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
rdFruitButton.Font = Enum.Font.Gotham
rdFruitButton.TextSize = 24
rdFruitButton.Parent = frame

-- Tính năng RD FRUIT
local rdFruitActive = false  -- Biến lưu trạng thái của tính năng RD FRUIT

-- Hàm thay đổi trạng thái RD FRUIT
local function toggleRD_FRUIT()
    rdFruitActive = not rdFruitActive
    if rdFruitActive then
        rdFruitButton.Text = "RD FRUIT: ON"
        rdFruitButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        print("Tính năng RD FRUIT đã bật!")
    else
        rdFruitButton.Text = "RD FRUIT: OFF"
        rdFruitButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        print("Tính năng RD FRUIT đã tắt!")
    end
end

-- Xử lý khi nhấn nút "SANG IOS" để hiển thị/ẩn GUI
button.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

-- Kết nối nút RD FRUIT để bật/tắt tính năng
rdFruitButton.MouseButton1Click:Connect(function()
    toggleRD_FRUIT()
end)

-- Tạo hàm random trái ác quỷ Dragon cho người chơi khi đến gần NPC "Blox Fruit Gacha"
local function giveDragonFruit()
    local npc = game.Workspace:FindFirstChild("Blox Fruit Gacha")
    
    if npc and (player.Character.PrimaryPart.Position - npc.PrimaryPart.Position).Magnitude < 10 then
        -- Người chơi gần NPC "Blox Fruit Gacha" và tính năng RD FRUIT đang bật
        print("Đang cấp trái ác quỷ Dragon cho người chơi...")

        -- Random trái ác quỷ Dragon (luôn random cho Dragon, có thể mở rộng thêm với các trái khác)
        local fruitName = "Dragon"  -- Trái ác quỷ Dragon (ở đây luôn random Dragon)

        -- Kiểm tra xem người chơi có trong "Backpack" chưa có trái ác quỷ Dragon không
        local backpack = player:FindFirstChild("Backpack")
        if backpack then
            -- Kiểm tra nếu người chơi chưa có trái Dragon trong Backpack
            local existingFruit = backpack:FindFirstChild(fruitName)
            if not existingFruit then
                -- Tạo trái ác quỷ Dragon và thêm vào Backpack của người chơi
                local dragonFruit = Instance.new("StringValue")
                dragonFruit.Name = fruitName
                dragonFruit.Parent = backpack
                print("Trái ác quỷ Dragon đã được cấp cho người chơi!")
            else
                print("Người chơi đã có trái ác quỷ Dragon.")
            end
        end
    end
end

-- Kiểm tra liên tục xem người chơi có đến gần NPC "Blox Fruit Gacha" và cấp trái Dragon nếu tính năng RD FRUIT bật
game:GetService("RunService").Heartbeat:Connect(function()
    if rdFruitActive then
        giveDragonFruit()  -- Nếu RD FRUIT bật, kiểm tra và cấp trái ác quỷ Dragon
    end
end)
