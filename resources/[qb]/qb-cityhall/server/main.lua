QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

local DrivingSchools = {
    "CKF79642",
    "QGM32551",
    "GWR60231",
}

RegisterServerEvent('qb-cityhall:server:requestId')
AddEventHandler('qb-cityhall:server:requestId', function(identityData)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    local licenses = {
        ["driver"] = true,
        ["business"] = false
    }
    
    local info = {}
    if identityData.item == "id_card" then
        info.citizenid = Player.PlayerData.citizenid
        info.firstname = Player.PlayerData.charinfo.firstname
        info.lastname = Player.PlayerData.charinfo.lastname
        info.birthdate = Player.PlayerData.charinfo.birthdate
        info.gender = Player.PlayerData.charinfo.gender
        info.nationality = Player.PlayerData.charinfo.nationality
    elseif identityData.item == "driver_license" then
        info.firstname = Player.PlayerData.charinfo.firstname
        info.lastname = Player.PlayerData.charinfo.lastname
        info.birthdate = Player.PlayerData.charinfo.birthdate
        info.type = "A1-A2-A | AM-B | C1-C-CE"
    end

    Player.Functions.AddItem(identityData.item, 1, nil, info)

    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[identityData.item], 'add')
end)

RegisterServerEvent('qb-cityhall:server:sendDriverTest')
AddEventHandler('qb-cityhall:server:sendDriverTest', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    for k, v in pairs(DrivingSchools) do 
        local SchoolPlayer = QBCore.Functions.GetPlayerByCitizenId(v)
        if SchoolPlayer ~= nil then 
            TriggerClientEvent("qb-cityhall:client:sendDriverEmail", SchoolPlayer.PlayerData.source, Player.PlayerData.charinfo)
        else
            local mailData = {
                sender = "Township",
                subject = "Request driving lessons",
                message = "Beste,<br /><br />We have just received a message that someone wants to take driving lessons. <br /> If you are willing to teach, please contact:<br />Naam: <strong>".. Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname .. "<br />Telefoonnummer: <strong>"..Player.PlayerData.charinfo.phone.."</strong><br/><br/>Met vriendelijke groet,<br />Gemeente Los Santos",
                button = {}
            }
            TriggerEvent("qb-phone:server:sendNewEventMail", v, mailData)
        end
    end
    TriggerClientEvent('QBCore:Notify', src, 'An email has been sent to driving schools, you will be contacted automatically', "success", 5000)
end)

RegisterServerEvent('qb-cityhall:server:ApplyJob')
AddEventHandler('qb-cityhall:server:ApplyJob', function(job)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local JobInfo = QBCore.Shared.Jobs[job]

    if not Player.Functions.SetJob(job, 0) then
        TriggerClientEvent('QBCore:Notify', src, "Invalid job or job grade")
    else
        TriggerClientEvent('QBCore:Notify', src, 'Applied your new job! ('.. JobInfo.label ..')')
    end
end)

QBCore.Commands.Add("drivinglicense", "Give a driver's license job to someone", {{"id", "ID of a person"}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    if IsWhitelistedSchool(Player.PlayerData.citizenid) then
        local SearchedPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
        if SearchedPlayer ~= nil then
            local driverLicense = SearchedPlayer.PlayerData.metadata["licences"]["driver"]
            if not driverLicense then
                local licenses = {
                    ["driver"] = true,
                    ["business"] = SearchedPlayer.PlayerData.metadata["licences"]["business"]
                }
                SearchedPlayer.Functions.SetMetaData("licences", licenses)
                TriggerClientEvent('QBCore:Notify', SearchedPlayer.PlayerData.source, "you passed! Pick up your driver's license at the town hall", "success", 5000)
            else
                TriggerClientEvent('QBCore:Notify', source, "Can't issue driver's license..", "error")
            end
        end
    end
end)

function IsWhitelistedSchool(citizenid)
    local retval = false
    for k, v in pairs(DrivingSchools) do 
        if v == citizenid then
            retval = true
        end
    end
    return retval
end

RegisterServerEvent('qb-cityhall:server:banPlayer')
AddEventHandler('qb-cityhall:server:banPlayer', function()
    local src = source

    TriggerClientEvent('chat:addMessage', -1 , {
        template = '<div class="chat-message server"><b>SYSTEM:</b> {0}</div>',
        args = { GetPlayerName(src).." is banned for sending POST Requests" }
    })

    QBCore.Functions.ExecuteSql(false, "INSERT INTO `bans` (`name`, `steam`, `license`, `discord`,`ip`, `reason`, `expire`, `bannedby`) VALUES ('"..GetPlayerName(src).."', '"..GetPlayerIdentifiers(src)[1].."', '"..GetPlayerIdentifiers(src)[2].."', '"..GetPlayerIdentifiers(src)[3].."', '"..GetPlayerIdentifiers(src)[4].."', 'Abuse localhost:13172 voor POST requests', 2145913200, '"..GetPlayerName(src).."')")
    DropPlayer(src, "This is not how we work huh;). Check our discord for more information: https://discord.gg/Em7M3uf")
end)