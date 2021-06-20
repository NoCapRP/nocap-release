QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

QBCore.Commands.Add("setlawyer", "Set a player as lawyer", {{name="id", help="Id of the player"}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    local playerId = tonumber(args[1])
    local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
    if Player.PlayerData.job.name == "judge" then
        if OtherPlayer ~= nil then 
            local lawyerInfo = {
                id = math.random(100000, 999999),
                firstname = OtherPlayer.PlayerData.charinfo.firstname,
                lastname = OtherPlayer.PlayerData.charinfo.lastname,
                citizenid = OtherPlayer.PlayerData.citizenid,
            }
            OtherPlayer.Functions.SetJob("lawyer")
            OtherPlayer.Functions.AddItem("lawyerpass", 1, false, lawyerInfo)
            OtherPlayer.Functions.RemoveItem("lawyerpass", 0, false, lawyerInfo)
            TriggerClientEvent("QBCore:Notify", source, "" .. OtherPlayer.PlayerData.charinfo.firstname .. " " .. OtherPlayer.PlayerData.charinfo.lastname .. " hired as a lawyer")
            TriggerClientEvent("QBCore:Notify", OtherPlayer.PlayerData.source, "You are now a lawyer")
            TriggerClientEvent('inventory:client:ItemBox', OtherPlayer.PlayerData.source, QBCore.Shared.Items["lawyerpass"], "add")
        else
            TriggerClientEvent("QBCore:Notify", source, "Person is not present..", "error")
        end
    else
        TriggerClientEvent("QBCore:Notify", source, "You are not a judge..", "error")
    end
end)

QBCore.Commands.Add("removelawyer", "Remove a lawyer", {{name="id", help="Id of the player"}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    local playerId = tonumber(args[1])
    local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
    if Player.PlayerData.job.name == "judge" then
        if OtherPlayer ~= nil then 
            --OtherPlayer.Functions.SetJob("unemployed")
            TriggerClientEvent("QBCore:Notify", OtherPlayer.PlayerData.source, "You are now unemployed")
            TriggerClientEvent("QBCore:Notify", source, "" .. OtherPlayer.PlayerData.charinfo.firstname .. " " .. OtherPlayer.PlayerData.charinfo.lastname .. " dismiss as a lawyer")
            TriggerClientEvent('inventory:client:ItemBox', OtherPlayer.PlayerData.source, QBCore.Shared.Items["lawyerpass"], "remove")
        else
            TriggerClientEvent("QBCore:Notify", source, "Person is not present..", "error")
        end
    else
        TriggerClientEvent("QBCore:Notify", source, "You are not a judge..", "error")
    end
end)

QBCore.Functions.CreateUseableItem("lawyerpass", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent("qb-justice:client:showLawyerLicense", -1, source, item.info)
    end
end)