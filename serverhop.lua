local function alternateServersRequest()
    local response = request({Url = 'https://games.roblox.com/v1/games/' .. tostring(game.PlaceId) .. '/servers/Public?sortOrder=Asc&limit=30', Method = "GET", Headers = { ["Content-Type"] = "application/json" },})

    if response.Success then
        return response.Body
    else
        return nil
    end
end


 
local function getServer()

    local success, decodedData = pcall(function()
        return game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. tostring(game.PlaceId) .. '/servers/Public?sortOrder=Asc&limit=20')).data
    end)

    if not success then
        print("Error getting servers, using backup method")
        decodedData = game.HttpService:JSONDecode(alternateServersRequest()).data
    end
    
    local servers = {2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26}
    local currentIndex = 1

    local function shuffleArray(array)
        local currentIndex = #array

        while currentIndex > 1 do
            local randomIndex = math.random(1, currentIndex)
            array[currentIndex], array[randomIndex] = array[randomIndex], array[currentIndex]
            currentIndex = currentIndex - 1
        end

        return array
    end

    while true do
        local server = servers[currentIndex]
        if server then
            return server
        else
            currentIndex = (currentIndex % #servers) + 1

            -- Kiểm tra nếu đã duyệt qua tất cả các phần tử trong mảng
            if currentIndex == 1 then
                servers = shuffleArray(servers) -- Trộn lại mảng servers
            end
        end
    end
end

pcall(function()
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, getServer().id, game.Players.LocalPlayer)
end)

task.wait(5)
while true do
    game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
    task.wait()
end
