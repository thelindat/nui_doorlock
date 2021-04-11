Config = {}
Config.ShowUnlockedText = true
Config.CheckVersion = true
Config.CheckVersionDelay = 60 -- Minutes

Config.KeybingText = 'Interact with a door lock'

Config.DoorList = {}


-- x
table.insert(Config.DoorList, {
	objHash = -1700911976,
	fixText = false,
	maxDistance = 2.0,
	garage = false,
	audioRemote = false,
	lockpick = false,
	locked = true,
	authorizedJobs = { ['police']=0 },
	objHeading = 249.98275756836,
	objCoords = vector3(327.256, -595.195, 43.43391),
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})