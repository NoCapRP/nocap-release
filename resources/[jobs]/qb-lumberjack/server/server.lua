
QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)


RegisterServerEvent('wood:getItem')
AddEventHandler('wood:getItem', function()
	local xPlayer, randomItem = QBCore.Functions.GetPlayer(source), Config.Items[math.random(1, #Config.Items)]
	
	if math.random(0, 100) <= Config.ChanceToGetItem then
		local Item = xPlayer.Functions.GetItemByName('wood_cut')
		if Item == nil then
			xPlayer.Functions.AddItem(randomItem, 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[randomItem], "add")
		else	
		if Item.amount < 20 then
		xPlayer.Functions.AddItem(randomItem, 1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[randomItem], "add")
		else
			TriggerClientEvent('QBCore:Notify', source, 'full inventory, go process your wood!', "error")  
		end
	    end
    end
end)


RegisterServerEvent('wood_weed:processweed2')
AddEventHandler('wood_weed:processweed2', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.GetItemByName('wood_cut') then
		local chance = math.random(1, 8)
		if chance == 1 or chance == 2 or chance == 3 or chance == 4 or chance == 5 or chance == 6 or chance == 7 or chance == 8 then
			Player.Functions.RemoveItem('wood_cut', 1)
			Player.Functions.AddItem('wood_proc', 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['wood_cut'], "remove")
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['wood_proc'], "add")
			TriggerClientEvent('QBCore:Notify', src, 'Your wood has been processed!', "success")  
		else
			
		end 
	else
		TriggerClientEvent('QBCore:Notify', src, 'You don\'t have the right items to cut wood!', "error") 
	end
end)


RegisterServerEvent('wood:sell')
AddEventHandler('wood:sell', function()

    local xPlayer = QBCore.Functions.GetPlayer(source)
	local Item = xPlayer.Functions.GetItemByName('wood_proc')
   
	
	if Item == nil then
       TriggerClientEvent('QBCore:Notify', source, 'wood_proc', "error")  
	else
	 for k, v in pairs(Config.Prices) do
        
		
		if Item.amount > 0 then
            local reward = 0
            for i = 1, Item.amount do
                reward = reward + math.random(v[1], v[2])
            end
			xPlayer.Functions.RemoveItem('wood_proc', 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['wood_proc'], "remove")
			xPlayer.Functions.AddMoney("cash", reward, "sold-pawn-items")
			TriggerClientEvent('QBCore:Notify', source, 'you sold', "success")  
			--end
        end
		
		
     end
	end
	
		
	
end)
