QBCore = nil

QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

-- Code
TriggerEvent('QBCore:getSharedObject', function(obj) QBCore = obj end)



RegisterServerEvent('QBCore:startcarTimer')
AddEventHandler('QBCore:startcarTimer', function(car)
    startTimer(source, car)
end)

RegisterServerEvent('sbop:server:rewarditem')
AddEventHandler('sbop:server:rewarditem', function(listKey)
    local src = source 
    local Player = QBCore.Functions.GetPlayer(src)
        for i = 1, math.random(1, 1), 1 do
            local item = Config.Items[math.random(1, #Config.Items)]
            Player.Functions.AddItem(item, math.random(0, 1))
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add')
            Citizen.Wait(500)
        end
        local Luck = math.random(1, 1)
        local Odd = math.random(1, 4)
        if Luck == Odd then
            local random = math.random(1, 1)
            Player.Functions.AddItem("walkstick", random)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["walkstick"], 'add')
        end
end)

function startTimer(id, object)
    local timer = 10 * 60000

    while timer > 0 do
        Wait(1000)
        timer = timer - 1000
        if timer == 0 then
            TriggerClientEvent('QBCore:removecar', id, object)
        end
    end
end