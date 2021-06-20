QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)


RegisterServerEvent('sbrulezop:server:clubsandwich')
AddEventHandler('sbrulezop:server:clubsandwich', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
     local amount = 1
           if Player.Functions.AddItem("clubsandwich", amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["clubsandwich"], 'add')
            TriggerClientEvent('QBCore:Notify', src, 'You Just Made A Club SandWich..', 'error')  
     end
end)

RegisterServerEvent('sbrulezop:server:whitechocolatedonut')
AddEventHandler('sbrulezop:server:whitechocolatedonut', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
     local amount = 1
           if Player.Functions.AddItem("whitechocolatedonut", amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["whitechocolatedonut"], 'add')
            TriggerClientEvent('QBCore:Notify', src, 'You Just Made A White Chocolate Donut ..', 'error')      
     end
end)

RegisterServerEvent('sbrulezop:server:strawberrydonut')
AddEventHandler('sbrulezop:server:strawberrydonut', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
     local amount = 1
           if Player.Functions.AddItem("strawberrydonut", amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["strawberrydonut"], 'add')
            TriggerClientEvent('QBCore:Notify', src, 'You Just Made A Strawberry Donut..', 'error')      
     end
end)

RegisterServerEvent('sbrulezop:server:chips')
AddEventHandler('sbrulezop:server:chips', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
     local amount = 1
           if Player.Functions.AddItem("chips", amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["chips"], 'add')
            TriggerClientEvent('QBCore:Notify', src, 'You Just Made A Chips..', 'error')      
     end
end)

RegisterServerEvent('sbrulezop:server:cheesypie')
AddEventHandler('sbrulezop:server:cheesypie', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
     local amount = 1
           if Player.Functions.AddItem("cheesypie", amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["cheesypie"], 'add')
            TriggerClientEvent('QBCore:Notify', src, 'You Just Made A Cheesy Pie..', 'error')      
     end
end)

RegisterServerEvent('sbrulezop:server:galaktoboureko')
AddEventHandler('sbrulezop:server:galaktoboureko', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
     local amount = 1
           if Player.Functions.AddItem("galaktoboureko", amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["galaktoboureko"], 'add')
            TriggerClientEvent('QBCore:Notify', src, 'You Just Made A Galaktoboureko..', 'error')      
     end
end)

RegisterServerEvent('sbrulezop:server:espresso')
AddEventHandler('sbrulezop:server:espresso', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
     local amount = 1
           if Player.Functions.AddItem("espresso", amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["espresso"], 'add')
            TriggerClientEvent('QBCore:Notify', src, 'You Just Made A Espresso..', 'error')      
     end
end)

RegisterServerEvent('sbrulezop:server:icedlatte')
AddEventHandler('sbrulezop:server:icedlatte', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
     local amount = 1
           if Player.Functions.AddItem("icedlatte", amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["icedlatte"], 'add')
            TriggerClientEvent('QBCore:Notify', src, 'You Just Made A IcedLatte..', 'error')      
     end
end)


RegisterServerEvent('sbrulezop:server:frappe')
AddEventHandler('sbrulezop:server:frappe', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
     local amount = 1
           if Player.Functions.AddItem("frappe", amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["frappe"], 'add')
            TriggerClientEvent('QBCore:Notify', src, 'You Just Made A Frappe..', 'error')      
     end
end)

RegisterServerEvent('sbrulezop:server:cappucino')
AddEventHandler('sbrulezop:server:cappucino', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
     local amount = 1
           if Player.Functions.AddItem("cappucino", amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["cappucino"], 'add')
            TriggerClientEvent('QBCore:Notify', src, 'You Just Made A Cappucino..', 'error')      
     end
end)

RegisterServerEvent('sbrulezop:server:hotchocolate')
AddEventHandler('sbrulezop:server:hotchocolate', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
     local amount = 1
           if Player.Functions.AddItem("hotchocolate", amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["hotchocolate"], 'add')
            TriggerClientEvent('QBCore:Notify', src, 'You Just Made A Hot Chocolate..', 'error')      
     end
end)

