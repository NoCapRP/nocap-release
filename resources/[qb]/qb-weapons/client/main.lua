QBCore = nil

local isLoggedIn = true
local CurrentWeaponData = {}
local CurrentItemData = {}
local PlayerData = {}
local CanShoot = true
local CanUse = true

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

CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Wait(200)
    end
end)

CreateThread(function()
    while true do
        pedId = PlayerPedId()
        plyId = PlayerId()
        Wait(5000)
    end
end)

CreateThread(function() 
    while true do
        if isLoggedIn then
            TriggerServerEvent("weapons:server:SaveWeaponAmmo")
        end
        Wait(60000)
    end
end)

CreateThread(function()
    Wait(1000)
    if QBCore.Functions.GetPlayerData() ~= nil then
        TriggerServerEvent("weapons:server:LoadWeaponAmmo")
        isLoggedIn = true
        PlayerData = QBCore.Functions.GetPlayerData()

        QBCore.Functions.TriggerCallback("weapons:server:GetConfig", function(RepairPoints)
            for k, data in pairs(RepairPoints) do
                Config.WeaponRepairPoints[k].IsRepairing = data.IsRepairing
                Config.WeaponRepairPoints[k].RepairingData = data.RepairingData
            end
        end)
    end
end)

local MultiplierAmount = 0
local MultiplierItemAmount = 0

CreateThread(function()
    while true do
        if isLoggedIn then
            if CurrentWeaponData ~= nil and next(CurrentWeaponData) ~= nil then
                if IsPedShooting(pedId) or IsControlJustPressed(0, 24) then
                    if CanShoot then
                        local weapon = GetSelectedPedWeapon(pedId)
                        local ammo = GetAmmoInPedWeapon(pedId, weapon)
                        if QBCore.Shared.Weapons[weapon]["name"] == "weapon_snowball" then
                            TriggerServerEvent('QBCore:Server:RemoveItem', "snowball", 1)
                        else
                            if ammo > 0 then
                                MultiplierAmount = MultiplierAmount + 1
                            end
                        end
                    else
                        TriggerEvent('inventory:client:CheckWeapon')
                        TriggerEvent("DoLongHudText", "This weapon is broken and can not be used..", 2)
                        MultiplierAmount = 0
                    end
                end
            end
        end
        Wait(1)
    end
end)

CreateThread(function()
    while true do
        local weapon = GetSelectedPedWeapon(pedId)
        local ammo = GetAmmoInPedWeapon(pedId, weapon)

        if weapon == 741814745 then
            if IsPedShooting(pedId) then
                if ammo - 1 < 1 then
                end
            end
        else
            if ammo == 1 then
                DisableControlAction(0, 24, true) -- Attack
                DisableControlAction(0, 257, true) -- Attack 2
                if IsPedInAnyVehicle(pedId, true) then
                    SetPlayerCanDoDriveBy(plyId, false)
                end
            else
                EnableControlAction(0, 24, true) -- Attack
                EnableControlAction(0, 257, true) -- Attack 2
                if IsPedInAnyVehicle(pedId, true) then
                    SetPlayerCanDoDriveBy(plyId, true)
                end
            end


            if IsPedShooting(pedId) then
                if ammo - 1 < 1 then
                    SetAmmoInClip(pedId, GetHashKey(QBCore.Shared.Weapons[weapon]["name"]), 1)
                end
            end
        end
        Wait(1)
    end
end)

CreateThread(function()
    while true do
        if IsPedShooting(PlayerPedId()) then
            local weapon = GetSelectedPedWeapon(pedId)
            local ammo = GetAmmoInPedWeapon(pedId, weapon)
            if ammo > 0 then
                TriggerServerEvent("weapons:server:UpdateWeaponAmmo", CurrentWeaponData, tonumber(ammo))
            else
                TriggerEvent('inventory:client:CheckWeapon')
                TriggerServerEvent("weapons:server:UpdateWeaponAmmo", CurrentWeaponData, 0)
            end

            if MultiplierAmount > 0 then
                TriggerServerEvent("weapons:server:UpdateWeaponQuality", CurrentWeaponData, MultiplierAmount)
                MultiplierAmount = 0
            end
        end
        Wait(1)
    end
end)

