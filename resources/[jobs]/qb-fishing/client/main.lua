
QBCore = nil
cachedData = {}

local JobBusy = false

Citizen.CreateThread(function()
	while not QBCore do
		TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

		Citizen.Wait(0)
	end
end)

function CreateBlips()
	for i, zone in ipairs(Config.FishingZones) do
		local coords = zone.secret and ((zone.coords / 1.5) - 133.37) or zone.coords
		local name = zone.name
		if not zone.secret then
			local x = AddBlipForCoord(coords)
			SetBlipSprite (x, 405)
			SetBlipDisplay(x, 4)
			SetBlipScale  (x, 0.35)
			SetBlipAsShortRange(x, true)
			SetBlipColour(x, 69)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentSubstringPlayerName(name)
			EndTextCommandSetBlipName(x)
		end
	end
end

function DeleteBlips()
	if DoesBlipExist(coords) then
		RemoveBlip(coords)
	end
end

-- function SellFish()


RegisterNetEvent("qb-fishing:tryToFish")
AddEventHandler("qb-fishing:tryToFish", function()
	TryToFish() 
end)

RegisterNetEvent("qb-fishing:calculatedistances")
AddEventHandler("qb-fishing:calculatedistances", pos, function()

end)



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1500)

		local ped = PlayerPedId()

		if cachedData["ped"] ~= ped then
			cachedData["ped"] = ped
		end
	end
end)