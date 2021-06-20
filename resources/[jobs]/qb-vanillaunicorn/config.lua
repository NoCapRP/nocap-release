Config = Config or {}

Config.Locations = {
	['shop'] = { ['x'] = 134.79779052734, ['y'] = -1281.6751708984, ['z'] = 29.25549697876, ['h'] = 266.37 },
	['claim'] = { ['x'] = 128.1915435791, ['y'] = -1285.8458251953, ['z'] = 29.255483627319, ['h'] = 295.78 },
	['vip'] = { ['x'] = 92.152587890625, ['y'] = -1297.1905517578, ['z'] = 29.255495071411, ['h'] = 197.61 },
	['stripper'] = { ['x'] = 111.39879608154, ['y'] = -1302.4102783203, ['z'] = 29.255504608154, ['h'] = 35.44  },
	['boss'] = { ['x'] = 97.271774291992, ['y'] = -1303.640625, ['z'] = 29.255506515503, ['h'] = 318.48  },
}

Config['PoleDance'] = { -- allows you to pole dance at the strip club, you can of course add more locations if you want.
    ['Enabled'] = true,
    ['Locations'] = {
        {['Position'] = vector3(108.75035095215,-1286.7696533203,28.454189300537), ['Number'] = '1'}
    }
}

Strings = {
    ['Pole_Dance'] = '[~r~E~w~] Poledance',
}

Config.Strippers = {
    ['locations'] ={
        {
            ['taken'] = 0,
            ['model'] = nil,
            ['sit'] = vector4(117.69651794434,-1294.4313964844,29.255504608154, 251.7),
            ['stand'] = vector4(118.46711730957,-1293.1396484375,29.255506515503, 172.76),
        },
        {
            ['taken'] = 0,
            ['model'] = nil,
            ['sit'] = vector4(116.74626, -1303.393, 28.273693, 32.705486),
            ['stand'] = vector4(116.29303, -1302.636, 28.269521, 207.09544),
        },
        {
            ['taken'] = 0,
            ['model'] = nil,
            ['sit'] = vector4(114.60829, -1304.639, 28.269498, 25.138725),
            ['stand'] = vector4(114.19611, -1303.985, 28.269498, 207.37702),
        },
        {
            ['taken'] = 0,
            ['model'] = nil,
            ['sit'] = vector4(112.82508, -1305.668, 28.2695, 30.056648),
            ['stand'] = vector4(112.34696, -1305.062, 28.269504, 202.59379),
        },
        {
            ['taken'] = 0,
            ['model'] = nil,
            ['sit'] = vector4(112.82508, -1305.668, 28.2695, 30.056648),
            ['stand'] = vector4(112.34696, -1305.062, 28.269504, 202.59379),
        },
    },
    ['peds'] = {
       'csb_stripper_01', -- White Stripper
	   's_f_y_stripperlite', -- Black Stripper
       'mp_f_stripperlite', -- Black Stripper
    }
}

Config.Items = {
    label = "Vanilla Unicorn",
    slots = 1,
    items = {
        [1] = {
            name = "vodka",
            price = 4,
            amount = 125,
            info = {},
            type = "item",
            slot = 1,
		},
        [2] = {
            name = "beer",
            price = 4,
            amount = 125,
            info = {},
            type = "item",
            slot = 2,
        },
        [3] = {
            name = "whiskey",
            price = 4,
            amount = 125,
            info = {},
            type = "item",
            slot = 3,
        },
        [4] = {
            name = "coffee",
            price = 7,
            amount = 125,
            info = {},
            type = "item",
            slot = 4,
        }
    }
}

Config.BossItems = {
    label = "Vanilla Unicorn VIP",
    slots = 1,
    items = {
        [1] = {
            name = "vodka",
            price = 0,
            amount = 125,
            info = {},
            type = "item",
            slot = 1,
		},
        [2] = {
            name = "beer",
            price = 0,
            amount = 125,
            info = {},
            type = "item",
            slot = 2,
        },
        [3] = {
            name = "whiskey",
            price = 0,
            amount = 125,
            info = {},
            type = "item",
            slot = 3,
        },
        [4] = {
            name = "coffee",
            price = 0,
            amount = 125,
            info = {},
            type = "item",
            slot = 4,
        },
        [5] = {
            name = "kurkakola",
            price = 0,
            amount = 125,
            info = {},
            type = "item",
            slot = 5,
        }
    }
}