CreateThread(function()
    while true do
        if MultiplierItemAmount > 0 then
            TriggerServerEvent("weapons:server:UpdateItemQuality", CurrentItemData)
            --TriggerServerEvent("weapons:server:SetItemQuality", CurrentItemData)
            Wait(1000)
            MultiplierItemAmount = 0
        else
            Wait(1000)
        end
    end
    Wait(1)
end)

RegisterNetEvent('weapon:client:AddAmmo')
AddEventHandler('weapon:client:AddAmmo', function(type, amount, itemData)
    local weapon = GetSelectedPedWeapon(pedId)
    if CurrentWeaponData ~= nil then
        if QBCore.Shared.Weapons[weapon]["name"] ~= "weapon_unarmed" and QBCore.Shared.Weapons[weapon]["ammotype"] == type:upper() then
            local total = (GetAmmoInPedWeapon(GetPlayerPed(-1), weapon))
            local retval = GetMaxAmmoInClip(pedId, weapon, 1)
            retval = tonumber(retval)
            local found, maxAmmo = GetMaxAmmo(pedId, weapon)

            if exports["qb-taskbarskill"]:taskBar(math.random(1000,2000),math.random(10,20)) ~= 100 then             
                TriggerEvent("DoShortHudText", "Reload failed!", 2)
                local c = math.random(2)
                local o = math.random(2)
                if c == o then
                    TriggerServerEvent('qb-hud:Server:GainStress', math.random(1, 4))
                end
                return
            end
            
            if total < maxAmmo then
                if QBCore.Shared.Weapons[weapon] ~= nil then
                    AddAmmoToPed(pedId,weapon,retval)
                    TaskReloadWeapon(pedId)
                    TriggerServerEvent("weapons:server:AddWeaponAmmo", CurrentWeaponData, total + retval)
                    TriggerServerEvent('QBCore:Server:RemoveItem', itemData.name, 1, itemData.slot)
                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[itemData.name], "remove")
                    TriggerEvent('QBCore:Notify', retval.." Loading bullets!", "success")
                end
            else
                TriggerEvent("DoLongHudText", "Your weapon is already max loaded..", 2)
            end
        else
            TriggerEvent("DoShortHudText", "Your not holding a weapon..", 2)
        end
    else
        TriggerEvent("DoShortHudText", "Your not holding a weapon..", 2)
    end
end)

--[[RegisterNetEvent('weapon:client:AddAmmo')
AddEventHandler('weapon:client:AddAmmo', function(type, amount, itemData)
    local weapon = GetSelectedPedWeapon(pedId)
    if CurrentWeaponData ~= nil then
        if QBCore.Shared.Weapons[weapon]["name"] ~= "weapon_unarmed" and QBCore.Shared.Weapons[weapon]["ammotype"] == type:upper() then
            local total = (GetAmmoInPedWeapon(pedId, weapon))
            local retval = GetMaxAmmoInClip(pedId, weapon, 1)
            retval = tonumber(retval)

            if exports["qb-taskbarskill"]:taskBar(math.random(1000,2000),math.random(10,20)) ~= 100 then             
                TriggerEvent("DoShortHudText", "Reload failed!", 2)
                local c = math.random(2)
                local o = math.random(2)
                if c == o then
                    TriggerServerEvent('qb-hud:Server:GainStress', math.random(1, 4))
                end
                return
            end
            if (total + retval) <= (retval + 100) then
                if QBCore.Shared.Weapons[weapon] ~= nil then
                    SetAmmoInClip(pedId, weapon, 0)
                    SetPedAmmo(pedId, weapon, retval)
                    TriggerServerEvent("weapons:server:AddWeaponAmmo", CurrentWeaponData, retval)
                    TriggerServerEvent('QBCore:Server:RemoveItem', itemData.name, 1, itemData.slot)
                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[itemData.name], "remove")
                    TriggerEvent('QBCore:Notify', retval.." Loading bullets!", "success")
                end
            else
                TriggerEvent("DoLongHudText", "Your weapon is already loaded..", 2)
            end
        else
            TriggerEvent("DoShortHudText", "Your not holding a weapon..", 2)
        end
    else
        TriggerEvent("DoShortHudText", "Your not holding a weapon..", 2)
    end
end)]]

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    TriggerServerEvent("weapons:server:LoadWeaponAmmo")
    isLoggedIn = true
    PlayerData = QBCore.Functions.GetPlayerData()

    QBCore.Functions.TriggerCallback("weapons:server:GetConfig", function(RepairPoints)
        for k, data in pairs(RepairPoints) do
            Config.WeaponRepairPoints[k].IsRepairing = data.IsRepairing
            Config.WeaponRepairPoints[k].RepairingData = data.RepairingData
        end
    end)
