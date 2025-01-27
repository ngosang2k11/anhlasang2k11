local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local UIS = game:GetService("UserInputService")

-- Tạo GUI
local ScreenGui = Instance.new("ScreenGui", Player:WaitForChild("PlayerGui"))
ScreenGui.Name = "NGO TAN SANG"

-- Nút mở/ẩn menu
local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Name = "ToggleButton"
ToggleButton.Size = UDim2.new(0, 100, 0, 50)
ToggleButton.Position = UDim2.new(0, 20, 0, 20)
ToggleButton.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
ToggleButton.Text = "SANG IOS"
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.TextScaled = true

-- Menu chính
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Position = UDim2.new(0, 20, 0, 80)
MainFrame.BackgroundColor3 = Color3.new(0, 0, 0)
MainFrame.Visible = false

-- Cuộn menu
local ScrollingFrame = Instance.new("ScrollingFrame", MainFrame)
ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 300)
ScrollingFrame.ScrollBarThickness = 5

-- Danh sách tính năng
local features = {
    {name = "Tự động farm", enabled = false},
    {name = "Teleport", enabled = false},
    {name = "Auto Quest", enabled = false},
    {name = "ESP", enabled = false},
    {name = "Stat Point Auto Allocator", enabled = false}
}

for i, feature in ipairs(features) do
    local FeatureFrame = Instance.new("Frame", ScrollingFrame)
    FeatureFrame.Size = UDim2.new(1, -10, 0, 50)
    FeatureFrame.Position = UDim2.new(0, 5, 0, (i - 1) * 60)
    FeatureFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)

    local FeatureLabel = Instance.new("TextLabel", FeatureFrame)
    FeatureLabel.Size = UDim2.new(0.7, 0, 1, 0)
    FeatureLabel.Position = UDim2.new(0, 10, 0, 0)
    FeatureLabel.Text = feature.name
    FeatureLabel.TextColor3 = Color3.new(1, 1, 1)
    FeatureLabel.BackgroundTransparency = 1
    FeatureLabel.TextScaled = true

    local Switch = Instance.new("TextButton", FeatureFrame)
    Switch.Size = UDim2.new(0.2, 0, 0.6, 0)
    Switch.Position = UDim2.new(0.75, 0, 0.2, 0)
    Switch.BackgroundColor3 = Color3.new(1, 0, 0)
    Switch.Text = "OFF"
    Switch.TextScaled = true

    -- Xử lý bật/tắt tính năng
    Switch.MouseButton1Click:Connect(function()
        feature.enabled = not feature.enabled
        if feature.enabled then
            Switch.Text = "ON"
            Switch.BackgroundColor3 = Color3.new(0, 1, 0)
            print(feature.name .. " được bật")

            -- Kích hoạt tính năng
            if feature.name == "Tự động farm" then
                _G.AutoFarm = true
                while _G.AutoFarm do
                    wait(1)
                    for _, enemy in pairs(game.Workspace.Enemies:GetChildren()) do
                        if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                            Player.Character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame
                            wait(0.5)
                            game:GetService("VirtualUser"):CaptureController()
                            game:GetService("VirtualUser"):Button1Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                        end
                    end
                end
            elseif feature.name == "Teleport" then
                local locations = {
                    Spawn = Vector3.new(0, 10, 0),
                    BossArea = Vector3.new(100, 20, 100),
                    Shop = Vector3.new(-50, 5, -50)
                }
                for name, position in pairs(locations) do
                    print("Dịch chuyển tới: " .. name)
                    Player.Character.HumanoidRootPart.CFrame = CFrame.new(position)
                    wait(2)
                end
            elseif feature.name == "Auto Quest" then
                _G.AutoQuest = true
                while _G.AutoQuest do
                    wait(1)
                    local questGiver = game.Workspace:FindFirstChild("QuestGiver")
                    if questGiver then
                        Player.Character.HumanoidRootPart.CFrame = questGiver.HumanoidRootPart.CFrame
                        wait(0.5)
                        fireproximityprompt(questGiver.ProximityPrompt)
                    end
                end
            elseif feature.name == "ESP" then
                for _, target in pairs(game.Workspace:GetChildren()) do
                    if target:FindFirstChild("Humanoid") then
                        local Billboard = Instance.new("BillboardGui", target)
                        Billboard.Size = UDim2.new(0, 100, 0, 50)
                        Billboard.Adornee = target
                        Billboard.AlwaysOnTop = true

                        local Label = Instance.new("TextLabel", Billboard)
                        Label.Size = UDim2.new(1, 0, 1, 0)
                        Label.BackgroundTransparency = 1
                        Label.Text = target.Name
                        Label.TextColor3 = Color3.new(1, 0, 0)
                    end
                end
            elseif feature.name == "Stat Point Auto Allocator" then
                local stats = {"Strength", "Defense", "Sword"}
                for _, stat in pairs(stats) do
                    local statButton = Player.PlayerGui.StatsUI:FindFirstChild(stat)
                    if statButton then
                        for i = 1, 5 do
                            statButton:Activate()
                            wait(0.5)
                        end
                    end
                end
            end

        else
            Switch.Text = "OFF"
            Switch.BackgroundColor3 = Color3.new(1, 0, 0)
            print(feature.name .. " đã tắt")

            -- Tắt tính năng
            if feature.name == "Tự động farm" then
                _G.AutoFarm = false
            elseif feature.name == "Auto Quest" then
                _G.AutoQuest = false
            elseif feature.name == "ESP" then
                for _, target in pairs(game.Workspace:GetChildren()) do
                    if target:FindFirstChild("BillboardGui") then
                        target.BillboardGui:Destroy()
                    end
                end
            end
        end
    end)
end

-- Xử lý ẩn/hiện menu
ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)
