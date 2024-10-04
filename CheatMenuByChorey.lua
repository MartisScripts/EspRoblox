-- Переменная для отслеживания состояния меню
local menuOpen = false
local screenGui = nil

-- Функция для создания и отображения меню
local function createMenu()
    if menuOpen then
        -- Если меню уже открыто, просто закрываем его
        if screenGui then
            screenGui:Destroy()
        end
        menuOpen = false
    else
        -- Создаем ScreenGui для отображения меню
        screenGui = Instance.new("ScreenGui")
        screenGui.Name = "MenuGui"
        screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui") -- Помещаем в PlayerGui

        -- Создаем Frame для меню
        local menuFrame = Instance.new("Frame")
        menuFrame.Size = UDim2.new(0.6, 0, 0.7, 0) -- Увеличенный размер меню
        menuFrame.Position = UDim2.new(0.2, 0, 0.15, 0) -- Позиция ближе к центру
        menuFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2) -- Цвет фона
        menuFrame.Parent = screenGui

        -- Создаем текстовую метку в меню
        local menuLabel = Instance.new("TextLabel")
        menuLabel.Size = UDim2.new(1, 0, 0.1, 0)
        menuLabel.Position = UDim2.new(0, 0, 0, 0)
        menuLabel.Text = "Меню"
        menuLabel.TextColor3 = Color3.new(1, 1, 1)
        menuLabel.BackgroundTransparency = 1
        menuLabel.TextScaled = true
        menuLabel.Parent = menuFrame

        -- Создаем кнопку для ESP
        local espButton = Instance.new("TextButton")
        espButton.Size = UDim2.new(0.3, 0, 0.1, 0) -- Размер кнопки
        espButton.Position = UDim2.new(0.05, 0, 0.2, 0) -- Позиция в меню
        espButton.Text = "ESP"
        espButton.TextColor3 = Color3.new(1, 1, 1)
        espButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
        espButton.Parent = menuFrame

        -- Обработка нажатия на кнопку ESP
        espButton.MouseButton1Click:Connect(function()
            local function highlightCharacter(character)
                if character and not character:FindFirstChild("Highlight") then
                    local highlight = Instance.new("Highlight")
                    highlight.Parent = character
                    highlight.FillColor = Color3.new(1, 0, 0)
                    highlight.FillTransparency = 0.5
                    highlight.OutlineColor = Color3.new(1, 1, 1)
                    highlight.OutlineTransparency = 0
                end
            end

            local function addNameTag(player, character)
                if character and character:FindFirstChild("Head") and not character:FindFirstChild("NameTag") then
                    local billboardGui = Instance.new("BillboardGui")
                    billboardGui.Name = "NameTag"
                    billboardGui.Parent = character.Head
                    billboardGui.Size = UDim2.new(4, 0, 1, 0)
                    billboardGui.StudsOffset = Vector3.new(0, 2, 0)
                    billboardGui.AlwaysOnTop = true

                    local textLabel = Instance.new("TextLabel")
                    textLabel.Parent = billboardGui
                    textLabel.Size = UDim2.new(1, 0, 1, 0)
                    textLabel.BackgroundTransparency = 1
                    textLabel.Text = player.Name
                    textLabel.TextColor3 = Color3.new(1, 0, 0)
                    textLabel.TextScaled = true
                end
            end

            for _, player in pairs(game.Players:GetPlayers()) do
                if player.Character then
                    highlightCharacter(player.Character)
                    addNameTag(player, player.Character)
                end

                player.CharacterAdded:Connect(function(character)
                    highlightCharacter(character)
                    addNameTag(player, character)
                end)
            end
        end)

        -- Создаем кнопку для Aimbot
        local aimbotButton = Instance.new("TextButton")
        aimbotButton.Size = UDim2.new(0.3, 0, 0.1, 0)
        aimbotButton.Position = UDim2.new(0.05, 0, 0.35, 0) -- Позиция под кнопкой ESP
        aimbotButton.Text = "Aimbot"
        aimbotButton.TextColor3 = Color3.new(1, 1, 1)
        aimbotButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
        aimbotButton.Parent = menuFrame

        -- Обработка нажатия на кнопку Aimbot
        aimbotButton.MouseButton1Click:Connect(function()
            -- Логика Aimbot
            -- Код для Aimbot может быть добавлен сюда, как в вашем первоначальном коде.
        end)

        menuOpen = true -- Меню открыто
    end
end

-- Функция для добавления кнопки изображения
local function createImageButton()
    -- Создаем ScreenGui для изображения
    local imageGui = Instance.new("ScreenGui")
    imageGui.Name = "ImageButtonGui"
    imageGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui") -- Помещаем в PlayerGui

    -- Создаем кнопку изображения
    local imageButton = Instance.new("ImageButton")
    imageButton.Size = UDim2.new(0.1, 0, 0.1, 0) -- Размер кнопки
    imageButton.Position = UDim2.new(0.9, -100, 0.9, -100) -- Позиция в правом нижнем углу
    imageButton.Image = "rbxassetid://13333189503" -- ID изображения
    imageButton.Parent = imageGui

    -- Обработка нажатия на изображение
    imageButton.MouseButton1Click:Connect(function()
        createMenu() -- Переключаем состояние меню
    end)
end

-- Создаем кнопку изображения при загрузке игры
createImageButton()
