Config = Config or {}

Config.RepeatTimeout = 2000
Config.CallRepeats = 10
Config.OpenPhone = 289
Config.PhoneApplications = {
    ["phone"] = {
        app = "phone",
        color = "#04b543",
        icon = "fa fa-phone-alt",
        tooltipText = "Phone",
        tooltipPos = "top",
        job = false,
        blockedjobs = {},
        slot = 1,
        Alerts = 0,
    },
    ["whatsapp"] = {
        app = "whatsapp",
        color = "#25d366",
        icon = "fab fa-whatsapp",
        tooltipText = "Whatsapp",
        tooltipPos = "top",
        style = "font-size: 2.8vh";
        job = false,
        blockedjobs = {},
        slot = 2,
        Alerts = 0,
    },
    ["settings"] = {
        app = "settings",
        color = "#636e72",
        icon = "fa fa-cog",
        tooltipText = "Settings",
        tooltipPos = "top",
        style = "padding-right: .08vh; font-size: 2.3vh";
        job = false,
        blockedjobs = {},
        slot = 3,
        Alerts = 0,
    },
    ["twitter"] = {
        app = "twitter",
        color = "#1da1f2",
        icon = "fab fa-twitter",
        tooltipText = "Twitter",
        tooltipPos = "top",
        job = false,
        blockedjobs = {},
        slot = 4,
        Alerts = 0,
    },
    ["garage"] = {
        app = "garage",
        color = "#575fcf",
        icon = "fas fa-warehouse",
        tooltipText = "Vehicles",
        job = false,
        blockedjobs = {},
        slot = 5,
        Alerts = 0,
    },
    ["mail"] = {
        app = "mail",
        color = "#ff002f",
        icon = "fas fa-envelope",
        tooltipText = "Mail",
        job = false,
        blockedjobs = {},
        slot = 6,
        Alerts = 0,
    },
    ["advert"] = {
        app = "advert",
        color = "#ff8f1a",
        icon = "fas fa-ad",
        tooltipText = "Advertisements",
        job = false,
        blockedjobs = {},
        slot = 7,
        Alerts = 0,
    },
    ["bank"] = {
        app = "bank",
        color = "#9c88ff",
        icon = "fas fa-university",
        tooltipText = "Bank",
        job = false,
        blockedjobs = {},
        slot = 8,
        Alerts = 0,
    },

    ["houses"] = {
        app = "houses",
        color = "#27ae60",
        icon = "fas fa-home",
        tooltipText = "Houses",
        job = false,
        blockedjobs = {},
        slot = 11,
        Alerts = 0,
    },
    
    -- ["trucker"] = {
    --     app = "trucker",
    --     color = "#cccc33",
    --     icon = "fas fa-truck-moving",
    --     tooltipText = "Dumbo",
    --     tooltipPos = "right",
    --     job = false,
    --     blockedjobs = {},
    --     slot = 17,
    --     Alerts = 0,
    -- },
}
Config.MaxSlots = 20

Config.StoreApps = {
    ["territory"] = {
        app = "territory",
        color = "#353b48",
        icon = "fas fa-globe-europe",
        tooltipText = "Territorium",
        tooltipPos = "right",
        style = "";
        job = false,
        blockedjobs = {},
        slot = 15,
        Alerts = 0,
        password = true,
        creator = "Qbus",
        title = "Territory",
    },
}