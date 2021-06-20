local QBCore = nil
local PlayerData = nil

local PlayerJob = {}

Citizen.CreateThread(function() 
    while QBCore == nil do
		TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)    
		Citizen.Wait(200)
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    PlayerJob = QBCore.Functions.GetPlayerData().job
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)


CreateThread(function()
    while true do
        pedId = PlayerPedId()
        plyId = PlayerId()
        Wait(5000)
    end
end)

CreateThread(function()
    while true do
        if pedId then
            GLOBAL_COORDS = GetEntityCoords(pedId)
        end
        Wait(200)
    end
end)

liquid = false

CreateThread(function()
    while GLOBAL_COORDS == nil do Wait(100); end
    while true do
        local sleep = 1
        local active = false
        
        local claimMarker = vector3(Config.Locations['claim'].x, Config.Locations['claim'].y, Config.Locations['claim'].z)
        local claimMarkerdis = #(GLOBAL_COORDS - claimMarker)
		if claimMarkerdis < 1.5 then
			active = true
			DrawMarker(2, Config.Locations['claim'].x, Config.Locations['claim'].y, Config.Locations['claim'].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
            DrawText3D(Config.Locations['claim'].x, Config.Locations['claim'].y, Config.Locations['claim'].z, "~p~E~w~ - Claim your order here")
            if IsControlJustReleased(0, 38) then
                TriggerServerEvent("inventory:server:OpenInventory", "stash", "claimorder", {
                    maxweight = 4000000,
                    slots = 10,
                })
                TriggerEvent("inventory:client:SetCurrentStash", "claimorder")
            end
		end
        
        if PlayerJob.name == 'vanilla' then
            local shopMarker = vector3(Config.Locations['shop'].x, Config.Locations['shop'].y, Config.Locations['shop'].z)
            local shopMarkerdis = #(GLOBAL_COORDS - shopMarker)
            if shopMarkerdis < 3.0 then
                active = true
				DrawMarker(2, Config.Locations['shop'].x, Config.Locations['shop'].y, Config.Locations['shop'].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
                if shopMarkerdis < 1.5 then
					DrawText3D(Config.Locations['shop'].x, Config.Locations['shop'].y, Config.Locations['shop'].z, "~p~E~w~ - Shop")
					if IsControlJustReleased(0, 38) then
						TriggerServerEvent("inventory:server:OpenInventory", "shop", "vanilla", Config.Items)
					end
				end
			end
            
            local vipMarker = vector3(Config.Locations['vip'].x, Config.Locations['vip'].y, Config.Locations['vip'].z)
            local vipMarkerdis = #(GLOBAL_COORDS - vipMarker)
            if vipMarkerdis < 3.0 and PlayerJob.isboss then
                active = true
				DrawMarker(2, Config.Locations['vip'].x, Config.Locations['vip'].y, Config.Locations['vip'].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
                if vipMarkerdis < 1.5 and PlayerJob.isboss then
					DrawText3D(Config.Locations['vip'].x, Config.Locations['vip'].y, Config.Locations['vip'].z, "~p~E~w~ - VIP Shop")
					if IsControlJustReleased(0, 38) then
						TriggerServerEvent("inventory:server:OpenInventory", "shop", "vanillaboss", Config.BossItems)
					end
				end  
			end
            
            local bossMarker = vector3(Config.Locations['boss'].x, Config.Locations['boss'].y, Config.Locations['boss'].z)
            local bossMarkerdis = #(GLOBAL_COORDS - bossMarker)
            if bossMarkerdis < 3.0 and PlayerJob.isboss then
                active = true
                DrawMarker(2, Config.Locations['boss'].x, Config.Locations['boss'].y, Config.Locations['boss'].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
                if bossMarkerdis < 1.5 and PlayerJob.isboss then
                    DrawText3D(Config.Locations['boss'].x, Config.Locations['boss'].y, Config.Locations['boss'].z, "~p~E~w~ - Boss Menu")
                    if IsControlJustReleased(0, 38) then
                        TriggerServerEvent("cash_bossmenu:server:openMenu")
                    end
                end  
            end
            
            local stripperMarker = vector3(Config.Locations['stripper'].x, Config.Locations['stripper'].y, Config.Locations['stripper'].z)
            local stripperMarkerdis = #(GLOBAL_COORDS - stripperMarker)
            if stripperMarkerdis < 3.0 and PlayerJob.isboss then
                active = true
                DrawMarker(2, Config.Locations['stripper'].x, Config.Locations['stripper'].y, Config.Locations['stripper'].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
                if stripperMarkerdis < 1.5 and PlayerJob.isboss then
                    DrawText3D(Config.Locations['stripper'].x, Config.Locations['stripper'].y, Config.Locations['stripper'].z, "~p~E~w~ - Stripper Bitches")
                    if IsControlJustReleased(0, 38) then
						Progressbar(5000,"Calling In Strippers")
						TriggerEvent("strippers:spawn")
						TriggerEvent("DoShortHudText", 'Stripper Bitches are here!')
                    end
                end  
            end

            if Config['PoleDance']['Enabled'] then
                for k, v in pairs(Config['PoleDance']['Locations']) do
                    if #(GetEntityCoords(PlayerPedId()) - v['Position']) <= 1.0 then
                        active = true
                        DrawText3D(v['Position'].x, v['Position'].y, v['Position'].z, "~p~E~w~ - Pole dance")
                        if IsControlJustReleased(0, 51) and not liquid then
						    liquid = true
                            LoadDict('mini@strip_club@pole_dance@pole_dance' .. v['Number'])
                            local scene = NetworkCreateSynchronisedScene(v['Position'], vector3(0.0, 0.0, 0.0), 2, false, false, 1065353216, 0, 1.3)
                            NetworkAddPedToSynchronisedScene(PlayerPedId(), scene, 'mini@strip_club@pole_dance@pole_dance' .. v['Number'], 'pd_dance_0' .. v['Number'], 1.5, -4.0, 1, 1, 1148846080, 0)
                            NetworkStartSynchronisedScene(scene)
						elseif IsControlJustReleased(0, 51) and liquid then
                            liquid = false
                            ClearPedTasksImmediately(PlayerPedId())
                        end
                    end
                end
            end
        end

        if not active then
            sleep = 2000
        end

        Wait(sleep)
	end
end)

function Progressbar(duration, label)
	local retval = nil
	QBCore.Functions.Progressbar("stripclub", label, duration, false, false, {
		disableMovement = false,
		disableCarMovement = false,
		disableMouse = false,
		disableCombat = false,
	}, {}, {}, {}, function()
		retval = true
	end, function()
		retval = false
	end)

	while retval == nil do
		Wait(1)
	end

	return retval
end

local stripperbitchhh = {
  { model="s_f_y_stripper_02", x=109.78167724609, y=-1288.6130371094, z=28.45419883728, a=302.54, animation="mini@strip_club@private_dance@idle", animationName="priv_dance_idle"},
  { model="s_f_y_stripper_02", x=108.56563568115, y=-1285.5646972656, z=28.454189300537, a=286.47, animation="mini@strip_club@lap_dance@ld_girl_a_song_a_p1", animationName="ld_girl_a_song_a_p1_f"},
  { model="s_f_y_stripper_01", x=104.66233825684, y=-1289.1970214844, z=28.854095458984, a=286.68, animation="mini@strip_club@private_dance@part2", animationName="priv_dance_p2"},
  { model="s_f_y_stripper_02", x=100.53195953369, y=-1294.5765380859, z=29.254007339478, a=293.42, animation="mini@strip_club@private_dance@part1", animationName="priv_dance_p1"},
  { model="s_f_y_stripper_02", x=98.377563476562, y=-1291.0877685547, z=29.254007339478, a=293.99, animation="mini@strip_club@lap_dance@ld_girl_a_song_a_p1", animationName="ld_girl_a_song_a_p1_f"},
  { model="s_f_y_stripper_01", x=101.06844329834, y=-1291.5778808594, z=29.254007339478, a=291.4, animation="mini@strip_club@private_dance@idle", animationName="priv_dance_idle"},
}

RegisterNetEvent('strippers:spawn')
AddEventHandler('strippers:spawn', function(spawned)
	if not spawned then
			for k,v in ipairs(stripperbitchhh) do
			RequestModel(GetHashKey(v.model))
			while not HasModelLoaded(GetHashKey(v.model)) do
				Wait(0)
			end
			RequestAnimDict(v.animation)
			while not HasAnimDictLoaded(v.animation) do
				Wait(1)
			end
			local stripperbitch = CreatePed(4, GetHashKey(v.model), v.x, v.y, v.z, v.a, true, true)
			TaskSetBlockingOfNonTemporaryEvents(stripperbitch, true)
			SetPedFleeAttributes(stripperbitch, 0, 0)
			SetPedCombatAttributes(stripperbitch, 17, 1)
			SetAmbientVoiceName(stripperbitch, v.voice)
			SetPedSeeingRange(stripperbitch, 0.0)
    		SetPedHearingRange(stripperbitch, 0.0)
    		SetPedAlertness(stripperbitch, 0)
    		SetPedKeepTask(stripperbitch, true)
			SetEntityInvincible(stripperbitch, true)

			TaskPlayAnim(stripperbitch, v.animation, v.animationName, 8.0, 0.0, -1, 1, 0, 0, 0, 0)
			SetModelAsNoLongerNeeded(GetHashKey(v.model))
		end
	end
end)

CreateThread(function()
    while true do
        Wait(1)
        local plyCoords = GetEntityCoords(PlayerPedId(), 0)
        local distance = #(vector3(111.32199859619,-1285.8576660156,28.256683349609) - plyCoords)
        if distance < 2 then
            if not IsPedInAnyVehicle(PlayerPedId(), true) then
                if distance < 2 then
                    DrawText3D(111.32199859619,-1285.8576660156,28.256683349609, '~p~[E]~w~ Make It Rain (500$)')
					if IsControlJustReleased(0, 38) then 
						LoadDict("anim@mp_player_intcelebrationfemale@raining_cash") 
						TaskPlayAnim( PlayerPedId(), "anim@mp_player_intcelebrationfemale@raining_cash", "raining_cash", 8.0 , -1 , -1 , 0 , 0 , false , false , false)
						Wait(2000)
						TriggerServerEvent('stripclubstack:pay')     
						DeleteEntity(cash)
                    end
                end
            end
        else
            Wait(500)
        end
    end
end)

CreateThread(function()
    while true do
        Wait(1)
        local plyCoords = GetEntityCoords(PlayerPedId(), 0)
        local distance = #(vector3(129.16831970215,-1287.8800048828,29.255498886108) - plyCoords)
		if PlayerData and PlayerData.job.name == 'vanilla' then
			--
		else
			if distance < 1 then
				if not IsPedInAnyVehicle(PlayerPedId(), true) then
					if distance < 1 then
						DrawText3D(129.16831970215,-1287.8800048828,29.255498886108, '~p~[E]~w~ Entry Fee (1000$)')
						if IsControlJustReleased(0, 38) then 
							TriggerServerEvent('paystripclub:pay')
							TriggerEvent('animations:client:EmoteCommandStart', {"id"})
							Progressbar(2500,"Paying...")
						end
					end
				end
			else
				Wait(500)
			end
		end
    end
end)

function Progressbar(duration, label)
	local retval = nil
	QBCore.Functions.Progressbar("strip", label, duration, false, false, {
		disableMovement = false,
		disableCarMovement = false,
		disableMouse = false,
		disableCombat = false,
	}, {}, {}, {}, function()
		retval = true
	end, function()
		retval = false
	end)

	while retval == nil do
		Wait(1)
	end

	return retval
end


LoadDict = function(Dict)
    while not HasAnimDictLoaded(Dict) do 
        Wait(0)
        RequestAnimDict(Dict)
    end
end

function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

CreateThread(function()
    while (true) do
		ClearAreaOfVehicles(141.71, -1322.01, 29.21, 5.0, false, false, false, false, false);
		ClearAreaOfPeds(115.12, -1285.75, 28.26, 15.0, 1)
        Wait(1)
    end
end)

RegisterNetEvent("strippers:mail")
AddEventHandler("strippers:mail", function(mailData)
    if PlayerData and PlayerData.job.name == 'vanilla' then
        TriggerServerEvent('qb-phone:server:sendNewMail', mailData)
    end
end)

RegisterNetEvent("strippers:updateStrippers")
AddEventHandler("strippers:updateStrippers", function(data)
    Config.Strippers['locations'] = data
end)

RegisterNetEvent("strippers:place")
AddEventHandler("strippers:place", function(index)
    local index = index ~= nil and index or GetClosestLocation()
    local location = Config.Strippers['locations'][index]
    if index and location and location['model'] == nil then
        local model = Config.Strippers['peds'][math.random(#Config.Strippers['peds'])]
        local hash = GetHashKey(model)
        local anim = 'timetable@reunited@ig_10'
        local dict = 'base_amanda'

        -- Loads model
        RequestModel(hash)
        while not HasModelLoaded(hash) do
          Wait(1)
        end
    
        -- Loads animation
        RequestAnimDict(anim)
        while not HasAnimDictLoaded(anim) do
          Wait(1)
        end
    
        -- Creates ped when everything is loaded
        local ped = CreatePed(4, hash, location.sit.x, location.sit.y, location.sit.z, location.sit[4], true, true)
        SetEntityHeading(ped, location.sit[4])
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        TaskPlayAnim(ped,anim,dict, 8.0, 0.0, -1, 1, 0, 0, 0, 0)

        Config.Strippers['locations'][index]['model'] = model
        TriggerServerEvent("strippers:updateStrippers", Config.Strippers['locations'])
    end
end)

function GetClosestLocation()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local lastDistance = nil
    local lastLocation = nil
    for k,v in pairs(Config.Strippers['locations']) do
        local distance = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.sit.x, v.sit.y, v.sit.z, true)
        if distance < 2 and (lastDistance == nil or distance < lastDistance) then
            lastDistance = distance
            lastLocation = k
        end
    end
    
    return lastLocation
end

local CurrentDanceIndex = 1
local Dances = {
    {"mp_safehouse", "lap_dance_girl"},
    {"mini@strip_club@private_dance@idle", "priv_dance_idle"},
    {"mini@strip_club@private_dance@part3", "priv_dance_p3"},
}

CreateThread(function()
    local serverID = GetPlayerServerId(PlayerId())

    while true do
        local plyPed = PlayerPedId()
        local coords = GetEntityCoords(plyPed)
        local letSleep = true
        local k = GetClosestLocation()
        local v = Config.Strippers['locations'][k]
        if k and v then
            if v.model ~= nil and v.taken == 0 then
                local distance = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.sit.x, v.sit.y, v.sit.z, true)
                if distance < 1.5 then
                    letSleep = false
                    local msg = "Press ~p~E~w~ to interact"
                    if PlayerData and PlayerData.job.name == 'vanilla' then
                        msg = msg .. '\nPress ~p~K~w~ to change ped'
                        msg = msg .. '\nPress ~p~BACKSPACE~w~ to delete ped'
                    end
                    ShowHelpNotification(msg)
                    if IsControlJustPressed(0,38) then
                        local ped = GetClosestNPC(v.model)
                        DoScreenFadeOut(500)
                        Wait(1000)
                        ClearPedTasksImmediately(ped)
                        ClearPedTasksImmediately(PlayerPedId())
                        SetEntityCoords(ped, v.stand.x, v.stand.y, v.stand.z)
                        SetEntityHeading(ped, v.stand[4])
                        Wait(200)
                        SetEntityCoords(PlayerPedId(), v.sit.x, v.sit.y, v.sit.z)
                        SetEntityHeading(PlayerPedId(), v.sit[4])

                        -- Loads animation
                        RequestAnimDict('timetable@ron@ig_5_p3')
                        while not HasAnimDictLoaded('timetable@ron@ig_5_p3') do
                            Wait(1)
                        end

                        Wait(200)

                        Config.Strippers['locations'][k]['taken'] = serverID
                        TriggerServerEvent("strippers:updateStrippers", Config.Strippers['locations'])
                        DoScreenFadeIn(500)

                        while Config.Strippers['locations'][k]['taken'] == serverID and DoesEntityExist(ped) do
                            Wait(1)

                            DisableControlAction(0, 38, true)
                            DisableControlAction(0, 77, true)
                            DisableControlAction(0, 244, true)
                            DisableControlAction(0, 246, true)
                            DisableControlAction(0, 249, true)
                            DisableControlAction(0, 45, true)
                            DisableControlAction(0, 288, true)
                            DisableControlAction(0, 289, true)
                            DisableControlAction(0, 157, true)
                            DisableControlAction(0, 158, true)
                            DisableControlAction(0, 160, true)
                            DisableControlAction(0, 164, true)
                            DisableControlAction(0, 165, true)
                            DisableControlAction(0, 159, true)
                            DisableControlAction(0, 161, true)
                            DisableControlAction(0, 162, true)

                            local msg = "Press ~p~E~w~ to change dance (" .. CurrentDanceIndex .. "/" .. #Dances .. ")"
                            msg = msg .. '\n Press ~p~BACKSPACE~w~ to stop dance'
                            ShowHelpNotification(msg)

                            if not IsEntityPlayingAnim(PlayerPedId(), 'timetable@ron@ig_5_p3', 'ig_5_p3_base', 3) then
                                ClearPedTasks(PlayerPedId())
                                TaskPlayAnim(PlayerPedId(),'timetable@ron@ig_5_p3',"ig_5_p3_base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
                            end

                            if Dances[CurrentDanceIndex] and not IsEntityPlayingAnim(ped, Dances[CurrentDanceIndex][1], Dances[CurrentDanceIndex][2], 3) then
                                CreateThread(function()
                                    RequestAnimDict(Dances[CurrentDanceIndex][1])
                                    while not HasAnimDictLoaded(Dances[CurrentDanceIndex][1]) do
                                        Wait(100)
                                    end

                                    ClearPedTasks(ped)
                                    Wait(150)

                                    TaskPlayAnim(ped,Dances[CurrentDanceIndex][1],Dances[CurrentDanceIndex][2], 8.0, 0.0, -1, 1, 0, 0, 0, 0)
                                end)
                            end

                            if IsDisabledControlJustPressed(0,38) then
                                DoScreenFadeOut(500)
                                CurrentDanceIndex = CurrentDanceIndex == #Dances and 1 or CurrentDanceIndex+1
                                Wait(1200)
                                DoScreenFadeIn(500)
                            elseif IsDisabledControlJustPressed(0,194) then
                                ClearPedTasksImmediately(PlayerPedId())
                                StopAnimTask(PlayerPedId(), 'timetable@ron@ig_5_p3', 'ig_5_p3_base', 1.0)
                                break
                            end
                        end
                        
                        DoScreenFadeOut(500)
                        Wait(500)
                        if DoesEntityExist(ped) then
                            TriggerServerEvent("strippers:serverDeletePed", v.model, GetEntityCoords(ped))
                        end
                        
                        ClearPedTasksImmediately(PlayerPedId())
                        StopAnimTask(PlayerPedId(), 'timetable@ron@ig_5_p3', 'ig_5_p3_base', 1.0)
                        Config.Strippers['locations'][k]['taken'] = 0
                        Config.Strippers['locations'][k]['model'] = nil
                        TriggerServerEvent("strippers:updateStrippers", Config.Strippers['locations'])
                        Wait(500)
                        DoScreenFadeIn(500)
                        TriggerEvent("dpemotes:WalkCommandStart")
                    elseif PlayerData and PlayerData.job.name == 'vanilla' then
                        if IsControlJustPressed(0,194) then
                            local ped = GetClosestNPC(v.model)
                            if DoesEntityExist(ped) then
                                TriggerServerEvent("strippers:serverDeletePed", v.model, GetEntityCoords(ped))
                            end

                            ClearPedTasksImmediately(PlayerPedId())
                            Config.Strippers['locations'][k]['taken'] = 0
                            Config.Strippers['locations'][k]['model'] = nil
                            TriggerServerEvent("strippers:updateStrippers", Config.Strippers['locations'])
                        elseif IsControlJustPressed(0,311) then
                            local ped = GetClosestNPC(v.model)
                            if DoesEntityExist(ped) then
                                TriggerServerEvent("strippers:serverDeletePed", v.model, GetEntityCoords(ped))
                            end

                            Config.Strippers['locations'][k]['model'] = Config.Strippers['peds'][math.random(#Config.Strippers['peds'])]
                            local location = Config.Strippers['locations'][k]
                            local hash = location['model']
                            local anim = 'timetable@reunited@ig_10'
                            local dict = 'base_amanda'

                            -- Loads model
                            RequestModel(hash)
                            while not HasModelLoaded(hash) do
                                Wait(1)
                            end
                        
                            -- Loads animation
                            RequestAnimDict(anim)
                            while not HasAnimDictLoaded(anim) do
                                Wait(1)
                            end
                        
                            -- Creates ped when everything is loaded
                            local ped = CreatePed(2, hash, location.sit.x, location.sit.y, location.sit.z, location.sit[4], true, true)
                            SetEntityHeading(ped, location.sit[4])
                            FreezeEntityPosition(ped, true)
                            SetEntityInvincible(ped, true)
                            SetBlockingOfNonTemporaryEvents(ped, true)
                            TaskPlayAnim(ped,anim,dict, 8.0, 0.0, -1, 1, 0, 0, 0, 0)
                            TriggerServerEvent("strippers:updateStrippers", Config.Strippers['locations'])
                        end
                    end
                end
            end
        end

        Wait(letSleep and 1000 or 1)
    end
end)

function ShowHelpNotification(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function GetClosestNPC(model, coords)
    local playerped = PlayerPedId()
    local playerCoords = coords ~= nil and coords or GetEntityCoords(playerped)
    local handle, ped = FindFirstPed()
    local success
    local rped = nil
    local distanceFrom
    repeat
        local pos = GetEntityCoords(ped)
        local distance = #(playerCoords - pos)
        if not IsEntityDead(ped) and distance < 2.0 and (distanceFrom == nil or distance < distanceFrom) and (model == nil or model == GetEntityModel(ped) or GetHashKey(model) == GetEntityModel(ped)) then
            distanceFrom = distance
            rped = ped
        end
        success, ped = FindNextPed(handle)
    until not success
    EndFindPed(handle)
    return rped
end

RegisterNetEvent("strippers:clientDeletePed")
AddEventHandler("strippers:clientDeletePed", function(model, coords)
    local ped = GetClosestNPC(model, coords)
    if DoesEntityExist(ped) then
        DeleteEntity(ped)
    end
end)