Citizen.CreateThread(function()
	while true do
		SetVehicleDensityMultiplierThisFrame(0.7)
	   	SetPedDensityMultiplierThisFrame(1.2)
	    SetParkedVehicleDensityMultiplierThisFrame(0.7)
		SetScenarioPedDensityMultiplierThisFrame(1.2, 1.2)

		Citizen.Wait(3)
	end
end)