-- Tạo GUI Screen
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SANG IOS"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Tạo nút mở/đóng menu
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0.1, 0, 0.05, 0) -- Kích thước nút
toggleButton.Position = UDim2.new(0, 10, 0, 10) -- Vị trí góc trái trên
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Nền đen
toggleButton.Text = "SANG IOS"
toggleButton.TextSize = 16
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255) -- Chữ trắng
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.Parent = screenGui

-- Tạo Frame cho menu
local menuFrame = Instance.new("Frame")
menuFrame.Size = UDim2.new(0.3, 0, 0.4, 0) -- Kích thước menu
menuFrame.Position = UDim2.new(0.35, 0, 0.3, 0) -- Giữa màn hình
menuFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Nền đen
menuFrame.Visible = false -- Ẩn menu ban đầu
menuFrame.Parent = screenGui

-- Tạo tiêu đề cho menu
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0.2, 0) -- Kích thước
titleLabel.Position = UDim2.new(0, 0, 0, 0) -- Phía trên của menu
titleLabel.BackgroundTransparency = 1 -- Nền trong suốt
titleLabel.Text = "SANG IOS"
titleLabel.TextSize = 24 -- Chữ lớn hơn
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255) -- Chữ trắng
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextScaled = true -- Tự động điều chỉnh kích thước chữ
titleLabel.Parent = menuFrame

-- Tạo Label cho công tắc
local randomVipLabel = Instance.new("TextLabel")
randomVipLabel.Size = UDim2.new(0.5, 0, 0.1, 0) -- Kích thước
randomVipLabel.Position = UDim2.new(0.1, 0, 0.3, 0) -- Căn trái
randomVipLabel.BackgroundTransparency = 1 -- Nền trong suốt
randomVipLabel.Text = "RANDOM VIP"
randomVipLabel.TextSize = 18
randomVipLabel.TextColor3 = Color3.fromRGB(255, 255, 255) -- Chữ trắng
randomVipLabel.Font = Enum.Font.SourceSansBold
randomVipLabel.TextXAlignment = Enum.TextXAlignment.Left
randomVipLabel.Parent = menuFrame

-- Tạo công tắc (Switch)
local switch = Instance.new("Frame")
switch.Size = UDim2.new(0.2, 0, 0.1, 0) -- Kích thước công tắc
switch.Position = UDim2.new(0.7, 0, 0.3, 0) -- Bên phải
switch.BackgroundColor3 = Color3.fromRGB(100, 100, 100) -- Nền công tắc
switch.Parent = menuFrame

local toggle = Instance.new("Frame")
toggle.Size = UDim2.new(0.5, 0, 1, 0) -- Công tắc nhỏ bên trong
toggle.Position = UDim2.new(0, 0, 0, 0) -- Ban đầu bên trái (OFF)
toggle.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Đỏ (OFF)
toggle.Parent = switch

-- Biến trạng thái của RANDOM VIP
local randomVipEnabled = false

-- Hàm xử lý bật/tắt switch
switch.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        randomVipEnabled = not randomVipEnabled
        if randomVipEnabled then
            toggle.Position = UDim2.new(0.5, 0, 0, 0) -- Chuyển công tắc sang phải
            toggle.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- Màu xanh (ON)
            print("RANDOM VIP: ON")
            -- Logic random trái ác quỷ
            local fruits = {"Dough", "Kitsune", "Dragon"}
            local randomFruit = fruits[math.random(1, #fruits)]
            print("Bạn đã nhận được trái ác quỷ: " .. randomFruit)
        else
            toggle.Position = UDim2.new(0, 0, 0, 0) -- Chuyển công tắc sang trái
            toggle.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Màu đỏ (OFF)
            print("RANDOM VIP: OFF")
        end
    end
end)

-- Hàm mở/đóng menu
toggleButton.MouseButton1Click:Connect(function()
    menuFrame.Visible = not menuFrame.Visible
end)
