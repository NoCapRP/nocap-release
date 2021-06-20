Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}

Consumeables = {
    ["sandwich"] = math.random(35, 54),
    ["water_bottle"] = math.random(35, 54),
    ["tosti"] = math.random(40, 50),
    ["burger"] = math.random(40, 50),
    ["kurkakola"] = math.random(35, 54),
    ["twerks_candy"] = math.random(35, 54),
    ["snikkel_candy"] = math.random(40, 50),
    ["coffee"] = math.random(40, 50),
    ["whiskey"] = math.random(20, 30),
    ["beer"] = math.random(30, 40),
    ["vodka"] = math.random(20, 40),
    ["clubsandwich"] = math.random(35, 54),
    ["whitechocolatedonut"] = math.random(35, 54),
    ["galaktoboureko"] = math.random(35, 54),
    ["cheesypie"] = math.random(35, 54),
    ["chips"] = math.random(35, 54),
    ["strawberrydonut"] = math.random(35, 54),
    ["espresso"] = math.random(35, 54),
    ["icedlatte"] = math.random(35, 54),
    ["cappucino"] = math.random(35, 54),
    ["frappe"] = math.random(35, 54),
    ["hotchocolate"] = math.random(35, 54),

}

Config = {}

Config.RemoveWeaponDrops = true
Config.RemoveWeaponDropsTimer = 25

Config.JointEffectTime = 60

Config.BlacklistedScenarios = {
    ['TYPES'] = {
        "WORLD_VEHICLE_MILITARY_PLANES_SMALL",
        "WORLD_VEHICLE_MILITARY_PLANES_BIG",
    },
    ['GROUPS'] = {
        2017590552,
        2141866469,
        1409640232,
        `ng_planes`,
    }
}

Config.BlacklistedVehs = {
    [`SHAMAL`] = false,
    [`LUXOR`] = false,
    [`LUXOR2`] = false,
    [`JET`] = false,
    [`LAZER`] = false,
    [`BUZZARD`] = false,
    [`BUZZARD2`] = false,
    [`ANNIHILATOR`] = false,
    [`SAVAGE`] = false,
    [`TITAN`] = false,
    [`RHINO`] = false,
    [`POLICE`] = false,
    [`POLICE2`] = false,
    [`POLICE3`] = false,
    [`POLICE4`] = false,
    [`POLICEB`] = false,
    [`POLICET`] = false,
    [`SHERIFF`] = false,
    [`SHERIFF2`] = false,
    [`FIRETRUK`] = false,
    [`MULE`] = false,
    [`POLMAV`] = false,
    [`MAVERICK`] = false,
    [`BLIMP`] = false,
    [`AIRTUG`] = false,
    [`CAMPER`] = false,   
}

Config.BlacklistedPeds = {
    [`s_m_y_ranger_01`] = true,
    [`s_m_y_sheriff_01`] = true,
    [`s_m_y_cop_01`] = true,
    [`s_f_y_sheriff_01`] = true,
    [`s_f_y_cop_01`] = true,
    [`s_m_y_hwaycop_01`] = true,
}