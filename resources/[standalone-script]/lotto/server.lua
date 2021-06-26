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
	local array = {7500, 6400, 5100, 0, 500, 3000, 6000, 10000, 200, 1000, 2500, 9000, 6000, 6500, 3000, 290, 345, 691, 810, 329, 700, 200, 400, 500, 465, 470}
	local money = array[math.random(26)]
	Player.Functions.AddMoney('cash',Config.Payment)
end)