end)

RegisterNetEvent('weapons:client:SetCurrentWeapon')
AddEventHandler('weapons:client:SetCurrentWeapon', function(data, bool)
    if data ~= false then
        CurrentWeaponData = data
    else
        CurrentWeaponData = {}
    end
    CanShoot = bool
end)

RegisterNetEvent('weapons:client:SetCurrentItem')
AddEventHandler('weapons:client:SetCurrentItem', function(data, bool)
    if data ~= false then
        CurrentItemData = data
        MultiplierItemAmount = 1
        Wait(1000)
    else
        CurrentItemData = data
    end
    CanUse = bool
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    isLoggedIn = false

    for k, v in pairs(Config.WeaponRepairPoints) do
        Config.WeaponRepairPoints[k].IsRepairing = false
        Config.WeaponRepairPoints[k].RepairingData = {}
    end
end)

RegisterNetEvent('weapons:client:SetWeaponQuality')
AddEventHandler('weapons:client:SetWeaponQuality', function(amount)
    if CurrentWeaponData ~= nil and next(CurrentWeaponData) ~= nil then
        TriggerServerEvent("weapons:server:SetWeaponQuality", CurrentWeaponData, amount)
    end
end)

RegisterNetEvent('weapons:client:SetItemQuality')
AddEventHandler('weapons:client:SetItemQuality', function(amount)
    if CurrentItemData ~= true then
        MultiplierItemAmount = 1
        TriggerServerEvent("weapons:server:SetItemQuality", CurrentItemData, amount)
    end
end)


--[[CreateThread(function()
    while true do
        if isLoggedIn then
            local inRange = false
            local pos = GetEntityCoords(ped)
            local weapon = GetSelectedPedWeapon(ped)


            for k, data in pairs(Config.WeaponRepairPoints) do
                local distance = GetDistanceBetweenCoords(pos, data.coords.x, data.coords.y, data.coords.z, true)

                if distance < 10 then
                    inRange = true

                    if distance < 1 then
                        if data.IsRepairing then
                            if data.RepairingData.CitizenId ~= PlayerData.citizenid then
                                DrawText3Ds(data.coords.x, data.coords.y, data.coords.z, 'The repairshop is this moment  ~r~NOT~w~ useble..')
                            else
                                if not data.RepairingData.Ready then
                                    DrawText3Ds(data.coords.x, data.coords.y, data.coords.z, 'Ur weapon wil be repaired')
                                else
                                    DrawText3Ds(data.coords.x, data.coords.y, data.coords.z, '[E] to take weapon back')
                                end
                            end
                        else
                            if CurrentWeaponData ~= nil and next(CurrentWeaponData) ~= nil then
                                if not data.RepairingData.Ready then
                                    local WeaponData = QBCore.Shared.Weapons[GetHashKey(CurrentWeaponData.name)]
                                    local WeaponClass = (QBCore.Shared.SplitStr(WeaponData.ammotype, "_")[2]):lower()
                                    DrawText3Ds(data.coords.x, data.coords.y, data.coords.z, '[E] Wapen repareren, ~g~$'..Config.WeaponRepairCotsts[WeaponClass]..'~w~')
                                    if IsControlJustPressed(0, Keys["E"]) then
                                        QBCore.Functions.TriggerCallback('weapons:server:RepairWeapon', function(HasMoney)
                                            if HasMoney then
                                                CurrentWeaponData = {}
                                            end
                                        end, k, CurrentWeaponData)
                                    end
                                else
                                    if data.RepairingData.CitizenId ~= PlayerData.citizenid then
                                        DrawText3Ds(data.coords.x, data.coords.y, data.coords.z, 'The repairshop is this moment ~r~NOT~w~ useble..')
                                    else
                                        DrawText3Ds(data.coords.x, data.coords.y, data.coords.z, '[E] to take weapon back')
                                        if IsControlJustPressed(0, Keys["E"]) then
                                            TriggerServerEvent('weapons:server:TakeBackWeapon', k, data)
                                        end
                                    end
                                end
                            else
                                if data.RepairingData.CitizenId == nil then
                                    DrawText3Ds(data.coords.x, data.coords.y, data.coords.z, 'You dont have a weapon in ur hands..')
                                elseif data.RepairingData.CitizenId == PlayerData.citizenid then
                                    DrawText3Ds(data.coords.x, data.coords.y, data.coords.z, '[E] to take weapon back')
                                    if IsControlJustPressed(0, Keys["E"]) then
                                        TriggerServerEvent('weapons:server:TakeBackWeapon', k, data)
                                    end
                                end
                            end
                        end
                    end
                end
            end

            if not inRange then
                Wait(1000)
            end
        end
        Wait(3)
    end
end)]]

