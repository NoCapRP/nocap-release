QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

local Plates = {}
cuffedPlayers = {}
PlayerStatus = {}
Casings = {}
BloodDrops = {}
FingerDrops = {}
local Objects = {}


Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1000 * 60 * 10)
        local curCops = GetCurrentCops()
        TriggerClientEvent("police:SetCopCount", -1, curCops)
    end
end)

RegisterServerEvent('police:server:CheckBills')
AddEventHandler('police:server:CheckBills', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    QBCore.Functions.ExecuteSql(false, "SELECT * FROM `bills` WHERE `citizenid` = '"..Player.PlayerData.citizenid.."' AND `type` = 'police'", function(result)
        if result[1] ~= nil then
            local totalAmount = 0
			for k, v in pairs(result) do
				totalAmount = totalAmount + tonumber(v.amount)
            end
            Player.Functions.RemoveMoney("bank", totalAmount, "paid-all-bills")
            QBCore.Functions.ExecuteSql(false, "DELETE FROM `bills` WHERE `citizenid` = '"..Player.PlayerData.citizenid.."' AND `type` = 'police'")
            TriggerClientEvent('police:client:sendBillingMail', src, totalAmount)
            TriggerEvent('qb-moneysafe:server:DepositMoney', "police", totalAmount, "bills")
		end
	end)
end)

RegisterServerEvent('police:server:CuffPlayer')
AddEventHandler('police:server:CuffPlayer', function(playerId, isSoftcuff)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    local CuffedPlayer = QBCore.Functions.GetPlayer(playerId)
    if CuffedPlayer ~= nil then
        if Player.Functions.GetItemByName("handcuffs") ~= nil or Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "police1" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police4" or Player.PlayerData.job.name == "police5" or Player.PlayerData.job.name == "police6" or Player.PlayerData.job.name == "police7" or Player.PlayerData.job.name == "police8" then
            TriggerClientEvent("police:client:GetCuffed", CuffedPlayer.PlayerData.source, Player.PlayerData.source, isSoftcuff)           
        end
    end
end)

