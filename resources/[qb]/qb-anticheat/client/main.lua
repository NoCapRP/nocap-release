-- Load QBCore and get permissions --
QBCore = nil

Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(1)
        if QBCore == nil then
            TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)    
            Citizen.Wait(200)
        end
    end
end)

local group = Config.Group

-- Check if is decorating --

local IsDecorating = false

RegisterNetEvent('qb-anticheat:client:ToggleDecorate')
AddEventHandler('qb-anticheat:client:ToggleDecorate', function(bool)
  IsDecorating = bool
end)

-- Few frequently used locals --

local flags = 0 
local player = PlayerId()
local ped = GetPlayerPed(-1)

local isLoggedIn = false

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.TriggerCallback('qb-anticheat:server:GetPermissions', function(UserGroup)
        group = UserGroup
    end)
    isLoggedIn = true
end)

-- Superjump --

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(500)
 
        local ped = GetPlayerPed(-1)
        local pedId = PlayerPedId()

        if group == Config.Group and isLoggedIn then 
            if IsPedJumping(pedId) then
                local firstCoord = GetEntityCoords(ped)
  
                while IsPedJumping(pedId) do
                    Citizen.Wait(0)
                end
        
                local secondCoord = GetEntityCoords(ped)
                local lengthBetweenCoords = GetDistanceBetweenCoords(firstCoord, secondCoord, false)

                if (lengthBetweenCoords > Config.SuperJumpLength) then
                    flags = flags + 1      
                    TriggerServerEvent("qb-log:server:CreateLog", "anticheat", "Cheat detected!", "orange", "** @everyone " ..GetPlayerName(player).. "** has been flagged by the anti-cheat! **(Flag "..flags.." /"..Config.FlagsForBan.." | Superjump)**")         
                end
            end
        end
    end
end)

-- Speedhack --

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(500)

        local ped = GetPlayerPed(-1)
        local speed = GetEntitySpeed(ped) 
        local inveh = IsPedInAnyVehicle(ped, false)
        local ragdoll = IsPedRagdoll(ped)
        local jumping = IsPedJumping(ped)
        local falling = IsPedFalling(ped)
 
        if group == Config.Group and isLoggedIn then 
            if not inveh then
                if not ragdoll then 
                    if not falling then 
                        if not jumping then 
                            if speed > Config.MaxSpeed then 
                                flags = flags + 1 
                                TriggerServerEvent("qb-log:server:CreateLog", "anticheat", "Cheat detected!", "orange", "** @everyone " ..GetPlayerName(player).. "** has been flagged by the anti-cheat! **(Flag "..flags.." /"..Config.FlagsForBan.." | Speedhack)**")   
                            end
                        end
                    end
                end
            end
        end
    end
end)

-- Invisibility --

Citizen.CreateThread(function()
    while true do      
        Citizen.Wait(10000)

        local ped = GetPlayerPed(-1)

        if group == Config.Group and isLoggedIn then 
            if not IsDecorating then 
                if not IsEntityVisible(ped) then
                    SetEntityVisible(ped, 1, 0)
                    TriggerEvent('QBCore:Notify', "QB-ANTICHEAT: You were invisible and have been made visible again!")
                    TriggerServerEvent("qb-log:server:CreateLog", "anticheat", "Made player visible", "green", "** @everyone " ..GetPlayerName(player).. "** was invisible and has been made visible again by QB-Anticheat")            
                end 
            end
        end
    end
end)

-- Nightvision --

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)

        local ped = GetPlayerPed(-1)

        if group == Config.Group and isLoggedIn then 
            if GetUsingnightvision(true) then 
                if not IsPedInAnyHeli(ped) then
                    flags = flags + 1 
                    TriggerServerEvent("qb-log:server:CreateLog", "anticheat", "Cheat detected!", "orange", "** @everyone " ..GetPlayerName(player).. "** has been flagged by the anti-cheat! **(Flag "..flags.." /"..Config.FlagsForBan.." | Nightvision)**")
                end
            end
        end
    end
