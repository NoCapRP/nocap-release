QBCore = nil

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if QBCore == nil then
            TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
            Citizen.Wait(200)
        end
    end
end)

isLoggedIn = false
local PlayerJob = {}


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

-- Code

local HotdogBlip = nil
local IsWorking = false
local StandObject = nil
local IsPushing = false
local IsSelling = false
local IsUIActive = false
local PreparingFood = false
local SpatelObject = nil
local SellingData = {
    Enabled = false,
    Target = nil,
    HasTarget = false,
    RecentPeds = {},
    Hotdog = nil,
}
local OffsetData = {
    x = 0.0,
    y = -0.8,
    z = 1.0,
    Distance = 0.5
}
local LastStandPos = nil

local AnimationData = {
    lib = "missfinale_c2ig_11",
    anim = "pushcar_offcliff_f",
}
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


Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1)
        if isLoggedIn and QBCore ~= nil then
            local pos = GetEntityCoords(GetPlayerPed(-1))
            if PlayerJob.name == Config.job then
                if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["cook"].coords.x, Config.Locations["cook"].coords.y, Config.Locations["cook"].coords.z, true) < 10.0) then
                    DrawMarker(2, Config.Locations["cook"].coords.x, Config.Locations["cook"].coords.y, Config.Locations["cook"].coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 200, 200, 222, false, false, false, true, false, false, false)
                    if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["cook"].coords.x, Config.Locations["cook"].coords.y, Config.Locations["cook"].coords.z, true) < 1.5) then
                            DrawText3D(Config.Locations["cook"].coords.x, Config.Locations["cook"].coords.y, Config.Locations["cook"].coords.z, "~g~E~w~ - Use The Machine Over Here ")
                        if IsControlJustReleased(0, Keys["E"]) then
                                MachineMenu()
                                Menu.hidden = not Menu.hidden
                            end
                        end
                        Menu.renderGUI()
                end
            else
                Citizen.Wait(2500)
            end
        else
            Citizen.Wait(2500)
        end
    end
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1)
        if isLoggedIn and QBCore ~= nil then
            local pos = GetEntityCoords(GetPlayerPed(-1))
            if PlayerJob.name == Config.job then
                if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["ogcarspawn"].coords.x, Config.Locations["ogcarspawn"].coords.y, Config.Locations["ogcarspawn"].coords.z, true) < 10.0) then
                    DrawMarker(2, Config.Locations["ogcarspawn"].coords.x, Config.Locations["ogcarspawn"].coords.y, Config.Locations["ogcarspawn"].coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 200, 200, 222, false, false, false, true, false, false, false)
                    if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["ogcarspawn"].coords.x, Config.Locations["ogcarspawn"].coords.y, Config.Locations["ogcarspawn"].coords.z, true) < 1.5) then
                        if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                            DrawText3D(Config.Locations["ogcarspawn"].coords.x, Config.Locations["ogcarspawn"].coords.y, Config.Locations["ogcarspawn"].coords.z, "~g~E~w~ - Store The Vehicle")
                        else
                            DrawText3D(Config.Locations["ogcarspawn"].coords.x, Config.Locations["ogcarspawn"].coords.y, Config.Locations["ogcarspawn"].coords.z, "~g~E~w~ - Remove A Vehicle")
                        end
                        if IsControlJustReleased(0, Keys["E"]) then
                            if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                                DeleteVehicle(GetVehiclePedIsIn(GetPlayerPed(-1)))
                            else
                                ogVehicleSpawn()
                                Menu.hidden = not Menu.hidden
                            end
                        end
                        Menu.renderGUI()
                    end 
                end
            else
                Citizen.Wait(2500)
            end
        else
            Citizen.Wait(2500)
        end
    end
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1)
        if isLoggedIn and QBCore ~= nil then
            local pos = GetEntityCoords(GetPlayerPed(-1))
            if PlayerJob.name == Config.job then
                if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["stash"].coords.x, Config.Locations["stash"].coords.y, Config.Locations["stash"].coords.z, true) < 10.0) then
                    DrawMarker(2, Config.Locations["stash"].coords.x, Config.Locations["stash"].coords.y, Config.Locations["stash"].coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 200, 200, 222, false, false, false, true, false, false, false)
                    if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["stash"].coords.x, Config.Locations["stash"].coords.y, Config.Locations["stash"].coords.z, true) < 1.5) then
                            DrawText3D(Config.Locations["stash"].coords.x, Config.Locations["stash"].coords.y, Config.Locations["stash"].coords.z, "~g~E~w~ - Use The Stash Here ")
                        if IsControlJustReleased(0, Keys["E"]) then
                            TriggerServerEvent("inventory:server:OpenInventory", "stash", "starbuckstash", {
                                maxweight = 4000000,
                                slots = 500,
                            })
                            TriggerEvent("inventory:client:SetCurrentStash", "starbuckstash")
                            end
                        end
                end
            else
                Citizen.Wait(2500)
            end
        else
            Citizen.Wait(2500)
        end
    end
