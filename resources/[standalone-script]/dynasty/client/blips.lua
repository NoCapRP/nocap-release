local blips = {


  {title="Weed", colour=25, id=140, x = 310.91, y = 4290.87, z = 45.15}, -- For example
  {title="Weed Processing", colour=25, id=140, x = 2328.92, y = 2571.35, z = 46.387}, -- For example
  {title="Coke", colour=24, id=514, x = 2122.2004394531, y = 4784.7919921875, z = 40.970275878906}, -- For example
  {title="Coke Processing", colour=24, id=514, x = 2431.57, y = 4971.2, z = 42.35}, -- For example
  {title="Catch Chicken", colour=5, id=233, x = 2388.37, y =  5045.8, z = 46.37}, -- Chicekn
  {title="Process Chicken", colour=5, id=233, x = -95.72, y =  6207.15, z = 31.03}, -- Chicekn
  {title="Sell Chickens", colour=5, id=233, x = 1469.1856689453, y =  6541.2602539062, z = 14.680911064148}, -- Chicekn
  {title="Gun Heist", colour=53, id=567, x = 1275.639, y =  -1710.568, z = 54.771}, -- Chicekn
  {title="Oxyruns",color=9, id= 403, x= 68.75,  y= -1569.87,  z =  29.6},
  {title="Drug Selling Zone", colour=1 , id=161, x = 295.14, y = 181.55, z = 104.25}, -- For example
  {title="Drug Selling Zone", colour=1 , id=161, x = 35.21, y = -1889.84, z = 22.13}, -- For example
  {title="Strip Club", colour=7 , id=121, x = 126.01577758789, y = -1297.2819824219, z = 29.269527435303},
  {title="Pawn Shop", colour=28 , id=605, x = -505.36, y = -695.75, z = 20.03},
  {title="Gold Bars", colour=46 , id=618,x = -1459.3, y = -413.6, z = 35.74},
  {title="Melting", colour=46 , id=618,x = 1087.92, y = -2001.95, z = 30.88},
  {title="Crafting", colour=15 , id=643,x = 135.49873352051, y = -3111.7392578125, z = 5.8963084220886},
  ------------------------------GANGS----------------------------------------
  {title="Ballas", colour=27 , id=84,x = 35.21, y = -1889.84, z = 22.13},
  {title="Vagos ", colour=46 , id=84,x = 305.76077270508, y = -2016.7679443359, z = 20.199161529541},
  {title="Marabunta  ", colour=3 , id=84,x = 1432.0805664062, y = -1511.7840576172, z = 61.763484954834},
  {title="Families", colour=2 , id=84,x = -100.47002410889, y = -1592.3553466797, z = 31.535570144653},
 }
     
Citizen.CreateThread(function()

   for _, info in pairs(blips) do
     info.blip = AddBlipForCoord(info.x, info.y, info.z)
     SetBlipSprite(info.blip, info.id)
     SetBlipDisplay(info.blip, 4)
     SetBlipScale(info.blip, 0.8)
     SetBlipColour(info.blip, info.colour)
     SetBlipAsShortRange(info.blip, true)
   BeginTextCommandSetBlipName("STRING")
     AddTextComponentString(info.title)
     EndTextCommandSetBlipName(info.blip)
   end
end)
