Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local ped = GetPlayerPed(-1)

		if DoesEntityExist(ped) and IsPedInAnyVehicle(ped, true) and IsControlPressed(2, 75) and not IsEntityDead(ped) and not IsPauseMenuActive() then
			local veh = GetVehiclePedIsIn(ped, true)
			local engineWasRunning = GetIsVehicleEngineRunning(veh)
			if engineWasRunning then
				SetVehicleEngineOn(veh, true, true, true)
			end

			Citizen.Wait(2000)
		end
	end
end)