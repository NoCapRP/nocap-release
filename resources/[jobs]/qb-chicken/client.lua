QBCore= nil

Citizen.CreateThread(function()
    while QBCore== nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore= obj end)
        Citizen.Wait(200)
    end
end)

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
  }
  


------------------CONFIG----------------------
local startX = 2388.37  --starting
local startY = 5045.8
local startZ = 46.37
---------------------------------------------
local portionX = -95.72   --slaughter
local portionY = 6207.15
local portionZ = 31.03
---
local portionX2 = -100.52   --slaughter
local portionY2 = 6202.48
local portionZ2 = 31.03
---
local packingX = -106.44    --Pack
local packingY = 6204.29
local packingZ = 31.02
---
local packingX2 = -104.20   --Pack
local packingY2 = 6206.45
local packingZ2 = 31.02
---
local sellX = 1469.1856689453    --Sell
local sellY = 6541.2602539062
local sellZ = 14.680911064148

local chicken1
local chicken2
local chicken3
local Caught1 = 0
local Caught2 = 0
local Caught3 = 0
local andsplashed = 0
local share = false
local prop
local zapakowaneDoauta = false
local karton
local mieso
local packs = 0




---------------------
-- Location --
---------------------

-- Citizen --
---------------------

Citizen.CreateThread(function()
    while true do
	Citizen.Wait(0)
		local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
		local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, startX, startY, startZ)
---
		if dist <= 20.0 then
		DrawMarker(27, startX, startY, startZ-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
		else
		Citizen.Wait(1500)
		end
		
		if dist <= 2.5 then
		DrawText3D(startX, startY, startZ, "~g~[E]~w~ To Catch chickens")
		end
--
		if dist <= 0.5 then
			if IsControlJustPressed(0, Keys['E']) then -- "E"
			TriggerServerEvent("qb-chickenjob:startChicken")
			LapChicken()
			end			
		end
	end
end)

