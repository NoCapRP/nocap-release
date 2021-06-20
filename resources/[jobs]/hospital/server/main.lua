QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

local PlayerInjuries = {}
local PlayerWeaponWounds = {}
local bedsTaken = {}

RegisterServerEvent('hospital:server:SendToBed')
AddEventHandler('hospital:server:SendToBed', function(bedId, isRevive)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local price = math.random(200,500)
	TriggerClientEvent('hospital:client:SendToBed', src, bedId, Config.Locations["beds"][bedId], isRevive)
	TriggerClientEvent('hospital:client:SetBed', -1, bedId, true)
	Player.Functions.RemoveMoney("bank", price, "respawned-at-hospital")
	TriggerEvent("cash_bossmenu:server:addAccountMoney", "ems", price)
	TriggerClientEvent('hospital:client:SendBillEmail', src, price)
end)

RegisterServerEvent('hospital:server:SendToBedx')
AddEventHandler('hospital:server:SendToBedx', function(bedId, isRevive)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local price = math.random(200,500)
	TriggerClientEvent('hospital:client:SendToBed', src, bedId, Config.Locations["beds"][bedId], isRevive)
	TriggerClientEvent('hospital:client:SetBed', -1, bedId, true)
	--Player.Functions.RemoveMoney("bank", price, "respawned-at-hospital")
	--TriggerClientEvent('hospital:client:SendBillEmail', src, price)
end)

RegisterServerEvent('hospital:server:RespawnAtHospital')
AddEventHandler('hospital:server:RespawnAtHospital', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	for k, v in pairs(Config.Locations["beds"]) do
		TriggerClientEvent('hospital:client:SendToBed', src, k, v, true)
		TriggerClientEvent('hospital:client:SetBed', -1, k, true)
		Player.Functions.RemoveMoney("bank", Config.BillCost, "respawned-at-hospital")
		TriggerEvent("cash_bossmenu:server:addAccountMoney", "ems", Config.BillCost)
		TriggerClientEvent('hospital:client:SendBillEmail', src, Config.BillCost)
		return
	end
end)

RegisterServerEvent('hospital:server:LeaveBed')
AddEventHandler('hospital:server:LeaveBed', function(id)
    TriggerClientEvent('hospital:client:SetBed', -1, id, false)
end)

RegisterServerEvent('hospital:server:SyncInjuries')
AddEventHandler('hospital:server:SyncInjuries', function(data)
    local src = source
    PlayerInjuries[src] = data
end)


RegisterServerEvent('hospital:server:SetWeaponDamage')
AddEventHandler('hospital:server:SetWeaponDamage', function(data)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Player ~= nil then 
		PlayerWeaponWounds[Player.PlayerData.source] = data
	end
end)

RegisterServerEvent('hospital:server:RestoreWeaponDamage')
AddEventHandler('hospital:server:RestoreWeaponDamage', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	PlayerWeaponWounds[Player.PlayerData.source] = nil
end)

RegisterServerEvent('hospital:server:SetDeathStatus')
AddEventHandler('hospital:server:SetDeathStatus', function(isDead)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Player ~= nil then
		Player.Functions.SetMetaData("isdead", isDead)
	end
end)

RegisterServerEvent('hospital:server:SetArmor')
AddEventHandler('hospital:server:SetArmor', function(amount)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Player ~= nil then
		Player.Functions.SetMetaData("armor", amount)
	end
end)

RegisterServerEvent('hospital:server:TreatWounds')
AddEventHandler('hospital:server:TreatWounds', function(playerId)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local Patient = QBCore.Functions.GetPlayer(playerId)
	if Patient ~= nil then
		if Player.PlayerData.job.name == "ems3" or Player.PlayerData.job.name == "ems4" or Player.PlayerData.job.name == "ems5" or Player.PlayerData.job.name == "ems6" or Player.PlayerData.job.name == "ems7" or Player.PlayerData.job.name == "ems8"  then
			TriggerClientEvent("hospital:client:HealInjuries", Patient.PlayerData.source, "partial")
		elseif Player.PlayerData.job.name == "ems" or Player.PlayerData.job.name == "ems1" or Player.PlayerData.job.name == "ems2" then
			TriggerClientEvent("hospital:client:HealInjuries", Patient.PlayerData.source, "full")
		end
	end
end)