end)

function PrepareAnim()
    local ped = GetPlayerPed(-1)
    LoadAnim('amb@prop_human_bbq@male@idle_a')
    TaskPlayAnim(ped, 'amb@prop_human_bbq@male@idle_a', 'idle_b', 6.0, -6.0, -1, 47, 0, 0, 0, 0)
    SpatelObject = CreateObject(GetHashKey("prop_fish_slice_01"), 0, 0, 0, true, true, true)
    AttachEntityToEntity(SpatelObject, ped, GetPedBoneIndex(ped, 57005), 0.08, 0.0, -0.02, 0.0, -25.0, 130.0, true, true, false, true, 1, true)  
    ClearPedTasksImmediately(ped)
end

function Clubsandwich()
    local ped = GetPlayerPed(-1)
    local playerPed = PlayerPedId()

    LoadAnim('amb@prop_human_bbq@male@idle_a')
    TaskPlayAnim(ped, 'amb@prop_human_bbq@male@idle_a', 'idle_b', 6.0, -6.0, -1, 47, 0, 0, 0, 0)
    SpatelObject = CreateObject(GetHashKey("prop_fish_slice_01"), 0, 0, 0, true, true, true)
    AttachEntityToEntity(SpatelObject, ped, GetPedBoneIndex(ped, 57005), 0.08, 0.0, -0.02, 0.0, -25.0, 130.0, true, true, false, true, 1, true)
    FreezeEntityPosition(playerPed, true)
	QBCore.Functions.Progressbar("starbucks_makefood", "Making Club Sandwich...", 20000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function() -- Done    
   -- 
    DetachEntity(SpatelObject)
    DeleteEntity(SpatelObject)
    ClearPedTasksImmediately(ped)
    FreezeEntityPosition(playerPed, false)
   TriggerServerEvent('sbrulezop:server:clubsandwich')
    end)
end

function WhiteChocolateDonut()
    local ped = GetPlayerPed(-1)
    local playerPed = PlayerPedId()
    local src = source 


    LoadAnim('amb@prop_human_bbq@male@idle_a')
    TaskPlayAnim(ped, 'amb@prop_human_bbq@male@idle_a', 'idle_b', 6.0, -6.0, -1, 47, 0, 0, 0, 0)
    SpatelObject = CreateObject(GetHashKey("prop_fish_slice_01"), 0, 0, 0, true, true, true)
    AttachEntityToEntity(SpatelObject, ped, GetPedBoneIndex(ped, 57005), 0.08, 0.0, -0.02, 0.0, -25.0, 130.0, true, true, false, true, 1, true)
    FreezeEntityPosition(playerPed, true)
    QBCore.Functions.Progressbar("starbucks_makefood", "Making White Chocolate Donut...", 20000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function() -- Done    
    
    DetachEntity(SpatelObject)
    DeleteEntity(SpatelObject)
    ClearPedTasksImmediately(ped)
    FreezeEntityPosition(playerPed, false)
    TriggerServerEvent('sbrulezop:server:whitechocolatedonut')
end)
end