Citizen.CreateThread(function()
    while true do
	Citizen.Wait(0)
		local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
		local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, portionX, portionY, portionZ)
		local dist2 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, portionX2, portionY2, portionZ2)
		local distP = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, packingX, packingY, packingZ)
		local distP2 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, packingX2, packingY2, packingZ2)

		if dist <= 25.0 then
		DrawMarker(27, portionX, portionY, portionZ-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
		DrawMarker(27, portionX2, portionY2, portionZ2-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
		DrawMarker(27, packingX, packingY, packingZ-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
		DrawMarker(27, packingX2, packingY2, packingZ2-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
		else
		Citizen.Wait(1500)
		end
		
		if dist <= 2.5 then
		DrawText3D(portionX, portionY, portionZ, "~g~[E]~w~ To slaughter the chicken")
		end

		if dist <= 0.5 then
			if IsControlJustPressed(0, Keys['E']) then -- "E"
				portioning(1)
			end			
		end
		
		if dist2 <= 2.5 then
		DrawText3D(portionX2, portionY2, portionZ2, "~g~[E]~w~ To slaughter the chicken")
		end

		if dist2 <= 0.5 then
			if IsControlJustPressed(0, Keys['E']) then -- "E"
				portioning(2)
			end			
		end
		--
		if distP <= 2.5 and packs == 0 then
		DrawText3D(packingX, packingY, packingZ, "~g~[E]~w~ To pack chicken")
		elseif distP <= 2.5 and packs == 1 then
		DrawText3D(packingX, packingY, packingZ, "~g~[G]~w~ To stop packing")
		DrawText3D(packingX, packingY, packingZ+0.1, "~g~[E]~w~ To keep packing")
		end

		if distP <= 0.5 then
			if IsControlJustPressed(0, Keys['E']) then 
			packingg(1)
			elseif IsControlJustPressed(0, Keys['G']) then
			packed(1)
			end			
		end
		
		if distP2 <= 2.5 and packs == 0 then
		DrawText3D(packingX2, packingY2, packingZ2, "~g~[E]~w~ To pack chicken")
		elseif distP2 <= 2.5 and packs == 1 then
		DrawText3D(packingX2, packingY2, packingZ2, "~g~[G]~w~ To stop packing")
		DrawText3D(packingX2, packingY2, packingZ2+0.1, "~g~[E]~w~ To keep packing")
		end

		if distP2 <= 0.5 then
			if IsControlJustPressed(0, Keys['E']) then -- "E"
			packingg(2)
			elseif IsControlJustPressed(0, Keys['G']) then
			packed(2)
			end		
		end	
	end
end)


Citizen.CreateThread(function()
    while true do
    Citizen.Wait(5)
	local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
    local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, sellX, sellY, sellZ)
	
	if dist <= 20.0 then
	--DrawMarker(0, sellX, sellY, sellZ-0.96, 0, 0, 0, 0, 0, 0, 2.20, 2.20, 2.20, 255, 255, 255, 200, 0, 0, 0, 0)
	else
	Citizen.Wait(1000)
	end
	
	if dist <= 2.0 then
	DrawText3D(sellX, sellY, sellZ+0.1, "[E] Sell Packed Chickens")
		if IsControlJustPressed(0, Keys['E']) then 
		packedsell()
		end	
	end
	
end
end)


-- Code

DrawText3D = function(x, y, z, text)
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



function LapChicken()
	DoScreenFadeOut(500)
	Citizen.Wait(500)
	SetEntityCoordsNoOffset(GetPlayerPed(-1), 2385.963, 5047.333, 46.400, 0, 0, 1)
	RequestModel(GetHashKey('a_c_hen'))
	while not HasModelLoaded(GetHashKey('a_c_hen')) do
	Wait(1)
	end
	chicken1 = CreatePed(26, "a_c_hen", 2370.262, 5052.913, 46.437, 276.351, true, false)
	
	chicken2 = CreatePed(26, "a_c_hen", 2372.040, 5059.604, 46.444, 223.595, true, false)
	chicken3 = CreatePed(26, "a_c_hen", 2379.192, 5062.992, 46.444, 195.477, true, false)
	TaskReactAndFleePed(chicken1, GetPlayerPed(-1))
	TaskReactAndFleePed(chicken2, GetPlayerPed(-1))
	TaskReactAndFleePed(chicken3, GetPlayerPed(-1))
	Citizen.Wait(500)
	DoScreenFadeIn(500)
	share = true
end


function LoadDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Citizen.Wait(10)
    end
end


Citizen.CreateThread(function()
    while true do
    Citizen.Wait(5)
	
if share == true then
	local chicken1Coords = GetEntityCoords(chicken1)
	local chicken2Coords = GetEntityCoords(chicken2)
	local chicken3Coords = GetEntityCoords(chicken3)
	local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
    local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, chicken1Coords.x, chicken1Coords.y, chicken1Coords.z)
	local dist2 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, chicken2Coords.x, chicken2Coords.y, chicken2Coords.z)
	local dist3 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, chicken3Coords.x, chicken3Coords.y, chicken3Coords.z)
	
	if andsplashed == 3 then
	Caught1 = 0
	Caught2 = 0
	Caught3 = 0
	andsplashed = 0
	share = false
	QBCore.Functions.Notify("Take Alived Chiken To Process Area ..", "primary")
	TriggerServerEvent("qb-chickenjob:getNewChicken")
	end
	
	if dist <= 1.0 then
	DrawText3D(chicken1Coords.x, chicken1Coords.y, chicken1Coords.z+0.5, "~o~[E]~b~ Catch the chicken")
		if IsControlJustPressed(0, Keys['E']) then 
		Caught1 = 1
		hewassplashed()
		end	
	elseif dist2 <= 1.0 then
		DrawText3D(chicken2Coords.x, chicken2Coords.y, chicken2Coords.z+0.5, "~o~[E]~b~ Catch the chicken")
		if IsControlJustPressed(0, Keys['E']) then 
		Caught2 = 1
		hewassplashed()
		end	
	elseif dist3 <= 1.0 then
		DrawText3D(chicken3Coords.x, chicken3Coords.y, chicken3Coords.z+0.5, "~o~[E]~b~ Catch the chicken")
		if IsControlJustPressed(0, Keys['E']) then 
		Caught3 = 1
		hewassplashed()
		end	
	end
