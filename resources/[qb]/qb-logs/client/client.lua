QBCore = nil

local citizenid = nil
local playerData = nil
local updateInterval = 30000

Citizen.CreateThread(function() 
    while QBCore == nil do
        TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)    
        Citizen.Wait(200)
    end
end)

-- Round function
function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

-- Main update loop (NOT IN USE)
--[[
Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(1000) 

        if QBCore ~= nil then
            if citizenid == nil then
                citizenid = QBCore.Functions.GetPlayerData().citizenid
            else
                local playerCoords = GetEntityCoords(PlayerPedId())
                local get = string.format("%s?x=%s&y=%s&cid=%s", round(playerCoords[1], 2), round(playerCoords[2], 2), citizenid)
                
                SendNUIMessage({
                    action = "http",
                    url = get
                })

                Citizen.Wait(updateInterval)
            end
        end
    end
end)
]]--
