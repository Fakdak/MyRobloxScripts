-- Сервисы
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")

-- Локальный игрок
local LocalPlayer = Players.LocalPlayer

-- Ожидание загрузки персонажа
if not LocalPlayer.Character then
    LocalPlayer.CharacterAdded:Wait()
end
local Character = LocalPlayer.Character
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- Таблицы для управления способностями и кулдаунами
local Toggles = {
    KaiserAccelerate = false,
    GetOutFuckingMe = false,
    YEXMovement = false,
    OffTheBallBeinschuss = false,
    GodsChosenEmperor = false,
    MetaVision = false
}

local Cooldowns = {
    KaiserAccelerate = {Cooldown = 15, LastUsed = 0},
    GetOutFuckingMe = {Cooldown = 20, LastUsed = 0},
    YEXMovement = {Cooldown = 8, LastUsed = 0},
    OffTheBallBeinschuss = {Cooldown = 12, LastUsed = 0},
    GodsChosenEmperor = {Cooldown = 30, LastUsed = 0},
    MetaVision = {Cooldown = 10, LastUsed = 0}
}

-- Функция для поиска мяча
local function findBall()
    local football = Workspace:FindFirstChild("Football")
    if football then
        print("Мяч найден: Football")
        return football
    end

    local ballSpawn = Workspace:FindFirstChild("BallSpawn")
    if ballSpawn then
        for _, child in pairs(ballSpawn:GetChildren()) do
            if child:IsA("BasePart") and child.Name:find("Football") then
                print("Мяч найден в BallSpawn:", child.Name)
                return child
            end
        end
    end

    print("Мяч не найден! Вот все объекты в Workspace:")
    for _, obj in pairs(Workspace:GetChildren()) do
        if obj:IsA("BasePart") then
            print("Объект:", obj.Name)
        end
    end
    return nil
end

-- Kaiser Accelerate: Телепортирует к мячу и крадёт его
local function kaiserAccelerate()
    if not Character or not RootPart then return end
    local ball = findBall()
    if ball then
        RootPart.CFrame = ball.CFrame + Vector3.new(0, 2, 0)
        local weld = ball:FindFirstChildOfClass("Weld")
        if weld then
            weld:Destroy()
        end
        local newWeld = Instance.new("Weld")
        newWeld.Part0 = RootPart
        newWeld.Part1 = ball
        newWeld.C0 = CFrame.new(0, -2, -2)
        newWeld.Parent = ball
    else
        print("Мяч не найден для Kaiser Accelerate!")
    end
end

-- Get Out Fucking Me: Отталкивает ближайших игроков
local function getOutFuckingMe()
    if not Character or not RootPart then return end
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if otherPlayer ~= LocalPlayer and otherPlayer.Character then
            local otherRoot = otherPlayer.Character:FindFirstChild("HumanoidRootPart")
            if otherRoot and (otherRoot.Position - RootPart.Position).Magnitude <= 10 then
                local direction = (otherRoot.Position - RootPart.Position).Unit * 20
                otherRoot.Velocity = direction
            end
        end
    end
end

-- Y'EX Movement: Заглушка для увеличения точности
local function yexMovement()
    print("Y'EX Movement активирован - увеличена точность!")
    -- Здесь можно добавить логику для увеличения точности удара/паса
end

-- Off The Ball Beinschuss: Заглушка (пока просто сообщение)
local function offTheBallBeinschuss()
    print("Off The Ball Beinschuss активирован!")
    -- Здесь можно добавить логику для этой способности
end

-- God's Chosen Emperor: Заглушка (пока просто сообщение)
local function godsChosenEmperor()
    print("God's Chosen Emperor активирован!")
    -- Здесь можно добавить логику для этой способности
end

-- Meta Vision: Заглушка (пока просто сообщение)
local function metaVision()
    print("Meta Vision активирован!")
    -- Здесь можно добавить логику для этой способности
end

-- Функции для запуска способностей с кулдаунами
local function runKaiserAccelerate()
    if Toggles.KaiserAccelerate then
        spawn(function()
            while Toggles.KaiserAccelerate do
                local currentTime = tick()
                if currentTime - Cooldowns.KaiserAccelerate.LastUsed >= Cooldowns.KaiserAccelerate.Cooldown then
                    kaiserAccelerate()
                    Cooldowns.KaiserAccelerate.LastUsed = currentTime
                end
                wait(0.5)
            end
        end)
    end
end

local function runGetOutFuckingMe()
    if Toggles.GetOutFuckingMe then
        spawn(function()
            while Toggles.GetOutFuckingMe do
                local currentTime = tick()
                if currentTime - Cooldowns.GetOutFuckingMe.LastUsed >= Cooldowns.GetOutFuckingMe.Cooldown then
                    getOutFuckingMe()
                    Cooldowns.GetOutFuckingMe.LastUsed = currentTime
                end
                wait(0.5)
            end
        end)
    end
end

local function runYEXMovement()
    if Toggles.YEXMovement then
        spawn(function()
            while Toggles.YEXMovement do
                local currentTime = tick()
                if currentTime - Cooldowns.YEXMovement.LastUsed >= Cooldowns.YEXMovement.Cooldown then
                    yexMovement()
                    Cooldowns.YEXMovement.LastUsed = currentTime
                end
                wait(0.5)
            end
        end)
    end
end

