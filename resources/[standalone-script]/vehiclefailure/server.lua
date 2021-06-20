QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

QBCore.Commands.Add("fix", "Repair a vehicle", {}, false, function(source, args)
    TriggerClientEvent('iens:repaira', source)
    TriggerClientEvent('vehiclemod:client:fixEverything', source)
end, "admin")

QBCore.Functions.CreateUseableItem("repairkit", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent("vehiclefailure:client:RepairVehicle", source)
    end
end)

QBCore.Functions.CreateUseableItem("cleaningkit", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent("vehiclefailure:client:CleanVehicle", source)
    end
end)

QBCore.Functions.CreateUseableItem("advancedrepairkit", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent("vehiclefailure:client:RepairVehicleFull", source)
    end
end)

RegisterServerEvent('qb-vehiclefailure:removeItem')
AddEventHandler('qb-vehiclefailure:removeItem', function(item)
    local src = source
    local ply = QBCore.Functions.GetPlayer(src)
    ply.Functions.RemoveItem(item, 1)
end)

RegisterServerEvent('vehiclefailure:server:removewashingkit')
AddEventHandler('vehiclefailure:server:removewashingkit', function(veh)
    local src = source
    local ply = QBCore.Functions.GetPlayer(src)
    ply.Functions.RemoveItem("cleaningkit", 1)
    TriggerClientEvent('vehiclefailure:client:SyncWash', -1, veh)
end)

RegisterCommand('repair', function(source, args, raw)
    local Mechanic = 0
    local xPlayer = QBCore.Functions.GetPlayer(source)
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if (Player.PlayerData.job.name == "mechanic" and Player.PlayerData.job.onduty ) then
                Mechanic = Mechanic + 1
            end
        end
    end
    if Mechanic >= 1 then
        if xPlayer.PlayerData.job.name == "mechanic" then
             TriggerClientEvent('iens:repair',source)
        else
            TriggerClientEvent('QBCore:Notify', source, 'There is an mechanic On-Duty RN U Cant Use This Command', "success")
        end
    else
        TriggerClientEvent('iens:repair',source)
    end
end)
RegisterNetEvent('cash:repair')
AddEventHandler('cash:repair',function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local price = 100
	Player.Functions.RemoveMoney("cash", price, "sold-pawn-items")
end)