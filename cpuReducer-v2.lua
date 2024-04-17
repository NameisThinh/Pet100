repeat
  task.wait()
until game:IsLoaded()

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
for k,v in workspace:GetChildren() do 
    if v.Name ~= plr.Name and v.Name ~= "Camera"  then 
        pcall(function() 
            v:Destroy()
        end)
    end
end
if plr.PlayerScripts:FindFirstChild("Parallel Pet Actors") then 
    plr.PlayerScripts:FindFirstChild("Parallel Pet Actors"):Destroy()
end
pcall(function() 
    plr.PlayerScripts.Scripts:Destroy()
end)
pcall(function() 
    for k,v in getrunningscripts() do pcall(function() v.Disabled = true end) v:Destroy() end
end)
pcall(function() 
    for k,v in game:GetDescendants() do 
        if v:IsA("RemoteEvent") then 
            pcall(function() 
                for k,v in getconnections(v.OnClientEvent) do 
                    if getfenv(v.Function).script ~= script then v:Disable() end
                end
            end)
        end
    end
end)

for k,v in plr.PlayerGui:GetChildren() do 
    v:Destroy()
end
