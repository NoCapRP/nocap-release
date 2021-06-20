QBCore = nil

local charPed = nil

Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(10)
        if QBCore == nil then
            TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)    
            Citizen.Wait(200)
        end
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if NetworkIsSessionStarted() then
            Citizen.Wait(500)
			TriggerServerEvent("scoreboard:AddPlayer")
            TriggerEvent('qb-multicharacter:client:chooseChar')
            return
		end
	end
end)

--- CODE

local choosingCharacter = false
local cam = nil

function openCharMenu(bool)
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        action = "openUI",
        toggle = bool,
    })
    choosingCharacter = bool
    skyCam(bool)
    print('[Character Menu Loaded]')
end

RegisterNUICallback('closeUI', function()
    openCharMenu(false)
end)

RegisterNUICallback('disconnectButton', function()
    TriggerServerEvent('qb-multicharacter:server:disconnect')
end)

RegisterNUICallback('selectCharacter', function(data)
    local cData = data.cData
    DoScreenFadeOut(10)
    TriggerServerEvent('qb-multicharacter:server:loadUserData', cData)
    openCharMenu(false)
end)

RegisterNetEvent('qb-multicharacter:client:closeNUI')
AddEventHandler('qb-multicharacter:client:closeNUI', function()
    openCharMenu(false)
end)

RegisterNetEvent('qb-multicharacter:client:chooseChar')
AddEventHandler('qb-multicharacter:client:chooseChar', function()
    SetNuiFocus(false, false)
    -- Sets the loadingscreen shutdown to manual so that it wont dissapear when interior not loaded
    -- Loads Micheals interior
    local interior = GetInteriorAtCoords(404.61, -970.70, -99.00)
    LoadInterior(interior)
    while not IsInteriorReady(interior) do
        Citizen.Wait(1000)
        print("[Loading Selector Interior, Please Wait!]")
    end
    
    -- Freezes player and places player inside interior hidden room
    FreezeEntityPosition(GetPlayerPed(-1), true)
    SetEntityCoords(GetPlayerPed(-1), 404.61, -970.70, -99.00)
    Citizen.Wait(100)
    -- Closes loading screen
    ShutdownLoadingScreenNui()

    -- Disables NATIVE voicechat (Does not effect TokoVoip)
    NetworkSetTalkerProximity(0.0)

    DoScreenFadeOut(0)
    DoScreenFadeIn(1000)
    openCharMenu(true)
end)

function selectChar()
    openCharMenu(true)
end

RegisterNUICallback('cDataPed', function(data)
    local cData = data.cData
	RequestModel(GetHashKey("mp_m_freemode_01"))

	while not HasModelLoaded(GetHashKey("mp_m_freemode_01")) do
	    Wait(1)
    end
    
    SetEntityAsMissionEntity(charPed, true, true)
    DeleteEntity(charPed)

    if cData ~= nil then
        QBCore.Functions.TriggerCallback('qb-multicharacter:server:getSkin', function(model, data)
            if model ~= nil then
                model = model ~= nil and tonumber(model) or false

                if not IsModelInCdimage(model) or not IsModelValid(model) then setDefault() return end
            
                Citizen.CreateThread(function()
                    RequestModel(model)
            
                    while not HasModelLoaded(model) do
                        Citizen.Wait(0)
                    end

                    charPed = CreatePed(3, model, 414.61, -979.70, -99.00, 1.40, false, true)
                    
                    data = json.decode(data)
            
                    TriggerEvent('qb-clothing:client:loadPlayerClothing', data, charPed)
                end)
            else
                charPed = CreatePed(4, GetHashKey("mp_m_freemode_01"), 414.61, -979.70, -99.00, 1.40, false, true)
            end
        end, cData.citizenid)
    else
        charPed = CreatePed(4, GetHashKey("mp_m_freemode_01"), 414.61, -979.70, -99.00, 1.40, false, true)
    end

    Citizen.Wait(100)
    
    SetEntityHeading(charPed, 89.5)
    FreezeEntityPosition(charPed, false)
    SetEntityInvincible(charPed, true)
    PlaceObjectOnGroundProperly(charPed)
    SetBlockingOfNonTemporaryEvents(charPed, true)
end)

RegisterNUICallback('setupCharacters', function()
    QBCore.Functions.TriggerCallback("test:yeet", function(result)
        SendNUIMessage({
            action = "setupCharacters",
            characters = result
        })
        SetTimecycleModifier('default')
    end)
end)

RegisterNUICallback('createNewCharacter', function(data)
    local cData = data
    DoScreenFadeOut(150)
    if cData.gender == "man" then
        cData.gender = 0
    elseif cData.gender == "vrouw" then
        cData.gender = 1
    end

    TriggerServerEvent('qb-multicharacter:server:createCharacter', cData)
    TriggerServerEvent('qb-multicharacter:server:GiveStarterItems')
    Citizen.Wait(500)
end)

RegisterNUICallback('removeCharacter', function(data)
    TriggerServerEvent('qb-multicharacter:server:deleteCharacter', data.citizenid)
end)

function skyCam(bool)
    if bool then
        DoScreenFadeIn(10)
        SetTimecycleModifier('hud_def_blur')
        SetTimecycleModifierStrength(1.0)
        FreezeEntityPosition(GetPlayerPed(-1), false)
        cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 414.46, -977.70, -98.50, 1.4, 0.00, 180.00, 200.00, false, 0)
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 1, true, true)
    else
        SetTimecycleModifier('default')
        SetCamActive(cam, false)
        DestroyCam(cam, true)
        RenderScriptCams(false, false, 1, true, true)
        FreezeEntityPosition(GetPlayerPed(-1), false)
    end
end