Config = {}

Config = {
    ChanceToGetItem = 20, -- if math.random(0, 100) <= ChanceToGetItem then give item
    Items = {'wood_cut','wood_cut','wood_cut','wood_cut','wood_cut'},
    Process = vector3(-584.66, 5285.63, 70.26),
    Objects = {
        ['pickaxe'] = 'w_me_hatchet',
    },
    WoodPosition = {
        {coords = vector3(-493.0, 5395.37, 77.18-0.97), heading = 282.49},
        {coords = vector3(-503.69, 5392.12, 75.98-0.97), heading = 113.62},
        {coords = vector3(-456.85, 5397.37, 79.49-0.97), heading = 29.92},
        {coords = vector3(-457.42, 5409.05, 78.78-0.97), heading = 209.65}
    },
    
   
}

Config.textDel = 'Press (~g~[E]~w~) Cutt wood. Press (~g~[Backspace]~w~) to quit cutting wood. '

Strings = {
   
    ['someone_close'] = 'There is a player too close to you!',
    ['wood'] = 'Woodcutter',
    ['process'] = 'Process Wood',
    ['sell_wood'] = 'Sell Wood',
}