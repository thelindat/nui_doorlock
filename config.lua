Config = {}
Config.ShowUnlockedText = false
Config.CheckVersion = true
Config.CheckVersionDelay = 60 -- Minutes

Config.DoorList = {

------------------------------------------
--	COMMUNITY MISSION ROW PD
--	https://www.gta5-mods.com/maps/community-mission-row-pd
------------------------------------------

-- MRPD MAIN ENTRANCE
	{
		authorizedJobs = { ['police']=0, ['offpolice']=0 },
		locked = false,
		maxDistance = 2.5,
		doors = {
			{objHash = -1215222675, objHeading = 270.0, objCoords = vector3(434.7479, -980.6184, 30.83927)},
			{objHash = 320433149, objHeading = 270.0, objCoords = vector3(434.7479, -983.2151, 30.83927)}
		},
		
	},

	-- MRPD BACK ENTRANCE
	{
		authorizedJobs = { ['police']=0 },
		locked = true,
		maxDistance = 2.5,
		doors = {
			{objHash = -2023754432, objHeading = 180.0, objCoords = vector3(469.968, -1014.452, 26.53624)},
			{objHash = -2023754432, objHeading = 0.0, objCoords = vector3(467.3716, -1014.452, 26.53624)}
		}
	},

	-- MRPD BACK ENTRANCE INSIDE
	{
		objHash = -1033001619,
		objHeading = 0.0,
		objCoords = vector3(463.4783, -1003.538, 25.00599),
		authorizedJobs = { ['police']=0 },
		locked = true,
		maxDistance = 2.0,
		fixText = true
	},

	-- MRPD BACK GATE
	{
		objHash = -1603817716,
		objHeading = 90.0,
		objCoords = vector3(488.8948, -1017.21, 27.14863),
		authorizedJobs = { ['police']=0 },
		locked = true,
		maxDistance = 5,
		slides = true,
		audioRemote = true
	},
	
	-- MRPD GARAGE 1
	{
		objHash = -190780785,
		objHeading = 0.0,
		objCoords = vector3(431.4056, -1001.169, 26.71261),
		authorizedJobs = { ['police']=0 },
		locked = true,
		maxDistance = 5,
		garage = true,
		slides = true,
		audioRemote = true
	},
	-- MRPD GARAGE 2
	{
		objHash = -190780785,
		objHeading = 0.0,
		objCoords = vector3(436.2234, -1001.169, 26.71261),
		authorizedJobs = { ['police']=0 },
		locked = true,
		maxDistance = 5,
		garage = true,
		slides = true,
		audioRemote = true
	},

	-- MRPD LOCKER ROOMS
	{
		objHash = 1557126584,
		objHeading = 90.0,
		objCoords = vector3(450.1042, -985.7384, 30.83931),
		authorizedJobs = { ['police']=0, ['offpolice']=0 },
		locked = true,
		maxDistance = 2.0
	},

	-- MRPD OUTSIDE BALCONY
	{
		objHash = 507213820,
		objHeading = 0.2,
		objCoords = vector3(464.1584, -1011.26, 33.01121),
		authorizedJobs = { ['police']=0 },
		locked = true,
		maxDistance = 2.0,
	},

	-- MRPD DOOR TO STAIRWELL AND ROOF
	{
		objHash = 749848321,
		objHeading = 90.0,
		objCoords = vector3(461.2865, -985.3206, 30.83927),
		authorizedJobs = { ['police']=0 },
		locked = true,
		maxDistance = 2.0,
	},

	-- MRPD CAPTAIN'S OFFICE
	{
		objHash = -1320876379,
		objHeading = 180.0,
		objCoords = vector3(446.5728, -980.0106, 30.83931),
		authorizedJobs = { ['police']=0 },
		locked = true,
		maxDistance = 2.0,
	},

	-- MRPD ARMOURY
	{
		objHash = -1033001619,
		objHeading = 90.6,
		objCoords = vector3(453.0938, -983.2294, 30.83927),
		authorizedJobs = { ['police']=0 },
		locked = true,
		maxDistance = 2.0,
		fixText = true,
		oldMethod = true
	},

	-- MRPD ROOFTOP
	{
		objHash = -340230128,
		objHeading = 90.0,
		objCoords = vector3(464.3614, -984.678, 43.83444),
		authorizedJobs = { ['police']=0 },
		locked = true,
		maxDistance = 2.0,
		fixText = true
	},

	-- MRPD MUGSHOT ROOM
	{
		objHash = -131296141,
		objHeading = 179.27,
		objCoords = vector3(442.6625, -988.2413, 26.81977),
		authorizedJobs = { ['police']=0 },
		locked = true,
		maxDistance = 2.0,
	},

	-- MRPD STORAGE
	{
		objHash = -131296141,
		objHeading = 270.0,
		objCoords = vector3(471.3154, -986.1091, 25.05795),
		authorizedJobs = { ['police']=0 },
		locked = true,
		maxDistance = 2.0,
	},

	-- MRPD SERVER
	{
		objHash = -131296141,
		objHeading = 180.0,
		objCoords = vector3(467.5936, -977.9933, 25.05795),
		authorizedJobs = { ['police']=0 },
		locked = true,
		maxDistance = 2.0,
	},

	-- MRPD LABORATORY
	{
		objHash = -131296141,
		objHeading = 90.0,
		objCoords = vector3(463.6146, -980.5814, 25.05795),
		authorizedJobs = { ['police']=0 },
		locked = true,
		maxDistance = 2.0,
	},

	-- MRPD CELL ACCESS
	{
		objHash = 631614199,
		objHeading = 0.0,
		objCoords = vector3(464.5702, -992.6641, 25.06443),
		authorizedJobs = { ['police']=0 },
		locked = true,
		maxDistance = 2.0,
		audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.35},
		audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7}
	},

	-- MRPD NORMAL CELL 1
	{
		objHash = 631614199,
		objHeading = 270.0,
		objCoords = vector3(461.8065, -994.4086, 25.06443),
		authorizedJobs = { ['police']=0 },
		locked = true,
		maxDistance = 2.0,
		fixText = false,
		audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.35},
		audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7}
	},

	-- MRPD NORMAL  CELL 2
	{
		objHash = 631614199,
		objHeading = 90.0,
		objCoords = vector3(461.8065, -997.6584, 25.06443),
		authorizedJobs = { ['police']=0 },
		locked = true,
		maxDistance = 2.0,
		audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.35},
		audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7}
	},

	-- MRPD NORMAL  CELL 3
	{
		objHash = 631614199,
		objHeading = 90.0,
		objCoords = vector3(461.8065, -1001.302, 25.06443),
		authorizedJobs = { ['police']=0 },
		locked = true,
		maxDistance = 2.0,
		audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.35},
		audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7}
	},

	-- MRPD CELL 1
	{
		objHash = -1033001619,
		objHeading = 0.0,
		objCoords = vector3(467.1922, -996.4594, 25.00599),
		authorizedJobs = { ['police']=0 },
		locked = true,
		maxDistance = 2.0,
		fixText = true
	},

	-- MRPD CELL 2
	{
		objHash = -1033001619,
		objHeading = 0.0,
		objCoords = vector3(471.4755, -996.4594, 25.00599),
		authorizedJobs = { ['police']=0 },
		locked = true,
		maxDistance = 2.0,
		fixText = true
	},

	-- MRPD CELL 3
	{
		objHash = -1033001619,
		objHeading = 0.0,
		objCoords = vector3(475.7543, -996.4594, 25.00599),
		authorizedJobs = { ['police']=0 },
		locked = true,
		maxDistance = 2.0,
		fixText = true
	},

	-- MRPD CELL 4
	{
		objHash = -1033001619,
		objHeading = 0.0,
		objCoords = vector3(480.0301, -996.4594, 25.00599),
		authorizedJobs = { ['police']=0 },
		locked = true,
		maxDistance = 2.0,
		fixText = true
	},

	-- MRPD INTERVIEW 1
	{
		objHash = -1033001619,
		objHeading = 180.0,
		objCoords = vector3(468.4872, -1003.548, 25.01314),
		authorizedJobs = { ['police']=0 },
		locked = true,
		maxDistance = 2.0,
		fixText = true
	},

	-- MRPD INTERVIEW 1.5
	{
		objHash = -1033001619,
		objHeading = 0.0,
		objCoords = vector3(471.4747, -1003.538, 25.01223),
		authorizedJobs = { ['police']=0 },
		locked = true,
		maxDistance = 2.0,
		fixText = true
	},

	-- MRPD INTERVIEW 2
	{
		locked = true,
		authorizedJobs = { ['police']=0 },
		audioRemote = false,
		slides = false,
		fixText = true,
		objHash = -1033001619,
		lockpick = false,
		objHeading = 179.27952575684,
		objCoords = vector3(477.0496, -1003.552, 25.01204),
		maxDistance = 2.0,
		garage = false,
	},

	-- MRPD INTERVIEW 2.5
	{
		objHash = -1033001619,
		objHeading = 0.0,
		objCoords = vector3(480.0301, -1003.538, 25.00599),
		authorizedJobs = { ['police']=0 },
		locked = true,
		maxDistance = 2.0,
		fixText = true
	},

	-- MRPD LOBBY DOUBLE DOORS
	{
		authorizedJobs = { ['police']=0 },
		locked = true,
		maxDistance = 2.5,
		doors = {
			{objHash = 185711165, objHeading = 180.0, objCoords = vector3(443.4078, -989.4454, 30.83931)},
			{objHash = 185711165, objHeading = 0.0, objCoords = vector3(446.008, -989.4454, 30.83931)}
		}
	},

	-- MRPD DOUBLE DOORS TO PARKING
	{
		authorizedJobs = { ['police']=0 },
		locked = true,
		maxDistance = 2.5,
		doors = {
			{objHash = -1033001619, objHeading = 180.0, objCoords = vector3(447.2184, -999.0023, 30.78942)},
			{objHash = -1033001619, objHeading = 0.0, objCoords = vector3(444.6212, -999.001, 30.78866)}
		}
	},

	-- DELETE MRPD DOUBLE DOORS TO PARKING
	{
		authorizedJobs = { ['police']=0 },
		delete = true,
		maxDistance = 2.5,
		doors = {
			{objHash = -2023754432, objHeading = 0.0, objCoords = vector3(444.6294, -997.0447, 30.84352)},
			{objHash = -2023754432, objHeading = 180.0, objCoords = vector3(447.2303, -997.0447, 30.84352)}
		},
		
	},

}