RegisterServerEvent('hospital:server:SetDoctor')
AddEventHandler('hospital:server:SetDoctor', function()
	local amount = 0
	for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then 
            if (Player.PlayerData.job.name == "ems" or Player.PlayerData.job.name == "ems1" or Player.PlayerData.job.name == "ems2" or Player.PlayerData.job.name == "ems3" or Player.PlayerData.job.name == "ems4" or Player.PlayerData.job.name == "ems5" and Player.PlayerData.job.onduty) then
                amount = amount + 1
            end
        end
	end
	TriggerClientEvent("hospital:client:SetDoctorCount", -1, amount)
end)

RegisterServerEvent('hospital:server:RevivePlayer')
AddEventHandler('hospital:server:RevivePlayer', function(playerId, isOldMan)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local Patient = QBCore.Functions.GetPlayer(playerId)
	local oldMan = isOldMan ~= nil and isOldMan or false
	if Patient ~= nil then
		if oldMan then
			if Player.Functions.RemoveMoney("cash", 5000, "revived-player") then
				TriggerClientEvent('hospital:client:Revive', Patient.PlayerData.source)
			else
				TriggerClientEvent('QBCore:Notify', src, "You don't have enough money in your pocket..", "error")
			end
		else
			TriggerClientEvent('hospital:client:Revive', Patient.PlayerData.source)
		end
	end
end)

RegisterServerEvent('hospital:server:SendDoctorAlert')
AddEventHandler('hospital:server:SendDoctorAlert', function()
	local src = source
	for k, v in pairs(QBCore.Functions.GetPlayers()) do
		local Player = QBCore.Functions.GetPlayer(v)
		if Player ~= nil then 
			if (Player.PlayerData.job.name == "ems" or Player.PlayerData.job.name == "ems1" or Player.PlayerData.job.name == "ems2" or Player.PlayerData.job.name == "ems3" or Player.PlayerData.job.name == "ems4" or Player.PlayerData.job.name == "ems5" or Player.PlayerData.job.name == "ems6" or Player.PlayerData.job.name == "ems7" or Player.PlayerData.job.name == "ems8" and Player.PlayerData.job.onduty) then
				TriggerClientEvent("hospital:client:SendAlert", v, "A Medical Person is needed at Pillbox Hospital")
			end
		end
	end
end)

RegisterServerEvent('hospital:server:MakeDeadCall')
AddEventHandler('hospital:server:MakeDeadCall', function(blipSettings, gender, street1, street2)
	local src = source
	local genderstr = "Mr."

	if gender == 1 then genderstr = "Mrs." end

	if street2 ~= nil then
		TriggerClientEvent("911:client:SendAlert", -1, "A ".. genderstr .." is injured at " ..street1 .. " "..street2, blipSettings)
	else
		TriggerClientEvent("911:client:SendAlert", -1, "A ".. genderstr .." is injured at "..street1, blipSettings)
	end
end)

QBCore.Functions.CreateCallback('hospital:GetDoctors', function(source, cb)
	local amount = 0
	for k, v in pairs(QBCore.Functions.GetPlayers()) do
		local Player = QBCore.Functions.GetPlayer(v)
		if Player ~= nil then 
			if (Player.PlayerData.job.name == "ems" and Player.PlayerData.job.onduty) then
				amount = amount + 1
			end
		end
	end
	cb(amount)
end)


function GetCharsInjuries(source)
    return PlayerInjuries[source]
end

function GetActiveInjuries(source)
	local injuries = {}
	if (PlayerInjuries[source].isBleeding > 0) then
		injuries["BLEED"] = PlayerInjuries[source].isBleeding
	end
	for k, v in pairs(PlayerInjuries[source].limbs) do
		if PlayerInjuries[source].limbs[k].isDamaged then
			injuries[k] = PlayerInjuries[source].limbs[k]
		end
	end
    return injuries
end


QBCore.Functions.CreateCallback('hospital:GetPlayerStatus', function(source, cb, playerId)
	local Player = QBCore.Functions.GetPlayer(playerId)
	local injuries = {}
	injuries["WEAPONWOUNDS"] = {}
	if Player ~= nil then
		if PlayerInjuries[Player.PlayerData.source] ~= nil then
			if (PlayerInjuries[Player.PlayerData.source].isBleeding > 0) then
				injuries["BLEED"] = PlayerInjuries[Player.PlayerData.source].isBleeding
			end
			for k, v in pairs(PlayerInjuries[Player.PlayerData.source].limbs) do
				if PlayerInjuries[Player.PlayerData.source].limbs[k].isDamaged then
					injuries[k] = PlayerInjuries[Player.PlayerData.source].limbs[k]
				end
			end
		end
		if PlayerWeaponWounds[Player.PlayerData.source] ~= nil then 
			for k, v in pairs(PlayerWeaponWounds[Player.PlayerData.source]) do
				injuries["WEAPONWOUNDS"][k] = v
			end
		end
	end
    cb(injuries)
end)

