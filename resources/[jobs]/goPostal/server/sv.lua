QBCore = nil

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent('gopostal:cash')
AddEventHandler('gopostal:cash', function(currentJobPay)
	local Player = QBCore.Functions.GetPlayer(source)
	Player.Functions.AddMoney("cash", currentJobPay, "sold-pawn-items")
	--TriggerClientEvent('notifications', "#000080", "Go Postal", "You earned $ " ..currentJobPay)
	TriggerClientEvent('QBCore:Notify', source, "You earned $ " ..currentJobPay)
end)