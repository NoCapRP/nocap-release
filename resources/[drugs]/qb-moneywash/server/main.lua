QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterNetEvent("qb-moneywash:server:checkInv")
AddEventHandler("qb-moneywash:server:checkInv", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

        if Player.Functions.GetItemByName('markedbills') ~= nil then
            local amt = Player.Functions.GetItemByName('markedbills').amount
            TriggerClientEvent('qb-moneywash:client:startTimer', src, amt)
            TriggerClientEvent('QBCore:Notify', src, 'You put the bills in the washer.', 'success')
            Player.Functions.RemoveItem('markedbills', amt)
 
        else
            TriggerClientEvent('QBCore:Notify', src, 'You have no marked bills.', 'error') 
        end

end)

RegisterNetEvent("qb-moneywash:server:giveMoney")
AddEventHandler("qb-moneywash:server:giveMoney", function(amt)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    payment = 10000
    Player.Functions.AddMoney('cash', payment)  
end)