else
Citizen.Wait(500)
end	
end
end)



function hewassplashed()
	LoadDict('move_jump')
	TaskPlayAnim(GetPlayerPed(-1), 'move_jump', 'dive_start_run', 8.0, -8.0, -1, 0, 0.0, 0, 0, 0)
	Citizen.Wait(600)
	SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
	Citizen.Wait(1000)
	ragdoll = true
	local chanceofsplashes = math.random(1,100)
	if chanceofsplashes <= 60 then
			QBCore.Functions.Notify("You managed to catch 1 chicken!", "success")
			if Caught1 == 1 then
				DeleteEntity(chicken1)
				Caught1 = 0
				andsplashed = andsplashed +1
			elseif Caught2 == 1 then
				DeleteEntity(chicken2)
				Caught2 = 0
				andsplashed = andsplashed +1
			elseif Caught3 == 1 then
				DeleteEntity(chicken3)
				Caught3 = 0
				andsplashed = andsplashed +1
			end
		else
		QBCore.Functions.Notify("The chicken escaped your arms!", "error")
	end
end


function packingg(stanowisko)
	local inventory =  QBCore.Functions.GetPlayerData()
	
	QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
		if result then
			SetEntityHeading(GetPlayerPed(-1), 40.0)
			local PedCoords = GetEntityCoords(GetPlayerPed(-1))
			mieso = CreateObject(GetHashKey('prop_cs_steak'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
			AttachEntityToEntity(mieso, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 0x49D9), 0.15, 0.0, 0.01, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
			karton = CreateObject(GetHashKey('prop_cs_clothes_box'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
			AttachEntityToEntity(karton, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 57005), 0.13, 0.0, -0.16, 250.0, -30.0, 0.0, false, false, false, false, 2, true)
			packs = 1
			LoadDict("anim@heists@ornate_bank@grab_cash_heels")
			TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@grab_cash_heels", "grab", 8.0, -8.0, -1, 1, 0, false, false, false)
			FreezeEntityPosition(GetPlayerPed(-1), true)
			QBCore.Functions.Progressbar("wash-", "Packing..", 30000, false, true, {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			}, {}, {}, {}, function()
			TriggerServerEvent("qb-chickenjob:getpackedChicken",2)
			QBCore.Functions.Notify("Keep packing the chicken or go to the vehicle and store it.", "primary")
			ClearPedTasks(GetPlayerPed(-1))
			DeleteEntity(karton)
			DeleteEntity(mieso)
			end, function() -- Cancel
				--isWashing = false
				ClearPedTasksImmediately(player)
				FreezeEntityPosition(player, false)
			end)
		else
		
		QBCore.Functions.Notify("You have nothing to pack!", "error")
		end
	end, 'slaughteredchicken')
end


function packed(stanowisko)
	FreezeEntityPosition(GetPlayerPed(-1), false)
	zapakowaneDoauta = true
	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
	prop = CreateObject(GetHashKey('hei_prop_heist_box'), x, y, z+0.2,  true,  true, true)
	AttachEntityToEntity(prop, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 60309), 0.025, 0.08, 0.255, -145.0, 290.0, 0.0, true, true, false, true, 1, true)
	packs = 0
	while zapakowaneDoauta do
	Citizen.Wait(250)
	
	local coords    = GetEntityCoords(GetPlayerPed(-1))
	LoadDict('anim@heists@box_carry@')
	
		if not IsEntityPlayingAnim(GetPlayerPed(-1), "anim@heists@box_carry@", "idle", 3 ) and zapakowaneDoauta == true then
		TaskPlayAnim(GetPlayerPed(-1), 'anim@heists@box_carry@', "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
		end
		
		zapakowaneDoauta = false
		QBCore.Functions.Notify("You stopped packing!", "error")
		LoadDict('anim@heists@narcotics@trash')
		TaskPlayAnim(GetPlayerPed(-1), 'anim@heists@narcotics@trash', "throw_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
		Citizen.Wait(900)
		ClearPedTasks(GetPlayerPed(-1))
		DeleteEntity(prop)
	
	end
end


function portioning(position)
	local inventory =  QBCore.Functions.GetPlayerData()
	
	QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
		if result then
			local dict = 'anim@amb@business@coc@coc_unpack_cut_left@'
			LoadDict(dict)
			FreezeEntityPosition(GetPlayerPed(-1),true)
			TaskPlayAnim(GetPlayerPed(-1), dict, "coke_cut_v1_coccutter", 3.0, -8, -1, 63, 0, 0, 0, 0 )
			local PedCoords = GetEntityCoords(GetPlayerPed(-1))
			nozyk = CreateObject(GetHashKey('prop_knife'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
			AttachEntityToEntity(nozyk, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 0xDEAD), 0.13, 0.14, 0.09, 40.0, 0.0, 0.0, false, false, false, false, 2, true)
			if position == 1 then
			SetEntityHeading(GetPlayerPed(-1), 311.0)
			kurczak = CreateObject(GetHashKey('prop_int_cf_chick_01'),-94.87, 6207.008, 30.08, true, true, true)
			SetEntityRotation(kurczak,90.0, 0.0, 45.0, 1,true)
			QBCore.Functions.Progressbar("Cut-", "Slaughtering..", 25000, false, true, {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			}, {}, {}, {}, function()
			
			QBCore.Functions.Notify("Now Pack slaughtered chicken!", "primary")
			TriggerServerEvent("qb-chickenjob:getcutChicken", 1)
			FreezeEntityPosition(GetPlayerPed(-1),false)
			DeleteEntity(kurczak)
			DeleteEntity(nozyk)
			end, function() -- Cancel
				FreezeEntityPosition(GetPlayerPed(-1),false)
				DeleteEntity(kurczak)
				DeleteEntity(nozyk)
				ClearPedTasks(GetPlayerPed(-1))
			end)
			elseif position == 2 then
			SetEntityHeading(GetPlayerPed(-1), 222.0)
			kurczak = CreateObject(GetHashKey('prop_int_cf_chick_01'),-100.39, 6201.56, 29.99, true, true, true)
			SetEntityRotation(kurczak,90.0, 0.0, -45.0, 1,true)

			QBCore.Functions.Progressbar("Cut-", "Slaughtering..", 25000, false, true, {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			}, {}, {}, {}, function()

			QBCore.Functions.Notify("Now Pack slaughtered chicken!", "primary")
			TriggerServerEvent("qb-chickenjob:getcutChicken", 1)
			FreezeEntityPosition(GetPlayerPed(-1),false)
			DeleteEntity(kurczak)
			DeleteEntity(nozyk)
			end, function() -- Cancel
				FreezeEntityPosition(GetPlayerPed(-1),false)
				DeleteEntity(kurczak)
				DeleteEntity(nozyk)
				ClearPedTasks(GetPlayerPed(-1))
			end)
			end
			
		else
			QBCore.Functions.Notify("You dont have any chickens!", "error")
		end
	end, 'alivechicken')
end



function packedsell()
	local inventory =  QBCore.Functions.GetPlayerData()
	QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
		if result then
			local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.9, -0.98))
			prop = CreateObject(GetHashKey('hei_prop_heist_box'), x, y, z,  true,  true, true)
			SetEntityHeading(prop, GetEntityHeading(GetPlayerPed(-1)))
			LoadDict('amb@medic@standing@tendtodead@idle_a')
			TaskPlayAnim(GetPlayerPed(-1), 'amb@medic@standing@tendtodead@idle_a', 'idle_a', 8.0, -8.0, -1, 1, 0.0, 0, 0, 0)
			QBCore.Functions.Progressbar("Cut-", "Selling..", 10000, false, true, {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			}, {}, {}, {}, function()
				TriggerServerEvent("qb-chickenjob:sell",3)
				ClearPedTasks(GetPlayerPed(-1))
				DeleteEntity(prop)
			end, function() -- Cancel
				LoadDict('amb@medic@standing@tendtodead@exit')
				TaskPlayAnim(GetPlayerPed(-1), 'amb@medic@standing@tendtodead@exit', 'exit', 8.0, -8.0, -1, 1, 0.0, 0, 0, 0)
				ClearPedTasks(GetPlayerPed(-1))
				DeleteEntity(prop)
				FreezeEntityPosition(GetPlayerPed(-1),false)
			end)
		else
			QBCore.Functions.Notify("You have nothing to sell!", "error")
		end
	
	end, 'packagedchicken')
