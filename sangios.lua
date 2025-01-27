-- Lấy thông tin người chơi
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local playerBackpack = player:WaitForChild("Backpack")

-- Lấy thông tin NPC và vị trí NPC
local npc = workspace:WaitForChild("NPC") -- Tên NPC trong workspace
local npcPosition = npc.Position -- Vị trí của NPC

-- Tạo ScreenGui và Menu
local playerGui = player:WaitForChild("PlayerGui")
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = playerGui

local menuFrame = Instance.new("Frame")
menuFrame.Size = UDim2.new(0.5, 0, 0.5, 0)
menuFrame.Position = UDim2.new(0.25, 0, 0.25, 0)
menuFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
menuFrame.Visible = false
menuFrame.Parent = screenGui

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0.2, 0)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.Text = "SANG IOS"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 24
titleLabel.BackgroundTransparency = 1
titleLabel.Parent = menuFrame

local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0.8, 0, 0.1, 0)
toggleButton.Position = UDim2.new(0.1, 0, 0.4, 0)
toggleButton.Text = "RD FRUIT"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextSize = 18
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 128, 255)
toggleButton.Parent = menuFrame

-- Biến để theo dõi trạng thái công tắc RD FRUIT
local rdFruitEnabled = false

-- Danh sách trái ác quỷ có thể random (bao gồm Dragon)
local fruits = {
    "Dragon",  -- Trái Dragon
    "Kisune",   -- Trái Lửa
    "Yeti",     -- Trái Băng
    "Leopard",   -- Trái Ánh sáng
    "Gas"    -- Trái Magma
}

-- Hành động khi người chơi nhấn vào "SANG IOS" để mở/ẩn menu
titleLabel.MouseButton1Click:Connect(function()
    menuFrame.Visible = not menuFrame.Visible
end)

-- Hành động khi nhấn công tắc "RD FRUIT"
toggleButton.MouseButton1Click:Connect(function()
    rdFruitEnabled = not rdFruitEnabled
    if rdFruitEnabled then
        print("Công tắc RD FRUIT đã được bật! Bạn chỉ có thể nhận trái Dragon.")
    else
        print("Công tắc RD FRUIT đã được tắt! Bạn có thể nhận trái ngẫu nhiên.")
    end
end)

-- Hàm thêm trái ác quỷ vào túi đồ của người chơi (Backpack)
local function giveFruitToPlayer(fruitName)
    -- Kiểm tra xem trái ác quỷ đã có trong túi đồ chưa
    local existingFruit = playerBackpack:FindFirstChild(fruitName)
    if not existingFruit then
        -- Nếu chưa có, tạo trái ác quỷ mới và đưa vào túi đồ
        local fruit = Instance.new("StringValue")  -- Hoặc tùy thuộc vào cách bạn muốn tạo trái ác quỷ
        fruit.Name = fruitName
        fruit.Parent = playerBackpack
        print("Bạn đã nhận trái ác quỷ " .. fruitName .. " vào túi đồ!")
    else
        print("Bạn đã có trái ác quỷ " .. fruitName .. " rồi!")
    end
end

-- Hành động khi người chơi tương tác với NPC để nhận trái ác quỷ
npc.Touched:Connect(function(hit)
    -- Kiểm tra xem đối tượng chạm vào có phải là người chơi không
    local characterHit = hit.Parent
    if characterHit == character then
        -- Nếu công tắc RD FRUIT bật, chỉ trao trái Dragon
        if rdFruitEnabled then
            print("Bạn đã nhận được trái ác quỷ Dragon!")
            -- Gọi hàm trao trái Dragon cho người chơi
            giveFruitToPlayer("Dragon")
        else
            -- Nếu công tắc không bật, chọn ngẫu nhiên trái ác quỷ
            local randomFruit = fruits[math.random(1, #fruits)]
            print("Trái ác quỷ bạn nhận được là: " .. randomFruit)
            -- Gọi hàm trao trái ngẫu nhiên cho người chơi
            giveFruitToPlayer(randomFruit)
        end
    end
end)