function StrawberryDonut()
    local ped = GetPlayerPed(-1)
    local playerPed = PlayerPedId()
    local src = source 


    LoadAnim('amb@prop_human_bbq@male@idle_a')
    TaskPlayAnim(ped, 'amb@prop_human_bbq@male@idle_a', 'idle_b', 6.0, -6.0, -1, 47, 0, 0, 0, 0)
    SpatelObject = CreateObject(GetHashKey("prop_fish_slice_01"), 0, 0, 0, true, true, true)
    AttachEntityToEntity(SpatelObject, ped, GetPedBoneIndex(ped, 57005), 0.08, 0.0, -0.02, 0.0, -25.0, 130.0, true, true, false, true, 1, true)
    FreezeEntityPosition(playerPed, true)
    QBCore.Functions.Progressbar("starbucks_makefood", "Making Strawberry Donut...", 20000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function() -- Done    
    
    DetachEntity(SpatelObject)
    DeleteEntity(SpatelObject)
    ClearPedTasksImmediately(ped)
    FreezeEntityPosition(playerPed, false)
    TriggerServerEvent('sbrulezop:server:strawberrydonut')

end)
end

function Chips()
    local ped = GetPlayerPed(-1)
    local playerPed = PlayerPedId()
    local src = source 


    LoadAnim('amb@prop_human_bbq@male@idle_a')
    TaskPlayAnim(ped, 'amb@prop_human_bbq@male@idle_a', 'idle_b', 6.0, -6.0, -1, 47, 0, 0, 0, 0)
    SpatelObject = CreateObject(GetHashKey("prop_fish_slice_01"), 0, 0, 0, true, true, true)
    AttachEntityToEntity(SpatelObject, ped, GetPedBoneIndex(ped, 57005), 0.08, 0.0, -0.02, 0.0, -25.0, 130.0, true, true, false, true, 1, true)
    FreezeEntityPosition(playerPed, true)
    QBCore.Functions.Progressbar("starbucks_makefood", "Making Chips...", 20000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function() -- Done    
    
    DetachEntity(SpatelObject)
    DeleteEntity(SpatelObject)
    ClearPedTasksImmediately(ped)
    FreezeEntityPosition(playerPed, false)
    TriggerServerEvent('sbrulezop:server:chips')

end)
end

function CheesyPie()
    local ped = GetPlayerPed(-1)
    local playerPed = PlayerPedId()
    local src = source 


    LoadAnim('amb@prop_human_bbq@male@idle_a')
    TaskPlayAnim(ped, 'amb@prop_human_bbq@male@idle_a', 'idle_b', 6.0, -6.0, -1, 47, 0, 0, 0, 0)
    SpatelObject = CreateObject(GetHashKey("prop_fish_slice_01"), 0, 0, 0, true, true, true)
    AttachEntityToEntity(SpatelObject, ped, GetPedBoneIndex(ped, 57005), 0.08, 0.0, -0.02, 0.0, -25.0, 130.0, true, true, false, true, 1, true)
    FreezeEntityPosition(playerPed, true)
    QBCore.Functions.Progressbar("starbucks_makefood", "Making Cheesy Pie...", 20000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function() -- Done    
    
    DetachEntity(SpatelObject)
    DeleteEntity(SpatelObject)
    ClearPedTasksImmediately(ped)
    FreezeEntityPosition(playerPed, false)
    TriggerServerEvent('sbrulezop:server:cheesypie')

end)
end

function Galaktoboureko()
    local ped = GetPlayerPed(-1)
    local playerPed = PlayerPedId()
    local src = source 


    LoadAnim('amb@prop_human_bbq@male@idle_a')
    TaskPlayAnim(ped, 'amb@prop_human_bbq@male@idle_a', 'idle_b', 6.0, -6.0, -1, 47, 0, 0, 0, 0)
    SpatelObject = CreateObject(GetHashKey("prop_fish_slice_01"), 0, 0, 0, true, true, true)
    AttachEntityToEntity(SpatelObject, ped, GetPedBoneIndex(ped, 57005), 0.08, 0.0, -0.02, 0.0, -25.0, 130.0, true, true, false, true, 1, true)
    FreezeEntityPosition(playerPed, true)
    QBCore.Functions.Progressbar("starbucks_makefood", "Making Galaktoboureko...", 20000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function() -- Done    
    
    DetachEntity(SpatelObject)
    DeleteEntity(SpatelObject)
    ClearPedTasksImmediately(ped)
    FreezeEntityPosition(playerPed, false)
    TriggerServerEvent('sbrulezop:server:galaktoboureko')

end)
end