end














key_to_teleport = 38

positions = {
{{-72.1, 6266.81, 30.22  , 0}, {-71.18, 6263.58, 30.12, 0},{0,0,0}, "Press [E] To Go in"},

}

-----------------------------------------------------------------------------
-------------------------DO NOT EDIT BELOW THIS LINE-------------------------
-----------------------------------------------------------------------------

local player = GetPlayerPed(-1)

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(5)
        local player = GetPlayerPed(-1)
        local playerLoc = GetEntityCoords(player)

        for _,location in ipairs(positions) do
            teleport_text = location[4]
            loc1 = {
                x=location[1][1],
                y=location[1][2],
                z=location[1][3],
                heading=location[1][4]
            }
            loc2 = {
                x=location[2][1],
                y=location[2][2],
                z=location[2][3],
                heading=location[2][4]
            }
            Red = location[3][1]
            Green = location[3][2]
            Blue = location[3][3]

            DrawMarker(20, loc1.x, loc1.y, loc1.z+1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.601, 1.0001, 0.2001, 0, 0, 200, 200, true, true, 2, true, false, false, false)
            DrawMarker(20, loc2.x, loc2.y, loc2.z+1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.601, 1.0001, 0.2001, 0, 0, 200, 200, true, true, 2, true, false, false, false)

            if CheckPos(playerLoc.x, playerLoc.y, playerLoc.z, loc1.x, loc1.y, loc1.z, 2) then 
                alert(teleport_text)
                
                if IsControlJustReleased(1, key_to_teleport) then
                    if IsPedInAnyVehicle(player, true) then
                        SetEntityCoords(GetVehiclePedIsUsing(player), loc2.x, loc2.y, loc2.z)
                        SetEntityHeading(GetVehiclePedIsUsing(player), loc2.heading)
                    else
                        SetEntityCoords(player, loc2.x, loc2.y, loc2.z)
                        SetEntityHeading(player, loc2.heading)
                    end
                end

            elseif CheckPos(playerLoc.x, playerLoc.y, playerLoc.z, loc2.x, loc2.y, loc2.z, 2) then
                alert(teleport_text)

                if IsControlJustReleased(1, key_to_teleport) then
                    if IsPedInAnyVehicle(player, true) then
                        SetEntityCoords(GetVehiclePedIsUsing(player), loc1.x, loc1.y, loc1.z)
                        SetEntityHeading(GetVehiclePedIsUsing(player), loc1.heading)
                    else
                        SetEntityCoords(player, loc1.x, loc1.y, loc1.z)
                        SetEntityHeading(player, loc1.heading)
                    end
                end
            end            
        end
    end
end)

function CheckPos(x, y, z, cx, cy, cz, radius)
    local t1 = x - cx
    local t12 = t1^2

    local t2 = y-cy
    local t21 = t2^2

    local t3 = z - cz
    local t31 = t3^2

    return (t12 + t21 + t31) <= radius^2
end

function alert(msg)
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end