end)

-- Thermalvision --

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)

        local ped = GetPlayerPed(-1)

        if group == Config.Group and isLoggedIn then 
            if GetUsingseethrough(true) then 
                if not IsPedInAnyHeli(ped) then
                    flags = flags + 1
                    TriggerServerEvent("qb-log:server:CreateLog", "anticheat", "Cheat detected!", "orange", "** @everyone " ..GetPlayerName(player).. "** has been flagged by the anti-cheat! **(Flag "..flags.." /"..Config.FlagsForBan.." | Thermalvision)**") 
                end
            end
        end
    end
end)

-- Spawned car --

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local ped = GetPlayerPed(-1)
        local veh = GetVehiclePedIsIn(ped)
        local DriverSeat = GetPedInVehicleSeat(veh, -1)
        local plate = GetVehicleNumberPlateText(veh)

        if isLoggedIn then
            if group == Config.Group then
                if IsPedInAnyVehicle(ped, true) then
                    for _, BlockedPlate in pairs(Config.BlacklistedPlates) do
                        if plate == BlockedPlate then
                            if DriverSeat == ped then 
                                DeleteVehicle(veh)               
                                TriggerServerEvent("qb-anticheat:server:banPlayer", "Cheating")
                                TriggerServerEvent("qb-log:server:CreateLog", "anticheat", "Cheat detected!", "red", "** @everyone " ..GetPlayerName(player).. "** has been banned for cheating (Sat as a driver in spawned vehicle with license plate **"..BlockedPlate.."**")         
                            end   
                        end
                    end
                end
            end
        end
    end
end)

-- Check if ped has weapon in inventory --

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)

        if isLoggedIn then

            local PlayerPed = GetPlayerPed(-1)
            local CurrentWeapon = GetSelectedPedWeapon(PlayerPed)
            local WeaponInformation = QBCore.Shared.Weapons[CurrentWeapon]

            if WeaponInformation["name"] ~= "weapon_unarmed" then
                QBCore.Functions.TriggerCallback('qb-anticheat:server:HasWeaponInInventory', function(HasWeapon)
                    if not HasWeapon then
                        RemoveAllPedWeapons(PlayerPed, false)
                        TriggerServerEvent("qb-log:server:CreateLog", "anticheat", "Weapon detected!", "orange", "** @everyone " ..GetPlayerName(player).. "**had a weapon in itself that he didn't have in his inventory. QB Anticheat removed the weapon.")  
                    end
                end, WeaponInformation)
            end

        end
    end
end)

-- Max flags reached = ban, log, explosion & break --

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)

        local coords = GetEntityCoords(ped, true)
        
        if flags >= Config.FlagsForBan then
            -- TriggerServerEvent("qb-anticheat:server:banPlayer", "Cheating")
            -- AddExplosion(coords, EXPLOSION_GRENADE, 1000.0, true, false, false, true)
            TriggerServerEvent("qb-log:server:CreateLog", "anticheat", "Player banned! (Not really of course, this is a test, duuuhhhh)", "red", "** @everyone " ..GetPlayerName(player).. "** is too often flagged by the anti-cheat and preventive banning of the server!")  
            flags = 0 
        end
    end
end)

RegisterNetEvent('qb-anticheat:client:NonRegisteredEventCalled')
AddEventHandler('qb-anticheat:client:NonRegisteredEventCalled', function(reason, CalledEvent)
    local player = PlayerId()
    local ped = GetPlayerPed(-1)

    TriggerServerEvent('qb-anticheat:server:banPlayer', reason)
    TriggerServerEvent("qb-log:server:CreateLog", "anticheat", "Player banned! (Not really of course, this is a test, duuuhhhh)", "red", "** @everyone " ..GetPlayerName(player).. "** tried to **"..CalledEvent.."trigger an event using a LUA injector")  
end)