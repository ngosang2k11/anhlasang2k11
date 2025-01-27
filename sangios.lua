-- Lấy đối tượng của người chơi
local player = game.Players.LocalPlayer
local playerGui = player.PlayerGui

-- Tạo GUI chứa logo và menu
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = playerGui

-- Tạo logo dưới dạng một ImageButton
local logoButton = Instance.new("ImageButton")
logoButton.Size = UDim2.new(0, 65, 0, 65) -- Kích thước của logo
logoButton.Position = UDim2.new(0.5, -100, 0, 10) -- Vị trí của logo
logoButton.Image = "http://www.roblox.com/asset/?id=126101456053607" -- Thay bằng URL hình ảnh logo
logoButton.Parent = screenGui

-- Tạo menu (ẩn ban đầu)
local menu = Instance.new("Frame")
menu.Size = UDim2.new(0, 300, 0, 400) -- Kích thước của menu
menu.Position = UDim2.new(0.5, -150, 0.5, -200) -- Vị trí của menu
menu.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- Màu nền của menu
menu.Visible = false -- Ẩn menu ban đầu
menu.Parent = screenGui

-- Tạo tiêu đề cho menu
local menuTitle = Instance.new("TextLabel")
menuTitle.Size = UDim2.new(0, 300, 0, 50) -- Kích thước của tiêu đề
menuTitle.Position = UDim2.new(0, 0, 0, 0) -- Vị trí tiêu đề ở đầu menu
menuTitle.Text = "SANG IOS V1" -- Tiêu đề menu
menuTitle.TextSize = 10 -- Kích thước chữ
menuTitle.TextColor3 = Color3.fromRGB(0, 0, 0) -- Màu chữ
menuTitle.BackgroundTransparency = 1 -- Không có nền cho tiêu đề
menuTitle.Parent = menu

-- Tạo một nút "RANDOM PRO" trong menu
local randomProButton = Instance.new("TextButton")
randomProButton.Size = UDim2.new(0, 200, 0, 50)
randomProButton.Position = UDim2.new(0.5, -100, 0.3, 0)
randomProButton.Text = "RANDOM PRO"
randomProButton.Parent = menu

-- Tạo một công tắc (switch) để bật/tắt RANDOM PRO
local switchButton = Instance.new("TextButton")
switchButton.Size = UDim2.new(0, 100, 0, 50)
switchButton.Position = UDim2.new(0.5, -50, 0.5, -25)
switchButton.Text = "TẮT"
switchButton.Parent = menu

-- Biến trạng thái của RANDOM PRO và số lượt random trái ác quỷ
local isRandomProActive = false
local randomDevilFruitCount = 0  -- Biến để lưu số lượt random trái ác quỷ

-- Các trái ác quỷ có thể random được
local devilFruits = {"Dragon", "Kisune", "Dough", "Leopard", "Portal"}

-- Tạo một TextLabel cho thông báo bật/tắt chức năng
local notification = Instance.new("TextLabel")
notification.Size = UDim2.new(0, 300, 0, 50)
notification.Position = UDim2.new(0.5, -150, 0.2, 0) -- Vị trí thông báo trên màn hình
notification.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Màu nền của thông báo
notification.TextColor3 = Color3.fromRGB(255, 255, 255) -- Màu chữ thông báo
notification.TextSize = 20
notification.Text = "" -- Ban đầu không có thông báo
notification.Visible = false -- Ẩn thông báo ban đầu
notification.Parent = screenGui

-- Hàm để bật/tắt RANDOM PRO và cập nhật số lượt random trái ác quỷ
local function toggleRandomPro()
    isRandomProActive = not isRandomProActive
    if isRandomProActive then
        switchButton.Text = "BẬT"
        randomDevilFruitCount = 70000  -- Đặt số lượt random trái ác quỷ khi bật
        print("RANDOM PRO đã được bật! Số lượt random trái ác quỷ: " .. randomDevilFruitCount)

        -- Hiển thị thông báo bật chức năng
        notification.Text = "Bạn Đã Bật Chức Năng"
        notification.Visible = true
        
        -- Ẩn thông báo sau 3 giây
        wait(3)
        notification.Visible = false

        -- Bắt đầu quá trình random trái ác quỷ
        randomDevilFruit()
    else
        switchButton.Text = "TẮT"
        randomDevilFruitCount = 0  -- Đặt lại số lượt random trái ác quỷ khi tắt
        print("RANDOM PRO đã được tắt! Số lượt random trái ác quỷ: " .. randomDevilFruitCount)

        -- Hiển thị thông báo tắt chức năng
        notification.Text = "Bạn Đã Tắt Chức Năng"
        notification.Visible = true
        
        -- Ẩn thông báo sau 3 giây
        wait(3)
        notification.Visible = false
    end
end

-- Hàm random trái ác quỷ với tỉ lệ
local function randomDevilFruit()
    -- Tỉ lệ random (98% trái ác quỷ và 2% không có trái ác quỷ)
    local randomChance = math.random(1, 100)
    
    if randomChance <= 98 then
        -- Chọn ngẫu nhiên trái ác quỷ từ danh sách
        local chosenFruit = devilFruits[math.random(1, #devilFruits)]
        print("Trái ác quỷ bạn nhận được: " .. chosenFruit)
    else
        print("Bạn không nhận được trái ác quỷ lần này!")
    end
end

-- Xử lý sự kiện kéo cho logo và menu
local draggingLogo = false
local draggingMenu = false
local dragInputObject = nil
local dragStartPos = nil
local dragOffset = nil

-- Logo kéo
logoButton.MouseButton1Down:Connect(function(input)
    draggingLogo = true
    dragStartPos = input.Position
    dragInputObject = input
    dragOffset = logoButton.Position - UDim2.new(0, dragStartPos.X, 0, dragStartPos.Y)
end)

logoButton.MouseMoved:Connect(function(input)
    if draggingLogo then
        local newPos = UDim2.new(0, input.Position.X, 0, input.Position.Y) + dragOffset
        logoButton.Position = newPos
    end
end)

logoButton.MouseButton1Up:Connect(function()
    draggingLogo = false
end)

-- Menu kéo
menu.MouseButton1Down:Connect(function(input)
    draggingMenu = true
    dragStartPos = input.Position
    dragInputObject = input
    dragOffset = menu.Position - UDim2.new(0, dragStartPos.X, 0, dragStartPos.Y)
end)

menu.MouseMoved:Connect(function(input)
    if draggingMenu then
        local newPos = UDim2.new(0, input.Position.X, 0, input.Position.Y) + dragOffset
        menu.Position = newPos
    end
end)

menu.MouseButton1Up:Connect(function()
    draggingMenu = false
end)

-- Kết nối sự kiện khi nhấn vào "RANDOM PRO"
randomProButton.MouseButton1Click:Connect(function()
    print("RANDOM PRO đã được nhấn!")
    toggleRandomPro() -- Bật/tắt chức năng RANDOM PRO
end)

-- Hàm toggle menu (hiện/ẩn)
local function toggleMenu()
    menu.Visible = not menu.Visible
end

-- Kết nối sự kiện khi nhấn vào logo
logoButton.MouseButton1Click:Connect(toggleMenu)
