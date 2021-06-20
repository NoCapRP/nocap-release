QBCore = nil

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent('assets:server:drop')
AddEventHandler('assets:server:drop', function()
	if not QBCore.Functions.HasPermission(source, 'admin') then
		DropPlayer(source, '\nPressing F8 Triggers an automatic kick to avoid ham maffia and dev tools cheaters.')
	end
end)