function Espresso()
    local ped = GetPlayerPed(-1)
    local playerPed = PlayerPedId()
    local src = source 


    LoadAnim('amb@prop_human_bbq@male@idle_a')
    TaskPlayAnim(ped, 'amb@prop_human_bbq@male@idle_a', 'idle_b', 6.0, -6.0, -1, 47, 0, 0, 0, 0)
    SpatelObject = CreateObject(GetHashKey("prop_fish_slice_01"), 0, 0, 0, true, true, true)
    AttachEntityToEntity(SpatelObject, ped, GetPedBoneIndex(ped, 57005), 0.08, 0.0, -0.02, 0.0, -25.0, 130.0, true, true, false, true, 1, true)
    FreezeEntityPosition(playerPed, true)
    QBCore.Functions.Progressbar("starbucks_makefood", "Making Espresso Coffee...", 20000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function() -- Done    
    
    DetachEntity(SpatelObject)
    DeleteEntity(SpatelObject)
    ClearPedTasksImmediately(ped)
    FreezeEntityPosition(playerPed, false)
    TriggerServerEvent('sbrulezop:server:espresso')

end)
end

function IcedLatte()
    local ped = GetPlayerPed(-1)
    local playerPed = PlayerPedId()
    local src = source 


    LoadAnim('amb@prop_human_bbq@male@idle_a')
    TaskPlayAnim(ped, 'amb@prop_human_bbq@male@idle_a', 'idle_b', 6.0, -6.0, -1, 47, 0, 0, 0, 0)
    SpatelObject = CreateObject(GetHashKey("prop_fish_slice_01"), 0, 0, 0, true, true, true)
    AttachEntityToEntity(SpatelObject, ped, GetPedBoneIndex(ped, 57005), 0.08, 0.0, -0.02, 0.0, -25.0, 130.0, true, true, false, true, 1, true)
    FreezeEntityPosition(playerPed, true)
    QBCore.Functions.Progressbar("starbucks_makefood", "Making IcedLatte...", 20000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function() -- Done    
    
    DetachEntity(SpatelObject)
    DeleteEntity(SpatelObject)
    ClearPedTasksImmediately(ped)
    FreezeEntityPosition(playerPed, false)
    TriggerServerEvent('sbrulezop:server:icedlatte')

end)
end

function Frappe()
    local ped = GetPlayerPed(-1)
    local playerPed = PlayerPedId()
    local src = source 


    LoadAnim('amb@prop_human_bbq@male@idle_a')
    TaskPlayAnim(ped, 'amb@prop_human_bbq@male@idle_a', 'idle_b', 6.0, -6.0, -1, 47, 0, 0, 0, 0)
    SpatelObject = CreateObject(GetHashKey("prop_fish_slice_01"), 0, 0, 0, true, true, true)
    AttachEntityToEntity(SpatelObject, ped, GetPedBoneIndex(ped, 57005), 0.08, 0.0, -0.02, 0.0, -25.0, 130.0, true, true, false, true, 1, true)
    FreezeEntityPosition(playerPed, true)
    QBCore.Functions.Progressbar("starbucks_makefood", "Making Frappe Coffee...", 20000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function() -- Done    
    
    DetachEntity(SpatelObject)
    DeleteEntity(SpatelObject)
    ClearPedTasksImmediately(ped)
    FreezeEntityPosition(playerPed, false)
    TriggerServerEvent('sbrulezop:server:frappe')

end)
end

function Cappuccino()
    local ped = GetPlayerPed(-1)
    local playerPed = PlayerPedId()
    local src = source 


    LoadAnim('amb@prop_human_bbq@male@idle_a')
    TaskPlayAnim(ped, 'amb@prop_human_bbq@male@idle_a', 'idle_b', 6.0, -6.0, -1, 47, 0, 0, 0, 0)
    SpatelObject = CreateObject(GetHashKey("prop_fish_slice_01"), 0, 0, 0, true, true, true)
    AttachEntityToEntity(SpatelObject, ped, GetPedBoneIndex(ped, 57005), 0.08, 0.0, -0.02, 0.0, -25.0, 130.0, true, true, false, true, 1, true)
    FreezeEntityPosition(playerPed, true)
    QBCore.Functions.Progressbar("starbucks_makefood", "Making Cappuccino Coffee...", 20000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function() -- Done    
    
    DetachEntity(SpatelObject)
    DeleteEntity(SpatelObject)
    ClearPedTasksImmediately(ped)
    FreezeEntityPosition(playerPed, false)
    TriggerServerEvent('sbrulezop:server:cappucino')
end)
end