local function runOffTheBallBeinschuss()
    if Toggles.OffTheBallBeinschuss then
        spawn(function()
            while Toggles.OffTheBallBeinschuss do
                local currentTime = tick()
                if currentTime - Cooldowns.OffTheBallBeinschuss.LastUsed >= Cooldowns.OffTheBallBeinschuss.Cooldown then
                    offTheBallBeinschuss()
                    Cooldowns.OffTheBallBeinschuss.LastUsed = currentTime
                end
                wait(0.5)
            end
        end)
    end
end

local function runGodsChosenEmperor()
    if Toggles.GodsChosenEmperor then
        spawn(function()
            while Toggles.GodsChosenEmperor do
                local currentTime = tick()
                if currentTime - Cooldowns.GodsChosenEmperor.LastUsed >= Cooldowns.GodsChosenEmperor.Cooldown then
                    godsChosenEmperor()
                    Cooldowns.GodsChosenEmperor.LastUsed = currentTime
                end
                wait(0.5)
            end
        end)
    end
end

local function runMetaVision()
    if Toggles.MetaVision then
        spawn(function()
            while Toggles.MetaVision do
                local currentTime = tick()
                if currentTime - Cooldowns.MetaVision.LastUsed >= Cooldowns.MetaVision.Cooldown then
                    metaVision()
                    Cooldowns.MetaVision.LastUsed = currentTime
                end
                wait(0.5)
            end
        end)
    end
end

-- Создание UI
local success, err = pcall(function()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "BlueLockGUI"
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    print("ScreenGui создан:", ScreenGui)

    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 300, 0, 300)
    Frame.Position = UDim2.new(0, 10, 0, 10)
    Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Frame.BorderSizePixel = 0
    Frame.Parent = ScreenGui
    print("Frame создан:", Frame)

    local function createButton(name, position, callback)
        local Button = Instance.new("TextButton")
        Button.Size = UDim2.new(0, 120, 0, 40)
        Button.Position = position
        Button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.Text = name
        Button.Parent = Frame
        print("Кнопка создана:", name)
        Button.MouseButton1Click:Connect(function()
            Toggles[name] = not Toggles[name]
            Button.BackgroundColor3 = Toggles[name] and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(70, 70, 70)
            print(name .. ":", Toggles[name] and "Включён" or "Выключен")
            callback()
        end)
    end

    -- Создание кнопок для каждой способности
    createButton("KaiserAccelerate", UDim2.new(0, 10, 0, 10), runKaiserAccelerate)
    createButton("GetOutFuckingMe", UDim2.new(0, 160, 0, 10), runGetOutFuckingMe)
    createButton("YEXMovement", UDim2.new(0, 10, 0, 60), runYEXMovement)
    createButton("OffTheBallBeinschuss", UDim2.new(0, 160, 0, 60), runOffTheBallBeinschuss)
    createButton("GodsChosenEmperor", UDim2.new(0, 10, 0, 110), runGodsChosenEmperor)
    createButton("MetaVision", UDim2.new(0, 160, 0, 110), runMetaVision)
end)

if not success then
    print("Ошибка при создании UI:", err)
end

-- Управление через клавиши (запасной вариант)
UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent then return end -- Игнорируем, если игрок взаимодействует с интерфейсом (например, чатом)

    -- Kaiser Accelerate (клавиша E)
    if input.KeyCode == Enum.KeyCode.E then
        Toggles.KaiserAccelerate = not Toggles.KaiserAccelerate
        print("Kaiser Accelerate:", Toggles.KaiserAccelerate and "Включён" or "Выключен")
        runKaiserAccelerate()
    end

    -- Get Out Fucking Me (клавиша F)
    if input.KeyCode == Enum.KeyCode.F then
        Toggles.GetOutFuckingMe = not Toggles.GetOutFuckingMe
        print("Get Out Fucking Me:", Toggles.GetOutFuckingMe and "Включён" or "Выключен")
        runGetOutFuckingMe()
    end

    -- Y'EX Movement (клавиша T)
    if input.KeyCode == Enum.KeyCode.T then
        Toggles.YEXMovement = not Toggles.YEXMovement
        print("Y'EX Movement:", Toggles.YEXMovement and "Включён" or "Выключен")
        runYEXMovement()
    end

    -- Off The Ball Beinschuss (клавиша R)
    if input.KeyCode == Enum.KeyCode.R then
        Toggles.OffTheBallBeinschuss = not Toggles.OffTheBallBeinschuss
        print("Off The Ball Beinschuss:", Toggles.OffTheBallBeinschuss and "Включён" or "Выключен")
        runOffTheBallBeinschuss()
    end

    -- God's Chosen Emperor (клавиша G)
    if input.KeyCode == Enum.KeyCode.G then
        Toggles.GodsChosenEmperor = not Toggles.GodsChosenEmperor
        print("God's Chosen Emperor:", Toggles.GodsChosenEmperor and "Включён" or "Выключен")
        runGodsChosenEmperor()
    end

    -- Meta Vision (клавиша J)
    if input.KeyCode == Enum.KeyCode.J then
        Toggles.MetaVision = not Toggles.MetaVision
        print("Meta Vision:", Toggles.MetaVision and "Включён" or "Выключен")
        runMetaVision()
    end
end)

-- Сообщение о загрузке скрипта
print("Скрипт для Blue Lock загружен!")
print("Если кнопки не отображаются, используй следующие клавиши для управления способностями:")
print("E - Kaiser Accelerate")
print("F - Get Out Fucking Me")
print("T - Y'EX Movement")
print("R - Off The Ball Beinschuss")
print("G - God's Chosen Emperor")
print("J - Meta Vision")
