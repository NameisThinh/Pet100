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

local function clearTextures(v)
    local className = v.ClassName
    local name = v.Name

    if className == "BasePart" then
        if not v:IsA("MeshPart") then
            v.Material = "Plastic"
            v.Reflectance = 0
        end
    elseif className == "Decal" or className == "Texture" then
        v.Transparency = 1
    elseif className == "ParticleEmitter" or className == "Trail" then
        v.Lifetime = NumberRange.new(0)
    elseif className == "Explosion" then
        v.BlastPressure = 1
        v.BlastRadius = 1
    elseif className == "Fire" or className == "SpotLight" or className == "Smoke" or className == "Sparkles" then
        v.Enabled = false
    elseif className == "MeshPart" then
        v.Material = "Plastic"
        v.Reflectance = 0
        v.TextureID = 10385902758728957
    elseif className == "SpecialMesh" then
        v.TextureId = 0
    elseif className == "ShirtGraphic" then
        v.Graphic = 1
    elseif className == "Shirt" or className == "Pants" then
        v[className .. "Template"] = 1
    elseif name == "Foilage" and className == "Folder" then
        v:Destroy()
    elseif string.find(name, "Tree") or string.find(name, "Water") or string.find(name, "Bush") or string.find(name, "grass") then
        task.wait()
        v:Destroy()
    end
end

game:GetService("Lighting"):ClearAllChildren()

for _, v in pairs(Workspace:GetDescendants()) do
  clearTextures(v)
end

Workspace.DescendantAdded:Connect(function(v)
  clearTextures(v)
end)