RegisterNetEvent("weapons:client:SyncRepairShops")
AddEventHandler("weapons:client:SyncRepairShops", function(NewData, key)
    Config.WeaponRepairPoints[key].IsRepairing = NewData.IsRepairing
    Config.WeaponRepairPoints[key].RepairingData = NewData.RepairingData
end)

RegisterNetEvent("weapons:client:EquipAttachment")
AddEventHandler("weapons:client:EquipAttachment", function(ItemData, attachment)
    local weapon = GetSelectedPedWeapon(pedId)
    local WeaponData = QBCore.Shared.Weapons[weapon]
    
    if weapon ~= GetHashKey("WEAPON_UNARMED") then
        WeaponData.name = WeaponData.name:upper()
        if Config.WeaponAttachments[WeaponData.name] ~= nil then
            if Config.WeaponAttachments[WeaponData.name][attachment] ~= nil then
                TriggerServerEvent("weapons:server:EquipAttachment", ItemData, CurrentWeaponData, Config.WeaponAttachments[WeaponData.name][attachment])
            else
                TriggerEvent("DoLongHudText", "This weapon does not support this attachment..", 2)
            end
        end
    else
        TriggerEvent("DoLongHudText", "You dont have a weapon in your hand..", 2)
    end
end)

RegisterNetEvent("weapons:client:EquipCamo")
AddEventHandler("weapons:client:EquipCamo", function(ItemData, camo)
    local weapon = GetSelectedPedWeapon(pedId)
    local WeaponData = QBCore.Shared.Weapons[weapon]
    
    if weapon ~= GetHashKey("WEAPON_UNARMED") then
        WeaponData.name = WeaponData.name:upper()
        if Config.WeaponAttachments[WeaponData.name] ~= nil then
            if Config.WeaponAttachments[WeaponData.name][attachment] ~= nil then
                TriggerServerEvent("weapons:server:EquipAttachment", ItemData, CurrentWeaponData, Config.WeaponAttachments[WeaponData.name][attachment])
            else
                TriggerEvent("DoLongHudText", "This weapon does not support this attachment..", 2)
            end
        end
    else
        TriggerEvent("DoLongHudText", "You dont have a weapon in your hand..", 2)
    end
end)

RegisterNetEvent("addAttachment")
AddEventHandler("addAttachment", function(component)
    local weapon = GetSelectedPedWeapon(pedId)
    local WeaponData = QBCore.Shared.Weapons[weapon]
    GiveWeaponComponentToPed(pedId, GetHashKey(WeaponData.name), GetHashKey(component))
end)