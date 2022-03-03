local game =  game
local GetService = game.GetService

while workspace.CurrentCamera == nil do wait() end

local Players = GetService(game, "Players")
local LocalPlayer = Players.LocalPlayer
local RunService = GetService(game, "RunService")
local BodyPart = nil
local Settings = {
    ["Enabled"] = false,
    ["TeamCheck"] = false,
    ["BodyPartToAim"] = "torso"
}
local Camera = workspace.CurrentCamera
local Mouse = LocalPlayer.GetMouse(LocalPlayer)

local GetPartToAim = function()
    local result = "UpperTorso"
    if Settings.BodyPartToAim == "head" then
        result = "Head"
    end
    if Settings.BodyPartToAim == "torso" then
        result = "UpperTorso"
    end
    if Settings.BodyPartToAim == "random" then
        local parts = {"Head", "UpperTorso"}
        result = parts[math.random(1, #parts)]
    end
    return result
end

local IsA, FindFirstChild, find, lower, GetChildren =
    game.IsA,
    game.FindFirstChild,
    string.find,
    string.lower,
    game.GetChildren

local WTS = function(Object)
    local ObjectVector = Camera.WorldToScreenPoint(Camera, Object.Position)
    return Vector2.new(ObjectVector.X, ObjectVector.Y)
end

local PositionToRay = function(Origin, Target)
    return Ray.new(Origin, (Target - Origin).Unit * 600)
end

local Filter = function (Object)
    if find(Object.Name, "Gun") then
        return
    end
    if IsA(Object, "Part") or IsA(Object, "MeshPart") then
        return true
    end
end

local MousePositionToVector2 = function()
    return Vector2.new(Mouse.X, Mouse.Y)
end

local IsOnScreen = function(Object)
    local IsOnScreen = Camera.WorldToScreenPoint(Camera, Object.Position)
    return IsOnScreen
end

local GetClosestBodyPartFromCursor = function()
    local ClosestDistance = math.huge
    for i, v in next, Players.GetPlayers(Players) do
        if v ~= LocalPlayer and (Settings.TeamCheck and v.Team ~= LocalPlayer.Team) and v.Character and FindFirstChild(v.Character, "Humanoid") then
            for k, x in next, GetChildren(v.Character) do
                if Filter(x) and lower(tostring(x.Name)) == GetPartToAim() and IsOnScreen(x) then
                    local Distance = (WTS(x) - MousePositionToVector2()).Magnitude
                    if Distance < ClosestDistance then
                        ClosestDistance = Distance
                        BodyPart = x
                    end
                end
            end
        end
    end
end

local OldNameCall
OldNameCall = hookmetamethod(game, "__namecall", function(Self, ...)
    local Method = getnamecallmethod()
    local Args = {...}
    if Settings.Enabled and Method == "FindPartOnRayWithIgnoreList" and BodyPart ~= nil then
        Args[1] = PositionToRay(Camera.CFrame.Position, BodyPart.Position)
        return OldNameCall(Self, unpack(Args))
    end
    return OldNameCall(Self, ...)
end)

RunService.BindToRenderStep(RunService, "Dynamic Silent Aim", 120, GetClosestBodyPartFromCursor)

return {
    ["Set"] = function(var, bool)
        if var ~= nil and Settings[var] ~= nil and bool ~= nil then
            Settings[var] = bool
        end
    end
}