QBCore.Functions.CreateCallback('hospital:GetPlayerBleeding', function(source, cb)
	local src = source
	if PlayerInjuries[src] ~= nil and PlayerInjuries[src].isBleeding ~= nil then
		cb(PlayerInjuries[src].isBleeding)
	else
		cb(nil)
	end
end)

QBCore.Commands.Add("status", "Check health of a player ", {}, false, function(source, args)
	local Player = QBCore.Functions.GetPlayer(source)
	if (PlayerJob.name == "ems" or PlayerJob.name == "ems1" or PlayerJob.name == "ems2" or PlayerJob.name == "ems3" or PlayerJob.name == "ems4" or PlayerJob.name == "ems5" or PlayerJob.name == "ems6" or PlayerJob.name == "ems7" or PlayerJob.name == "ems8") and onDuty then
		TriggerClientEvent("hospital:client:CheckStatus", source)
	else
		TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "This command is for emergency services!")
	end
end)

QBCore.Commands.Add("heal", "Heal a player", {}, false, function(source, args)
	local Player = QBCore.Functions.GetPlayer(source)
	if (PlayerJob.name == "ems" or PlayerJob.name == "ems1" or PlayerJob.name == "ems2" or PlayerJob.name == "ems3" or PlayerJob.name == "ems4" or PlayerJob.name == "ems5" or PlayerJob.name == "ems6" or PlayerJob.name == "ems7" or PlayerJob.name == "ems8") and onDuty then
		TriggerClientEvent("hospital:client:TreatWounds", source)
	else
		TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "This command is for emergency services!")
	end
end)

QBCore.Commands.Add("revivep", "revive a player", {}, false, function(source, args)
	local Player = QBCore.Functions.GetPlayer(source)
	if (PlayerJob.name == "ems" or PlayerJob.name == "ems1" or PlayerJob.name == "ems2" or PlayerJob.name == "ems3" or PlayerJob.name == "ems4" or PlayerJob.name == "ems5" or PlayerJob.name == "ems6" or PlayerJob.name == "ems7" or PlayerJob.name == "ems8") and onDuty then
		TriggerClientEvent("hospital:client:RevivePlayer", source)
	else
		TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "This command is for emergency services!")
	end
end)

QBCore.Commands.Add("revive", "Revive a player or yourseld", {{name="id", help="Player ID (may be empty)"}}, false, function(source, args)
	if args[1] ~= nil then
		local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
		if Player ~= nil then
			TriggerClientEvent('hospital:client:Revive', Player.PlayerData.source)
		else
			TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Player is not online!")
		end
	else
		TriggerClientEvent('hospital:client:Revive', source)
	end
end, "admin")

QBCore.Commands.Add("setpain", "Set pain to a player or yourself", {{name="id", help="Player ID (may be empty)"}}, false, function(source, args)
	if args[1] ~= nil then
		local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
		if Player ~= nil then
			TriggerClientEvent('hospital:client:SetPain', Player.PlayerData.source)
		else
			TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Player is not online!")
		end
	else
		TriggerClientEvent('hospital:client:SetPain', source)
	end
end, "god")

QBCore.Commands.Add("kill", "Kill al player or yourself", {{name="id", help="Player ID (may be empty)"}}, false, function(source, args)
	if args[1] ~= nil then
		local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
		if Player ~= nil then
			TriggerClientEvent('hospital:client:KillPlayer', Player.PlayerData.source)
		else
			TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Player is not online!")
		end
	else
		TriggerClientEvent('hospital:client:KillPlayer', source)
	end
end, "god")

