QBCore.Commands.Add("recruit", "Recruit Somone", {{name = "ID", help = "Player ID"}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    local job = Player.PlayerData.job.name

    if job == "none" then 
        TriggerClientEvent("QBCore:Notify", source, "You are not Whitelisted for this", "error")
        return 
    end
    if Config["Boss"][job] ~= nil and has_value(Config["Boss"][job], Player.PlayerData.citizenid) then
        local id = tonumber(args[1])
        if id == source then return end

        local OtherPlayer = QBCore.Functions.GetPlayer(id)
        if OtherPlayer ~= nil then
            OtherPlayer.Functions.SetGang(gang)
            TriggerClientEvent("QBCore:Notify", source, string.format("%s has been invited into your gang", GetPlayerName(id)))
            TriggerClientEvent("QBCore:Notify", id, string.format("%s has invited into you to %s", GetPlayerName(source), QBCore.Shared.Jobs[job].label))
        else
            TriggerClientEvent("QBCore:Notify", source, "This player is not online", "error")
        end
    else
        TriggerClientEvent("QBCore:Notify", source, "You are not the leader of this gang", "error")
    end
end)

QBCore.Commands.Add("removegang", "Remove a player from your gang", {{name = "ID", help = "Player ID"}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    local gang = Player.PlayerData.gang.name

    if gang == "none" then 
        TriggerClientEvent("QBCore:Notify", source, "You are not in a gang", "error")
        return 
    end
    if Config["GangLeaders"][gang] ~= nil and has_value(Config["GangLeaders"][gang], Player.PlayerData.citizenid) then
        local id = tonumber(args[1])
        if id == source then return end

        local OtherPlayer = QBCore.Functions.GetPlayer(id)
        if OtherPlayer ~= nil then
            OtherPlayer.Functions.SetGang("none")
            TriggerClientEvent("QBCore:Notify", source, string.format("%s has been removed from your gang", GetPlayerName(id)))
            TriggerClientEvent("QBCore:Notify", id, string.format("%s has removed you from %s", GetPlayerName(source), QBCore.Shared.Gangs[gang].label))
        else
            TriggerClientEvent("QBCore:Notify", source, "This player is not online", "error")
        end
    else
        TriggerClientEvent("QBCore:Notify", source, "You are not the leader of this gang", "error")
    end
end)