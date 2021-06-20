Config = {}

Config.Debug = false
Config.JobBusy = false

Config.MarkerData = {
    ["type"] = 6,
    ["size"] = vector3(2.0, 2.0, 2.0),
    ["color"] = vector3(0, 255, 150)
}



Config.FishingItems = {
    ["rod"] = {
        ["name"] = "fishingrod",
        ["label"] = "Fishing Rod"
    },
    ["bait"] = {
        ["name"] = "fishingbait",
        ["label"] = "Fishing Bait"
    },
    ["fish"] = {
        ["price"] = 100
    },
    ["stripedbass"] = {
        ["price"] = 150
    },
    ["bluefish"] = {
        ["price"] = 200
    },
    ["redfish"] = {
        ["price"] = 250
    },
    ["pacifichalibut"] = {
        ["price"] = 300
    },
    ["goldfish"] = {
        ["price"] = 350
    },
    ["largemouthbass"] = {
        ["price"] = 400
    },
    ["salmon"] = {
        ["price"] = 450
    },
    ["catfish"] = {
        ["price"] = 500
    },
    ["tigersharkmeat"] = {
        ["price"] = 550
    },
    ["stingraymeat"] = {
        ["price"] = 600
    },
    ["killerwhalemeat"] = {
        ["price"] = 650
    },
}

Config.FishingZones = {
    {
        ["name"] = "Beach Fishing",
        ["coords"] = vector3(-1948.1279296875, -749.79125976563, 2.5400819778442),
        ["radius"] = 50.0,
    },
    {
        ["name"] = "Ocean Fishing",
        ["coords"] = vector3(-1835.0385742188, -1820.4168701172, 3.6758048534393),
        ["radius"] = 200.0,
    }
}
