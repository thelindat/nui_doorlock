ESX = nil
local doorInfo = {}

Citizen.CreateThread(function()
	local xPlayers = #ESX.GetPlayers()
	local path = GetResourcePath(GetCurrentResourceName())
	path = path:gsub('//', '/')..'/server/states.json'
	local file = io.open(path, 'r')
	if not file or xPlayers == 0 then
		file = io.open(path, 'a')
		for k,v in pairs(Config.DoorList) do
			doorInfo[k] = v.locked
		end
	else
		local data = file:read('*a')
		file:close()
		if #json.decode(data) > #Config.DoorList then -- Config.DoorList contains less doors than states.json, so don't restore states
			return
		elseif #json.decode(data) > 0 then
			for k,v in pairs(json.decode(data)) do
				doorInfo[k] = v
			end
		end
	end
end)

AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
	end
	local path = GetResourcePath(resourceName)
	path = path:gsub('//', '/')..'/server/states.json'
	local file = io.open(path, 'r+')
	if file and doorInfo then
		local json = json.encode(doorInfo)
		file:write(json)
		file:close()
	end
end)

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('nui_doorlock:updateState')
AddEventHandler('nui_doorlock:updateState', function(doorID, locked, src)
	local xPlayer = ESX.GetPlayerFromId(source)

	if type(doorID) ~= 'number' then
		print(('nui_doorlock: %s didn\'t send a number!'):format(xPlayer.identifier))
		return
	end

	if type(locked) ~= 'boolean' then
		print(('nui_doorlock: %s attempted to update invalid state! (%s)'):format(xPlayer.identifier), locked)
		return
	end

	if not Config.DoorList[doorID] then
		print(('nui_doorlock: %s attempted to update invalid door!'):format(xPlayer.identifier))
		return
	end

	if not Config.DoorList[doorID].items and not Config.DoorList[doorID].lockpick and not IsAuthorized(xPlayer.job.name, xPlayer.job.grade, Config.DoorList[doorID]) then
		print(('nui_doorlock: %s was not authorized to open a locked door!'):format(xPlayer.identifier))
		return
	end

	if Config.DoorList[doorID].items then
		local count
		for k,v in pairs(Config.DoorList[doorID].items) do
			count = xPlayer.getInventoryItem(v).count
			--count = exports['hsn-inventory']:getItemCount(source, v)
			if count and count >= 1 then break end
		end
		if not count or count < 1 then return end
	end

	doorInfo[doorID] = locked
	if not src then TriggerClientEvent('nui_doorlock:setState', -1, source, doorID, locked)
	else TriggerClientEvent('nui_doorlock:setState', -1, source, doorID, locked, src) end
end)

ESX.RegisterServerCallback('nui_doorlock:getDoorInfo', function(source, cb)
	cb(doorInfo)
end)

function IsAuthorized(jobName, grade, doorID)
	for job,rank in pairs(doorID.authorizedJobs) do
		if job == jobName and rank <= grade then
			return true
		end
	end

	return false
end

RegisterCommand('newdoor', function(playerId, args, rawCommand)
	TriggerClientEvent('nui_doorlock:newDoorSetup', playerId, args)
end, true)

