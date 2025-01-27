-- Tạo GUI
local ScreenGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")
local MenuFrame = Instance.new("Frame")
local RandomToggle = Instance.new("TextButton")

-- Cài đặt GUI
ScreenGui.Name = "SANG_IOS_Menu"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- Nút mở/đóng menu
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.new(0, 0.5, 1)
ToggleButton.Size = UDim2.new(0, 200, 0, 50)
ToggleButton.Position = UDim2.new(0.5, -100, 0, 10)
ToggleButton.Text = "SANG IOS"
ToggleButton.Font = Enum.Font.SourceSans
ToggleButton.TextSize = 20
ToggleButton.TextColor3 = Color3.new(1, 1, 1)

-- Khung menu
MenuFrame.Name = "SANG IOS MAIN"
MenuFrame.Parent = ScreenGui
MenuFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
MenuFrame.Size = UDim2.new(0, 300, 0, 200)
MenuFrame.Position = UDim2.new(0.5, -150, 0, 70)
MenuFrame.Visible = false

-- Nút bật/tắt Random XERTY
RandomToggle.Name = "RandomToggle"
RandomToggle.Parent = MenuFrame
RandomToggle.BackgroundColor3 = Color3.new(0, 1, 0)
RandomToggle.Size = UDim2.new(0, 200, 0, 50)
RandomToggle.Position = UDim2.new(0.5, -100, 0.5, -25)
RandomToggle.Text = "RANDOM XERTY: OFF"
RandomToggle.Font = Enum.Font.SourceSans
RandomToggle.TextSize = 20
RandomToggle.TextColor3 = Color3.new(1, 1, 1)

-- Biến trạng thái
local isMenuOpen = false
local isRandomEnabled = false

-- Hàm mở/đóng menu
ToggleButton.MouseButton1Click:Connect(function()
    isMenuOpen = not isMenuOpen
    MenuFrame.Visible = isMenuOpen
end)

-- Hàm bật/tắt Random XERTY
RandomToggle.MouseButton1Click:Connect(function()
    isRandomEnabled = not isRandomEnabled
    if isRandomEnabled then
        RandomToggle.Text = "RANDOM XERTY: ON"
        RandomToggle.BackgroundColor3 = Color3.new(0, 1, 0)
        -- Thay đổi tỷ lệ random (ví dụ: tăng lên 95%)
        game.Players.LocalPlayer.Character.RandomChance = 0.95 -- Giả lập tỷ lệ
    else
        RandomToggle.Text = "RANDOM XERTY: OFF"
        RandomToggle.BackgroundColor3 = Color3.new(1, 0, 0)
        -- Khôi phục tỷ lệ random ban đầu
        game.Players.LocalPlayer.Character.RandomChance = 0.1 -- Giá trị mặc định
    end
end)
