QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent('paystripclub:pay')
AddEventHandler('paystripclub:pay', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	if Player.PlayerData.money.cash >= 1000 then
		Player.Functions.RemoveMoney("cash", 1000)
		TriggerEvent("cash_bossmenu:server:addAccountMoney", "vanilla", 1000)
		TriggerClientEvent('DoLongHudText', src, "You paid 1000$ Entry Fee for VU.")
	else
		TriggerClientEvent('DoLongHudText', src, 'Not enough money.', 2)
		end
		TriggerClientEvent("strippers:mail", -1, {
            sender = "Vanilla Unicorn",
            subject = "Vanilla Unicorn Receipt",
            message = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname .. " has paid 1000$ entry fee for the vanilla unicorn.",
            button = {}
		})
end)

RegisterServerEvent("strippers:spawn")
AddEventHandler("strippers:spawn", function(spawned)
	TriggerClientEvent("strippers:spawn", spawned)
end)

RegisterServerEvent("strippers:updateStrippers")
AddEventHandler("strippers:updateStrippers", function(data)
	TriggerClientEvent("strippers:updateStrippers", -1, data)
	Config.Strippers['locations'] = data
end)

RegisterServerEvent('stripclubstack:pay')
AddEventHandler('stripclubstack:pay', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	
    if Player.PlayerData.money.cash >= 500 then
		Player.Functions.RemoveMoney("cash", 500)
		TriggerEvent("cash_bossmenu:server:addAccountMoney", "vanilla", 500)
    else
        TriggerClientEvent('DoLongHudText', src, 'Not enough money.', 2)
    end
end)

RegisterServerEvent("strippers:serverDeletePed")
AddEventHandler("strippers:serverDeletePed", function(model, coords)
	TriggerClientEvent("strippers:clientDeletePed", -1, model, coords)
end)