QBCore.Commands.Add("setems8", "Give the EMS Trainee job to someone ", {{name="id", help="Player ID"}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local Myself = QBCore.Functions.GetPlayer(source)
    if Player ~= nil then 
        if ((Myself.PlayerData.job.name == "ems8" or Myself.PlayerData.job.name == "ems") and Myself.PlayerData.job.onduty) and IsHighCommand(Myself.PlayerData.citizenid) then
            Player.Functions.SetJob("ems8")
        end
    end
end)

QBCore.Commands.Add("setems7", "Give the EMS Advanced job to someone ", {{name="id", help="Player ID"}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local Myself = QBCore.Functions.GetPlayer(source)
    if Player ~= nil then 
        if ((Myself.PlayerData.job.name == "ems7" or Myself.PlayerData.job.name == "ems") and Myself.PlayerData.job.onduty) and IsHighCommand(Myself.PlayerData.citizenid) then
            Player.Functions.SetJob("ems7")
        end
    end
end)

QBCore.Commands.Add("setems6", "Give the EMS Sergeant job to someone ", {{name="id", help="Player ID"}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local Myself = QBCore.Functions.GetPlayer(source)
    if Player ~= nil then 
        if ((Myself.PlayerData.job.name == "ems6" or Myself.PlayerData.job.name == "ems") and Myself.PlayerData.job.onduty) and IsHighCommand(Myself.PlayerData.citizenid) then
            Player.Functions.SetJob("ems6")
        end
    end
end)

QBCore.Commands.Add("setems5", "Give the Lead Paramedic job to someone ", {{name="id", help="Player ID"}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local Myself = QBCore.Functions.GetPlayer(source)
    if Player ~= nil then 
        if ((Myself.PlayerData.job.name == "ems5" or Myself.PlayerData.job.name == "ems") and Myself.PlayerData.job.onduty) and IsHighCommand(Myself.PlayerData.citizenid) then
            Player.Functions.SetJob("ems5")
        end
    end
end)

QBCore.Commands.Add("setems4", "Give the EMS Captain job to someone ", {{name="id", help="Player ID"}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local Myself = QBCore.Functions.GetPlayer(source)
    if Player ~= nil then 
        if ((Myself.PlayerData.job.name == "ems4" or Myself.PlayerData.job.name == "ems") and Myself.PlayerData.job.onduty) and IsHighCommand(Myself.PlayerData.citizenid) then
            Player.Functions.SetJob("ems4")
        end
    end
end)

QBCore.Commands.Add("setems3", "Give the EMS Supervisor job to someone ", {{name="id", help="Player ID"}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local Myself = QBCore.Functions.GetPlayer(source)
    if Player ~= nil then 
        if ((Myself.PlayerData.job.name == "ems3" or Myself.PlayerData.job.name == "ems") and Myself.PlayerData.job.onduty) and IsHighCommand(Myself.PlayerData.citizenid) then
            Player.Functions.SetJob("ems3")
        end
    end
end)

QBCore.Commands.Add("setems2", "Give the EMS Assistant Chief job to someone ", {{name="id", help="Player ID"}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local Myself = QBCore.Functions.GetPlayer(source)
    if Player ~= nil then 
        if ((Myself.PlayerData.job.name == "ems2" or Myself.PlayerData.job.name == "ems") and Myself.PlayerData.job.onduty) and IsHighCommand(Myself.PlayerData.citizenid) then
            Player.Functions.SetJob("ems2")
        end
    end
end)

-- QBCore.Commands.Add("setambulance", "Give the ambulance job to someone ", {{name="id", help="Player ID"}}, true, function(source, args)
--     local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
--     local Myself = QBCore.Functions.GetPlayer(source)
--     if Player ~= nil then 
--         if ((Myself.PlayerData.job.name == "ambulance" or Myself.PlayerData.job.name == "doctor") and Myself.PlayerData.job.onduty) and IsHighCommand(Myself.PlayerData.citizenid) then
--             Player.Functions.SetJob("ambulance")
--         end
--     end
-- end)

-- QBCore.Commands.Add("setdoctor", "Geef de doctor baan aan iemand ", {{name="id", help="Player ID"}}, true, function(source, args)
--     local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
--     local Myself = QBCore.Functions.GetPlayer(source)
--     if Player ~= nil then 
--         if ((Myself.PlayerData.job.name == "ambulance" or Myself.PlayerData.job.name == "doctor") and Myself.PlayerData.job.onduty) and IsHighCommand(Myself.PlayerData.citizenid) then
--             Player.Functions.SetJob("doctor")
--         end
--     end
-- end)

QBCore.Functions.CreateUseableItem("bandage", function(source, item)
	local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName(item.name) ~= nil then
		TriggerClientEvent("hospital:client:UseBandage", source)
	end
end)

QBCore.Functions.CreateUseableItem("painkillers", function(source, item)
	local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName(item.name) ~= nil then
		TriggerClientEvent("hospital:client:UsePainkillers", source)
	end
end)

function IsHighCommand(citizenid)
    local retval = false
    for k, v in pairs(Config.Whitelist) do
        if v == citizenid then
            retval = true
        end
    end
    return retval
end