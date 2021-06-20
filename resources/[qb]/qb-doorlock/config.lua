QB = {}

QB.Doors = {
	{
		textCoords = vector3(434.81, -981.93, 30.89),
	authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = false,
		pickable = false,
		distance = 2.5,
		doors = {
			{
				objName = "gabz_mrpd_reception_entrancedoor",
				objYaw = -90.0,
				objCoords = vector3(434.7444, -980.7556, 30.8153)
			},

			{
				objName = "gabz_mrpd_reception_entrancedoor",
				objYaw = 90.0,
				objCoords = vector3(434.7444, -983.0781, 30.8153)
			}
		}
	},
	{
		objName = "gabz_mrpd_door_04",
		objYaw = 0.0,
		objCoords = vector3(440.5201, -977.6011, 30.82319),
		textCoords = vector3(440.5201, -977.6011, 30.82319),
	authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},

	{
		objName = "gabz_mrpd_door_05",
		objYaw = 180.0,
		objCoords = vector3(440.5201, -986.2335, 30.82319),
		textCoords = vector3(440.5201, -986.2335, 30.82319),
	authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},
	-- Hallway to roof
	{
		objName = "gabz_mrpd_door_04",
		objYaw = 90.0,
		objCoords = vector3(445.4067, -984.2014, 30.82319),
		textCoords = vector3(445.4067, -984.2014, 30.82319),
	authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},
	-- Armory
	{
		objName = "gabz_mrpd_door_05",
		objYaw = 135.0,
		objCoords = vector3(452.2663, -995.5254, 30.82319),
		textCoords = vector3(452.2663, -995.5254, 30.82319),
	authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},
	-- {
		-- objName = 'v_ilev_gtdoor',
		-- objYaw = -90.0,
		-- objCoords  = vector3(452.6, -982.7, 30.6), 
		-- textCoords = vector3(452.95, -982.16, 30.99),
		-- authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		-- locking = false,
		-- locked = true,
		-- pickable = false,
		-- distance = 1.5,
	-- },
	-- Captain Office
	{
		objName = "gabz_mrpd_door_02",
		objYaw = 225.0,
		objCoords = vector3(458.0894, -995.5247, 30.82319),
		textCoords = vector3(458.0894, -995.5247, 30.82319),
	authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},
	-- To downstairs (double doors)
	{
		textCoords = vector3(444.71, -989.43, 30.92),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		doors = {
			{
				objName = 'v_ilev_ph_gendoor005',
				objYaw = 180.0,
				objCoords = vector3(443.9, -989.0, 30.6)
			},

			{
				objName = 'v_ilev_ph_gendoor005',
				objYaw = 0.0,
				objCoords = vector3(445.3, -988.7, 30.6)
			}
		}
	},
	--
	-- Mission Row Cells
	--
	-- Main Cells
	{ -- DOOR 9
	objName = "gabz_mrpd_door_05",
	objYaw = 270.0,
	objCoords = vector3(458.6543, -990.6498, 30.82319),
	textCoords = vector3(458.6543, -990.6498, 30.82319),
authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
	locking = false,
	locked = true,
	pickable = false,
	distance = 2.0,
	size = 2
},
	-- Cell 1
	{
		objName = "gabz_mrpd_door_04",
		objYaw = 270.0,
		objCoords = vector3(458.6543, -976.8864, 30.82319),
		textCoords = vector3(458.6543, -976.8864, 30.82319),
	authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},
	-- Cell 2
	{
		objName = "gabz_mrpd_cells_door",
		objYaw = 180.0,
		objCoords = vector3(481.0084, -1004.118, 26.48005),
		textCoords = vector3(481.0084, -1004.118, 26.48005),
	authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},
	-- Cell 3
	{
		objName = "gabz_mrpd_cells_door",
		objYaw = 180.0,
		objCoords = vector3(484.1764, -1007.734, 26.48005),
		textCoords = vector3(484.1764, -1007.734, 26.48005),
	authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},
	

	-- Door 20
	{
		objName = "gabz_mrpd_cells_door",
		objYaw = 0.0,
		objCoords = vector3(486.9131, -1012.189, 26.48005),
		textCoords = vector3(486.9131, -1012.189, 26.48005),
	authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},
	--
	-- Mission Row Back
	--
	-- Back (double doors)
	{
		textCoords = vector3(468.67, -1014.43, 26.48),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.5,
		doors = {
			{
				objName = 'v_ilev_rc_door2',
				objYaw = 0.0,
				objCoords  = vector3(467.3, -1014.4, 26.5)
			},

			{
				objName = 'v_ilev_rc_door2',
				objYaw = 180.0,
				objCoords  = vector3(469.9, -1014.4, 26.5)
			}
		}
	},
	-- Back Gate
	{
		objName = 'hei_prop_station_gate',
		objYaw = 90.0,
		objCoords  = vector3(488.8, -1017.2, 27.1),
		textCoords = vector3(488.8, -1020.2, 30.0),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 14,
		size = 2
	},
	--
	-- Mission Row Extension
	--
	-- Briefing room
	{
		textCoords = vector3(455.86, -981.31, 26.86),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = false,
		pickable = false,
		distance = 2.5,
		doors = {
			{
				objName = 'v_ilev_ph_gendoor005',
				objYaw = 90.0,
				objCoords  = vector3(455.94, -980.57, 26.67)
			},

			{
				objName = 'v_ilev_ph_gendoor005',
				objYaw = 270.0,
				objCoords  = vector3(455.85, -982.14, 26.67)
			}
		}
	},
	-- To Breakrooms
	{
		objName = "gabz_mrpd_cells_door",
		objYaw = 0.0,
		objCoords = vector3(483.9127, -1012.189, 26.48005),
		textCoords = vector3(483.9127, -1012.189, 26.48005),
	authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},



	-- Door 22
	{
		objName = "gabz_mrpd_cells_door",
		objYaw = 0.0,
		objCoords = vector3(480.9128, -1012.189, 26.48005),
		textCoords = vector3(480.9128, -1012.189, 26.48005),
	authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},
	-- New Cell 2
	{
		objName = "gabz_mrpd_cells_door",
		objYaw = 0.0,
		objCoords = vector3(477.9126, -1012.189, 26.48005),
		textCoords = vector3(477.9126, -1012.189, 26.48005),
	authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},


	-- Door 24
	{
		objName = "gabz_mrpd_cells_door",
		objYaw = -90.0,
		objCoords = vector3(476.6157, -1008.875, 26.48005),
		textCoords = vector3(476.6157, -1008.875, 26.48005),
	authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},
	-- New Cell 4
	{
		objName = "gabz_mrpd_door_01",
		objYaw = 180.0,
		objCoords = vector3(475.9539, -1006.938, 26.40639),
		textCoords = vector3(475.9539, -1006.938, 26.40639),
	authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},
	-- To Photoroom
	{
		objName = 'v_ilev_ph_gendoor006',
		objYaw = 0.0,
		objCoords  = vector3(475.05, -995.08, 24.46),
		textCoords = vector3(475.05, -995.08, 24.46),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 1.0,
	},
	-- To Standplace
	{
		objName = 'v_ilev_ph_gendoor006',
		objYaw = 180.0,
		objCoords  = vector3(485.71, -996.08, 24.45),
		textCoords = vector3(485.71, -996.08, 24.45),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 1.0,
	},
	-- To Interigation 1
	{
		objName = 'v_ilev_ph_gendoor005',
		objYaw = 180.0,
		objCoords  = vector3(484.63, -999.74, 24.46),
		textCoords = vector3(484.63, -999.74, 24.46),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 1.0,
	},
	-- To Interigation 2
	{
		objName = 'v_ilev_ph_gendoor005',
		objYaw = 180.0,
		objCoords  = vector3(491.37, -999.81, 24.46),
		textCoords = vector3(491.37, -999.81, 24.46),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 1.0,
	},
	-- To Evidence
	{
		objName = 'v_ilev_ph_gendoor005',
		objYaw = 180.0,
		objCoords  = vector3(470.78, -992.21, 25.12),
		textCoords = vector3(470.78, -992.21, 25.12),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 1.0,
	},
	
	-- Bureau Paleto Bay
	{
		textCoords = vector3(-435.57, 6008.76, 27.98),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.5,
		doors = {
			{
				objName = 'v_ilev_ph_gendoor002',
				objYaw = -135.0,
				objCoords = vector3(-436.5157, 6007.844, 28.13839),			
			},
			{
				objName = 'v_ilev_ph_gendoor002',
				objYaw = 45.0,
				objCoords = vector3(-434.6776, 6009.681, 28.13839)			
			}
		}
	},	
	-- Achterdeur links
	{
		objName = 'v_ilev_rc_door2',
		objYaw = 135.0,
		objCoords  = vector3(-450.9664, 6006.086, 31.99004),		
		textCoords = vector3(-451.38, 6006.55, 31.84),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
	},
	-- Achterdeur rechts
	{
		objName = 'v_ilev_rc_door2',
		objYaw = -45.0,
		objCoords  = vector3(-447.2363, 6002.317, 31.84003),		
		textCoords = vector3(-446.77, 6001.84, 31.68),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
	},
	-- Kleedkamer
	{
		objName = 'v_ilev_rc_door2',
		objYaw = -45.0,
		objCoords  = vector3(-450.7136, 6016.371, 31.86523),				
		textCoords = vector3(-450.15, 6015.96, 31.71),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
	},	
	-- Kleedkamer 2
	{
		objName = 'v_ilev_rc_door2',
		objYaw = 45.0,
		objCoords  = vector3(-454.0435, 6010.243, 31.86106),						
		textCoords = vector3(-453.56, 6010.73, 31.71),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
	},	
	-- Wapenkamer
	{
		objName = 'v_ilev_arm_secdoor',
		objYaw = -135.0,
		objCoords  = vector3(-439.1576, 5998.157, 31.86815),						
		textCoords = vector3(-438.64, 5998.51, 31.71), 
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
	},	
	-- Verhoorkamer
	{
		objName = 'v_ilev_arm_secdoor',
		objYaw = 45.0,
		objCoords  = vector3(-436.6276, 6002.548, 28.14062),							
		textCoords = vector3(-437.09, 6002.100, 27.98),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
	},
	-- Entree cellen 1
	{
		objName = 'v_ilev_ph_cellgate1',
		objYaw = 45.0,
		objCoords  = vector3(-438.228, 6006.167, 28.13558),							
		textCoords = vector3(-438.610, 6005.64, 27.98),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
	},
	-- Entree cellen 2
	{
		objName = 'v_ilev_ph_cellgate1',
		objYaw = 45.0,
		objCoords  = vector3(-442.1082, 6010.052, 28.13558),							
		textCoords = vector3(-442.55, 6009.61, 27.98),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
	},	
	-- Cel
	{
		objName = 'v_ilev_ph_cellgate1',
		objYaw = 45.0,
		objCoords  = vector3(-444.3682, 6012.223, 28.13558),								
		textCoords = vector3(-444.77, 6011.74, 27.98),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
	},						
	-- Gang lockers (dubbele deuren)
	{
		textCoords = vector3(-442.09, 6011.93, 31.86523),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.5,
		doors = {
			{
				objName = 'v_ilev_rc_door2',
				objYaw = 225.0,
				objCoords  = vector3(-441.0185, 6012.795, 31.86523),			
			},

			{
				objName = 'v_ilev_rc_door2',
				objYaw = 45.0,
				objCoords  = vector3(-442.8578, 6010.958, 31.86523)			
			}
		}
	},	
	-- Gang naar achterkant (dubbele deuren)
	{
		textCoords = vector3(-448.67, 6007.52, 31.86523),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.5,
		doors = {
			{
				objName = 'v_ilev_rc_door2',
				objYaw = 135.0,
				objCoords = vector3(-447.7283, 6006.702, 31.86523),				
			},

			{
				objName = 'v_ilev_rc_door2',
				objYaw = -45.0,
				objCoords = vector3(-449.5656, 6008.538, 31.86523)		
			}
		}
	},				
	--
	-- Bolingbroke Penitentiary
	--
	-- Entrance (Two big gates)
	{
		objName = 'prop_gate_prison_01',
		objCoords  = vector3(1844.9, 2604.8, 44.6),
		textCoords = vector3(1844.9, 2608.5, 48.0),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 13,
		size = 2
	},
	{
		objName = 'prop_gate_prison_01',
		objCoords  = vector3(1818.5, 2604.8, 44.6),
		textCoords = vector3(1818.5, 2608.4, 48.0),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 13,
		size = 2
	},
	{
		objName = 'prop_gate_prison_01',
		objCoords = vector3(1799.237, 2616.303, 44.6),
		textCoords = vector3(1795.941, 2616.969, 48.0),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 10,
		size = 2
	},


	--outside doors
	{
		objName = 'prop_fnclink_03gate5',
		objCoords = vector3(1796.322, 2596.574, 45.565),
		textCoords = vector3(1796.322, 2596.574, 45.965),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.5,
		size = 2
	},
	{
		objName = 'v_ilev_gtdoor',
		objCoords = vector3(1821.677, 2477.265, 45.945),
		textCoords = vector3(1821.677, 2477.265, 45.945),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.5,
		size = 2
	},
	{
		objName = 'v_ilev_gtdoor',
		objCoords = vector3(1760.692, 2413.251, 45.945),
		textCoords = vector3(1760.692, 2413.251, 45.945),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.5,
		size = 2
	},
	{
		objName = 'v_ilev_gtdoor',
		objCoords = vector3(1543.58, 2470.252, 45.945),
		textCoords = vector3(1543.58, 2470.25, 45.945),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.5,
		size = 2
	},
	{
		objName = 'v_ilev_gtdoor',
		objCoords = vector3(1659.733, 2397.475, 45.945),
		textCoords = vector3(1659.733, 2397.475, 45.945),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.5,
		size = 2
	},
	{
		objName = 'v_ilev_gtdoor',
		objCoords = vector3(1537.731, 2584.842, 45.945),
		textCoords = vector3(1537.731, 2584.842, 45.945),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.5,
		size = 2
	},
	{
		objName = 'v_ilev_gtdoor',
		objCoords  = vector3(1571.964, 2678.354, 45.945),
		textCoords = vector3(1571.964, 2678.354, 45.945),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.5,
		size = 2
	},
	{
		objName = 'v_ilev_gtdoor',
		objCoords  = vector3(1650.18, 2755.104, 45.945),
		textCoords = vector3(1650.18, 2755.104, 45.945),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.5,
		size = 2
	},
	{
		objName = 'v_ilev_gtdoor',
		objCoords  = vector3(1771.98, 2759.98, 45.945),
		textCoords = vector3(1771.98, 2759.98, 45.945),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.5,
		size = 2
	},
	{
		objName = 'v_ilev_gtdoor',
		objCoords  = vector3(1845.7, 2699.79, 45.945),
		textCoords = vector3(1845.7, 2699.79, 45.945),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.5,
		size = 2
	},
	{
		objName = 'v_ilev_gtdoor',
		objCoords  = vector3(1820.68, 2621.95, 45.945),
		textCoords = vector3(1820.68, 2621.95, 45.945),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.5,
		size = 2
	},
	--
	-- Bolingbroke Extra
	--
	-- To Offices
	{
		objName = 'v_ilev_gtdoor',
		objYaw = 90.0,
		objCoords  = vector3(1819.129, 2593.64, 46.09929),
		textCoords = vector3(1843.3, 2579.39, 45.98),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},

	-- To Changingroom
	{
		objName = 'v_ilev_gtdoor',
		objYaw = 360.0,
		objCoords  = vector3(1827.365, 2587.547, 46.09929),
		textCoords = vector3(1835.76, 2583.15, 45.95),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},
	-- To CrimChangingroom
	{
		objName = 'v_ilev_gtdoor',
		objYaw = 90.0,
		objCoords  = vector3(1826.466, 2585.271, 46.09929),
		textCoords = vector3(1835.77, 2589.76, 45.95),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 1.0,
		size = 2
	},
	-- To CheckingRoom
	{
		objName = 'v_ilev_gtdoor',
		objYaw = 0.0,
		objCoords  = vector3(1827.521, 2583.905, 45.28576),
		textCoords = vector3(1828.638, 2584.675, 45.95233),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2,
		size = 2
	},
	-- Checking Gate
	{
		objName = 'v_ilev_gtdoor',
		objYaw = 270.0,
		objCoords  = vector3(1837.714, 2595.185, 46.09929),
		textCoords = vector3(1837.714, 2595.185, 46.09929),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 1.5,
		size = 2
	},
	-- To CheckingRoomFromCheck
	{
		objName = 'v_ilev_gtdoor',
		objYaw = 90.0,
		objCoords  = vector3(1837.697, 2585.24, 46.09929),
		textCoords = vector3(1837.697, 2585.24, 46.09929),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 1.5,
		size = 2
	},
	-- To SecondCheckGate
	
	-- 58
	-- X:1845.198 Y:2585.24 Z:46.09929
	{
		objName = 'v_ilev_gtdoor',
		objYaw = 90.0,
		objCoords  = vector3(1845.198, 2585.24, 46.09929),
		textCoords = vector3(1845.198, 2585.24, 46.09929),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = false,
		pickable = false,
		distance = 1.5,
		size = 2
	},
	-- To MainHall
	{
		objName = 'v_ilev_ph_door002',
		objYaw = 90.0,
		objCoords  = vector3(1791.18, 2593.11, 546.15),
		textCoords = vector3(1791.18, 2593.11, 546.15),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},
	-- To VisitorRoom
	{
		objName = 'prison_prop_door2',
		objYaw = 90.0,
		objCoords  = vector3(1784, 2599, 46),
		textCoords = vector3(1785.808, 2590.02, 44.79703),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},
	{
		objName = 'prison_prop_door1',
		objYaw = 0.0,
		objCoords  = vector3(1786, 2600, 46),
		textCoords = vector3(1785.808, 2590.02, 44.79703),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},
	{
		textCoords = vector3(1785.83, 2609.59, 45.99),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.5,
		doors = {
			{
				objName = 'prison_prop_door1',
				objYaw = 182.0,
				objCoords = vector3(1785, 2610, 46),	
			},

			{
				objName = 'prison_prop_door1a',
				objYaw = 0.0,
				objCoords = vector3(1787, 2610, 46),
			}
		}
	},
	{
		textCoords = vector3(1779.67, 2601.83, 50.71),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.5,
		doors = {
			{
				objName = 'prison_prop_door2',
				objYaw = 1.5,
				objCoords = vector3(1781, 2602, 51),	
			},

			{
				objName = 'prison_prop_door2',
				objYaw = 180.0,
				objCoords = vector3(1778, 2602, 51),
			}
		}
	},
	{
		objName = 'prison_prop_door2',
		objYaw = 0.0,
		objCoords  = vector3(1780, 2596, 51),
		textCoords = vector3(1785.808, 2590.02, 44.79703),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},
	{
		objName = 'prison_prop_door1',
		objYaw = 0.0,
		objCoords  = vector3(1787, 2621, 46),
		textCoords = vector3(1785.808, 2590.02, 44.79703),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},
	{
		objName = 'prison_prop_door2',
		objYaw = 270.0,
		objCoords  = vector3(1788, 2606, 51),
		textCoords = vector3(1785.808, 2590.02, 44.79703),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},
	{
		textCoords = vector3(1791.08, 2593.76, 46.18),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.5,
		doors = {
			{
				objName = 'prison_prop_door1',
				objYaw = 272.0,
				objCoords = vector3(1791.1140136719, 2592.50390625, 46.3132473297119),		
			},

			{
				objName = 'prison_prop_door1a',
				objYaw = 90.0,
				objCoords = vector3(1791, 2595, 46),	
			}
		}
	},	
	-- To DoctorRoom
	{
		objName = 'v_ilev_ph_gendoor002',
		objYaw = 90.0,
		objCoords  = vector3(1786.4, 2579.8, 45.97),
		textCoords = vector3(1786.4, 2579.8, 45.97),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 1.0,
		size = 2
	},
	-- HallGate
	{
		objName = 'prison_prop_door2',
		objYaw = 0.0,
		objCoords  = vector3(1786, 2567, 46),
		textCoords = vector3(1778.91, 2568.91, 46.07),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},
	-- HallGate 2
	{
		objName = 'prison_prop_door1',
		objYaw = 270.0,
		objCoords  = vector3(1792, 2551, 46),
		textCoords = vector3(1773.49, 2568.9, 46.07),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},
	{
		textCoords = vector3( 1781.72, 2552.07, 49.57),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.5,
		doors = {
			{
				objName = 'prison_prop_door2',
				objYaw = 269.5,
				objCoords = vector3(1782, 2551, 50),		
			},

			{
				objName = 'prison_prop_door2',
				objYaw = 90.0,
				objCoords = vector3(1782, 2553, 50),	
			}
		}
	},	
	-- Gate To Work
	{
		objName = 'prison_prop_door2',
		objYaw = 90.0,
		objCoords  = vector3(1786, 2552, 50),
		textCoords = vector3(1760.89, 2578.51, 46.07),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},
	-- Cell Maindoor
	{
		objName = 'prison_prop_door2',
		objYaw = 180.0,
		objCoords  = vector3(1785, 2550, 46),
		textCoords = vector3(1760.89, 2578.51, 46.07),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},
	{
		objName = 'prison_prop_door1a',
		objYaw = 270.0,
		objCoords  = vector3(1776, 2551, 46),
		textCoords = vector3(1760.89, 2578.51, 46.07),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},
	----------------
	-- Pacific Bank
	----------------
	-- First Door
	{
		objName = 'hei_v_ilev_bk_gate_pris',			
		objCoords  = vector3(257.41, 220.25, 106.4),
		textCoords = vector3(257.41, 220.25, 106.4),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8', 'hotdog', 'mechanic', 'ems', 'ems1', 'ems2', 'ems2', 'ems3' ,'ems4', 'ems5', 'ems6','ems7', 'ems8', 'cardealer', 'lawyer', 'realestate', 'unemployed', 'judge', 'taxi', 'trucker', 'tow', 'reporter', 'garbage' },
		objYaw = -20.0,
		locking = false,
		locked = true,
		pickable = true,
		distance = 1.5,
		size = 2
	},
	-- Second Door
	{
		objName = 'hei_v_ilev_bk_gate2_pris',
		objCoords  = vector3(261.83, 221.39, 106.41),
		textCoords = vector3(261.83, 221.39, 106.41),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		objYaw = -110.0,
		locking = false,
		locked = true,
		pickable = false,
		distance = 1.5,
		size = 2
	},
	-- Office to gate door
	{
		objName = 'v_ilev_bk_door',
		objCoords  = vector3(265.19, 217.84, 110.28),
		textCoords = vector3(265.19, 217.84, 110.28),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		objYaw = -20.0,
		locking = false,
		locked = true,
		pickable = true,
		distance = 1.5,
		size = 2
	},

	-- First safe Door
	{
		objName = 'hei_v_ilev_bk_safegate_pris',
		objCoords  = vector3(252.98, 220.65, 101.8),
		textCoords = vector3(252.98, 220.65, 101.8),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		objYaw = 160.0,
		locking = false,
		locked = true,
		pickable = false,
		distance = 1.5,
		size = 2
	},
	-- Second safe Door
	{
		objName = 'hei_v_ilev_bk_safegate_pris',
		objCoords  = vector3(261.68, 215.62, 101.81),
		textCoords = vector3(261.68, 215.62, 101.81),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		objYaw = -110.0,
		locking = false,
		locked = true,
		pickable = false,
		distance = 1.5,
		size = 2
	},

	----------------
	-- Fleeca Banks
	----------------
	-- Door 1
	{
		objName = 'v_ilev_gb_vaubar',
		objCoords  = vector3(314.61, -285.82, 54.49),
		textCoords = vector3(313.3, -285.45, 54.49),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8', 'hotdog', 'mechanic', 'ems', 'ems1', 'ems2', 'ems2', 'ems3' ,'ems4', 'ems5', 'ems6','ems7', 'ems8', 'cardealer', 'lawyer', 'realestate', 'unemployed', 'judge', 'taxi', 'trucker', 'tow', 'reporter', 'garbage' },
		locking = false,
		locked = true,
		pickable = true,
		distance = 1.5,
		size = 2
	},
	-- Door 2
	{
		objName = 'v_ilev_gb_vaubar',
		objCoords  = vector3(148.96, -1047.12, 29.7),
		textCoords = vector3(148.96, -1047.12, 29.7),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = true,
		distance = 1.5,
		size = 2
	},
	-- Door 3
	{
		objName = 'v_ilev_gb_vaubar',
		objCoords  = vector3(-351.7, -56.28, 49.38),
		textCoords = vector3(-351.7, -56.28, 49.38),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = true,
		distance = 1.5,
		size = 2
	},
	-- Door 4
	{
		objName = 'v_ilev_gb_vaubar',
		objCoords  = vector3(-2956.18, -335.76, 38.11),
		textCoords = vector3(-2956.18, -335.76, 38.11),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = true,
		distance = 1.5,
		size = 2
	},
	-- Door 5
	{
		objName = 'v_ilev_gb_vaubar',
		objCoords  = vector3(-2956.18, 483.96, 16.02),
		textCoords = vector3(-2956.18, 483.96, 16.02),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = true,
		distance = 1.5,
		size = 2
	},
	-- Paleto Door 1
	{
		objName = 'v_ilev_cbankvaulgate01',
		objCoords  = vector3(-105.77, 6472.59, 31.81),
		textCoords = vector3(-105.77, 6472.59, 31.81),
		objYaw = 45.0,
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 1.5,
		size = 2
	},
	-- Paleto Door 2
	{
		objName = 'v_ilev_cbankvaulgate02',
		objCoords  = vector3(-106.26, 6476.01, 31.98),
		textCoords = vector3(-105.5, 6475.08, 31.99),
		objYaw = -45.0,
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 1.5,
		size = 2
	},
	-----
	-- Police front gate
	-----
	{
		objName = 'prop_facgate_07b',
		objYaw = -90.0,
		objCoords  = vector3(419.99, -1025.0, 28.99),
		textCoords = vector3(419.9, -1021.04, 30.5),
		authorizedJobs = { 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 20,
		size = 2
	},
	-----
	-- Luxury Cars
	-----
	-- Entrance Doors 
	{
		textCoords = vector3(-803.0223, -223.8222, 37.87975),
		authorizedJobs = { 'cardealer', 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 3.5,
		doors = {
			{
				objName = 'prop_doorluxyry2',
				objYaw = 120.0,
				objCoords = vector3(-803.0223, -222.5841, 37.87975)
			},

			{
				objName = 'prop_doorluxyry2',
				objYaw = -60.0,
				objCoords = vector3(-801.9622, -224.5203, 37.87975)			
			}
		}
	},	
	-- Side Entrance Doors 
	{
		textCoords = vector3(-777.1855, -244.0013, 37.333889),
		authorizedJobs = { 'cardealer', 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 3.5,
		doors = {
			{
				objName = 'prop_doorluxyry',				
				objYaw = -160.0,
				objCoords = vector3(-778.1855, -244.3013, 37.33388)
			},

			{
				objName = 'prop_doorluxyry',
				objYaw = 23.0,
				objCoords = vector3(-776.1591, -243.5013, 37.33388)				
			}
		}
	},	
	-- Garage Doors
	{
		textCoords = vector3(-768.1264, -238.9737, 37.43247),
		authorizedJobs = { 'cardealer', 'police', 'police1', 'police2', 'police4', 'police5', 'police6', 'police3', 'police7', 'police8' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 13.0,
		doors = {
			{
				objName = 'prop_autodoor',
				objCoords = vector3(-770.6311, -240.0069, 37.43247)    
			},

			{
				objName = 'prop_autodoor',
				objCoords = vector3(-765.6217, -237.9405, 37.43247) 		
			}
		}
	},		
	----------------
	-- Pickle Rental
	----------------
	-- Voordeur 1
	{
		objName = 'apa_prop_apa_cutscene_doorb',
		objCoords  = vector3(-21.71276, -1392.778, 29.63847),		
		textCoords = vector3(-22.31276, -1392.778, 29.63847),
		authorizedJobs = { 'cardealer' },
		objYaw = -180.0,
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.5,
		size = 2
	},	
	-- Voordeur 2
	{
		objName = 'apa_prop_apa_cutscene_doorb',
		objCoords  = vector3(-32.67987, -1392.064, 29.63847),		
		textCoords = vector3(-32.10987, -1392.064, 29.63847),
		authorizedJobs = { 'cardealer' },
		objYaw = 0.0,
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.5,
		size = 2
	},	
	-- Deur naar kelder
	{
		objName = 'apa_prop_apa_cutscene_doorb',
		objCoords  = vector3(-24.22668, -1403.067, 29.63847),				
		textCoords = vector3(-24.22668, -1402.537, 29.63847),
		authorizedJobs = { 'cardealer' },
		objYaw = 90.0,
		locking = false,
		locked = true,
		pickable = false,
		distance = 1.5,
		size = 2
	},	
	-- Achterdeur
	{
		objName = 'apa_prop_apa_cutscene_doorb',
		objCoords  = vector3(-21.27107, -1406.845, 29.63847),			
		textCoords = vector3(-21.27107, -1406.245, 29.63847),
		authorizedJobs = { 'cardealer' },
		objYaw = 90.0,
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},		
	-- Roldeur
	{
		objName = 'prop_com_gar_door_01',
		objCoords  = vector3(-21.04025, -1410.734, 30.51094),			
		textCoords = vector3(-21.04025, -1410.734, 30.51094),
		authorizedJobs = { 'cardealer' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 15.0,
		size = 2
	},
}