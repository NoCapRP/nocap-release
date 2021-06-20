Config = {}

Config.Locations = {
    ["vehiclegundealer"] = {
        label = "Car Spawn",
        coords = {x = 934.62255859375, y = -1.5961220264435, z = 78.764038085938},
    },
    ["gundealerweapons"] = {
        label = "Casino-Shop",
        coords = {x =935.82293701172, y = 5.785270690918,  z = 75.491317749023},
    },
    ["stashgundealer"] = {
        label = "Casino-Stash",
        coords = {x = 957.45025634766, y = 16.217056274414, z = 75.741302490234},
    },
}

Config.Vehicles = {
    ["boss302"] = "Boss Car",

}

Config.GunDealer = {
    label = "Casino",
    slots = 30,
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