QBCore = nil

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)


QBCore.Functions.CreateUseableItem("lotto", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("lotto:usar", source)
    end
end)



RegisterServerEvent('lotto:win')
AddEventHandler('lotto:win', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local array = {7500, 6400, 5100, 500, 3000, 6000, 10000, 2000, 1000, 2500, 9000, 6000, 6500, 3000, 2900, 3450, 6910, 8100, 3290, 7000, 1500, 4000, 5000, 4650, 4700}
	local money = array[math.random(25)]
	Player.Functions.AddMoney('cash',Config.Payment)
end)
