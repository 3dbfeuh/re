while not game:IsLoaded() do game.Loaded:Wait() end
while workspace.CurrentCamera == nil do wait() end

local LoadUrl = function(str)
    return loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/3dbfeuh/re/main/" .. str))()
end

local Lib = LoadUrl("Modules/Lib/interface.lua")
local EspLib = LoadUrl("Modules/Lib/player_esp.lua")
local Silent = LoadUrl("Modules/Silent/arsenal.lua")

local CombatTab = Lib:new("Combat")
local VisualsTab = Lib:new("Visuals")

CombatTab:newBtn("Silent Aim", function(bool)
	Silent.Set("Enabled", bool)
end, false)

CombatTab:newDropdown("Body Part", function(choice)
    Silent.Set("BodyPartToAim", choice)
end, {"Head", "Torso", "Random"})

CombatTab:newBtn("Team Check", function(bool)
	Silent.Set("TeamCheck", bool)
end, false)

VisualsTab:newBtn("ESP", function(bool)
	EspLib.Set("Enabled", bool)
end, false)

VisualsTab:newBtn("Tracers", function(bool)
	EspLib.Set("Tracers", bool)
end, false)

VisualsTab:newBtn("Team Check", function(bool)
	EspLib.Set("Team Check", bool)
end, false)

VisualsTab:newBtn("Team Names", function(bool)
	EspLib.Set("Team Names", bool)
end, false)

Lib:SetCategory(CombatTab)
