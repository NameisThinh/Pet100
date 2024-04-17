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