function HotChocolate()
    local ped = GetPlayerPed(-1)
    local playerPed = PlayerPedId()
    local src = source 


    LoadAnim('amb@prop_human_bbq@male@idle_a')
    TaskPlayAnim(ped, 'amb@prop_human_bbq@male@idle_a', 'idle_b', 6.0, -6.0, -1, 47, 0, 0, 0, 0)
    SpatelObject = CreateObject(GetHashKey("prop_fish_slice_01"), 0, 0, 0, true, true, true)
    AttachEntityToEntity(SpatelObject, ped, GetPedBoneIndex(ped, 57005), 0.08, 0.0, -0.02, 0.0, -25.0, 130.0, true, true, false, true, 1, true)
    FreezeEntityPosition(playerPed, true)
    QBCore.Functions.Progressbar("starbucks_makefood", "Making HotChocolate Coffee...", 20000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function() -- Done        
    DetachEntity(SpatelObject)
    DeleteEntity(SpatelObject)
    ClearPedTasksImmediately(ped)
    FreezeEntityPosition(playerPed, false)
    TriggerServerEvent('sbrulezop:server:hotchocolate')
end)
end


function ogVehicleSpawn()
    ped = GetPlayerPed(-1);
    MenuTitle = "Garage"
    ClearMenu()
    Menu.addButton("Vehicle", "VehicleList", nil)
    Menu.addButton("Close menu", "closeMenuFull", nil) 
end

function VehicleList(isDown)
    ped = GetPlayerPed(-1);
    MenuTitle = "Vehicle:"
    ClearMenu()
    for k, v in pairs(Config.Vehicles) do
        Menu.addButton(Config.Vehicles[k], "TakeOutVehicle", k, "Garage", " Engine: 100%", " Body: 100%", " Fuel: 100%")
    end
        
    Menu.addButton("Return", "MachineMenu",nil)
end

function TakeOutVehicle(vehicleInfo)
    local coords = Config.Locations["ogcarspawn"].coords
    QBCore.Functions.SpawnVehicle(vehicleInfo, function(veh)
        SetVehicleNumberPlateText(veh, "TOWR"..tostring(math.random(1000, 9999)))
        SetEntityHeading(veh, coords.h)
        exports['LegacyFuel']:SetFuel(veh, 100.0)
        closeMenuFull()
        TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
        SetVehicleEngineOn(veh, true, true)
        CurrentPlate = GetVehicleNumberPlateText(veh)
    end, coords, true)
end


function LoadAnim(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(1)
    end
end

function LoadModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(1)
    end
end


function MachineMenu()
    ped = GetPlayerPed(-1);
    MenuTitle = "MachineMenu" 
    ClearMenu()
    Menu.addButton("Food", "FoodList", nil)
    Menu.addButton("Drinks", "DrinksList", nil)
    Menu.addButton("Close menu", "closeMenuFull", nil) 
end

function FoodList(isDown)
    ped = GetPlayerPed(-1);
    MenuTitle = "Vehicles:"
    ClearMenu()
        Menu.addButton("Club Sandwich", "Clubsandwich", nil)
        Menu.addButton("White Chocolate Donut", "WhiteChocolateDonut", nil)
        Menu.addButton("Strawberry Donut", "StrawberryDonut", nil)
        Menu.addButton("Chips", "Chips", nil)
        Menu.addButton("Cheesy Pie", "CheesyPie", nil)
        Menu.addButton("Galaktoboureko", "Galaktoboureko", nil)
        Menu.addButton("Bougatsa", "Espresso", nil)

    Menu.addButton("Back", "MachineMenu",nil)
end

function DrinksList(isDown)
    ped = GetPlayerPed(-1);
    MenuTitle = "MachineMenu:"
    ClearMenu()
        Menu.addButton("Espresso", "Espresso", nil)
        Menu.addButton("Iced Latte", "IcedLatte", nil)
        Menu.addButton("Frappé", "Frappe", nil)
        Menu.addButton("Cappuccino", "Cappuccino", nil)
        Menu.addButton("Hot Chocolate", "HotChocolate", nil)

    Menu.addButton("Back", "MachineMenu",nil)
end

function closeMenuFull()
    Menu.hidden = true
    currentGarage = nil
    ClearMenu()
end
