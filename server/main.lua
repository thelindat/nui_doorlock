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

	if not IsAuthorized(xPlayer.job.name, Config.DoorList[doorID]) then
		print(('nui_doorlock: %s was not authorized to open a locked door!'):format(xPlayer.identifier))
		return
	end

	doorInfo[doorID] = locked
	if not src then TriggerClientEvent('nui_doorlock:setState', -1, doorID, locked)
	else TriggerClientEvent('nui_doorlock:setState', -1, doorID, locked, src) end
end)

ESX.RegisterServerCallback('nui_doorlock:getDoorInfo', function(source, cb)
	cb(doorInfo)
end)

function IsAuthorized(jobName, doorID)
	for _,job in pairs(doorID.authorizedJobs) do
		if job == jobName then
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
	local doorConfig
	if not doubleDoor then
		doorConfig = [[
	{
		objHash = ]]..model..[[,
		objHeading = ]]..heading..[[,
		objCoords = ]]..coords..[[,
		authorizedJobs = { ]]..jobs..[[ },
		locked = ]]..doorLocked..[[,
		maxDistance = ]]..maxDistance..[[,
		slides = ]]..slides..[[,
		garage = ]]..garage..[[,
		fixText = false,
		audioLock = nil,
		audioUnlock = nil,
		audioRemote = false
	}]]
	else
		doorConfig = [[
	{
		doors = {
			{objHash = ]]..model[1]..[[, objHeading = ]]..heading[1]..[[, objCoords = ]]..coords[1]..[[},
			{objHash = ]]..model[2]..[[, objHeading = ]]..heading[2]..[[, objCoords = ]]..coords[2]..[[}
		},
		authorizedJobs = { ]]..jobs..[[ },
		locked = ]]..doorLocked..[[,
		maxDistance = ]]..maxDistance..[[,
		slides = ]]..slides..[[,
		audioLock = nil,
		audioUnlock = nil,
		audioRemote = false
	}]]
	end
	local path = GetResourcePath(GetCurrentResourceName())
	path = path:gsub('//', '/')..'/customdoors.lua'

	local config = LoadResourceFile(GetCurrentResourceName(), 'customdoors.lua')
	config = tostring(config:sub(1, -2))

	file = io.open(path, 'w+')
	file:write(config..'	-- UNNAMED DOOR CREATED BY '..xPlayer.getName()..'\n'..doorConfig..',\n\n}')
	file:close()
end)