RegisterServerEvent('nui_doorlock:newDoorCreate')
AddEventHandler('nui_doorlock:newDoorCreate', function(model, heading, coords, jobs, doorLocked, maxDistance, slides, garage, doubleDoor)
	xPlayer = ESX.GetPlayerFromId(source)
	if not IsPlayerAceAllowed(source, 'command.newdoor') then print(xPlayer.getName().. 'attempted to create a new door but does not have permission') return end
	doorLocked = tostring(doorLocked)
	slides = tostring(slides)
	garage = tostring(garage)
	local newDoor = {}
	local auth = tostring("['"..jobs[1].."']=0")
	if jobs[2] then auth = auth..', '..tostring("['"..jobs[2].."']=0") end
	if jobs[3] then auth = auth..', '..tostring("['"..jobs[3].."']=0") end
	if jobs[4] then auth = auth..', '..tostring("['"..jobs[4].."']=0") end

	newDoor.authorizedJobs = { auth }
	newDoor.locked = doorLocked
	newDoor.maxDistance = maxDistance
	newDoor.slides = slides
	if not doubleDoor then
		newDoor.garage = garage
		newDoor.objHash = model
		newDoor.objHeading = heading
		newDoor.objCoords = coords
		newDoor.fixText = false
	else
		newDoor.doors = {
			{objHash = model[1], objHeading = heading[1], objCoords = coords[1]},
			{objHash = model[2], objHeading = heading[2], objCoords = coords[2]}
		}
	end
		newDoor.audioRemote = false
		newDoor.lockpick = false
	local path = GetResourcePath(GetCurrentResourceName())
	path = path:gsub('//', '/')..'/config.lua'

	file = io.open(path, 'a+')
	file:write('\n\n-- UNNAMED DOOR CREATED BY '..xPlayer.getName()..'\ntable.insert(Config.DoorList, {')
	for k,v in pairs(newDoor) do
		if k == 'authorizedJobs' then
			local str =  ('\n	%s = { %s },'):format(k, auth)
			file:write(str)
		elseif k == 'doors' then
			local doorStr = {}
			for i=1, 2 do
				table.insert(doorStr, ('	{objHash = %s, objHeading = %s, objCoords = %s}'):format(model[i], heading[i], coords[i]))
			end
			local str = ('\n	%s = {\n	%s,\n	%s\n },'):format(k, doorStr[1], doorStr[2])
			file:write(str)
		else
			local str = ('\n	%s = %s,'):format(k, v)
			file:write(str)
		end
	end
	file:write('\n})')
	file:close()
	local doorID = #Config.DoorList + 1
	
	if jobs[4] then newDoor.authorizedJobs = { [jobs[1]] = 0, [jobs[2]] = 0, [jobs[3]] = 0, [jobs[4]] = 0 }
	elseif jobs[3] then newDoor.authorizedJobs = { [jobs[1]] = 0, [jobs[2]] = 0, [jobs[3]] = 0 }
	elseif jobs[2] then newDoor.authorizedJobs = { [jobs[1]] = 0, [jobs[2]] = 0 }
	else newDoor.authorizedJobs = { [jobs[1]] = 0 } end

	Config.DoorList[doorID] = newDoor
	doorInfo[doorID] = doorLocked 
	TriggerClientEvent('nui_doorlock:newDoorAdded', -1, newDoor, doorID, doorLocked)
end)



-- Test command that causes all doors to change state
--[[RegisterCommand('testdoors', function(playerId, args, rawCommand)
	for k, v in pairs(doorInfo) do
		if v == true then lock = false else lock = true end
		doorInfo[k] = lock
		TriggerClientEvent('nui_doorlock:setState', -1, k, lock)
	end
end, true)
--]]


-- VERSION CHECK
CreateThread(function()
    local resourceName = GetCurrentResourceName()
    local currentVersion, latestVersion = GetResourceMetadata(resourceName, 'version')
    local outdated = '^6[%s]^3 Version ^2%s^3 is available! You are using version ^1%s^7'
    Citizen.Wait(2000)
    while Config.CheckVersion do
        Citizen.Wait(0)
        PerformHttpRequest(GetResourceMetadata(resourceName, 'versioncheck'), function (errorCode, resultData, resultHeaders)
            if errorCode ~= 200 then print("Returned error code:" .. tostring(errorCode)) else
                local data, version = tostring(resultData)
                for line in data:gmatch("([^\n]*)\n?") do
                    if line:find('^version') then version = line:sub(10, (line:len(line) - 1)) break end
                end         
                latestVersion = version
            end
        end)
        if latestVersion then 
            if currentVersion ~= latestVersion then
                print(outdated:format(resourceName, latestVersion, currentVersion))
            end
            Citizen.Wait(60000*Config.CheckVersionDelay)
        end
    end
end)
