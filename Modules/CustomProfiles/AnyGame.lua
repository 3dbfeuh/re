local LoadUrl = function(str)
    return loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/3dbfeuh/re/main/" .. str))()
end

local Lib = LoadUrl("Modules/Lib/interface.lua")
local EspLib = LoadUrl("Modules/Lib/player_esp.lua")

local VisualsTab = Lib:new("Visuals")

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

Lib:SetCategory(VisualsTab)
