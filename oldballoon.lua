

getgenv().autoBalloon = true

getgenv().autoBalloonConfig = {
    START_DELAY = 1, -- delay before starting
    SERVER_HOP = true, -- server hop after popping balloons
    SERVER_HOP_DELAY = 0, -- delay before server hopping
    BALLOON_DELAY = 0.5, -- delay before popping next balloon (if there are multiple balloons in the server)
    GET_BALLOON_DELAY = 1, -- delay before getting balloons again if none are detected
    WAIT_FOR_BREAK = 3 -- delay in seconds to wait for the gift to break
}
loadstring(game:HttpGet("https://raw.githubusercontent.com/fdvll/pet-simulator-99/main/waitForGameLoad.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/fdvll/pet-simulator-99/main/antiStaff.lua"))()



local Workspace = game:GetService("Workspace")
local Terrain = Workspace:WaitForChild("Terrain")
Terrain.WaterReflectance = 0
Terrain.WaterTransparency = 1
Terrain.WaterWaveSize = 0
Terrain.WaterWaveSpeed = 0

local Lighting = game:GetService("Lighting")
Lighting.Brightness = 0
Lighting.GlobalShadows = false
Lighting.FogEnd = 9e100
Lighting.FogStart = 0
sethiddenproperty(Lighting, "Technology", 2)

sethiddenproperty(Terrain, "Decoration", false)

game:GetService("Lighting"):ClearAllChildren()
local function clearTextures(v)
    if v:IsA("BasePart") and not v:IsA("MeshPart") then
        v.Material = "Plastic"
        v.Reflectance = 0
    elseif (v:IsA("Decal") or v:IsA("Texture")) then
        v.Transparency = 1
        v:Destroy()
    elseif v.Name == "Foilage" and v:IsA("Folder") then
        v:Destroy()
    elseif v.Name == "Foil" and v:IsA("Folder") then
        v:Destroy()
    elseif v.Name == "Wood" and v:IsA("Folder") then
        v:Destroy()
    elseif v.Name == "Sky" and v:IsA("Folder") then
        v:Destroy()
    elseif v.Name == "grass" and v:IsA("Folder") then
        v:Destroy()
    elseif v.Name == "ice" and v:IsA("Folder") then
        v:Destroy()
    elseif v.Name == "glass" and v:IsA("Folder") then
        v:Destroy()
    elseif v.Name == "Tree" and v:IsA("Folder") then
        v:Destroy()
    elseif v.Name == "Bush" and v:IsA("Folder") then
        v:Destroy()
    elseif v.Name == "Water" and v:IsA("Folder") then
        v:Destroy()
    elseif v.Name == "Brick" and v:IsA("Folder") then
        v:Destroy()
    elseif v.Name == "cobblestone" and v:IsA("Folder") then
        v:Destroy()
    elseif v.Name == "woodplanks" and v:IsA("Folder") then
        v:Destroy()
    elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
        v.Enabled = false
    elseif v:IsA("SpecialMesh")  then
        v.TextureId = 0
      elseif v:IsA("MeshPart") then
        v.Material = "Plastic"
        v.Reflectance = 0
        v.TextureID = 10385902758728957
    elseif v:IsA("ShirtGraphic") then
      v.Graphic = 1
    elseif (v:IsA("Shirt") or v:IsA("Pants")) then
      v[v.ClassName .. "Template"] = 1
    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
        v.Lifetime = NumberRange.new(0)
    elseif v:IsA("Explosion") then
        v.BlastPressure = 1
        v.BlastRadius = 1
    end
end
for _, v in pairs(Workspace:GetDescendants()) do
    clearTextures(v)
end

Workspace.DescendantAdded:Connect(function(v)
    clearTextures(v)
end)


for _, lootbag in pairs(game:GetService("Workspace").__THINGS:FindFirstChild("Lootbags"):GetChildren()) do
    if lootbag then
        game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Lootbags_Claim"):FireServer(unpack( { [1] = { [1] = lootbag.Name, }, } ))
        lootbag:Destroy()
        task.wait()
    end
end

game:GetService("Workspace").__THINGS:FindFirstChild("Lootbags").ChildAdded:Connect(function(lootbag)
    task.wait()
    if lootbag then
        game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Lootbags_Claim"):FireServer(unpack( { [1] = { [1] = lootbag.Name, }, } ))
        lootbag:Destroy()
    end
end)

