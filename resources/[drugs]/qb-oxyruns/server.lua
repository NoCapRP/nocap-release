QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

-- Oxy Run
RegisterServerEvent('oxydelivery:server')
AddEventHandler('oxydelivery:server', function()
	local Player = QBCore.Functions.GetPlayer(source)
    local bank = Player.PlayerData.money["bank"]
    local cash = Player.PlayerData.money["cash"]

	if cash >= Config.StartOxyPayment then
		Player.Functions.RemoveMoney('cash', Config.StartOxyPayment)
		TriggerClientEvent('QBCore:Notify', source, 'Mission started, go to your stolen vehicle and Hotwire it!')
		TriggerClientEvent("oxydelivery:startDealing", source)
	elseif bank >= Config.StartOxyPayment then
		Player.Functions.RemoveMoney('bank', Config.StartOxyPayment)
		TriggerClientEvent('QBCore:Notify', source, 'Mission started, go to your stolen vehicle and Hotwire it!')
		TriggerClientEvent("oxydelivery:startDealing", source)
	else
		TriggerClientEvent('QBCore:Notify', source, 'You Dont Have Enough Money To Start OXY Mission!')
	end
end)

RegisterServerEvent('oxydelivery:receiveBigRewarditem')
AddEventHandler('oxydelivery:receiveBigRewarditem', function()
	local Player = QBCore.Functions.GetPlayer(source)

	Player.Functions.AddItem(Config.BigRewarditem, 1)
	TriggerClientEvent('QBCore:Notify', source, 'You have received an access card!')
end)

RegisterServerEvent('oxydelivery:receiveoxy')
AddEventHandler('oxydelivery:receiveoxy', function()
	local Player = QBCore.Functions.GetPlayer(source)

	Player.Functions.AddMoney('cash', Config.Payment / 2)
	Player.Functions.AddItem(Config.Item, Config.OxyAmount)
	
	TriggerClientEvent('QBCore:Notify', source, 'You received oxy and money!')
end)

RegisterServerEvent('oxydelivery:receivemoneyyy')
AddEventHandler('oxydelivery:receivemoneyyy', function()
	local Player = QBCore.Functions.GetPlayer(source)

	Player.Functions.AddMoney('cash', Config.Payment)
	TriggerClientEvent('QBCore:Notify', source, 'You received money!')

end)