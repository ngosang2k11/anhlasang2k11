-- Tạo Menu "SANG IOS"
local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

local menuFrame = Instance.new("Frame")
menuFrame.Parent = screenGui
menuFrame.Size = UDim2.new(0, 300, 0, 200)
menuFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
menuFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Nền màu đen

local title = Instance.new("TextLabel")
title.Parent = menuFrame
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "SANG IOS"
title.TextColor3 = Color3.fromRGB(255, 255, 255) -- Chữ màu trắng
title.TextSize = 24
title.TextAlign = Enum.TextXAlignment.Center
title.BackgroundTransparency = 1

-- Công tắc RD FRUIT
local rdFruitToggle = Instance.new("TextButton")
rdFruitToggle.Parent = menuFrame
rdFruitToggle.Size = UDim2.new(0.8, 0, 0, 40)
rdFruitToggle.Position = UDim2.new(0.5, -120, 0.5, -20)
rdFruitToggle.Text = "RD FRUIT: OFF"
rdFruitToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
rdFruitToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
rdFruitToggle.TextSize = 18
rdFruitToggle.TextAlign = Enum.TextXAlignment.Center

local isRdFruitOn = false

-- Toggle công tắc RD FRUIT
rdFruitToggle.MouseButton1Click:Connect(function()
    isRdFruitOn = not isRdFruitOn
    if isRdFruitOn then
        rdFruitToggle.Text = "RD FRUIT: ON"
    else
        rdFruitToggle.Text = "RD FRUIT: OFF"
    end
end)

-- Ẩn/Hiện Menu khi ấn vào chữ "SANG IOS"
local function toggleMenu()
    menuFrame.Visible = not menuFrame.Visible
end

title.MouseButton1Click:Connect(toggleMenu)

-- Tạo một NPC Blox Fruit Gacha giả lập trong game
local npc = workspace:WaitForChild("BloxFruitGacha") -- NPC BloxFruitGacha

-- Hàm cấp trái ác quỷ Dragon nếu bật RD FRUIT và người chơi đủ điều kiện
local function giveDragonFruit(character)
    if isRdFruitOn then
        -- Kiểm tra nếu người chơi có đủ level (ví dụ: Level >= 50)
        local level = character:FindFirstChild("Level") -- Giả sử có thuộc tính Level
        if level and level.Value >= 50 then
            local fruits = {"Dragon"} -- Chỉ cho trái Dragon
            local randomFruit = fruits[math.random(1, #fruits)] -- Luôn luôn chọn Dragon

            print(character.Name .. " đã nhận được trái Ác Quỷ " .. randomFruit)
            -- Logic cấp trái Dragon cho người chơi (giả sử là thêm vào inventory)

            local fruitItem = Instance.new("StringValue") -- Tạo một item trái ác quỷ mới
            fruitItem.Name = "Fruit"
            fruitItem.Value = randomFruit
            fruitItem.Parent = character -- Thêm trái Dragon vào người chơi

            -- Hiển thị thông báo cho người chơi
            local message = Instance.new("Message")
            message.Text = character.Name .. " đã nhận được trái Ác Quỷ Dragon!"
            message.Parent = game.Workspace
            wait(3)
            message:Destroy()

        else
            -- Nếu người chơi không đủ level
            local message = Instance.new("Message")
            message.Text = character.Name .. " chưa đủ level để nhận trái Ác Quỷ!"
            message.Parent = game.Workspace
            wait(3)
            message:Destroy()
        end
    end
end

-- Kiểm tra khi người chơi chạm vào NPC Blox Fruit Gacha
npc.Touched:Connect(function(hit)
    local character = hit.Parent
    if character:IsA("Model") and character:FindFirstChild("Humanoid") then
        if character == player.Character then
            giveDragonFruit(character) -- Cấp trái Dragon khi RD FRUIT bật và đủ điều kiện
        end
    end
end)

-- Đảm bảo menu được ẩn khi game bắt đầu
menuFrame.Visible = false
