-- Tạo một ScreenGui để hiển thị menu cho người chơi
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Tạo một Frame cho menu và căn giữa màn hình
local menuFrame = Instance.new("Frame")
menuFrame.Parent = screenGui
menuFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Nền màu đen
menuFrame.Size = UDim2.new(0, 200, 0, 150)  -- Kích thước menu
menuFrame.Position = UDim2.new(0.5, -100, 0.5, -75)  -- Căn giữa màn hình
menuFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)  -- Viền màu đỏ
menuFrame.Visible = false  -- Ban đầu ẩn menu

-- Tạo một nút để mở/ẩn menu, tên nút là "SANG IOS"
local toggleButton = Instance.new("TextButton")
toggleButton.Parent = screenGui
toggleButton.Size = UDim2.new(0, 200, 0, 50)
toggleButton.Position = UDim2.new(0.5, -100, 0, 10)  -- Vị trí nút ở trên cùng và căn giữa
toggleButton.AnchorPoint = Vector2.new(0.5, 0)  -- Gắn nút ở giữa
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Nền màu đen
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)  -- Chữ trắng
toggleButton.Text = "SANG IOS"  -- Tên nút là "SANG IOS"
toggleButton.Font = Enum.Font.SourceSans
toggleButton.TextSize = 24

-- Tạo một switch để bật/tắt, thay cho nút RD FRUIT
local switchButton = Instance.new("TextButton")
switchButton.Parent = menuFrame
switchButton.Size = UDim2.new(0, 180, 0, 50)  -- Kích thước của switch
switchButton.Position = UDim2.new(0, 10, 0, 60)  -- Vị trí switch trong menu
switchButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)  -- Màu nền đỏ khi OFF
switchButton.TextColor3 = Color3.fromRGB(255, 255, 255)  -- Chữ trắng
switchButton.Text = "Switch: OFF"  -- Văn bản ban đầu của switch
switchButton.Font = Enum.Font.SourceSans
switchButton.TextSize = 24

local isSwitchOn = false  -- Biến kiểm tra trạng thái switch

-- Hàm để bật/tắt switch khi nhấn vào nút
switchButton.MouseButton1Click:Connect(function()
    isSwitchOn = not isSwitchOn  -- Đảo trạng thái switch
    if isSwitchOn then
        switchButton.Text = "Switch: ON"  -- Cập nhật trạng thái bật
        switchButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)  -- Màu nền xanh khi bật
    else
        switchButton.Text = "Switch: OFF"  -- Cập nhật trạng thái tắt
        switchButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)  -- Màu nền đỏ khi tắt
    end
end)

-- Hàm để mở/ẩn menu khi nhấn vào nút "SANG IOS"
toggleButton.MouseButton1Click:Connect(function()
    menuFrame.Visible = not menuFrame.Visible  -- Chuyển đổi trạng thái hiển thị menu
end)

-- Tạo một TextLabel trong menu để hiển thị tiêu đề
local menuText = Instance.new("TextLabel")
menuText.Parent = menuFrame
menuText.Size = UDim2.new(1, 0, 0, 50)
menuText.TextColor3 = Color3.fromRGB(255, 255, 255)  -- Chữ màu trắng
menuText.Text = "RD FRUIT"
menuText.TextSize = 30
menuText.TextAlign = Enum.TextAlign.Center
menuText.Font = Enum.Font.SourceSans

-- Hàm random trái ác quỷ
local function randomDevilFruit()
    -- Nếu switch bật, chắc chắn trái Dragon sẽ được chọn
    if isSwitchOn then
        print("Switch is ON, you received the Dragon Fruit!")
        return "Dragon"  -- Trả về trái ác quỷ Dragon
    else
        -- Nếu switch tắt, chọn ngẫu nhiên trái ác quỷ khác
        local fruits = {
            "Kisune",  -- Ví dụ trái ác quỷ Phoenix
            "Yeti",  -- Ví dụ trái ác quỷ Magma
            "Leopard",  -- Ví dụ trái ác quỷ Ice
            -- Có thể thêm nhiều trái ác quỷ khác vào danh sách này
        }

        -- Random chọn trái ác quỷ
        local randomIndex = math.random(1, #fruits)
        return fruits[randomIndex]
    end
end

-- Hàm để kích hoạt hành động random trái ác quỷ
local function onRandomFruit()
    local fruit = randomDevilFruit()
    if fruit == "Dragon" then
        print("Chúc mừng! Bạn đã nhận được trái ác quỷ Dragon!")
        -- Tại đây, bạn có thể thực hiện hành động thêm trái Dragon vào túi đồ của người chơi
    else
        print("Bạn nhận được trái ác quỷ " .. fruit)
        -- Xử lý nhận các trái ác quỷ khác tại đây
    end
end

-- Ví dụ gọi hàm random trái ác quỷ khi người chơi muốn nhận trái
onRandomFruit()
