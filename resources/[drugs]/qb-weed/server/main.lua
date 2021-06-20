QBCore = nil

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

local playersProcessingCannabis = {}

RegisterServerEvent('qb-weed:pickedUpCannabis')
AddEventHandler('qb-weed:pickedUpCannabis', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	  if 	TriggerClientEvent("QBCore:Notify", src, "Picked up some Cannabis!!", "Success", 8000) then
		  Player.Functions.AddItem('cannabis', 1) ---- change this shit 
		  TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['cannabis'], "add")
	  end
  end)


RegisterServerEvent('qb-weed:processCannabisxpfw')
AddEventHandler('qb-weed:processCannabisxpfw', function()
		local src = source
		local Player = QBCore.Functions.GetPlayer(src)
		Player.Functions.AddItem('joint', 1)-----change this
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['joint'], "add")
		TriggerClientEvent('QBCore:Notify', src, 'Joint Processed successfully', "success")                                                                         				
end)

RegisterServerEvent('qb-weed:processCannabisxpfw')
AddEventHandler('qb-weed:processCannabisxpfw', function()
		local src = source
		local Player = QBCore.Functions.GetPlayer(src)
		
		Player.Functions.RemoveItem('marijuana_20oz', 1)----change this
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['marijuana'], "remove")                                                                         				
end)


RegisterServerEvent('qb-weed:processCannabisxpfwxpfw')
AddEventHandler('qb-weed:processCannabisxpfwxpfw', function()
		local src = source
    	local Player = QBCore.Functions.GetPlayer(src)
		Player.Functions.AddItem('marijuana', 1)-----change this
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['marijuana'], "add")
		TriggerClientEvent('QBCore:Notify', src, 'Marijuana Processed successfully', "success")                                                                         				
end)

RegisterServerEvent('qb-weed:processCannabisxpfw')
AddEventHandler('qb-weed:processCannabisxpfw', function()
		local src = source
    	local Player = QBCore.Functions.GetPlayer(src)
		Player.Functions.RemoveItem('cannabis', 1)----change this
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['cannabis'], "remove")                                                                    				
end)


function CancelProcessing(playerId)
	if playersProcessingCannabis[playerId] then
		ClearTimeout(playersProcessingCannabis[playerId])
		playersProcessingCannabis[playerId] = nil
	end
end

RegisterServerEvent('qb-weed:cancelProcessing')
AddEventHandler('qb-weed:cancelProcessing', function()
	CancelProcessing(source)
end)

AddEventHandler('QBCore:playerDropped', function(playerId, reason)
	CancelProcessing(playerId)
end)

RegisterServerEvent('qb-weed:onPlayerDeath')
AddEventHandler('qb-weed:onPlayerDeath', function(data)
	local src = source
	CancelProcessing(src)
end)

QBCore.Functions.CreateCallback('weed:process', function(source, cb)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	 
	if Player.PlayerData.item ~= nil and next(Player.PlayerData.items) ~= nil then
		for k, v in pairs(Player.PlayerData.items) do
		    if Player.Playerdata.items[k] ~= nil then
				if Player.Playerdata.items[k].name == "cannabis" then
					cb(true)
			    else
					TriggerClientEvent("QBCore:Notify", src, "You do not have any Cannabis", "error", 10000)
					cb(false)
				end
	        end
		end	
	end
end)

QBCore.Functions.CreateCallback('weed:processxD', function(source, cb)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	 
	if Player.PlayerData.item ~= nil and next(Player.PlayerData.items) ~= nil then
		for k, v in pairs(Player.PlayerData.items) do
		    if Player.Playerdata.items[k] ~= nil then
				if Player.Playerdata.items[k].name == "marijuana" then
					cb(true)
			    else
					TriggerClientEvent("QBCore:Notify", src, "You do not have any marijuana", "error", 10000)
					cb(false)
				end
	        end
		end	
	end
end)
