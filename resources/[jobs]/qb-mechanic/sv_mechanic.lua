QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent("qb-mechanic:attemptPurchase")
AddEventHandler("qb-mechanic:attemptPurchase", function(cheap, type, upgradeLevel)
    local src = source
    local price = 0

    if vehicleCustomisationPrices[type] and vehicleCustomisationPrices[type].prices and upgradeLevel then
        price = vehicleCustomisationPrices[type].prices[upgradeLevel]
    elseif vehicleCustomisationPrices[type] and vehicleCustomisationPrices[type].price then 
        price = vehicleCustomisationPrices[type].price
    end

    if exports['cash_bossmenu']:GetAccount("mechanic") >= price then
        TriggerEvent("cash_bossmenu:server:removeAccountMoney", "mechanic", price)
        TriggerClientEvent("qb-mechanic:purchaseSuccessful", src)
    else
        TriggerClientEvent("qb-mechanic:purchaseFailed", src)
    end
end)

RegisterServerEvent("qb-mechanic:updateVehicle")
AddEventHandler("qb-mechanic:updateVehicle", function(plate, vehicleMods)
    QBCore.Functions.ExecuteSql(false, "UPDATE `player_vehicles` SET `mods` = '" .. json.encode(vehicleMods) .. "' WHERE `plate` = '" .. plate .. "'")
end)

function IsAuthorized(CitizenId)
    local retval = false
    for _, cid in pairs(Config.AuthorizedIds) do
        if cid == CitizenId then
            retval = true
            break
        end
    end
    return retval
end