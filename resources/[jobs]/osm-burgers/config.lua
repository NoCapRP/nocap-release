Config = {}

Config.JobStart = {
	{ ["x"] = 94.06, ["y"] = 285.68, ["z"] = 110.51, ["h"] = 0 },
}

Config.PickUpStuff = {
	{ ["x"] = 650.68, ["y"] = 2727.25, ["z"] = 41.99, ["h"] = 0 },
}

Config.PaymentTaco = math.random(350, 450)

Config.BurgerPrice = 50 -- Driveby Burger Price

Config.Driveby = math.random(250, 350) 

Config.JobBusy = false

Config.JobData = {
 ['burgers'] = 0,
 ['register'] = 0,
 ['stock-lettuce'] = 0,
 ['stock-bread'] = 0,
 ['stock-meat'] = 0,
 ['green-tacos'] = 110,
 ['locations'] = {
    [1] = {
	  ['name'] = 'Lettuce', 
	  x = 94.508323669434,
	  y = 289.02374267578,
	  z = 110.23069763184,
	},
	[2] = {
	  ['name'] = 'Meat', 
	  x = 89.537620544434,
	  y = 293.32708740234,
	  z = 110.23068237305,
	},
	[3] = {
	  ['name'] = 'Shell', 
	  x = 88.833717346191,
	  y = 291.26501464844,
	  z = 110.23065185547,
	},
	[4] = {
		['name'] = 'Register', 
		x = 89.974540710449,
		y = 286.07818603516,
		z = 110.23068237305,
	  },
	[5] = {
		['name'] = 'GiveTaco', 
		x = 91.291000366211,
		y = 288.404388427736,
		z = 110.23068237305,
	  },
	[6] = {
		['name'] = 'Stock', 
		x = 90.426643371582,
		y = 291.17086791992,
		z = 110.23069763184,
	  },
	[7] = {
		['name'] = 'Bun', 
		x = 96.01,
		y = 292.66,
		z = 110.21,
	  },
	[8] = {
		['name'] = 'Driveby', 
		x = 96.56,
		y = 284.45,
		z = 110.51,
	  },
  },
}