RegisterServerEvent('police:server:EscortPlayer')
AddEventHandler('police:server:EscortPlayer', function(playerId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    local EscortPlayer = QBCore.Functions.GetPlayer(playerId)
    if EscortPlayer ~= nil then
        if (Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "police1" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police4" or Player.PlayerData.job.name == "police5" or Player.PlayerData.job.name == "police6" or Player.PlayerData.job.name == "police7" or Player.PlayerData.job.name == "police8" or Player.PlayerData.job.name == "ambulance" or Player.PlayerData.job.name == "doctor") or (EscortPlayer.PlayerData.metadata["ishandcuffed"] or EscortPlayer.PlayerData.metadata["isdead"] or EscortPlayer.PlayerData.metadata["inlaststand"]) then
            TriggerClientEvent("police:client:GetEscorted", EscortPlayer.PlayerData.source, Player.PlayerData.source)
        else
            TriggerClientEvent('chatMessage', src, "SYSTEM", "error", "Person is not dead or handcuffed!")
        end
    end
end)

RegisterServerEvent('police:server:KidnapPlayer')
AddEventHandler('police:server:KidnapPlayer', function(playerId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    local EscortPlayer = QBCore.Functions.GetPlayer(playerId)
    if EscortPlayer ~= nil then
        if EscortPlayer.PlayerData.metadata["ishandcuffed"] or EscortPlayer.PlayerData.metadata["isdead"] or EscortPlayer.PlayerData.metadata["inlaststand"] then
            TriggerClientEvent("police:client:GetKidnappedTarget", EscortPlayer.PlayerData.source, Player.PlayerData.source)
            TriggerClientEvent("police:client:GetKidnappedDragger", Player.PlayerData.source, EscortPlayer.PlayerData.source)
        else
            TriggerClientEvent('chatMessage', src, "SYSTEM", "error", "Person is not dead or handcuffed!")
        end
    end
end)

RegisterServerEvent('police:server:SetPlayerOutVehicle')
AddEventHandler('police:server:SetPlayerOutVehicle', function(playerId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    local EscortPlayer = QBCore.Functions.GetPlayer(playerId)
    if EscortPlayer ~= nil then
        if EscortPlayer.PlayerData.metadata["ishandcuffed"] or EscortPlayer.PlayerData.metadata["isdead"] then
            TriggerClientEvent("police:client:SetOutVehicle", EscortPlayer.PlayerData.source)
        else
            TriggerClientEvent('chatMessage', src, "SYSTEM", "error", "Person is not dead or handcuffed!")
        end
    end
end)

RegisterServerEvent('police:server:PutPlayerInVehicle')
AddEventHandler('police:server:PutPlayerInVehicle', function(playerId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    local EscortPlayer = QBCore.Functions.GetPlayer(playerId)
    if EscortPlayer ~= nil then
        if EscortPlayer.PlayerData.metadata["ishandcuffed"] or EscortPlayer.PlayerData.metadata["isdead"] then
            TriggerClientEvent("police:client:PutInVehicle", EscortPlayer.PlayerData.source)
        else
            TriggerClientEvent('chatMessage', src, "SYSTEM", "error", "Person is not dead or handcuffed!")
        end
    end
end)

RegisterServerEvent('police:server:BillPlayer')
AddEventHandler('police:server:BillPlayer', function(playerId, price)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
    if Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "police1" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police4" or Player.PlayerData.job.name == "police5" or Player.PlayerData.job.name == "police6" or Player.PlayerData.job.name == "police7" or Player.PlayerData.job.name == "police8" then
        if OtherPlayer ~= nil then
            OtherPlayer.Functions.RemoveMoney("bank", price, "paid-bills")
            TriggerClientEvent('QBCore:Notify', OtherPlayer.PlayerData.source, "You received a fine from $"..price)
        end
    end
end)

RegisterServerEvent('police:server:JailPlayer')
AddEventHandler('police:server:JailPlayer', function(playerId, time)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
    local currentDate = os.date("*t")
    if currentDate.day == 31 then currentDate.day = 30 end

    if Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "police1" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police3" or Player.PlayerData.job.name == "police4" or Player.PlayerData.job.name == "police5" or Player.PlayerData.job.name == "police6" or Player.PlayerData.job.name == "police7" or Player.PlayerData.job.name == "police8" then
        if OtherPlayer ~= nil then
            OtherPlayer.Functions.SetMetaData("injail", time)
            OtherPlayer.Functions.SetMetaData("criminalrecord", {
                ["hasRecord"] = true,
                ["date"] = currentDate
            })
            TriggerClientEvent("police:client:SendToJail", OtherPlayer.PlayerData.source, time)
            TriggerClientEvent('QBCore:Notify', src, "You sent the person to prison for "..time.." months")
        end
    end
end)

QBCore.Commands.Add("liveryp", "Livery", {{name="livery", help="Number of the livery"}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)

    if Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "police1" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police4" or Player.PlayerData.job.name == "police5" or Player.PlayerData.job.name == "police6" or Player.PlayerData.job.name == "police7" or Player.PlayerData.job.name == "police8" then
        TriggerClientEvent('lscustoms:SetLivery', source, tonumber(args[1]))
    else
        TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "This command is for emergency services!")
    end
end)

RegisterServerEvent('police:server:SetHandcuffStatus')
AddEventHandler('police:server:SetHandcuffStatus', function(isHandcuffed)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Player ~= nil then
		Player.Functions.SetMetaData("ishandcuffed", isHandcuffed)
	end
end)

RegisterServerEvent('heli:spotlight')
AddEventHandler('heli:spotlight', function(state)
	local serverID = source
	TriggerClientEvent('heli:spotlight', -1, serverID, state)
end)

RegisterServerEvent('police:server:FlaggedPlateTriggered')
AddEventHandler('police:server:FlaggedPlateTriggered', function(camId, plate, street1, street2, blipSettings)
    local src = source
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if (Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "police1" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police4" or Player.PlayerData.job.name == "police5" or Player.PlayerData.job.name == "police6" or Player.PlayerData.job.name == "police7" or Player.PlayerData.job.name == "police8" and Player.PlayerData.job.onduty) then
                if street2 ~= nil then
                    TriggerClientEvent("112:client:SendPoliceAlert", v, "flagged", {
                        camId = camId,
                        plate = plate,
                        streetLabel = street1.. " "..street2,
                    }, blipSettings)
                else
                    TriggerClientEvent("112:client:SendPoliceAlert", v, "flagged", {
                        camId = camId,
                        plate = plate,
                        streetLabel = street1
                    }, blipSettings)
                end
            end
        end
	end
end)

RegisterServerEvent('police:server:PoliceAlertMessage')
AddEventHandler('police:server:PoliceAlertMessage', function(title, streetLabel, coords)
    local src = source

    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then 
            if (Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "police1" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police4" or Player.PlayerData.job.name == "police5" or Player.PlayerData.job.name == "police6" or Player.PlayerData.job.name == "police7" or Player.PlayerData.job.name == "police8" and Player.PlayerData.job.onduty) then
                TriggerClientEvent("police:client:PoliceAlertMessage", v, title, streetLabel, coords)
            elseif Player.Functions.GetItemByName("radioscanner") ~= nil and math.random(1, 100) <= 50 then
                TriggerClientEvent("police:client:PoliceAlertMessage", v, title, streetLabel, coords)
            end
        end
    end
end)

RegisterServerEvent('police:server:GunshotAlert')
AddEventHandler('police:server:GunshotAlert', function(streetLabel, isAutomatic, fromVehicle, coords, vehicleInfo)
    local src = source

    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then 
            if (Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "police1" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police4" or Player.PlayerData.job.name == "police5" or Player.PlayerData.job.name == "police6" or Player.PlayerData.job.name == "police7" or Player.PlayerData.job.name == "police8" and Player.PlayerData.job.onduty) then
                TriggerClientEvent("police:client:GunShotAlert", Player.PlayerData.source, streetLabel, isAutomatic, fromVehicle, coords, vehicleInfo)
            elseif Player.Functions.GetItemByName("radioscanner") ~= nil and math.random(1, 100) <= 50 then
                TriggerClientEvent("police:client:GunShotAlert", Player.PlayerData.source, streetLabel, isAutomatic, fromVehicle, coords, vehicleInfo)
            end
        end
    end
end)

RegisterServerEvent('police:server:VehicleCall')
AddEventHandler('police:server:VehicleCall', function(pos, msg, alertTitle, streetLabel, modelPlate, modelName)
    local src = source
    local alertData = {
        title = "Vehiclediefstal",
        coords = {x = pos.x, y = pos.y, z = pos.z},
        description = msg,
    }
    print(streetLabel)
    TriggerClientEvent("police:client:VehicleCall", -1, pos, alertTitle, streetLabel, modelPlate, modelName)
    TriggerClientEvent("qb-phone:client:addPoliceAlert", -1, alertData)
end)

RegisterServerEvent('police:server:HouseRobberyCall')
AddEventHandler('police:server:HouseRobberyCall', function(coords, message, gender, streetLabel)
    local src = source
    local alertData = {
        title = "Huisinbraak",
        coords = {x = coords.x, y = coords.y, z = coords.z},
        description = message,
    }
    TriggerClientEvent("police:client:HouseRobberyCall", -1, coords, message, gender, streetLabel)
    TriggerClientEvent("qb-phone:client:addPoliceAlert", -1, alertData)
end)

RegisterServerEvent('police:server:SendEmergencyMessage')
AddEventHandler('police:server:SendEmergencyMessage', function(coords, message)
    local src = source
    local MainPlayer = QBCore.Functions.GetPlayer(src)
    local alertData = {
        title = "112 Melding - "..MainPlayer.PlayerData.charinfo.firstname .. " " .. MainPlayer.PlayerData.charinfo.lastname .. " ("..src..")",
        coords = {x = coords.x, y = coords.y, z = coords.z},
        description = message,
    }
    TriggerClientEvent("qb-phone:client:addPoliceAlert", -1, alertData)
    TriggerClientEvent('police:server:SendEmergencyMessageCheck', -1, MainPlayer, message, coords)
end)

RegisterServerEvent('police:server:SearchPlayer')
AddEventHandler('police:server:SearchPlayer', function(playerId)
    local src = source
    local SearchedPlayer = QBCore.Functions.GetPlayer(playerId)
    if SearchedPlayer ~= nil then 
        TriggerClientEvent('chatMessage', source, "SYSTEM", "warning", "Person has $"..SearchedPlayer.PlayerData.money["cash"]..",- op zak..")
        TriggerClientEvent('QBCore:Notify', SearchedPlayer.PlayerData.source, "You are being searched..")
    end
end)

RegisterServerEvent('police:server:SeizeCash')
AddEventHandler('police:server:SeizeCash', function(playerId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local SearchedPlayer = QBCore.Functions.GetPlayer(playerId)
    if SearchedPlayer ~= nil then 
        local moneyAmount = SearchedPlayer.PlayerData.money["cash"]
        local info = {
            cash = moneyAmount,
        }
        SearchedPlayer.Functions.RemoveMoney("cash", moneyAmount, "police-cash-seized")
        Player.Functions.AddItem("moneybag", 1, false, info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["moneybag"], "add")
        TriggerClientEvent('QBCore:Notify', SearchedPlayer.PlayerData.source, "Your cash confiscated..")
    end
end)

RegisterServerEvent('police:server:SeizeqbverLicense')
AddEventHandler('police:server:SeizeqbverLicense', function(playerId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local SearchedPlayer = QBCore.Functions.GetPlayer(playerId)
    if SearchedPlayer ~= nil then
        local qbverLicense = SearchedPlayer.PlayerData.metadata["licences"]["qbver"]
        if qbverLicense then
            local licenses = {
                ["qbver"] = false,
                ["business"] = SearchedPlayer.PlayerData.metadata["licences"]["business"]
            }
            SearchedPlayer.Functions.SetMetaData("licences", licenses)
            TriggerClientEvent('QBCore:Notify', SearchedPlayer.PlayerData.source, "Your qbving license confiscated..")
        else
            TriggerClientEvent('QBCore:Notify', src, "Can't take qbving license..", "error")
        end
    end
end)

RegisterServerEvent('police:server:RobPlayer')
AddEventHandler('police:server:RobPlayer', function(playerId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local SearchedPlayer = QBCore.Functions.GetPlayer(playerId)
    if SearchedPlayer ~= nil then 
        local money = SearchedPlayer.PlayerData.money["cash"]
        Player.Functions.AddMoney("cash", money, "police-player-robbed")
        SearchedPlayer.Functions.RemoveMoney("cash", money, "police-player-robbed")
        TriggerClientEvent('QBCore:Notify', SearchedPlayer.PlayerData.source, "You're like $"..money.." robbed")
    end
end)

RegisterServerEvent('police:server:UpdateBlips')
AddEventHandler('police:server:UpdateBlips', function()
    local src = source
    local dutyPlayers = {}
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then 
            if ((Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "police1" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police4" or Player.PlayerData.job.name == "police5" or Player.PlayerData.job.name == "police6" or Player.PlayerData.job.name == "police7" or Player.PlayerData.job.name == "police8" or Player.PlayerData.job.name == "ambulance" or Player.PlayerData.job.name == "doctor") and Player.PlayerData.job.onduty) then
                table.insert(dutyPlayers, {
                    source = Player.PlayerData.source,
                    label = Player.PlayerData.metadata["callsign"],
                    job = Player.PlayerData.job.name,
                })
            end
        end
    end
    TriggerClientEvent("police:client:UpdateBlips", -1, dutyPlayers)
end)

RegisterServerEvent('police:server:spawnObject')
AddEventHandler('police:server:spawnObject', function(type)
    local src = source
    local objectId = CreateObjectId()
    Objects[objectId] = type
    TriggerClientEvent("police:client:spawnObject", -1, objectId, type, src)
end)

RegisterServerEvent('police:server:deleteObject')
AddEventHandler('police:server:deleteObject', function(objectId)
    local src = source
    TriggerClientEvent('police:client:removeObject', -1, objectId)
end)

RegisterServerEvent('police:server:Impound')
AddEventHandler('police:server:Impound', function(plate, fullImpound, price)
    local src = source
    local price = price ~= nil and price or 0
    if IsVehicleOwned(plate) then
        if not fullImpound then
            exports['ghmattimysql']:execute('UPDATE player_vehicles SET state = @state, depotprice = @depotprice WHERE plate = @plate', {['@state'] = 0, ['@depotprice'] = price, ['@plate'] = plate})
            TriggerClientEvent('QBCore:Notify', src, "Vehicle entered in depot before $"..price.."!")
        else
            exports['ghmattimysql']:execute('UPDATE player_vehicles SET state = @state WHERE plate = @plate', {['@state'] = 2, ['@plate'] = plate})
            TriggerClientEvent('QBCore:Notify', src, "Vehicle completely seized!")
        end
    end
end)

RegisterServerEvent('evidence:server:UpdateStatus')
AddEventHandler('evidence:server:UpdateStatus', function(data)
    local src = source
    PlayerStatus[src] = data
end)

RegisterServerEvent('evidence:server:CreateBloodDrop')
AddEventHandler('evidence:server:CreateBloodDrop', function(citizenid, bloodtype, coords)
    local src = source
    local bloodId = CreateBloodId()
    BloodDrops[bloodId] = {dna = citizenid, bloodtype = bloodtype}
    TriggerClientEvent("evidence:client:AddBlooddrop", -1, bloodId, citizenid, bloodtype, coords)
end)

RegisterServerEvent('evidence:server:CreateFingerDrop')
AddEventHandler('evidence:server:CreateFingerDrop', function(coords)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local fingerId = CreateFingerId()
    FingerDrops[fingerId] = Player.PlayerData.metadata["fingerprint"]
    TriggerClientEvent("evidence:client:AddFingerPrint", -1, fingerId, Player.PlayerData.metadata["fingerprint"], coords)
end)

RegisterServerEvent('evidence:server:ClearBlooddrops')
AddEventHandler('evidence:server:ClearBlooddrops', function(blooddropList)
    if blooddropList ~= nil and next(blooddropList) ~= nil then 
        for k, v in pairs(blooddropList) do
            TriggerClientEvent("evidence:client:RemoveBlooddrop", -1, v)
            BloodDrops[v] = nil
        end
    end
end)

RegisterServerEvent('evidence:server:AddBlooddropToInventory')
AddEventHandler('evidence:server:AddBlooddropToInventory', function(bloodId, bloodInfo)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveItem("empty_evidence_bag", 1) then
        if Player.Functions.AddItem("filled_evidence_bag", 1, false, bloodInfo) then
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["filled_evidence_bag"], "add")
            TriggerClientEvent("evidence:client:RemoveBlooddrop", -1, bloodId)
            BloodDrops[bloodId] = nil
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You must have an empty evidence bag with you", "error")
    end
end)

RegisterServerEvent('evidence:server:AddFingerprintToInventory')
AddEventHandler('evidence:server:AddFingerprintToInventory', function(fingerId, fingerInfo)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveItem("empty_evidence_bag", 1) then
        if Player.Functions.AddItem("filled_evidence_bag", 1, false, fingerInfo) then
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["filled_evidence_bag"], "add")
            TriggerClientEvent("evidence:client:RemoveFingerprint", -1, fingerId)
            FingerDrops[fingerId] = nil
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You must have an empty evidence bag with you", "error")
    end
end)

RegisterServerEvent('evidence:server:CreateCasing')
AddEventHandler('evidence:server:CreateCasing', function(weapon, coords)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local casingId = CreateCasingId()
    local weaponInfo = QBCore.Shared.Weapons[weapon]
    local serieNumber = nil
    if weaponInfo ~= nil then 
        local weaponItem = Player.Functions.GetItemByName(weaponInfo["name"])
        if weaponItem ~= nil then
            if weaponItem.info ~= nil and  weaponItem.info ~= "" then 
                serieNumber = weaponItem.info.serie
            end
        end
    end
    TriggerClientEvent("evidence:client:AddCasing", -1, casingId, weapon, coords, serieNumber)
end)


RegisterServerEvent('police:server:UpdateCurrentCops')
AddEventHandler('police:server:UpdateCurrentCops', function()
    local amount = 0
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then 
            if (Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "police1" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police4" or Player.PlayerData.job.name == "police5" or Player.PlayerData.job.name == "police6" or Player.PlayerData.job.name == "police7" or Player.PlayerData.job.name == "police8" and Player.PlayerData.job.onduty) then
                amount = amount + 1
            end
        end
    end
    TriggerClientEvent("police:SetCopCount", -1, amount)
end)

RegisterServerEvent('evidence:server:ClearCasings')
AddEventHandler('evidence:server:ClearCasings', function(casingList)
    if casingList ~= nil and next(casingList) ~= nil then 
        for k, v in pairs(casingList) do
            TriggerClientEvent("evidence:client:RemoveCasing", -1, v)
            Casings[v] = nil
        end
    end
end)

RegisterServerEvent('evidence:server:AddCasingToInventory')
AddEventHandler('evidence:server:AddCasingToInventory', function(casingId, casingInfo)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveItem("empty_evidence_bag", 1) then
        if Player.Functions.AddItem("filled_evidence_bag", 1, false, casingInfo) then
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["filled_evidence_bag"], "add")
            TriggerClientEvent("evidence:client:RemoveCasing", -1, casingId)
            Casings[casingId] = nil
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You must have an empty evidence bag with you", "error")
    end
end)

RegisterServerEvent('police:server:showFingerprint')
AddEventHandler('police:server:showFingerprint', function(playerId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(playerId)

    TriggerClientEvent('police:client:showFingerprint', playerId, src)
    TriggerClientEvent('police:client:showFingerprint', src, playerId)
end)

RegisterServerEvent('police:server:showFingerprintId')
AddEventHandler('police:server:showFingerprintId', function(sessionId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local fid = Player.PlayerData.metadata["fingerprint"]

    TriggerClientEvent('police:client:showFingerprintId', sessionId, fid)
    TriggerClientEvent('police:client:showFingerprintId', src, fid)
end)

RegisterServerEvent('police:server:SetTracker')
AddEventHandler('police:server:SetTracker', function(targetId)
    local Target = QBCore.Functions.GetPlayer(targetId)
    local TrackerMeta = Target.PlayerData.metadata["tracker"]

    if TrackerMeta then
        Target.Functions.SetMetaData("tracker", false)
        TriggerClientEvent('QBCore:Notify', targetId, 'Your ankle strap is taken off.', 'error', 5000)
        TriggerClientEvent('QBCore:Notify', source, 'You took off an ankle bracelet from '..Target.PlayerData.charinfo.firstname.." "..Target.PlayerData.charinfo.lastname, 'error', 5000)
        TriggerClientEvent('police:client:SetTracker', targetId, false)
    else
        Target.Functions.SetMetaData("tracker", true)
        TriggerClientEvent('QBCore:Notify', targetId, 'You took off an ankle bracelet from', 'error', 5000)
        TriggerClientEvent('QBCore:Notify', source, 'You put on an ankle strap at'..Target.PlayerData.charinfo.firstname.." "..Target.PlayerData.charinfo.lastname, 'error', 5000)
        TriggerClientEvent('police:client:SetTracker', targetId, true)
    end
end)

RegisterServerEvent('police:server:SendTrackerLocation')
AddEventHandler('police:server:SendTrackerLocation', function(coords, requestId)
    local Target = QBCore.Functions.GetPlayer(source)
    local TrackerMeta = Target.PlayerData.metadata["tracker"]

    local msg = "The location of "..Target.PlayerData.charinfo.firstname.." "..Target.PlayerData.charinfo.lastname.." is indicated on your card."

    local alertData = {
        title = "Ankle band Location",
        coords = {x = coords.x, y = coords.y, z = coords.z},
        description = msg
    }

    TriggerClientEvent("police:client:TrackerMessage", requestId, msg, coords)
    TriggerClientEvent("qb-phone:client:addPoliceAlert", requestId, alertData)
end)

RegisterServerEvent('police:server:SendPoliceEmergencyAlert')
AddEventHandler('police:server:SendPoliceEmergencyAlert', function(streetLabel, coords, callsign)
    local alertData = {
        title = "Assistentie collega",
        coords = {x = coords.x, y = coords.y, z = coords.z},
        description = "Noodknop ingedrukt door ".. callsign .. " Bee "..streetLabel,
    }
    TriggerClientEvent("police:client:PoliceEmergencyAlert", -1, callsign, streetLabel, coords)
    TriggerClientEvent("qb-phone:client:addPoliceAlert", -1, alertData)
end)

QBCore.Functions.CreateCallback('police:server:isPlayerDead', function(source, cb, playerId)
    local Player = QBCore.Functions.GetPlayer(playerId)
    cb(Player.PlayerData.metadata["isdead"])
end)

QBCore.Functions.CreateCallback('police:GetPlayerStatus', function(source, cb, playerId)
    local Player = QBCore.Functions.GetPlayer(playerId)
    local statList = {}
	if Player ~= nil then
        if PlayerStatus[Player.PlayerData.source] ~= nil and next(PlayerStatus[Player.PlayerData.source]) ~= nil then
            for k, v in pairs(PlayerStatus[Player.PlayerData.source]) do
                table.insert(statList, PlayerStatus[Player.PlayerData.source][k].text)
            end
        end
	end
    cb(statList)
end)

QBCore.Functions.CreateCallback('police:IsSilencedWeapon', function(source, cb, weapon)
    local Player = QBCore.Functions.GetPlayer(source)
    local itemInfo = Player.Functions.GetItemByName(QBCore.Shared.Weapons[weapon]["name"])
    local retval = false
    if itemInfo ~= nil then 
        if itemInfo.info ~= nil and itemInfo.info.attachments ~= nil then 
            for k, v in pairs(itemInfo.info.attachments) do
                if itemInfo.info.attachments[k].component == "COMPONENT_AT_AR_SUPP_02" or itemInfo.info.attachments[k].component == "COMPONENT_AT_AR_SUPP" or itemInfo.info.attachments[k].component == "COMPONENT_AT_PI_SUPP_02" or itemInfo.info.attachments[k].component == "COMPONENT_AT_PI_SUPP" then
                    retval = true
                end
            end
        end
    end
    cb(retval)
end)

QBCore.Functions.CreateCallback('police:GetDutyPlayers', function(source, cb)
    local dutyPlayers = {}
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then 
            if ((Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "police1" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police4" or Player.PlayerData.job.name == "police5" or Player.PlayerData.job.name == "police6" or Player.PlayerData.job.name == "police7" or Player.PlayerData.job.name == "police8" or Player.PlayerData.job.name == "ambulance") and Player.PlayerData.job.onduty) then
                table.insert(dutyPlayers, {
                    source = Player.PlayerData.source,
                    label = Player.PlayerData.metadata["callsign"],
                    job = Player.PlayerData.job.name,
                })
            end
        end
    end
    cb(dutyPlayers)
end)

function CreateBloodId()
    if BloodDrops ~= nil then
		local bloodId = math.random(10000, 99999)
		while BloodDrops[caseId] ~= nil do
			bloodId = math.random(10000, 99999)
		end
		return bloodId
	else
		local bloodId = math.random(10000, 99999)
		return bloodId
	end
end

function CreateFingerId()
    if FingerDrops ~= nil then
		local fingerId = math.random(10000, 99999)
		while FingerDrops[caseId] ~= nil do
			fingerId = math.random(10000, 99999)
		end
		return fingerId
	else
		local fingerId = math.random(10000, 99999)
		return fingerId
	end
end

function CreateCasingId()
    if Casings ~= nil then
		local caseId = math.random(10000, 99999)
		while Casings[caseId] ~= nil do
			caseId = math.random(10000, 99999)
		end
		return caseId
	else
		local caseId = math.random(10000, 99999)
		return caseId
	end
end

function CreateObjectId()
    if Objects ~= nil then
		local objectId = math.random(10000, 99999)
		while Objects[caseId] ~= nil do
			objectId = math.random(10000, 99999)
		end
		return objectId
	else
		local objectId = math.random(10000, 99999)
		return objectId
	end
end

function IsVehicleOwned(plate)
    local val = false
	QBCore.Functions.ExecuteSql(true, "SELECT * FROM `player_vehicles` WHERE `plate` = '"..plate.."'", function(result)
		if (result[1] ~= nil) then
			val = true
		else
			val = false
		end
	end)
	return val
end

QBCore.Functions.CreateCallback('police:GetImpoundedVehicles', function(source, cb)
    local vehicles = {}
    exports['ghmattimysql']:execute('SELECT * FROM player_vehicles WHERE state = @state', {['@state'] = 2}, function(result)
        if result[1] ~= nil then
            vehicles = result
        end
        cb(vehicles)
    end)
end)

QBCore.Functions.CreateCallback('police:IsPlateFlagged', function(source, cb, plate)
    local retval = false
    if Plates ~= nil and Plates[plate] ~= nil then
        if Plates[plate].isflagged then
            retval = true
        end
    end
    cb(retval)
end)

QBCore.Functions.CreateCallback('police:GetCops', function(source, cb)
    local amount = 0
    
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then 
            if (Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "police1" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police4" or Player.PlayerData.job.name == "police5" or Player.PlayerData.job.name == "police6" or Player.PlayerData.job.name == "police7" or Player.PlayerData.job.name == "police8" and Player.PlayerData.job.onduty) then
                amount = amount + 1
            end
        end
    end
	cb(amount)
end)

QBCore.Commands.Add("setpolice", "Give the police job to someone ", {{name="id", help="Player ID"}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local Myself = QBCore.Functions.GetPlayer(source)
    if Player ~= nil then 
        if (Myself.PlayerData.job.name == "police" and Myself.PlayerData.job.onduty) and IsHighCommand(Myself.PlayerData.citizenid) then
            Player.Functions.SetJob("police")
        end
    end
end)

QBCore.Commands.Add("setpolice2", "Give the police job to someone ", {{name="id", help="Player ID"}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local Myself = QBCore.Functions.GetPlayer(source)
    if Player ~= nil then 
        if (Myself.PlayerData.job.name == "police2" and Myself.PlayerData.job.onduty) and IsHighCommand(Myself.PlayerData.citizenid) then
            Player.Functions.SetJob("police2")
        end
    end
end)

QBCore.Commands.Add("setpolice3", "Give the police job to someone ", {{name="id", help="Player ID"}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local Myself = QBCore.Functions.GetPlayer(source)
    if Player ~= nil then 
        if (Myself.PlayerData.job.name == "police3" and Myself.PlayerData.job.onduty) and IsHighCommand(Myself.PlayerData.citizenid) then
            Player.Functions.SetJob("police3")
        end
    end
end)

QBCore.Commands.Add("setpolice4", "Give the police job to someone ", {{name="id", help="Player ID"}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local Myself = QBCore.Functions.GetPlayer(source)
    if Player ~= nil then 
        if (Myself.PlayerData.job.name == "police4" and Myself.PlayerData.job.onduty) and IsHighCommand(Myself.PlayerData.citizenid) then
            Player.Functions.SetJob("police4")
        end
    end
end)

QBCore.Commands.Add("setpolice5", "Give the police job to someone ", {{name="id", help="Player ID"}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local Myself = QBCore.Functions.GetPlayer(source)
    if Player ~= nil then 
        if (Myself.PlayerData.job.name == "police5" and Myself.PlayerData.job.onduty) and IsHighCommand(Myself.PlayerData.citizenid) then
            Player.Functions.SetJob("police5")
        end
    end
end)

QBCore.Commands.Add("setpolice6", "Give the police job to someone ", {{name="id", help="Player ID"}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local Myself = QBCore.Functions.GetPlayer(source)
    if Player ~= nil then 
        if (Myself.PlayerData.job.name == "police6" and Myself.PlayerData.job.onduty) and IsHighCommand(Myself.PlayerData.citizenid) then
            Player.Functions.SetJob("police6")
        end
    end
end)

QBCore.Commands.Add("setpolice7", "Give the police job to someone ", {{name="id", help="Player ID"}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local Myself = QBCore.Functions.GetPlayer(source)
    if Player ~= nil then 
        if (Myself.PlayerData.job.name == "police7" and Myself.PlayerData.job.onduty) and IsHighCommand(Myself.PlayerData.citizenid) then
            Player.Functions.SetJob("police7")
        end
    end
end)

QBCore.Commands.Add("setpolice8", "Give the police job to someone ", {{name="id", help="Player ID"}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local Myself = QBCore.Functions.GetPlayer(source)
    if Player ~= nil then 
        if (Myself.PlayerData.job.name == "police8" and Myself.PlayerData.job.onduty) and IsHighCommand(Myself.PlayerData.citizenid) then
            Player.Functions.SetJob("police8")
        end
    end
end)

QBCore.Commands.Add("spikes", "Give the police job to someonePut down a spike strip", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player ~= nil then 
        if (Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "police1" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police4" or Player.PlayerData.job.name == "police5" or Player.PlayerData.job.name == "police6" or Player.PlayerData.job.name == "police7" or Player.PlayerData.job.name == "police8" and Player.PlayerData.job.onduty) then
            TriggerClientEvent('police:client:SpawnSpikeStrip', source)
        end
    end
end)


QBCore.Commands.Add("firepolice", "Fire a police officer!", {{name="id", help="Player ID"}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local Myself = QBCore.Functions.GetPlayer(source)
    if Player ~= nil then 
        if (Myself.PlayerData.Job.name == 'police' or PlayerData.Job.name == 'police1' or PlayerData.Job.name == 'police2' or PlayerData.Job.name == 'police3' or PlayerData.Job.name == 'police4' or PlayerData.Job.name == 'police5' or PlayerData.Job.name == 'police6' or PlayerData.Job.name == 'police7' or PlayerData.Job.name == 'police8' and Myself.PlayerData.job.onduty) and IsHighCommand(Myself.PlayerData.citizenid) then
            Player.Functions.SetJob("unemployed")
        end
    end
end)

function IsHighCommand(citizenid)
    local retval = false
    for k, v in pairs(Config.ArmoryWhitelist) do
        if v == citizenid then
            retval = true
        end
    end
    return retval
end

QBCore.Commands.Add("object", "Fire a police officerPlace / Delete an object", {{name="type", help="Type object you want or 'delete' to delete"}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    local type = args[1]:lower()
    if Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "police1" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police4" or Player.PlayerData.job.name == "police5" or Player.PlayerData.job.name == "police6" or Player.PlayerData.job.name == "police7" or Player.PlayerData.job.name == "police8" then
        if type == "pion" then
            TriggerClientEvent("police:client:spawnCone", source)
        elseif type == "barier" then
            TriggerClientEvent("police:client:spawnBarier", source)
        elseif type == "schotten" then
            TriggerClientEvent("police:client:spawnSchotten", source)
        elseif type == "tent" then
            TriggerClientEvent("police:client:spawnTent", source)
        elseif type == "light" then
            TriggerClientEvent("police:client:spawnLight", source)
        elseif type == "delete" then
            TriggerClientEvent("police:client:deleteObject", source)
        end
    else
        TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "This command is for emergency services!")
    end
end)

QBCore.Commands.Add("hc", "Cuff a player", {}, false, function(source, args)
	local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "police1" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police4" or Player.PlayerData.job.name == "police5" or Player.PlayerData.job.name == "police6" or Player.PlayerData.job.name == "police7" or Player.PlayerData.job.name == "police8" and Player.PlayerData.job.onduty then
        TriggerClientEvent("police:client:CuffPlayer", source)
    else
        TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "This command is for emergency services!")
    end
end)

QBCore.Commands.Add("reportpolice", "Report the police", {{name="Message", help="It police Message"}}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    
    if (Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "police1" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police3" or Player.PlayerData.job.name == "police4" or Player.PlayerData.job.name == "police5" or Player.PlayerData.job.name == "police6" or Player.PlayerData.job.name == "police7" or Player.PlayerData.job.name == "police8" and Player.PlayerData.job.onduty) then
        if args[1] ~= nil then
            local msg = table.concat(args, " ")
            TriggerClientEvent("chatMessage", -1, "POLICE REPORT", "error", msg)
            TriggerEvent("qb-log:server:CreateLog", "pmelding", "Police Notification", "blue", "**"..GetPlayerName(source).."** (CitizenID: "..Player.PlayerData.citizenid.." | ID: "..source..") **Message:** " ..msg, false)
            TriggerClientEvent('police:PlaySound', -1)
        else
            TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "You must fill in Message!")
        end
    else
        TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "This command is for emergency services!")
    end
end)

QBCore.Commands.Add("escort", "Escort a Player", {}, false, function(source, args)
	local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("police:client:EscortPlayer", source)
end)

QBCore.Commands.Add("databank", "Toggle police databank", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    
    if (Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "police1" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police4" or Player.PlayerData.job.name == "police5" or Player.PlayerData.job.name == "police6" or Player.PlayerData.job.name == "police7" or Player.PlayerData.job.name == "police8" and Player.PlayerData.job.onduty) then
        TriggerClientEvent("police:client:toggleDatabank", source)
    else
        TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "This command is for emergency services!")
    end
end)

QBCore.Commands.Add("callsign", "Put the name of your callsign (callsign)", {{name =" name ", help =" Name of your callsign"}}, false, function(source, args)
	local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.SetMetaData("callsign", table.concat(args, " "))
end)

QBCore.Commands.Add("clearcasings", "Take away bullets nearby (make sure you've picked up some)", {}, false, function(source, args)
	local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "police1" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police4" or Player.PlayerData.job.name == "police5" or Player.PlayerData.job.name == "police6" or Player.PlayerData.job.name == "police7" or Player.PlayerData.job.name == "police8" then
        TriggerClientEvent("evidence:client:ClearCasingsInArea", source)
    else
        TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "This command is for emergency services!")
    end
end)

QBCore.Commands.Add("jail", "Send a person to prison", {{name = "id", help = "Player ID"}, {name = "time", help = "Time how long to rot >:)"}}, true, function(source, args)
	local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "police1" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police3" or Player.PlayerData.job.name == "police4" or Player.PlayerData.job.name == "police5" or Player.PlayerData.job.name == "police6" or Player.PlayerData.job.name == "police7" or Player.PlayerData.job.name == "police8" then
        local playerId = tonumber(args[1])
        local time = tonumber(args[2])
        if time > 0 then
            TriggerClientEvent("police:client:JailCommand", source, playerId, time)
        else
            TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Time must be higher than 0")
        end
    else
        TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "This command is for emergency services!")
    end
end)

QBCore.Commands.Add("bail", "Get person out of prison.", {{name="id", help="Players ID"}}, true, function(source, args)
	local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "police1" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police3" or Player.PlayerData.job.name == "police4" or Player.PlayerData.job.name == "police5" or Player.PlayerData.job.name == "police6" or Player.PlayerData.job.name == "police7" or Player.PlayerData.job.name == "police8" then
        local playerId = tonumber(args[1])
        TriggerClientEvent("prison:client:UnjailPerson", playerId)
    else
        TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "This command is for emergency services!")
    end
end)

QBCore.Commands.Add("fine", "Fine to Player", {{name = "id", help = "Player ID"}, {name = "price", help = "Fine Amount )"}}, true, function(source, args)
	local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "police1" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police3" or Player.PlayerData.job.name == "police4" or Player.PlayerData.job.name == "police5" or Player.PlayerData.job.name == "police6" or Player.PlayerData.job.name == "police7" or Player.PlayerData.job.name == "police8" then
        local playerId = tonumber(args[1])
        local price = tonumber(args[2])
        if price > 0 then
            TriggerClientEvent("police:client:BillCommand", source, playerId, price)
       --     TriggerClientEvent("police:client:BillCommand", playerId, tonumber(price))
        else
            TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Amount must be higher than 0")
        end
    else
        TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "This command is for emergency services!")
    end
end)

QBCore.Commands.Add("gimme", ":)", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    local info = {
        serie = "K"..math.random(10,99).."SH"..math.random(100,999).."HJ"..math.random(1,9),
        attachments = {
            {component = "COMPONENT_AT_AR_FLSH", label = "Flashlight"},
            {component = "COMPONENT_AT_AR_SUPP_02", label = "Supressor"},
            {component = "COMPONENT_AT_AR_AFGRIP", label = "Grip"},
            {component = "COMPONENT_AT_SCOPE_MACRO", label = "1x Scope"},
            {component = "COMPONENT_ASSAULTRIFLE_CLIP_02", label = "Extended Clip"},
        }
    }
    if Player.Functions.AddItem("weapon_assaultrifle", 1, false, info) then
        print("Smile :)")
    end
end, "god")

QBCore.Commands.Add("gimme2", ":)", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    local info = {
        serie = "K"..math.random(10,99).."SH"..math.random(100,999).."HJ"..math.random(1,9),
        attachments = {
            {component = "COMPONENT_AT_AR_SUPP_02", label = "Supressor"},
        }
    }
    if Player.Functions.AddItem("weapon_pistol50", 1, false, info) then
        print("BB is the best KEKW")
    end
end, "god")

QBCore.Commands.Add("clearblood", "Take away nearby blood (make sure you've picked up some)", {}, false, function(source, args)
	local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "police1" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police3" or Player.PlayerData.job.name == "police4" or Player.PlayerData.job.name == "police5" or Player.PlayerData.job.name == "police6" or Player.PlayerData.job.name == "police7" or Player.PlayerData.job.name == "police8" then
        TriggerClientEvent("evidence:client:ClearBlooddropsInArea", source)
    else
        TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "This command is for emergency services!")
    end
end)

QBCore.Commands.Add("confiscate", "Take cash from the nearest person", {}, false, function(source, args)
	local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "police1" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police3" or Player.PlayerData.job.name == "police4" or Player.PlayerData.job.name == "police5" or Player.PlayerData.job.name == "police6" or Player.PlayerData.job.name == "police7" or Player.PlayerData.job.name == "police8" and Player.PlayerData.job.onduty then
        TriggerClientEvent("police:client:SeizeCash", source)
    else
        TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "This command is for emergency services!")
    end
end)

QBCore.Commands.Add("cuff", "Handcuff someone but let him run", {}, false, function(source, args)
	local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "police1" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police3" or Player.PlayerData.job.name == "police4" or Player.PlayerData.job.name == "police5" or Player.PlayerData.job.name == "police6" or Player.PlayerData.job.name == "police7" or Player.PlayerData.job.name == "police8" then
        TriggerClientEvent("police:client:CuffPlayerSoft", source)
    else
        TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "This command is for emergency services!")
    end
end)

QBCore.Commands.Add("cam", "BView security camera", {{name="camid", help="Camera ID"}}, false, function(source, args)
	local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "police1" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police3" or Player.PlayerData.job.name == "police4" or Player.PlayerData.job.name == "police5" or Player.PlayerData.job.name == "police6" or Player.PlayerData.job.name == "police7" or Player.PlayerData.job.name == "police8" then
        TriggerClientEvent("police:client:ActiveCamera", source, tonumber(args[1]))
    else
        TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "This command is for emergency services!")
    end
end)

QBCore.Commands.Add("flagplate", "Mark a vehicle", {{name="plate", help="License plate"}, {name =" reason ", help =" Reason for marking"}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    
    if Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "police1" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police3" or Player.PlayerData.job.name == "police4" or Player.PlayerData.job.name == "police5" or Player.PlayerData.job.name == "police6" or Player.PlayerData.job.name == "police7" or Player.PlayerData.job.name == "police8" then
        local reason = {}
        for i = 2, #args, 1 do
            table.insert(reason, args[i])
        end
        Plates[args[1]:upper()] = {
            isflagged = true,
            reason = table.concat(reason, " ")
        }
        TriggerClientEvent('QBCore:Notify', source, "Vehicle ("..args[1]:upper()..") is marked for: "..table.concat(reason, " "))
    else
        TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "This command is for emergency services!")
    end
end)

QBCore.Commands.Add("unflagplate", "Put a vehicle unmarked", {{name =" plate", help ="License plate"}}, true, function(source, args)
	local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "police1" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police3" or Player.PlayerData.job.name == "police4" or Player.PlayerData.job.name == "police5" or Player.PlayerData.job.name == "police6" or Player.PlayerData.job.name == "police7" or Player.PlayerData.job.name == "police8" then
        if Plates ~= nil and Plates[args[1]:upper()] ~= nil then
            if Plates[args[1]:upper()].isflagged then
                Plates[args[1]:upper()].isflagged = false
                TriggerClientEvent('QBCore:Notify', source, "Vehicle ("..args[1]:upper()..") is no longer marked")
            else
                TriggerClientEvent('chatMessage', source, "REPORTING ROOM", "error", "Vehicle is not marked!")
            end
        else
            TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Vehicle is not marked!")
        end
    else
        TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "This command is for emergency services!")
    end
end)

QBCore.Commands.Add("plateinfo", "Highlight a Vehicle", {{name="plate", help="License Plate"}}, true, function(source, args)
	local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "police1" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police3" or Player.PlayerData.job.name == "police4" or Player.PlayerData.job.name == "police5" or Player.PlayerData.job.name == "police6" or Player.PlayerData.job.name == "police7" or Player.PlayerData.job.name == "police8" then
        if Plates ~= nil and Plates[args[1]:upper()] ~= nil then
            if Plates[args[1]:upper()].isflagged then
                TriggerClientEvent('chatMessage', source, "REPORTING ROOM", "normal", "Vehicle ("..args[1]:upper()..") is marked for: "..Plates[args[1]:upper()].reason)
            else
                TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Vehicle is not marked!")
            end
        else
            TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Vehicle is not marked!")
        end
    else
        TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "This command is for emergency services!")
    end
end)

QBCore.Commands.Add("impound", "Send a Vehicle to the impound", {{name="price", help="Price for how much the person has to pay (may be empty)"}}, false, function(source, args)
	local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "police1" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police3" or Player.PlayerData.job.name == "police4" or Player.PlayerData.job.name == "police5" or Player.PlayerData.job.name == "police6" or Player.PlayerData.job.name == "police7" or Player.PlayerData.job.name == "police8" or Player.PlayerData.job.name == "mechanic" or Player.PlayerData.job.name == "cardealer" or Player.PlayerData.job.name == "ems1" or Player.PlayerData.job.name == "ems2" or Player.PlayerData.job.name == "ems3" or Player.PlayerData.job.name == "ems4" or Player.PlayerData.job.name == "ems5" or Player.PlayerData.job.name == "ems6" or Player.PlayerData.job.name == "ems6"or Player.PlayerData.job.name == "ems7" or Player.PlayerData.job.name == "ems8" then
        TriggerClientEvent("police:client:ImpoundVehicle", source, false, tonumber(args[1]))
    else
        TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "This command is for emergency services!")
    end
end)

QBCore.Commands.Add("confiscatev", "Confiscate a Vehicle", {}, false, function(source, args)
	local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "police1" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police3" or Player.PlayerData.job.name == "police4" or Player.PlayerData.job.name == "police5" or Player.PlayerData.job.name == "police6" or Player.PlayerData.job.name == "police7" or Player.PlayerData.job.name == "police8" then
        TriggerClientEvent("police:client:ImpoundVehicle", source, true)
    else
        TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "This command is for emergency services!")
    end
end)

QBCore.Commands.Add("paytow", "Pay a mountain net employee", {{name =" id ", help ="ID of a player"}}, true, function(source, args)
	local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "police1" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police3" or Player.PlayerData.job.name == "police4" or Player.PlayerData.job.name == "police5" or Player.PlayerData.job.name == "police6" or Player.PlayerData.job.name == "police7" or Player.PlayerData.job.name == "police8" or Player.PlayerData.job.name == "ems" or Player.PlayerData.job.name == "ems1" or Player.PlayerData.job.name == "ems2" or Player.PlayerData.job.name == "ems3" or Player.PlayerData.job.name == "ems4" or Player.PlayerData.job.name == "ems5" or Player.PlayerData.job.name == "ems6" or Player.PlayerData.job.name == "ems7" or Player.PlayerData.job.name == "ems8" or  then
        local playerId = tonumber(args[1])
        local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
        if OtherPlayer ~= nil then
            if OtherPlayer.PlayerData.job.name == "tow" then
                OtherPlayer.Functions.AddMoney("bank", 500, "police-tow-paid")
                TriggerClientEvent('chatMessage', OtherPlayer.PlayerData.source, "SYSTEM", "warning", "You received $500 for your service!")
                TriggerClientEvent('QBCore:Notify', source, 'You paid a mountain net employee')
            else
                TriggerClientEvent('QBCore:Notify', source, 'Person is not a mountain net employee', "error")
            end
        end
    else
        TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "This command is for emergency services!")
    end
end)

QBCore.Commands.Add("paylaw", "Pay a lawyer", {{name ="id ", help=" ID of a player"}}, true, function(source, args)
	local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "police1" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police3" or Player.PlayerData.job.name == "police4" or Player.PlayerData.job.name == "police5" or Player.PlayerData.job.name == "police6" or Player.PlayerData.job.name == "police7" or Player.PlayerData.job.name == "police8" or Player.PlayerData.job.name == "judge" then
        local playerId = tonumber(args[1])
        local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
        if OtherPlayer ~= nil then
            if OtherPlayer.PlayerData.job.name == "lawyer" then
                OtherPlayer.Functions.AddMoney("bank", 500, "police-lawyer-paid")
                TriggerClientEvent('chatMessage', OtherPlayer.PlayerData.source, "SYSTEM", "warning", "You received $500 for your case!")
                TriggerClientEvent('QBCore:Notify', source, 'You paid a lawyer')
            else
                TriggerClientEvent('QBCore:Notify', source, 'Person is not a lawyer', "error")
            end
        end
    else
        TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "This command is for emergency services!")
    end
end)

QBCore.Commands.Add("radar", "Toggle speed radar :)", {}, false, function(source, args)
	local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "police1" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police3" or Player.PlayerData.job.name == "police4" or Player.PlayerData.job.name == "police5" or Player.PlayerData.job.name == "police6" or Player.PlayerData.job.name == "police7" or Player.PlayerData.job.name == "police8" then
        TriggerClientEvent("wk:toggleRadar", source)
    else
        TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "This command is for emergency services!")
    end
end)

QBCore.Functions.CreateUseableItem("handcuffs", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent("police:client:CuffPlayerSoft", source)
    end
end)

QBCore.Commands.Add("911", "Send a report to emergency services", {{name="Message", help="Message you want to send to the emergency services"}}, true, function(source, args)
    local message = table.concat(args, " ")
    local Player = QBCore.Functions.GetPlayer(source)

    if Player.Functions.GetItemByName("phone") ~= nil then
        TriggerClientEvent("police:client:SendEmergencyMessage", source, message)
        TriggerEvent("qb-log:server:CreateLog", "112", "112 Message", "blue", "**"..GetPlayerName(source).."** (CitizenID: "..Player.PlayerData.citizenid.." | ID: "..source..") **Message:** " ..message, false)
    else
        TriggerClientEvent('QBCore:Notify', source, 'You dont have a phone', 'error')
    end
end)

QBCore.Commands.Add("911a", "Send an anonymous report to emergency services (gives no location)", {{name =" Message", help ="Message you want to send to the emergency services"}}, true, function(source, args)
    local message = table.concat(args, " ")
    local Player = QBCore.Functions.GetPlayer(source)

    if Player.Functions.GetItemByName("phone") ~= nil then
        TriggerClientEvent("police:client:CallAnim", source)
        TriggerClientEvent('police:client:Send112AMessage', -1, message)
    else
        TriggerClientEvent('QBCore:Notify', source, 'You dont have a phone', 'error')
    end
end)

QBCore.Commands.Add("911r", "Send a Message back to a report", {{name="id", help="ID of the report"}, {name="Message", help="Message you want to send"}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    local OtherPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
    table.remove(args, 1)
    local message = table.concat(args, " ")
    local Prefix = "POLICE"
    if (Player.PlayerData.job.name == "ambulance" or Player.PlayerData.job.name == "doctor") then
        Prefix = "AMBULANCE"
    end
    if OtherPlayer ~= nil then 
        TriggerClientEvent('chatMessage', OtherPlayer.PlayerData.source, "("..Prefix..") " ..Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname, "error", message)
        TriggerClientEvent("police:client:EmergencySound", OtherPlayer.PlayerData.source)
        TriggerClientEvent("police:client:CallAnim", source)
    end
end)

QBCore.Commands.Add("ankleband", "Put an ankle strap on the nearest person.", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)

    if Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "police1" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police3" or Player.PlayerData.job.name == "police4" or Player.PlayerData.job.name == "police5" or Player.PlayerData.job.name == "police6" or Player.PlayerData.job.name == "police7" or Player.PlayerData.job.name == "police8" then
        TriggerClientEvent("police:client:CheckDistance", source)
    else
        TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "This command is for emergency services!")
    end
end)

QBCore.Commands.Add("anklestraplocation", "Get location of person with ankle strap", {{"bsn","BSN from person"}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    
    if Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "police1" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police3" or Player.PlayerData.job.name == "police4" or Player.PlayerData.job.name == "police5" or Player.PlayerData.job.name == "police6" or Player.PlayerData.job.name == "police7" or Player.PlayerData.job.name == "police8" then
        if args[1] ~= nil then
            local citizenid = args[1]
            local Target = QBCore.Functions.GetPlayerByCitizenId(citizenid)

            if Target ~= nil then
                if Target.PlayerData.metadata["tracker"] then
                    TriggerClientEvent("police:client:SendTrackerLocation", Target.PlayerData.source, source)
                else
                    TriggerClientEvent('QBCore:Notify', source, 'This person has no ankle strap.', 'error')
                end
            end
        end
    else
        TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "This command is for emergency services!")
    end
end)

QBCore.Commands.Add("embutton", "Send a Message back to a report", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    if ((Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "police1" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police3" or Player.PlayerData.job.name == "police4" or Player.PlayerData.job.name == "police5" or Player.PlayerData.job.name == "police6" or Player.PlayerData.job.name == "police7" or Player.PlayerData.job.name == "police8" or Player.PlayerData.job.name == "ambulance" or Player.PlayerData.job.name == "doctor") and Player.PlayerData.job.onduty) then
        TriggerClientEvent("police:client:SendPoliceEmergencyAlert", source)
    end
end)

QBCore.Commands.Add("dl", "Take a qbver's license from someone", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    if ((Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "police1" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police3" or Player.PlayerData.job.name == "police4" or Player.PlayerData.job.name == "police5" or Player.PlayerData.job.name == "police6" or Player.PlayerData.job.name == "police7" or Player.PlayerData.job.name == "police8") and Player.PlayerData.job.onduty) then
        TriggerClientEvent("police:client:SeizeqbverLicense", source)
    end
end)

QBCore.Commands.Add("dna", "Take a DNA copy from a person (empty evidance bag needed)", {{name="id", help="Player ID"}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    local OtherPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
    if ((Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "police1" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police3" or Player.PlayerData.job.name == "police4" or Player.PlayerData.job.name == "police5" or Player.PlayerData.job.name == "police6" or Player.PlayerData.job.name == "police7" or Player.PlayerData.job.name == "police8") and Player.PlayerData.job.onduty) and OtherPlayer ~= nil then
        if Player.Functions.RemoveItem("empty_evidence_bag", 1) then
            local info = {
                label = "DNA-Monster",
                type = "dna",
                dnalabel = DnaHash(OtherPlayer.PlayerData.citizenid),
            }
            if Player.Functions.AddItem("filled_evidence_bag", 1, false, info) then
                TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items["filled_evidence_bag"], "add")
            end
        else
            TriggerClientEvent('QBCore:Notify', source, "You must have an empty evidence bag with you", "error")
        end
    end
end)

QBCore.Functions.CreateUseableItem("moneybag", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        if item.info ~= nil and item.info ~= "" then
            if Player.PlayerData.Job.name == 'police' or PlayerData.Job.name == 'police1' or PlayerData.Job.name == 'police2' or PlayerData.Job.name == 'police3' or PlayerData.Job.name == 'police4' or PlayerData.Job.name == 'police5' or PlayerData.Job.name == 'police6' or PlayerData.Job.name == 'police7' or PlayerData.Job.name == 'police8' then
                if Player.Functions.RemoveItem("moneybag", 1, item.slot) then
                    Player.Functions.AddMoney("cash", tonumber(item.info.cash), "used-moneybag")
                end
            end
        end
    end
end)

function GetCurrentCops()
    local amount = 0
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then 
            if (Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "police1" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police3" or Player.PlayerData.job.name == "police4" or Player.PlayerData.job.name == "police5" or Player.PlayerData.job.name == "police6" or Player.PlayerData.job.name == "police7" or Player.PlayerData.job.name == "police8" and Player.PlayerData.job.onduty) then
                amount = amount + 1
            end
        end
    end
    return amount
end

QBCore.Functions.CreateCallback('police:server:IsPoliceForcePresent', function(source, cb)
    local retval = false
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then 
            for _, citizenid in pairs(Config.ArmoryWhitelist) do
                if citizenid == Player.PlayerData.citizenid then
                    retval = true
                    break
                end
            end
        end
    end
    cb(retval)
end)

function DnaHash(s)
    local h = string.gsub(s, ".", function(c)
		return string.format("%02x", string.byte(c))
	end)
    return h
end

RegisterServerEvent('police:server:SyncSpikes')
AddEventHandler('police:server:SyncSpikes', function(table)
    TriggerClientEvent('police:client:SyncSpikes', -1, table)
end)