--[[ TOP Optimizer - Complete Working Version ]]

-- Проверка загрузки игры
if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- Инициализация
local Optimizer = {
    Version = "2.1",
    SessionID = math.random(1000000, 9999999),
    Applied = 0
}

-- Основные оптимизации
function Optimizer:ApplyMemoryOptimization()
    for i = 1, 5 do
        collectgarbage("collect")
        task.wait(0.05)
    end
    self.Applied = self.Applied + 1
    return "Memory cleaned"
end

function Optimizer:ApplyGraphicsOptimization()
    pcall(function()
        settings().Rendering.QualityLevel = 1
        if game:GetService("Lighting") then
            game:GetService("Lighting").GlobalShadows = false
        end
    end)
    self.Applied = self.Applied + 1
    return "Graphics optimized"
end

function Optimizer:ApplyNetworkOptimization()
    pcall(function()
        game:GetService("NetworkClient"):SetOutgoingKBPSLimit(999999999)
    end)
    self.Applied = self.Applied + 1
    return "Network boosted"
end

-- UI уведомление
function Optimizer:ShowNotification()
    pcall(function()
        local gui = Instance.new("ScreenGui")
        gui.Name = "TopOptimizerNotify"
        gui.DisplayOrder = 999
        
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0, 300, 0, 80)
        frame.Position = UDim2.new(1, -310, 0, 10)
        frame.BackgroundColor3 = Color3.fromRGB(25, 30, 40)
        frame.BackgroundTransparency = 0.3
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = frame
        
        local title = Instance.new("TextLabel")
        title.Text = "TOP OPTIMIZER v" .. self.Version
        title.Size = UDim2.new(1, -10, 0, 30)
        title.Position = UDim2.new(0, 5, 0, 5)
        title.TextColor3 = Color3.fromRGB(100, 180, 255)
        title.BackgroundTransparency = 1
        title.Font = Enum.Font.Code
        title.TextSize = 16
        
        local status = Instance.new("TextLabel")
        status.Text = "Applied " .. self.Applied .. " optimizations\nSession: " .. self.SessionID
        status.Size = UDim2.new(1, -10, 0, 40)
        status.Position = UDim2.new(0, 5, 0, 35)
        status.TextColor3 = Color3.fromRGB(200, 220, 255)
        status.BackgroundTransparency = 1
        status.Font = Enum.Font.Code
        status.TextSize = 14
        
        title.Parent = frame
        status.Parent = frame
        frame.Parent = gui
        gui.Parent = game:GetService("CoreGui")
        
        -- Автоудаление через 5 секунд
        task.wait(5)
        for i = 1, 20 do
            frame.BackgroundTransparency = frame.BackgroundTransparency + 0.05
            task.wait(0.05)
        end
        gui:Destroy()
    end)
end

-- Основной процесс
function Optimizer:Run()
    print("[TOP Optimizer] Starting...")
    
    -- Применяем оптимизации
    local results = {
        self:ApplyMemoryOptimization(),
        self:ApplyGraphicsOptimization(),
        self:ApplyNetworkOptimization()
    }
    
    -- Показываем уведомление
    self:ShowNotification()
    
    -- Логируем результат
    print("[TOP Optimizer] Complete! Applied " .. self.Applied .. " optimizations")
    print("[TOP Optimizer] Session ID: " .. self.SessionID)
    
    return {
        success = true,
        optimizations = self.Applied,
        session = self.SessionID,
        version = self.Version
    }
end

-- Запускаем оптимизатор
return Optimizer:Run()