game:GetService("Workspace").__THINGS:FindFirstChild("Orbs").ChildAdded:Connect(function(orb)
    task.wait()
    if orb then
        game:GetService("ReplicatedStorage"):WaitForChild("Network"):FindFirstChild("Orbs: Collect"):FireServer(unpack( { [1] = { [1] = tonumber(orb.Name), }, } ))
        orb:Destroy()
    end
end)

print("boga boga")
task.wait(getgenv().autoBalloonConfig.START_DELAY)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = game:GetService("Players").LocalPlayer

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Ensure 'Highlight' exists before attempting to destroy it
local highlight = Workspace.__THINGS.Breakables:FindFirstChild("Highlight")
if highlight then
    highlight:Destroy()
end

local function IsWithinDistance(object, maxDistance)
    local localPlayer = Players.LocalPlayer
    if localPlayer and localPlayer.Character then
        local playerPosition = localPlayer.Character.HumanoidRootPart.Position
        local objectPosition = object.WorldPivot.Position
        local distance = (playerPosition - objectPosition).magnitude
        return distance <= maxDistance
    end
    return false
end

MaxDistance = 5
spawn(function()
    while true do
        local breakables = Workspace.__THINGS.Breakables:GetChildren()
        for _, breakable in pairs(breakables) do
            if IsWithinDistance(breakable, MaxDistance) then
                local Model = Workspace.__THINGS.Breakables:FindFirstChild(breakable.Name)
                while Model and IsWithinDistance(Model, MaxDistance) do
                    local args = { breakable.Name } -- Assuming the name of the model is the argument
                    ReplicatedStorage:WaitForChild("Network"):WaitForChild("Breakables_PlayerDealDamage"):FireServer(unpack(args))
                    Model = Workspace.__THINGS.Breakables:FindFirstChild(breakable.Name)
                    wait()
                end
            end
        end
        wait()
    end

end)


while getgenv().autoBalloon do
    
    local balloonIds = {}

    local getActiveBalloons = ReplicatedStorage.Network.BalloonGifts_GetActiveBalloons:InvokeServer()

    local allPopped = true
    for i, v in pairs(getActiveBalloons) do
        if not v.Popped then
            allPopped = false
            print("Unpopped balloon found")
            balloonIds[i] = v
        end
    end

    if allPopped then
        print("No balloons detected, waiting " .. getgenv().autoBalloonConfig.GET_BALLOON_DELAY .. " seconds")
        if getgenv().autoBalloonConfig.SERVER_HOP then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/nameisthinh/Pet100/thinh/serverhop.lua"))()

        end
        task.wait(getgenv().autoBalloonConfig.GET_BALLOON_DELAY)
        continue
    end

    if not getgenv().autoBalloon then
        break
    end

    local originalPosition = LocalPlayer.Character.HumanoidRootPart.CFrame

    LocalPlayer.Character.HumanoidRootPart.Anchored = true
    for balloonId, balloonData in pairs(balloonIds) do
        LocalPlayer.Character.HumanoidRootPart.Anchored = true
        print("Popping balloon")

        local balloonPosition = balloonData.Position

        ReplicatedStorage.Network.Slingshot_Toggle:InvokeServer()

        task.wait()

        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(balloonPosition.X, balloonPosition.Y + 30, balloonPosition.Z)

        task.wait()

        local args = {
            [1] = Vector3.new(balloonPosition.X, balloonPosition.Y + 25, balloonPosition.Z),
            [2] = 0.5794160315249014,
            [3] = -0.8331117721691044,
            [4] = 200
        }

        ReplicatedStorage.Network.Slingshot_FireProjectile:InvokeServer(unpack(args))

        task.wait(0.1)

        local args = {
            [1] = balloonId
        }

        ReplicatedStorage.Network.BalloonGifts_BalloonHit:FireServer(unpack(args))

        LocalPlayer.Character.HumanoidRootPart.Anchored = false

        task.wait(getgenv().autoBalloonConfig.WAIT_FOR_BREAK)

        ReplicatedStorage.Network.Slingshot_Unequip:InvokeServer()

        print("Popped balloon, waiting " .. tostring(getgenv().autoBalloonConfig.BALLOON_DELAY) .. " seconds")
        task.wait(getgenv().autoBalloonConfig.BALLOON_DELAY)
    end

    if getgenv().autoBalloonConfig.SERVER_HOP then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/nameisthinh/Pet100/thinh/serverhop.lua"))()
  
    end

    LocalPlayer.Character.HumanoidRootPart.Anchored = false
    LocalPlayer.Character.HumanoidRootPart.CFrame = originalPosition
end


