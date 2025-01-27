local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Tạo khung menu
local menuFrame = Instance.new("Frame")
menuFrame.Size = UDim2.new(0.3, 0, 0.5, 0)
menuFrame.Position = UDim2.new(0.35, 0, 0.25, 0)
menuFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Màu nền đen
menuFrame.BackgroundTransparency = 0.5
menuFrame.Visible = false  -- Mặc định ẩn menu
menuFrame.Parent = screenGui

-- Thêm tiêu đề cho menu
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0.2, 0)
titleLabel.Text = "SANG IOS"  -- Tên menu là "SANG IOS"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)  -- Màu chữ trắng
titleLabel.TextScaled = true
titleLabel.BackgroundTransparency = 1
titleLabel.Parent = screenGui

-- Khi nhấn vào tiêu đề, mở hoặc ẩn menu
titleLabel.MouseButton1Click:Connect(function()
    menuFrame.Visible = not menuFrame.Visible  -- Đảo ngược trạng thái ẩn/hiện của menu
end)

-- Thêm chức năng RD_PRO với công tắc On/Off
local rdProLabel = Instance.new("TextLabel")
rdProLabel.Size = UDim2.new(1, 0, 0.2, 0)
rdProLabel.Position = UDim2.new(0, 0, 0.2, 0)
rdProLabel.Text = "RD_PRO: OFF"  -- Ban đầu là OFF
rdProLabel.TextColor3 = Color3.fromRGB(255, 255, 255)  -- Màu chữ trắng
rdProLabel.TextScaled = true
rdProLabel.BackgroundTransparency = 1
rdProLabel.Parent = menuFrame

-- Tạo công tắc On/Off (Switch)
local switch1 = Instance.new("TextButton")
switch1.Size = UDim2.new(0.3, 0, 0.2, 0)
switch1.Position = UDim2.new(0.35, 0, 0.4, 0)
switch1.Text = "OFF"  -- Ban đầu là OFF
switch1.TextColor3 = Color3.fromRGB(255, 255, 255)  -- Màu chữ trắng
switch1.BackgroundColor3 = Color3.fromRGB(255, 0, 0)  -- Màu đỏ cho trạng thái OFF
switch1.TextScaled = true
switch1.Parent = menuFrame

-- Hàm để random fruit (Luôn trả về Dragon Fruit)
local function giveRandomFruit()
    local fruit = "Dragon_Fruit"  -- Cứng định trả về Dragon_Fruit
    print(player.Name .. " đã nhận trái " .. fruit)
    
    -- Giả sử bạn có một hệ thống trái cây trong Blox Fruits, bạn sẽ thêm Dragon_Fruit vào đây
    -- Dưới đây là ví dụ đơn giản (có thể thêm Dragon_Fruit vào Backpack)
    local dragonFruit = game.ServerStorage:FindFirstChild("Dragon_Fruit") -- Giả sử Dragon_Fruit có trong ServerStorage
    if dragonFruit then
        local newFruit = dragonFruit:Clone()  -- Tạo một bản sao của Dragon_Fruit
        newFruit.Parent = player.Backpack  -- Thêm Dragon_Fruit vào Backpack của người chơi
    else
        print("Không tìm thấy Dragon_Fruit trong ServerStorage")
    end
end

-- Khi người chơi nhấn vào công tắc, chuyển trạng thái RD_PRO và thực hiện các hành động
switch1.MouseButton1Click:Connect(function()
    if switch1.Text == "OFF" then
        switch1.Text = "ON"  -- Đổi thành ON
        switch1.BackgroundColor3 = Color3.fromRGB(0, 255, 0)  -- Màu xanh cho ON
        rdProLabel.Text = "RD_PRO: ON"  -- Thay đổi trạng thái RD_PRO
        
        -- Người chơi sẽ nhận Dragon_Fruit khi bật công tắc
        giveRandomFruit()
    else
        switch1.Text = "OFF"  -- Đổi lại thành OFF
        switch1.BackgroundColor3 = Color3.fromRGB(255, 0, 0)  -- Màu đỏ cho OFF
        rdProLabel.Text = "RD_PRO: OFF"  -- Thay đổi trạng thái RD_PRO
    end
end)
