-- Gọi đối tượng GUI
local player = game.Players.LocalPlayer
local playerGui = player.PlayerGui
local screenGui = Instance.new("ScreenGui", playerGui)

-- Tạo phần menu
local menuFrame = Instance.new("Frame", screenGui)
menuFrame.Size = UDim2.new(0, 200, 0, 100)
menuFrame.Position = UDim2.new(0, 0, 0, 0)
menuFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
menuFrame.Visible = false  -- Ẩn menu khi bắt đầu

-- Tạo nút "SANG IOS"
local sangIosButton = Instance.new("TextButton", menuFrame)
sangIosButton.Size = UDim2.new(1, 0, 0.2, 0)
sangIosButton.Text = "SANG IOS"
sangIosButton.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
sangIosButton.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Tạo nút "RD FRUIT" để bật/tắt chức năng
local rdFruitButton = Instance.new("TextButton", menuFrame)
rdFruitButton.Size = UDim2.new(1, 0, 0.2, 0)
rdFruitButton.Position = UDim2.new(0, 0, 0.2, 0)
rdFruitButton.Text = "RD FRUIT"
rdFruitButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
rdFruitButton.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Tạo TextLabel để hiển thị trạng thái RD FRUIT
local rdFruitStatus = Instance.new("TextLabel", menuFrame)
rdFruitStatus.Size = UDim2.new(1, 0, 0.2, 0)
rdFruitStatus.Position = UDim2.new(0, 0, 0.4, 0)
rdFruitStatus.Text = "RD FRUIT: OFF"
rdFruitStatus.TextColor3 = Color3.fromRGB(0, 0, 0)
rdFruitStatus.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

-- Biến để theo dõi trạng thái RD FRUIT
local rdFruitEnabled = false

-- Hàm mở/đóng menu
local function toggleMenu()
    menuFrame.Visible = not menuFrame.Visible
end

-- Hàm bật/tắt chức năng RD FRUIT
local function toggleRDFruit()
    rdFruitEnabled = not rdFruitEnabled
    if rdFruitEnabled then
        rdFruitStatus.Text = "RD FRUIT: ON"
    else
        rdFruitStatus.Text = "RD FRUIT: OFF"
    end
end

-- Xử lý sự kiện khi bấm nút "SANG IOS" để mở/đóng menu
sangIosButton.MouseButton1Click:Connect(toggleMenu)

-- Xử lý sự kiện khi bấm nút "RD FRUIT" để bật/tắt chức năng
rdFruitButton.MouseButton1Click:Connect(toggleRDFruit)

-- Hàm random trái ác quỷ Dragon
local function randomFruit()
    if rdFruitEnabled then
        -- Trái ác quỷ Dragon
        local fruit = Instance.new("Model")
        local fruitName = Instance.new("StringValue")
        fruitName.Name = "FruitName"
        fruitName.Value = "Dragon"
        fruitName.Parent = fruit
        fruit.Parent = game.Workspace
        
        -- Giả sử NPC này sẽ cho người chơi trái ác quỷ khi gần
        local fruitPos = game.Workspace:WaitForChild("Blox Fruit Gacha").Position + Vector3.new(0, 5, 0)  -- Vị trí random gần NPC
        fruit:SetPrimaryPartCFrame(CFrame.new(fruitPos))
        
        -- Thông báo cho người chơi nhận được trái ác quỷ
        game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Bạn đã nhận được trái ác quỷ Dragon!", "All")
    end
end

-- Kiểm tra xem người chơi có đến gần NPC và RD FRUIT đã bật chưa
local function checkProximity()
    while true do
        wait(1)  -- Kiểm tra mỗi giây
        local playerPos = player.Character.HumanoidRootPart.Position
        local npcPos = game.Workspace:WaitForChild("Blox Fruit Gacha").Position
        local distance = (playerPos - npcPos).Magnitude
        
        -- Nếu người chơi đến gần NPC và chức năng RD FRUIT đã bật
        if distance < 10 and rdFruitEnabled then
            randomFruit()
        end
    end
end

-- Bắt đầu kiểm tra khoảng cách
checkProximity()
