-- Функция для добавления эффекта подсветки персонажу
local function highlightCharacter(character)
    -- Проверяем, существует ли уже Highlight
    if not character:FindFirstChild("Highlight") then
        -- Создаем объект Highlight
        local highlight = Instance.new("Highlight")
        highlight.Parent = character -- Устанавливаем родительским объектом модель персонажа

        -- Настройки Highlight
        highlight.FillColor = Color3.new(1, 0, 0) -- Цвет заполнения (красный)
        highlight.FillTransparency = 0.5 -- Прозрачность заполнения
        highlight.OutlineColor = Color3.new(1, 1, 0) -- Цвет обводки (желтый)
        highlight.OutlineTransparency = 0 -- Прозрачность обводки (0 = полностью видимый)
    end
end

-- Функция для добавления ника над персонажем
local function addNameTag(player, character)
    -- Проверяем, существует ли уже BillboardGui
    if not character:FindFirstChild("NameTag") then
        -- Создаем BillboardGui
        local billboardGui = Instance.new("BillboardGui")
        billboardGui.Name = "NameTag"
        billboardGui.Parent = character:FindFirstChild("Head") -- Родитель — голова персонажа
        billboardGui.Size = UDim2.new(4, 0, 1, 0) -- Размер BillboardGui
        billboardGui.StudsOffset = Vector3.new(0, 2, 0) -- Смещение вверх над головой
        billboardGui.AlwaysOnTop = true -- Делает так, чтобы текст всегда был видимым

        -- Создаем текстовый элемент для ника
        local textLabel = Instance.new("TextLabel")
        textLabel.Parent = billboardGui
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1 -- Убираем фон
        textLabel.Text = player.Name -- Устанавливаем текст как имя игрока
        textLabel.TextColor3 = Color3.new(1, 1, 1) -- Цвет текста (белый)
        textLabel.TextScaled = true -- Масштабирование текста по размеру
    end
end

-- Когда новый игрок входит в игру
game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        -- Добавляем подсветку и ник новому персонажу
        highlightCharacter(character)
        addNameTag(player, character)
    end)
end)

-- Для всех уже существующих игроков
for _, player in pairs(game.Players:GetPlayers()) do
    if player.Character then
        highlightCharacter(player.Character)
        addNameTag(player, player.Character)
    end
end
