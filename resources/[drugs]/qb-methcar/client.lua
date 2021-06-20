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
local started = false
local displayed = false
local progress = 0
local CurrentVehicle 
local pause = true
local selection = 0
local quality = 0
--ESX = nil
QBCore = nil

local LastCar
local requiredItemsShowed = false

-- function DisplayHelpText(str)
-- 	SetTextComponentFormat("STRING")
-- 	AddTextComponentString(str)
-- 	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
-- end
-- Citizen.CreateThread(function()
-- 	while ESX == nil do
-- 		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
-- 		Citizen.Wait(0)
-- 	end
-- end)

Citizen.CreateThread(function() 
    while QBCore == nil do
        TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
end)

RegisterNetEvent('qb-methcar:stop')
AddEventHandler('qb-methcar:stop', function()
	QBCore.Functions.Notify('Production stopped...', 'error')
	pause = true
	started = false
	FreezeEntityPosition(LastCar, false)
	SetPedIntoVehicle(GetPlayerPed(-1), CurrentVehicle, -1)
	SetVehicleDoorShut(CurrentVehicle, 2)
end)

RegisterNetEvent('qb-methcar:notify')
AddEventHandler('qb-methcar:notify', function(message)
	--ESX.ShowNotification(message)
	QBCore.Functions.Notify(message)
end)

RegisterNetEvent('qb-methcar:start')
AddEventHandler('qb-methcar:start', function()
	--DisplayHelpText("~g~Starting production")
	QBCore.Functions.Notify('Starting production...', 'success')
	started = true
	FreezeEntityPosition(CurrentVehicle,true)
	displayed = false
	--ESX.ShowNotification("~r~Meth production has started")	
	QBCore.Functions.Notify('Meth Production has started', 'success')
	SetPedIntoVehicle(GetPlayerPed(-1), CurrentVehicle, 3)
	SetVehicleDoorOpen(CurrentVehicle, 2)
end)

RegisterNetEvent('qb-methcar:blowup')
AddEventHandler('qb-methcar:blowup', function(posx, posy, posz)
	AddExplosion(posx, posy, posz + 2,23, 20.0, true, false, 1.0, true)
	if not HasNamedPtfxAssetLoaded("core") then
		RequestNamedPtfxAsset("core")
		while not HasNamedPtfxAssetLoaded("core") do
			Citizen.Wait(1)
		end
	end
	SetPtfxAssetNextCall("core")
	local fire = StartParticleFxLoopedAtCoord("en_ray_heli_aprtmnt_l_fire", posx, posy, posz-0.8 , 0.0, 0.0, 0.0, 0.8, false, false, false, false)
	Citizen.Wait(6000)
	StopParticleFxLooped(fire, 0)	
end)


RegisterNetEvent('qb-methcar:smoke')
AddEventHandler('qb-methcar:smoke', function(posx, posy, posz, bool)

	if bool == 'a' then

		if not HasNamedPtfxAssetLoaded("core") then
			RequestNamedPtfxAsset("core")
			while not HasNamedPtfxAssetLoaded("core") do
				Citizen.Wait(1)
			end
		end
		SetPtfxAssetNextCall("core")
		local smoke = StartParticleFxLoopedAtCoord("ex_grd_flare", posx, posy, posz + 1.7, 0.0, 0.0, 0.0, 2.0, false, false, false, false)
		SetParticleFxLoopedAlpha(smoke, 0.8)
		SetParticleFxLoopedColour(smoke, 0.0, 0.0, 0.0, 0)
		Citizen.Wait(22000)
		StopParticleFxLooped(smoke, 0)
	else
		StopParticleFxLooped(smoke, 0)
	end
end)

