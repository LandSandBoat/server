-----------------------------------
-- func: einherjar <command> <chamber> ...
--       einherjar help [<command>]
--       einherjar enter <chamber> [<player>]
--       einherjar create <chamber> [boss <boss>] [waves <waves>] [<wave#> <group> <group>]
--       einharjar special <chamber> <special>
--       einherjar close <chamber>
--       einherjar clearwave <chamber>
-- desc: Interacts with einherjar.
-----------------------------------
local ID = require ('scripts/zones/Hazhalm_Testing_Grounds/IDs')

---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'sssssssssssssss'
}

local function error(player, msg)
    if msg then
        player:printToPlayer(msg)
    end

    player:printToPlayer('!einherjar <command> <chamber> ...')
end

local function handleHelp(player, command)
    command = command and string.lower(command)

    if not command then
        player:printToPlayer('!einherjar <command> <chamber> [...]', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('List of available !einherjar commands:', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('(< > means user entry, [ ] means optional)', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('help [<command>]', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('enter <chamber> [<player>]', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('close <chamber>', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('create <chamber> [boss <boss>] [waves <waves>] [<wave#> <group> <group>]', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('special <chamber> <special>', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('clearwave <chamber>', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('For more specific help, use !einherjar help <command>', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('Example:', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('!einherjar help create', xi.msg.channel.SYSTEM_3)
    elseif command == 'create' then
        player:printToPlayer('!einherjar create <chamber> [boss <boss>] [waves <waves>] [<wave#> <group> <group>]', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('A command to create a new chamber with the specified configuration.', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('After creating, use !einherjar enter <chamber> to enter.', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('chamber: the chamber name or chamber id (1-10).', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('boss (optional): the mob id, the boss name (use _ instead of spaces), or the boss index (1-6).', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('waves (optional): up to max waves for this chamber.', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('wave# (optional): to specify the groups for wave1, wave2, or wave3.', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('group: the mob name (use _ instead of spaces) or the group index (1-22).', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('For each wave, up to two groups can be specified (separated by a space).', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('Examples:', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('!einherjar create rossweisse boss hildesvini wave1 chigoe craven_einherjar', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('!einherjar create 9 boss 3 wave1 3 5 wave2 19 wave3 1', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('!einherjar create helmwige waves 2', xi.msg.channel.SYSTEM_3)
    elseif command == 'enter' then
        player:printToPlayer('!einherjar enter <chamber> [<player>]', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('Push a player (or yourself) into the specified chamber.', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('chamber: the chamber name or chamber id (1-10).', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('player (optional): the player name or id to affect. Defaults to yourself.', xi.msg.channel.SYSTEM_3)
    elseif command == 'close' then
        player:printToPlayer('!einherjar close <chamber>', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('Immediately expire a chamber and clear out all mobs and players.', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('chamber: the chamber name or chamber id (1-10).', xi.msg.channel.SYSTEM_3)
    elseif command == 'special' then
        player:printToPlayer('!einherjar special <chamber> <special>', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('Spawn a special mob in the desired chamber.', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('chamber: the chamber name or chamber id (1-10).', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('special: the mob name or special mob type (1-4) to spawn.', xi.msg.channel.SYSTEM_3)
    elseif command == 'clearwave' then
        player:printToPlayer('!einherjar clearwave <chamber>', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('Immediately clear the current wave in the specified chamber.', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('chamber: the chamber name or chamber id (1-10).', xi.msg.channel.SYSTEM_3)
    end
end

local function handleEnter(player, chamberId, playerName)
    local targetPlayer = playerName and GetPlayerByName(playerName) or player

    if not targetPlayer then
        player:printToPlayer('Could not find a player with name: ' .. tostring(playerName))
        return
    end

    local chamberData = xi.einherjar.getChamber(chamberId)
    if not chamberData then
        player:printToPlayer('Could not add the player to the chamber. Chamber is not active.')
        return
    end

    local time = GetSystemTime()

    if time > chamberData.endTime then
        player:printToPlayer('Could not add the player to the chamber. It is already expired.')
        return
    end

    local targetPlayerId = targetPlayer:getID()

    if chamberData.players[targetPlayerId] then
        player:printToPlayer('Could not add the player to the chamber. They are already there.')
        return
    end

    if targetPlayer:getFreeSlotsCount() == 0 then
        player:printToPlayer('Could not add the player to the chamber. Their inventory was full (needs Glowing Lamp).')
        return
    end

    if #xi.einherjar.getMatchingLamps(targetPlayer, chamberData.id, chamberData.startTime) == 0 then
        xi.einherjar.makeLamp(targetPlayer, chamberData.id, chamberData.startTime, chamberData.endTime)
    end

    if targetPlayer:getZoneID() ~= xi.zone.HAZHALM_TESTING_GROUNDS then
        targetPlayer:setPos(652, -272.6, -104.9, 148, xi.zone.HAZHALM_TESTING_GROUNDS)
    else
        targetPlayer:setPos(
            xi.einherjar.chambers[chamberData.id].center[1],
            xi.einherjar.chambers[chamberData.id].center[2],
            xi.einherjar.chambers[chamberData.id].center[3],
            xi.einherjar.chambers[chamberData.id].center[4],
            xi.zone.HAZHALM_TESTING_GROUNDS
        )
    end

    xi.einherjar.onChamberEnter(chamberData, targetPlayer, false)
    player:printToPlayer(string.format('Moving player %s into the chamber.', targetPlayer:getName()))
end

local function handleClose(player, chamberId)
    local chamberData = xi.einherjar.getChamber(chamberId)
    if not chamberData then
        player:printToPlayer('Could not close the chamber. It is not active.')
        return
    end

    player:printToPlayer('The chamber will now be cleared.')

    -- Trigger their cleanup event by stealing the endTime event function and executing it now.
    -- We can just execute the event associated with endTime to invoke expelAllFromChamber.
    local expelEvent = chamberData.eventsQueue[chamberData.endTime]
    if expelEvent then
        expelEvent()
        chamberData.eventsQueue[chamberData.endTime] = nil
    end
end

local function handleCreate(player, chamberId, ...)
    local chamberData = xi.einherjar.getChamber(chamberId)
    if chamberData then
        player:printToPlayer('Could not create the chamber. It is already active.')
        return
    end

    local options = {}
    local state = nil
    for _, value in ipairs({ ... }) do
        value = string.lower(value)

        if value == 'boss' or value == 'waves' then
            state = value
        elseif value == 'wave1' or value == 'wave2' or value == 'wave3' then
            state = value
            options[value] = {}
        elseif state == 'boss' then
            options.boss = value
        elseif state == 'waves' then
            options.waves = tonumber(value)
        elseif state == 'wave1' or state == 'wave2' or state == 'wave3' then
            table.insert(options[state], value)
        end
    end

    chamberData = xi.einherjar.createNewChamber(chamberId, player, true)

    if not chamberData then
        player:printToPlayer('Failed to create chamber ' .. tostring(chamberId) .. '.')
        return
    end

    if options.boss then
        local bossId = ID.mob[string.upper(options.boss)] or tonumber(options.boss)
        if type(bossId) == 'table' then
            bossId = bossId[1]
        end

        if bossId then
            chamberData.encounters.boss = bossId
        else
            player:printToPlayer('Warning: Could not resolve boss override: ' .. tostring(options.boss))
        end
    end

    if options.wave1 or options.wave2 or options.wave3 then
        chamberData.encounters.waves = {}
        for i = 1, 3 do
            local waveInput = options['wave' .. i]
            if waveInput then
                local waveMobIds = {}
                for _, groupName in ipairs(waveInput) do
                    local groupUpper = string.upper(groupName)
                    local mobIdsArray = ID.mob[groupUpper]
                    if type(mobIdsArray) == 'table' then
                        for _, id in ipairs(mobIdsArray) do
                            table.insert(waveMobIds, id)
                        end
                    elseif type(mobIdsArray) == 'number' then
                        table.insert(waveMobIds, mobIdsArray)
                    else
                        local rawId = tonumber(groupName)
                        if rawId then
                            table.insert(waveMobIds, rawId)
                        end
                    end
                end

                table.insert(chamberData.encounters.waves, waveMobIds)
            end
        end

        chamberData.encounters.waveCount = #chamberData.encounters.waves
    elseif options.waves then
        local newWaves = {}
        for i = 1, math.min(options.waves, #chamberData.encounters.waves) do
            table.insert(newWaves, chamberData.encounters.waves[i])
        end

        chamberData.encounters.waves = newWaves
        chamberData.encounters.waveCount = #newWaves
    end

    -- Trigger the first wave explicitly now that overrides are populated
    xi.einherjar.cycleWave(chamberData)

    player:printToPlayer('Successfully created chamber ' .. chamberId .. ' for leader ' .. player:getName() .. ' with explicitly applied parameters!')
end

local function handleSpecial(player, chamberId, specialName)
    local chamberData = xi.einherjar.getChamber(chamberId)
    if not chamberData then
        player:printToPlayer('Could not create the special mob. Chamber is not active.')
        return
    end

    if not specialName then
        player:printToPlayer('You must provide a valid special mob type.')
        return
    end

    local specialId = ID.mob[string.upper(specialName)] or tonumber(specialName)
    if type(specialId) == 'table' then
        specialId = specialId[1]
    end

    if not specialId then
        player:printToPlayer('Invalid special mob.')
        return
    end

    local specialMob = GetMobByID(specialId)
    if specialMob then
        local x, y, z = unpack(xi.einherjar.getRandomPosForMobGroup(chamberData.id, 10, 30))
        specialMob:setSpawn(x, y, z, math.random(0, 255))
        xi.einherjar.spawnMob(specialMob, 3, chamberData) -- 3 is mobType.SPECIAL
        player:printToPlayer('Spawned special mob!')
    else
        player:printToPlayer('Could not find mob.')
    end
end

local function handleClearWave(player, chamberId)
    local chamberData = xi.einherjar.getChamber(chamberId)
    if not chamberData then
        player:printToPlayer('Could not clear the wave. Chamber is not active.')
        return
    end

    player:printToPlayer('Clearing the current wave.')

    local mobsToDespawn = {}
    for _, mob in pairs(chamberData.mobs) do
        table.insert(mobsToDespawn, mob:getID())
    end

    for _, mobId in ipairs(mobsToDespawn) do
        DespawnMob(mobId)
    end
end

commandObj.onTrigger = function(player, command, ...)
    local arg = { ... }

    if not command or command == 'help' then
        return handleHelp(player, arg[1])
    end

    local chamberName = arg[1]
    local chamberId = xi.einherjar.chamber[chamberName and string.upper(chamberName)] or tonumber(chamberName)

    if not chamberId or chamberId < 1 or chamberId > 10 then
        error(player, 'Chamber must be a chamber name (Rossweisse, Odin, etc.) or a number between 1 and 10.')
        return
    end

    command = string.lower(command)

    if command == 'enter' then
        handleEnter(player, chamberId, arg[2])
    elseif command == 'close' then
        handleClose(player, chamberId)
    elseif command == 'create' then
        handleCreate(player, chamberId, ...)
    elseif command == 'special' then
        handleSpecial(player, chamberId, arg[2])
    elseif command == 'clearwave' then
        handleClearWave(player, chamberId)
    else
        error(player, 'Invalid secondary command: ' .. command)
    end
end

return commandObj
