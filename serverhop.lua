local function alternateServersRequest()
    local response = request({Url = 'https://games.roblox.com/v1/games/' .. tostring(game.PlaceId) .. '/servers/Public?sortOrder=Asc&limit=100', Method = "GET", Headers = { ["Content-Type"] = "application/json" },})

    if response.Success then
        return response.Body
    else
        return nil
    end
end


 
local function getServer()

    local success, decodedData = pcall(function()
        return game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. tostring(game.PlaceId) .. '/servers/Public?sortOrder=Asc&limit=100')).data
    end)

    if not success then
        print("Error getting servers, using backup method")
        decodedData = game.HttpService:JSONDecode(alternateServersRequest()).data
    end

    local servers = {2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50}
    local currentIndex = 1

    local function shuffleArray(array)
        local currentIndex = #array
    
        for i = currentIndex, 2, -1 do
            local randomIndex = math.random(1, i)
            array[i], array[randomIndex] = array[randomIndex], array[i]
        end
    
        return array
    end
    local shuffledServers = shuffleArray(servers)
    while true do
        local server = shuffledServers[currentIndex]
        if server then
            return server
        else
            currentIndex = (currentIndex % #shuffledServers) + 1
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