RegisterNetEvent('qb-methcar:drug')
AddEventHandler('qb-methcar:drug', function()
	SetTimecycleModifier("drug_drive_blend01")
	SetPedMotionBlur(GetPlayerPed(-1), true)
	SetPedMovementClipset(GetPlayerPed(-1), "MOV_M@DRUNK@SLIGHTLYDRUNK", true)
	SetPedIsDrunk(GetPlayerPed(-1), true)

	Citizen.Wait(300000)
	ClearTimecycleModifier()
end)



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		
		playerPed = GetPlayerPed(-1)
		local pos = GetEntityCoords(GetPlayerPed(-1))
		if IsPedInAnyVehicle(playerPed) then
			
			
			CurrentVehicle = GetVehiclePedIsUsing(PlayerPedId())

			car = GetVehiclePedIsIn(playerPed, false)
			LastCar = GetVehiclePedIsUsing(playerPed)
	
			local model = GetEntityModel(CurrentVehicle)
			local modelName = GetDisplayNameFromVehicleModel(model)
			
			if modelName == 'JOURNEY' and car then
				
					if GetPedInVehicleSeat(car, -1) == playerPed then
						if started == false then
							if displayed == false then
								--DisplayHelpText("Press ~INPUT_THROW_GRENADE~ to start making drugs")
								displayed = true
							end
						end
						if IsControlJustReleased(0, Keys['Y']) and GetLastInputMethod( 0 ) then
							if pos.y >= 3500 then
								if IsVehicleSeatFree(CurrentVehicle, 3) then
									TriggerServerEvent('qb-methcar:start')
									TriggerEvent('qb-methcar:make')
									progress = 0
									pause = false
									selection = 0
									quality = 0
								else
								  --DisplayHelpText('~r~The car is already occupied')
									QBCore.Functions.Notify('The car is already occupied..', 'error')
								end
							else
								--ESX.ShowNotification('~r~You are too close to the city, head further up north to begin meth production')
								QBCore.Functions.Notify('You are too close to the city, Head further up north to begin meth production', 'error')
							end
						end
					end
			end	
		else
				if started then
					pause = true
					displayed = false
					FreezeEntityPosition(LastCar,false)
					TriggerEvent('qb-methcar:stop')
				end
		end
		
		if started == true then
			
			if progress < 98 then
				Citizen.Wait(6000)
				if IsPedInAnyVehicle(playerPed) then
					progress = progress +  1
					--ESX.ShowNotification('~r~Meth production: ~g~~h~' .. progress .. '%')
					QBCore.Functions.Notify('Meth production: ' ..progress.. '%', 'success')
					Citizen.Wait(6000) 
				end

				--
				--   EVENT 1
				--
				if progress > 22 and progress < 24 then
					pause = true
					if selection == 0 then
						--ESX.ShowNotification('~o~The propane pipe is leaking, what do you do?')	
						QBCore.Functions.Notify('The propane pipe is leaking, What do you do?', 'success')
						--ESX.ShowNotification('~o~1. Fix using tape')
						QBCore.Functions.Notify('N7. Fix using tape', 'success')
						--ESX.ShowNotification('~o~2. Leave it be ')
						QBCore.Functions.Notify('N8. Leave it be', 'success')
						--ESX.ShowNotification('~o~3. Replace it')
						QBCore.Functions.Notify('N9. Replace it', 'success')
						--ESX.ShowNotification('~c~Press the number of the option you want to do')
						QBCore.Functions.Notify('Press the number of the option you want to do?', 'success')
					end
					if selection == 1 then
						print("Slcted 1")
						--ESX.ShowNotification('~r~The tape kinda stopped the leak')
						QBCore.Functions.Notify('The tape kinda stopped the leak?', 'success')
						quality = quality - 3
						pause = false
						selection = 0
					end
					if selection == 2 then
						print("Slcted 2")
						--ESX.ShowNotification('~r~The propane tank blew up, you messed up...')
						QBCore.Functions.Notify('The propane tank blew up, you messed up...', 'success')
						TriggerServerEvent('qb-methcar:blow', pos.x, pos.y, pos.z)
						SetVehicleEngineHealth(CurrentVehicle, 0.0)
						quality = 0
						started = false
						displayed = false
						ApplyDamageToPed(GetPlayerPed(-1), 10, false)
					end
					if selection == 3 then
						print("Slcted 3")
						--ESX.ShowNotification('~r~Good job, the pipe wasnt in a good condition')
						QBCore.Functions.Notify('Good job, the pipe wasn\'t in a good condition', 'success')
						pause = false
						quality = quality + 5
						selection = 0
					end
				end
				--
				--   EVENT 5
				--
				if progress > 30 and progress < 32 then
					pause = true
					if selection == 0 then
						--ESX.ShowNotification('~o~You spilled a bottle of acetone on the ground, what do you do?')
						QBCore.Functions.Notify('You spilled a bottle of acetone on the ground, what do you do?', 'success')	
						--ESX.ShowNotification('~o~1. Open the windows to get rid of the smell')
						QBCore.Functions.Notify('N7. Open the windows to get rid of the smell', 'success')
						--ESX.ShowNotification('~o~2. Leave it be')
						QBCore.Functions.Notify('N8. Leave it be', 'success')
						--ESX.ShowNotification('~o~3. Put on a mask with airfilter')
						QBCore.Functions.Notify('N9. Put on a mask with airfilter', 'success')
						--ESX.ShowNotification('~c~Press the number of the option you want to do')
						QBCore.Functions.Notify('Press the number of the option you want to do..', 'success')
					end
					if selection == 1 then
						print("Slcted 1")
						--ESX.ShowNotification('~r~You opened the windows to get rid of the smell')
						QBCore.Functions.Notify('You opened the windows to get rid of the smell', 'success')
						quality = quality - 1
						pause = false
						selection = 0
					end
					if selection == 2 then
						print("Slcted 2")
						--ESX.ShowNotification('~r~You got high from inhaling acetone too much')
						QBCore.Functions.Notify('You got high from inhaling acetone too much', 'success')
						pause = false
						TriggerEvent('qb-methcar:drugged')
						selection = 0
					end
					if selection == 3 then
						print("Slcted 3")
						--ESX.ShowNotification('~r~Thats an easy way to fix the issue.. I guess')
						QBCore.Functions.Notify('Thats an easy way to fix the issue.. I guess', 'success')
						SetPedPropIndex(playerPed, 1, 26, 7, true)
						pause = false
						selection = 0
					end
				end
				--
				--   EVENT 2
				--
				if progress > 38 and progress < 40 then
					pause = true
					if selection == 0 then
						--ESX.ShowNotification('~o~Meth becomes solid too fast, what do you do? ')
						QBCore.Functions.Notify('Meth becomes solid too fast, what do you do?', 'success')	
						--ESX.ShowNotification('~o~1. Raise the pressure')
						QBCore.Functions.Notify('N7. Raise the pressure', 'success')
						--ESX.ShowNotification('~o~2. Raise the temperature')
						QBCore.Functions.Notify('N8. Raise the temperature', 'success')
						--ESX.ShowNotification('~o~3. Lower the pressure')
						QBCore.Functions.Notify('N9. Lower the pressure', 'success')
						--ESX.ShowNotification('~c~Press the number of the option you want to do')
						QBCore.Functions.Notify('Press the number of the option you want to do', 'success')
					end
					if selection == 1 then
						print("Slcted 1")
						--ESX.ShowNotification('~r~You raised the pressure and the propane started escaping, you lowered it and its okay for now')
						QBCore.Functions.Notify('You raised the pressure and the propane started escaping, you lowered it and its okay for now', 'success')
						pause = false
						selection = 0
					end
					if selection == 2 then
						print("Slcted 2")
						--ESX.ShowNotification('~r~Raising the temperature helped...')
						QBCore.Functions.Notify('Raising the temperature helped...', 'success')
						quality = quality + 5
						pause = false
						selection = 0
					end
					if selection == 3 then
						print("Slcted 3")
						--ESX.ShowNotification('~r~Lowering the pressure just made it worse...')
						QBCore.Functions.Notify('Lowering the pressure just made it worse...', 'success')
						pause = false
						quality = quality -4
						selection = 0
					end
				end
				--
				--   EVENT 8 - 3
				--
				if progress > 41 and progress < 43 then
					pause = true
					if selection == 0 then
						--ESX.ShowNotification('~o~You accidentally pour too much acetone, what do you do?')	
                        QBCore.Functions.Notify('You accidentally pour too much acetone, what do you do?', 'success')
						--ESX.ShowNotification('~o~1. Do nothing')
						QBCore.Functions.Notify('N7. Do nothing', 'success')
						--ESX.ShowNotification('~o~2. Try to sucking it out using syringe')
						QBCore.Functions.Notify('N8. Try to sucking it out using syringe', 'success')
						--ESX.ShowNotification('~o~3. Add more lithium to balance it out')
						QBCore.Functions.Notify('N9. Add more lithium to balance it out', 'success')
						--ESX.ShowNotification('~c~Press the number of the option you want to do')
						QBCore.Functions.Notify('Press the number of the option you want to do', 'success')
					end
					if selection == 1 then
						print("Slcted 1")
						--ESX.ShowNotification('~r~The meth is not smelling like acetone a lot')
						QBCore.Functions.Notify('The meth is not smelling like acetone a lot', 'success')
						quality = quality - 3
						pause = false
						selection = 0
					end
					if selection == 2 then
						print("Slcted 2")
						--ESX.ShowNotification('~r~It kind of worked but its still too much')
						QBCore.Functions.Notify('It kind of worked but its still too much', 'success')
						pause = false
						quality = quality - 1
						selection = 0
					end
					if selection == 3 then
						print("Slcted 3")
						--ESX.ShowNotification('~r~You successfully balanced both chemicals out and its good again')
						QBCore.Functions.Notify('You successfully balanced both chemicals out and its good again', 'success')
						pause = false
						quality = quality + 3
						selection = 0
					end
				end
				--
				--   EVENT 3
				--
				if progress > 46 and progress < 49 then
					pause = true
					if selection == 0 then
						--ESX.ShowNotification('~o~You found some water coloring, what do you do?')	
						QBCore.Functions.Notify('You found some water coloring, what do you do?', 'success')
						--ESX.ShowNotification('~o~1. Add it in')
						QBCore.Functions.Notify('N7. Add it in', 'success')
					  --	ESX.ShowNotification('~o~2. Put it away')
						QBCore.Functions.Notify('N8. Put it away', 'success')
						--ESX.ShowNotification('~o~3. Drink it')
						QBCore.Functions.Notify('N9. Drink it', 'success')
						--ESX.ShowNotification('~c~Press the number of the option you want to do')
						QBCore.Functions.Notify('Press the number of the option you want to do', 'success')
					end
					if selection == 1 then
						print("Slcted 1")
						--ESX.ShowNotification('~r~Good idea, people like colors')
						QBCore.Functions.Notify('Good idea, people like colors', 'success')
						quality = quality + 4
						pause = false
						selection = 0
					end
					if selection == 2 then
						print("Slcted 2")
						--ESX.ShowNotification('~r~Yeah it might destroy the taste of meth')
						QBCore.Functions.Notify('Yeah it might destroy the taste of meth', 'success')
						pause = false
						selection = 0
					end
					if selection == 3 then
						print("Slcted 3")
						--ESX.ShowNotification('~r~You are a bit weird and feel dizzy but its all good')
						QBCore.Functions.Notify('You are a bit weird and feel dizzy but its all good', 'success')
						pause = false
						selection = 0
					end
				end
				--
				--   EVENT 4
				--
				if progress > 55 and progress < 58 then
					pause = true
					if selection == 0 then
						--ESX.ShowNotification('~o~The filter is clogged, what do you do?')
						QBCore.Functions.Notify('The filter is clogged, what do you do?', 'success')	
						--ESX.ShowNotification('~o~1. Clean it using compressed air')
						QBCore.Functions.Notify('N7. Clean it using compressed air', 'success')
						--ESX.ShowNotification('~o~2. Replace the filter')
						QBCore.Functions.Notify('N8. Replace the filter', 'success')
						--ESX.ShowNotification('~o~3. Clean it using a tooth brush')
						QBCore.Functions.Notify('N9. Clean it using a tooth brush', 'success')
						--ESX.ShowNotification('~c~Press the number of the option you want to do')
						QBCore.Functions.Notify('Press the number of the option you want to do', 'success')
					end
					if selection == 1 then
						print("Slcted 1")
						--ESX.ShowNotification('~r~Compressed air sprayed the liquid meth all over you')
						QBCore.Functions.Notify('Compressed air sprayed the liquid meth all over you', 'success')
						quality = quality - 2
						pause = false
						selection = 0
					end
					if selection == 2 then
						print("Slcted 2")
						--ESX.ShowNotification('~r~Replacing it was probably the best option')
						QBCore.Functions.Notify('Replacing it was probably the best option', 'success')
						pause = false
						quality = quality + 3
						selection = 0
					end
					if selection == 3 then
						print("Slcted 3")
						--ESX.ShowNotification('~r~This worked quite well but its still kinda dirty')
						QBCore.Functions.Notify('This worked quite well but its still kinda dirty', 'success')
						pause = false
						quality = quality - 1
						selection = 0
					end
				end
				--
				--   EVENT 5
				--
				if progress > 58 and progress < 60 then
					pause = true
					if selection == 0 then
						--ESX.ShowNotification('~o~You spilled a bottle of acetone on the ground, what do you do?')	
						QBCore.Functions.Notify('You spilled a bottle of acetone on the ground, what do you do?', 'success')
						--ESX.ShowNotification('~o~1. Open the windows to get rid of the smell')
						QBCore.Functions.Notify('N7. Open the windows to get rid of the smell', 'success')
						--ESX.ShowNotification('~o~2. Leave it be')
						QBCore.Functions.Notify('N8. Leave it be', 'success')
						--ESX.ShowNotification('~o~3. Put on a mask with airfilter')
						QBCore.Functions.Notify('NN9. Put on a mask with airfilter', 'success')
						--ESX.ShowNotification('~c~Press the number of the option you want to do')
						QBCore.Functions.Notify('Press the number of the option you want to do', 'success')
					end
					if selection == 1 then
						print("Slcted 1")
						--ESX.ShowNotification('~r~You opened the windows to get rid of the smell')
						QBCore.Functions.Notify('You opened the windows to get rid of the smell', 'success')
						quality = quality - 1
						pause = false
						selection = 0
					end
					if selection == 2 then
						print("Slcted 2")
						--ESX.ShowNotification('~r~You got high from inhaling acetone too much')
						QBCore.Functions.Notify('You got high from inhaling acetone too much', 'success')
						pause = false
						TriggerEvent('qb-methcar:drugged')
						selection = 0
					end
					if selection == 3 then
						print("Slcted 3")
						--ESX.ShowNotification('~r~Thats an easy way to fix the issue.. I guess')
						QBCore.Functions.Notify('Thats an easy way to fix the issue.. I guess', 'success')
						SetPedPropIndex(playerPed, 1, 26, 7, true)
						pause = false
						selection = 0
					end
				end
				--
				--   EVENT 1 - 6
				--
				if progress > 63 and progress < 65 then
					pause = true
					if selection == 0 then
						--ESX.ShowNotification('~o~The propane pipe is leaking, what do you do?')	
						QBCore.Functions.Notify('The propane pipe is leaking, What do you do?', 'success')
						--ESX.ShowNotification('~o~1. Fix using tape')
						QBCore.Functions.Notify('N7. Fix using tape', 'success')
						--ESX.ShowNotification('~o~2. Leave it be ')
						QBCore.Functions.Notify('N8. Leave it be', 'success')
						--ESX.ShowNotification('~o~3. Replace it')
						QBCore.Functions.Notify('N9. Replace it', 'success')
						--ESX.ShowNotification('~c~Press the number of the option you want to do')
						QBCore.Functions.Notify('Press the number of the option you want to do', 'success')
					end
					if selection == 1 then
						print("Slcted 1")
						--ESX.ShowNotification('~r~The tape kinda stopped the leak')
						QBCore.Functions.Notify('The tape kinda stopped the leak', 'success')
						quality = quality - 3
						pause = false
						selection = 0
					end
					if selection == 2 then
						print("Slcted 2")
						--ESX.ShowNotification('~r~The propane tank blew up, you messed up...')
						QBCore.Functions.Notify('The propane tank blew up, you messed up...', 'success')
						TriggerServerEvent('qb-methcar:blow', pos.x, pos.y, pos.z)
						SetVehicleEngineHealth(CurrentVehicle, 0.0)
						quality = 0
						started = false
						displayed = false
						ApplyDamageToPed(GetPlayerPed(-1), 10, false)
					end
					if selection == 3 then
						print("Slcted 3")
						--ESX.ShowNotification('~r~Good job, the pipe wasnt in a good condition')
						QBCore.Functions.Notify('Good job, the pipe wasnt in a good condition', 'success')
						pause = false
						quality = quality + 5
						selection = 0
					end
				end
				--
				--   EVENT 4 - 7
				--
				if progress > 71 and progress < 73 then
					pause = true
					if selection == 0 then
						--ESX.ShowNotification('~o~The filter is clogged, what do you do?')
						QBCore.Functions.Notify('The filter is clogged, what do you do?', 'success')	
						--ESX.ShowNotification('~o~1. Clean it using compressed air')
						QBCore.Functions.Notify('N7. Clean it using compressed air', 'success')
						--ESX.ShowNotification('~o~2. Replace the filter')
						QBCore.Functions.Notify('N8. Replace the filter', 'success')
						--ESX.ShowNotification('~o~3. Clean it using a tooth brush')
						QBCore.Functions.Notify('N9. Clean it using a tooth brush', 'success')
						--ESX.ShowNotification('~c~Press the number of the option you want to do')
						QBCore.Functions.Notify('Press the number of the option you want to do', 'success')
					end
					if selection == 1 then
						print("Slcted 1")
						--ESX.ShowNotification('~r~Compressed air sprayed the liquid meth all over you')
						QBCore.Functions.Notify('Compressed air sprayed the liquid meth all over you', 'success')
						quality = quality - 2
						pause = false
						selection = 0
					end
					if selection == 2 then
						print("Slcted 2")
						--ESX.ShowNotification('~r~Replacing it was probably the best option')
						QBCore.Functions.Notify('Replacing it was probably the best option', 'success')
						pause = false
						quality = quality + 3
						selection = 0
					end
					if selection == 3 then
						print("Slcted 3")
						--ESX.ShowNotification('~r~This worked quite well but its still kinda dirty')
						QBCore.Functions.Notify('This worked quite well but its still kinda dirty', 'success')
						pause = false
						quality = quality - 1
						selection = 0
					end
				end
				--
				--   EVENT 8
				--
				if progress > 76 and progress < 78 then
					pause = true
					if selection == 0 then
						--ESX.ShowNotification('~o~You accidentally pour too much acetone, what do you do?')	
						QBCore.Functions.Notify('You accidentally pour too much acetone, what do you do?', 'success')
						--ESX.ShowNotification('~o~1. Do nothing')
						QBCore.Functions.Notify('N7. Do nothing', 'success')
						--ESX.ShowNotification('~o~2. Try to sucking it out using syringe')
						QBCore.Functions.Notify('N8. Try to sucking it out using syringe', 'success')
						--ESX.ShowNotification('~o~3. Add more lithium to balance it out')
						QBCore.Functions.Notify('N9. Add more lithium to balance it out', 'success')
						--ESX.ShowNotification('~c~Press the number of the option you want to do')
						QBCore.Functions.Notify('Press the number of the option you want to do', 'success')
					end
					if selection == 1 then
						print("Slcted 1")
						--ESX.ShowNotification('~r~The meth is not smelling like acetone a lot')
						QBCore.Functions.Notify('The meth is not smelling like acetone a lot', 'success')
						quality = quality - 3
						pause = false
						selection = 0
					end
					if selection == 2 then
						print("Slcted 2")
						--ESX.ShowNotification('~r~It kind of worked but its still too much')
						QBCore.Functions.Notify('It kind of worked but its still too much', 'success')
						pause = false
						quality = quality - 1
						selection = 0
					end
					if selection == 3 then
						print("Slcted 3")
						--ESX.ShowNotification('~r~You successfully balanced both chemicals out and its good again')
						QBCore.Functions.Notify('You successfully balanced both chemicals out and its good again', 'success')
						pause = false
						quality = quality + 3
						selection = 0
					end
				end
				--
				--   EVENT 9
				--
				if progress > 82 and progress < 84 then
					pause = true
					if selection == 0 then
						--ESX.ShowNotification('~o~You need to take a shit, what do you do?')	
						QBCore.Functions.Notify('You need to take a shit, what do you do?', 'success')
						--ESX.ShowNotification('~o~1. Try to hold it')
						QBCore.Functions.Notify('N7. Try to hold it', 'success')
						--ESX.ShowNotification('~o~2. Go outside and take a shit')
						QBCore.Functions.Notify('N8. Go outside and take a shit', 'success')
						--ESX.ShowNotification('~o~3. Shit inside')
						QBCore.Functions.Notify('N9. Shit inside', 'success')
						--ESX.ShowNotification('~c~Press the number of the option you want to do')
						QBCore.Functions.Notify('Press the number of the option you want to do', 'success')
					end
					if selection == 1 then
						print("Slcted 1")
						--ESX.ShowNotification('~r~Good job, you need to work first, shit later')
						QBCore.Functions.Notify('Good job, you need to work first, shit later', 'success')
						quality = quality + 1
						pause = false
						selection = 0
					end
					if selection == 2 then
						print("Slcted 2")
						--ESX.ShowNotification('~r~While you were outside the glass fell off the table and spilled all over the floor...')
						QBCore.Functions.Notify('While you were outside the glass fell off the table and spilled all over the floor...', 'success')
						pause = false
						quality = quality - 2
						selection = 0
					end
					if selection == 3 then
						print("Slcted 3")
						--ESX.ShowNotification('~r~The air smells like shit now, the meth smells like shit now')
						QBCore.Functions.Notify('The air smells like shit now, the meth smells like shit now', 'success')
						pause = false
						quality = quality - 1
						selection = 0
					end
				end
				--
				--   EVENT 10
				--
				if progress > 88 and progress < 90 then
					pause = true
					if selection == 0 then
						--ESX.ShowNotification('~o~Do you add some glass pieces to the meth so it looks like you have more of it?')
						QBCore.Functions.Notify('Do you add some glass pieces to the meth so it looks like you have more of it?', 'success')	
						--ESX.ShowNotification('~o~1. Yes!')
						QBCore.Functions.Notify('N7. Yes!', 'success')
						--ESX.ShowNotification('~o~2. No')
						QBCore.Functions.Notify('N8. No', 'success')
						--ESX.ShowNotification('~o~3. What if I add meth to glass instead?')
						QBCore.Functions.Notify('N9. What if I add meth to glass instead', 'success')
						--ESX.ShowNotification('~c~Press the number of the option you want to do')
						QBCore.Functions.Notify('Press the number of the option you want to do', 'success')
					end
					if selection == 1 then
						print("Slcted 1")
						--ESX.ShowNotification('~r~Now you got few more baggies out of it')
						QBCore.Functions.Notify('Now you got few more baggies out of it', 'success')
						quality = quality + 1
						pause = false
						selection = 0
					end
					if selection == 2 then
						print("Slcted 2")
						--ESX.ShowNotification('~r~You are a good drug maker, your product is high quality')
						QBCore.Functions.Notify('You are a good drug maker, your product is high quality', 'success')
						pause = false
						quality = quality + 1
						selection = 0
					end
					if selection == 3 then
						print("Slcted 3")
						--ESX.ShowNotification('~r~Thats a bit too much, its more glass than meth but ok')
						QBCore.Functions.Notify('Thats a bit too much, its more glass than meth but ok.', 'success')
						pause = false
						quality = quality - 1
						selection = 0
					end
				end
				if IsPedInAnyVehicle(playerPed) then
					TriggerServerEvent('qb-methcar:make', pos.x,pos.y,pos.z)
					if pause == false then
						selection = 0
						quality = quality + 1
						progress = progress +  math.random(1, 2)
						--ESX.ShowNotification('~r~Meth production: ~g~~h~' .. progress .. '%')
						QBCore.Functions.Notify('Meth production: ' .. progress .. '%', 'success')
					end
				else
					TriggerEvent('qb-methcar:stop')
				end
			else 
				progress = 100
				pause = true
				started = false
				QBCore.Functions.Notify('Meth Production: ' ..progress.. '%', 'success')
				QBCore.Functions.Notify('Meth Production finished', 'success')
				TriggerServerEvent('qb-methcar:finish', quality)
				TriggerEvent('qb-methcar:stop')
				FreezeEntityPosition(LastCar, false)
				progress = 0
			end	
		end	
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
			if IsPedInAnyVehicle(GetPlayerPed(-1)) then
			else
				if started then
					started = true
					displayed = false
					FreezeEntityPosition(LastCar,false)
				end		
			end
		end
	end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)		
		if pause == true and started == true then
			if IsControlJustReleased(0, Keys['N7']) then
				selection = 1
				--ESX.ShowNotification('~g~Selected option number 1')
				QBCore.Functions.Notify('Selected option number 7', 'success')
			end
			if IsControlJustReleased(0, Keys['N8']) then
				selection = 2
				--ESX.ShowNotification('~g~Selected option number 2')
				QBCore.Functions.Notify('Selected option number 8', 'success')
			end
			if IsControlJustReleased(0, Keys['N9']) then
				selection = 3
				--ESX.ShowNotification('~g~Selected option number 3')
				QBCore.Functions.Notify('Selected option number 9', 'success')
			end
		end
	end
end)
