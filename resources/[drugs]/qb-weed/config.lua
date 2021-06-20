Config = {}

Config.Locale = 'en'

Config.Delays = {
	WeedProcessing = 1000 * 3
}

Config.DrugDealerItems = {
	marijuana = 50
}

Config.LicenseEnable = false -- enable processing licenses? The player will be required to buy a license in order to process drugs. Requires esx_license

-- Config.LicensePrices = {
-- 	weed_processing = {label = _U('license_weed'), price = 10000}
-- }

Config.GiveBlack = true -- give black money? if disabled it'll give regular cash.

Config.CircleZones = {
	WeedField = {coords = vector3(310.91, 4290.87, 45.15), name = 'blip_weedfield', color = 25, sprite = 496, radius = 120.0},
	WeedProcessing = {coords = vector3(1392.02, 3605.74, 38.68), name = 'blip_weedprocessing', color = 25, sprite = 496, radius = 100.0},
	WeedProcessingmarijuana = {coords = vector3(2328.92, 2571.35, 46.387), name = 'blip_weedprocessing', color = 25, sprite = 496, radius = 100.0},
	
}