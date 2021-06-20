QBCore = nil

local zones = {
	{ ['x'] = -552.00659179688, ['y'] = -191.67660522461, ['z'] = 38.220558166504}, -- City Hall
    { ['x'] = 304.57, ['y'] = -589.02, ['z'] = 43.29}, -- Pillbox Hospital
	{ ['x'] = 941.08966064453, ['y'] = -977.00360107422, ['z'] = 39.499820709229}, -- Mechanic
	{ ['x'] = -44.239879608154, ['y'] = -1098.6038818359, ['z'] = 26.422340393066}, -- Car Dealership
	{ ['x'] = -795.38757324219, ['y'] = -221.54844665527, ['z'] = 37.079627990723}, -- Car Dealership
	--{ ['x'] = 00.00, ['y'] = 00.00, ['z'] = 00.00} -- EXAMPLE
}

-- Blip settings
local color = 2 -- Green zone color. Obviously its green
local radius = 70.0 -- Size of the green zones
local text = "Green Zone" -- Name of the green zone map blip

-- Settings
local GreenZoneDist = 50.0

-- Locales
local EnteredGreenZone = 'You entered green zone'
local LeftGreenZone = 'You left green zone'
local disabledGreenZone = 'You can\'t do that in a green zone'

-- Dont touch
local notifIn = false
local notifOut = false
local closestZone = 1

Citizen.CreateThread(function()
	for k,zone in pairs(zones) do
		coords = vector3(zone.x, zone.y, zone.z)

		local blip = AddBlipForRadius(coords, radius)

		SetBlipHighDetail(blip, true)
		SetBlipColour(blip, 2)
		SetBlipAlpha (blip, 128)
	end
end)

Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end
	
	while true do
		sleep = 500
		local player = GetPlayerPed(-1)
		local x,y,z = table.unpack(GetEntityCoords(player, true))

		for k,zone in pairs(zones) do
			local dist = Vdist(zone.x, zone.y, zone.z, x, y, z)
	
			if dist <= GreenZoneDist then
				sleep = 5
				if not notifIn then																		  
					NetworkSetFriendlyFireOption(false)
					ClearPlayerWantedLevel(PlayerId())
					SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true)
					notifIn = true
					notifOut = false
				end
			else
				if not notifOut then
					--SetPlayerInvincible(player, false)
					NetworkSetFriendlyFireOption(true)
					notifOut = true
					notifIn = false
				end
			end
			if notifIn then
				DisableControlAction(2, 37, true) -- disable weapon wheel (Tab)
				DisableControlAction(0, 45, true) -- disable R
				DisableControlAction(0, 80, true) -- disable R
				DisableControlAction(0, 140, true) -- disable R
				DisableControlAction(0, 250, true) -- disable R
				DisableControlAction(0, 263, true) -- disable R
				DisableControlAction(0, 106, true) -- Disable in-game mouse controls
				DisableControlAction(0, 140, true)
				DisableControlAction(0, 141, true)
				DisableControlAction(0, 142, true)
				DisablePlayerFiring(player,true) -- Disables firing all together if they somehow bypass inzone Mouse Disable
				--SetPlayerInvincible(player, true)
				if IsDisabledControlJustPressed(2, 37) then --if Tab is pressed, send error message
					SetCurrentPedWeapon(player, GetHashKey("WEAPON_UNARMED"), true) -- if tab is pressed it will set them to unarmed (this is to cover the vehicle glitch until I sort that all out)
					QBCore.Functions.Notify("You can\'t do that in green zone", "error")
				end
				if IsDisabledControlJustPressed(0, 106) then --if LeftClick is pressed, send error message
					SetCurrentPedWeapon(player, GetHashKey("WEAPON_UNARMED"), true) -- If they click it will set them to unarmed
                    QBCore.Functions.Notify("You can\'t do that in green zone", "error")
				end
			else
				--SetPlayerInvincible(PlayerId(), false)
			end
		end
		Citizen.Wait(sleep)
	end
end)