QBCore = nil

Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(10)
        if QBCore == nil then
            TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)    
            Citizen.Wait(200)
        end
    end
end)

-- code

local isLoggedIn = false 

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
end)

Citizen.CreateThread(function()
    while true do
        local InRange = false
        local PlayerPed = GetPlayerPed(-1)
        local PlayerPos = GetEntityCoords(PlayerPed)

            local dist = GetDistanceBetweenCoords(PlayerPos, 960.14959716797,26.020780563354,76.991325378418)
            if dist < 10 then
                InRange = true
                DrawMarker(2, 960.14959716797,26.020780563354,76.991325378418, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.25, 0.2, 0.1, 255, 0, 0, 155, 0, 0, 0, 1, 0, 0, 0)
                if dist < 1 then
                    DrawText3Ds(960.14959716797,26.020780563354,76.991325378418, '~g~E~w~ - Sell chips')
                    if IsControlJustPressed(0, Config.Keys["E"]) then
                        TriggerServerEvent('qb-casino:sharlock:sell')
                    end
                end
            end

        if not InRange then
            Citizen.Wait(5000)
        end
        Citizen.Wait(5)
    end
end)

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end


-- all credits goes to Sharlock and Lua Leaks
-- https://www.twitch.tv/Sharlock Lua Leaks | discord.gg/Ngx5M6S