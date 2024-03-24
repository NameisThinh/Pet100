local function alternateServersRequest()
    local response = request({Url = 'https://games.roblox.com/v1/games/' .. tostring(game.PlaceId) .. '/servers/Public?sortOrder=Asc&limit=20', Method = "GET", Headers = { ["Content-Type"] = "application/json" },})

    if response.Success then
        return response.Body
    else
        return nil
    end
end

 
local function getServer()
        local servers
    
        local success, decodedData = pcall(function()
            return game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. tostring(game.PlaceId) .. '/servers/Public?sortOrder=Asc&limit=20')).data
        end)
    
        if not success then
            print("Error getting servers, using backup method")
            decodedData = game.HttpService:JSONDecode(alternateServersRequest()).data
        end
    

        -- local server = servers[Random.new():NextInteger(1, 20)]
    -- if server then
    --     return server
    -- else
    --     return getServer()
    -- end
        local serverIndices = {2,3,4, 5, 6, 7, 8, 9, 10  }
        local currentIndex = 1
    
        while true do
            local server = decodedData[serverIndices[currentIndex]]
            if server then
                return server
            else
                currentIndex = (currentIndex % #serverIndices) + 1
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
