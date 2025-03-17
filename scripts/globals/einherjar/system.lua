-----------------------------------
-- Einherjar
-----------------------------------
xi = xi or {}
xi.einherjar = xi.einherjar or {}

local ID = zones[xi.zone.HAZHALM_TESTING_GROUNDS]

local mobType = {
    REGULAR = 1,
    BOSS    = 2,
    SPECIAL = 3,
}

local function forEachPlayer(players, callback)
    for _, player in pairs(players) do
        if player then
            callback(player)
        end
    end
end

local function log(chamberId, msg)
    local function getChamberNameById(id)
        for name, value in pairs(xi.einherjar.chamber) do
            if value == id then
                return name
            end
        end

        return id
    end

    print(string.format('[einherjar][%s] ', getChamberNameById(chamberId)) .. msg)
end

--=============================
-- Chamber instances management
--=============================

local chambersInstances = {
    [xi.einherjar.chamber.ROSSWEISSE]   = nil,
    [xi.einherjar.chamber.GRIMGERDE]    = nil,
    [xi.einherjar.chamber.SIEGRUNE]     = nil,
    [xi.einherjar.chamber.HELMWIGE]     = nil,
    [xi.einherjar.chamber.SCHWERTLEITE] = nil,
    [xi.einherjar.chamber.WALTRAUTE]    = nil,
    [xi.einherjar.chamber.ORTLINDE]     = nil,
    [xi.einherjar.chamber.GERHILDE]     = nil,
    [xi.einherjar.chamber.BRUNNHILDE]   = nil,
    -- [xi.einherjar.chamber.ODIN]         = nil, -- ODIN_II shares the same chamber -- Not implemented
}

-- Get the chamber instance by ID
xi.einherjar.getChamber = function(id)
    return chambersInstances[id]
end

-- Create a new chamber instance
xi.einherjar.createNewChamber = function(chamberId, leaderId)
    log(chamberId, 'Creating chamber ' .. chamberId)
    local newInstance = xi.einherjar.new(chamberId, leaderId)
    chambersInstances[chamberId] = newInstance
    if newInstance then
        xi.einherjar.cycleWave(newInstance)
    end

    return chambersInstances[chamberId]
end

-- Clean up related entities, hide chests, despawn mobs, etc.
local function cleanChamber(chamberData)
    for _, mob in pairs(chamberData.mobs) do
        if mob:isSpawned() then
            mob:removeListener('EINHERJAR_ENGAGE')
            mob:removeListener('EINHERJAR_DEATH')
            mob:removeListener('EINHERJAR_DESPAWN')
            DespawnMob(mob:getID())
        end

        xi.einherjar.unlockMob(mob:getID())
    end

    for _, mob in pairs(chamberData.deadMobs) do
        xi.einherjar.unlockMob(mob:getID())
    end

    xi.einherjar.unlockMob(chamberData.encounters.boss)

    if chamberData.lootCrate then
        xi.einherjar.hideCrate(chamberData.lootCrate)
    end

    if chamberData.tempCrate then
        xi.einherjar.hideCrate(chamberData.tempCrate)
    end

    log(chamberData.id, 'Chamber cleaned.')
end

local function releaseChamber(chamberId)
    log(chamberId, 'Releasing chamber ' .. chamberId)
    chambersInstances[chamberId] = nil
end

-- Time's up! Force flush the pool and expel everyone.
local function expelAllFromChamber(chamberData)
    -- TODO: Flush the chamber-scoped pool

    forEachPlayer(chamberData.players, function(player)
        log(chamberData.id, 'Expelling player: ' .. player:getName() .. ' (' .. player:getID() .. ')')
        xi.einherjar.onChamberExit(chamberData, player)
        player:messageSpecial(ID.text.TIMEOUT_EXPIRED)
    end)
end

local function onWin(chamberData)
    forEachPlayer(chamberData.players, function(player)
        player:setCharVar('[ein]chamber', 0)
        player:messageSpecial(
                ID.text.CHAMBER_CLEARED,
                xi.einherjar.settings.EINHERJAR_CLEAR_EXTRA_TIME,
                chamberData.id - 1
        )
        if xi.einherjar.chambers[chamberData.id].ki then
            if not player:hasKeyItem(xi.einherjar.chambers[chamberData.id].ki) then
                player:addKeyItem(xi.einherjar.chambers[chamberData.id].ki)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.einherjar.chambers[chamberData.id].ki)
            end
        end
    end)

    -- Cancel all pending events
    for k in pairs(chamberData.eventsQueue) do
        chamberData.eventsQueue[k] = nil
    end

    chamberData.eventsQueue[os.time() + (xi.einherjar.settings.EINHERJAR_CLEAR_EXTRA_TIME * 60)] = function()
        log(chamberData.id, 'Post-win timeout, expelling players and cleaning chamber.')
        expelAllFromChamber(chamberData)
        cleanChamber(chamberData)
        releaseChamber(chamberData.id)
    end
end

--=============================
-- Chamber listeners
--=============================

local function onArmouryCrateTrigger(chamberData, chestOpener, armouryCrate)
    npcUtil.openCrate(armouryCrate, function()
        onWin(chamberData)

        -- TODO: Rewards are supposed to go in a chamber-scoped treasure pool
        for _, reward in ipairs(xi.einherjar.getArmouryCrateRewards(chamberData.encounters.boss, chamberData.id)) do
            chestOpener:addTreasure(reward, armouryCrate)
        end

        return false
    end)
end

local function onSpecialMobDespawn(chamberData, mob)
    local specialMobHandlers = {
        ['Saehrimnir'] = function()
            -- TODO: The exact value is unknown but it appears to provide a certain amount of regain to all mobs
            -- Future mobs will have 30% regain
            chamberData.mods[xi.mod.REGAIN] = 30
            -- Apply regain to mobs already spawned
            for _, spawnedMob in pairs(chamberData.mobs) do
                spawnedMob:setMod(xi.mod.REGAIN, 30)
            end

            forEachPlayer(chamberData.players, function(player)
                player:messageSpecial(ID.text.STAGNANT_AURA_CLEARED)
                player:messageSpecial(ID.text.CREATURES_RESTLESS)
            end)
        end
    }

    if specialMobHandlers[mob:getName()] then
        specialMobHandlers[mob:getName()]()
    end
end

local function onSpecialMobDeath(chamberData, mob)
    local specialMobHandlers = {
        ['Saehrimnir'] = function()
            mob:removeListener('EINHERJAR_DESPAWN')
        end,

        ['Heithrun'] = function()
            -- TODO: Not enough data on Heithrun effect
        end,

        ['Muninn'] = function()
            chamberData.mods[xi.mod.HPP] = -10
            for _, spawnedMob in pairs(chamberData.mobs) do
                spawnedMob:setMod(xi.mod.HPP, -10)
                spawnedMob:updateHealth()
            end

            forEachPlayer(chamberData.players, function(player)
                player:messageSpecial(ID.text.STAGNANT_AURA_CLEARED)
                player:messageSpecial(ID.text.CREATURES_CALMED)
            end)
        end,

        ['Huginn'] = function()
            if chamberData.tempCrate then
                log(chamberData.id, 'Showing temporary armory crate')
                chamberData.tempCrate:setPos(
                    mob:getXPos(),
                    mob:getYPos(),
                    mob:getZPos(),
                    mob:getRotPos()
                )
                npcUtil.showCrate(chamberData.tempCrate)
            end
        end,
    }

    if specialMobHandlers[mob:getName()] then
        specialMobHandlers[mob:getName()]()
    end
end

-- Check if all mobs are defeated and cycle to the next wave
-- Keeps track of defeated regular mobs for Ichor calculation
local function onMobDespawn(chamberData, mob)
    if mob:getLocalVar('[ein]type') == mobType.REGULAR then
        table.insert(chamberData.deadMobs, mob)
    end

    for i, mobEntry in ipairs(chamberData.mobs) do
        if mobEntry == mob then
            table.remove(chamberData.mobs, i)
            break
        end
    end

    if #chamberData.mobs <= 0 then
        xi.einherjar.cycleWave(chamberData)
    end
end

-- Lock the chamber when any mob is engaged
local function onMobEngage(chamberData, mob)
    if not chamberData.locked then
        chamberData.locked = true
        log(chamberData.id, 'Mobs engaged, locking the chamber.')
        if chamberData.encounters.special then
            -- Unknown if that's the actual trigger for countdown
            -- Captures show special spawn as early as 1.5 minutes from engaging mobs
            chamberData.eventsQueue[os.time() + math.random(90, 300)] = function()
                local x, y, z = unpack(xi.einherjar.getRandomPosForMobGroup(chamberData.id, 10, 30))
                local specialMob = GetMobByID(chamberData.encounters.special)
                if specialMob then
                    specialMob:setSpawn(x, y, z, math.random(0, 255))
                    xi.einherjar.spawnMob(specialMob, mobType.SPECIAL, chamberData)
                end
            end
        end
    end
end

xi.einherjar.new = function(chamberId, leaderId)
    local startTime = os.time()

    local chamberData = {
        id          = chamberId,
        leaderId    = leaderId,
        startTime   = startTime,
        endTime     = startTime + (xi.einherjar.settings.EINHERJAR_TIME_LIMIT * 60),
        locked      = false,
        players     = {},

        encounters  = xi.einherjar.makeChamberPlan(chamberId),
        mobs        = {},
        deadMobs    = {},
        plannedMobs = 0,
        mobMods     = {
            [xi.mobMod.ALLI_HATE]      = 100,
            [xi.mobMod.CHECK_AS_NM]    = 1,
            [xi.mobMod.CHARMABLE]      = 0,
            [xi.mobMod.DONT_ROAM_HOME] = 1,
        },
        mods        = {},
        waveIndex   = 0,
        lootCrate   = GetNPCByID(ID.npc.ARMOURY_CRATE[chamberId]),
        tempCrate   = GetNPCByID(ID.npc.ARMOURY_CRATE[chamberId * 2]),
    }

    -- Back out if we failed to create a plan
    if not chamberData.encounters then
        log(chamberId, 'Failed to create chamber plan, releasing chamber.')
        return nil
    end

    -- Keep track of number of planned mobs
    -- Used to calculate completion rate for Ichor rewards
    for _, wave in ipairs(chamberData.encounters.waves) do
        chamberData.plannedMobs = chamberData.plannedMobs + #wave
    end

    if chamberData.lootCrate then
        chamberData.lootCrate:setPos(
            xi.einherjar.chambers[chamberData.id].center[1],
            xi.einherjar.chambers[chamberData.id].center[2],
            xi.einherjar.chambers[chamberData.id].center[3],
            xi.einherjar.chambers[chamberData.id].center[4]
        )
        xi.einherjar.hideCrate(chamberData.lootCrate)
        chamberData.lootCrate:addListener('ON_TRIGGER', 'TRIGGER_ITEM_CRATE', utils.bind(onArmouryCrateTrigger, chamberData))
    end

    if chamberData.tempCrate then
        xi.einherjar.hideCrate(chamberData.tempCrate)
    end

    -- TODO: Create a chamber-scoped shared treasure pool

    chamberData.eventsQueue = {
        [chamberData.startTime + (xi.einherjar.settings.EINHERJAR_RESERVATION_TIMEOUT * 60)] = function()
            if not chamberData.players[chamberData.leaderId] then
                log(chamberId, 'Leader never entered chamber, cancelling reservation.')
                cleanChamber(chamberData)
                releaseChamber(chamberData.id)
            end
        end,

        -- 10 minutes, 5 minutes, 30 seconds warnings
        [chamberData.endTime - 600] = function()
            forEachPlayer(chamberData.players, function(player)
                player:messageSpecial(ID.text.TIMEOUT_WARNING, 10)
            end)
        end,

        [chamberData.endTime - 300] = function()
            forEachPlayer(chamberData.players, function(player)
                player:messageSpecial(ID.text.TIMEOUT_WARNING, 5)
            end)
        end,

        [chamberData.endTime - 30] = function()
            forEachPlayer(chamberData.players, function(player)
                player:messageSpecial(ID.text.TIMEOUT_WARNING_SECONDS, 30)
            end)
        end,

        [chamberData.endTime] = function()
            expelAllFromChamber(chamberData)
        end
    }

    log(chamberId, 'Created chamber with ' .. #chamberData.encounters.waves .. ' waves.')
    return chamberData
end

xi.einherjar.onChamberEnter = function(chamberData, player, reconnecting)
    local playerId = player:getID()
    log(chamberData.id, 'Player entered: ' .. player:getName() .. ' (' .. playerId .. ')')

    player:setCharVar('[ein]chamber', chamberData.id, chamberData.endTime)
    -- TODO: Add to chamber treasure pool

    for i = 0, 3 do
        player:changeMusic(i, 0x8F)
    end

    chamberData.players[playerId] = player

    if not reconnecting then
        xi.einherjar.recordLockout(player)
    end
end

xi.einherjar.onChamberExit = function(chamberData, player)
    if not chamberData.players[player:getID()] then -- player dropped glass without entering
        return
    end

    for _, remainingMob in pairs(chamberData.mobs) do
        remainingMob:clearEnmityForEntity(player)
    end

    -- Expel player from chamber
    player:startEvent(4)

    player:messageSpecial(ID.text.LAMP_POWER_FADED, xi.item.GLOWING_LAMP)

    -- Award Therion Ichor
    local ampoulesReward = xi.einherjar.getAmpoulesReward(chamberData.id, #chamberData.deadMobs, chamberData.plannedMobs)
    player:messageSpecial(ID.text.AMPOULES_OBTAINED, ampoulesReward)

    if ampoulesReward ~= 0 then
        player:addCurrency('therion_ichor', ampoulesReward)
    end

    -- Clean player state
    player:setCharVar('[ein]chamber', 0)
    -- TODO: Remove from chamber treasure pool

    for i = 0, 3 do
        player:changeMusic(i, 0x0)
    end

    chamberData.players[player:getID()] = nil

    xi.einherjar.voidAllLamps(player, chamberData.id)

    -- Release chamber if no players are left without waiting for the timeout
    if #chamberData.players == 0 then
        cleanChamber(chamberData)
        releaseChamber(chamberData.id)
    end
end

xi.einherjar.spawnMob = function(mob, newMobType, chamberData)
    mob:setCallForHelpBlocked(true)
    mob:setClaimable(false) -- TODO: On retail, mobs show as red but still allow everyone to attack

    if newMobType == mobType.SPECIAL then
        mob:addListener('DEATH', 'EINHERJAR_DEATH', utils.bind(onSpecialMobDeath, chamberData))
        mob:addListener('DESPAWN', 'EINHERJAR_DESPAWN', utils.bind(onSpecialMobDespawn, chamberData))
        mob:addListener('ENGAGE', 'EINHERJAR_ENGAGE', utils.bind(onMobEngage, chamberData))

        -- Despawn special mob after 5 minutes
        chamberData.eventsQueue[os.time() + 300] = function()
            DespawnMob(mob:getID())
        end
    else
        mob:addListener('DESPAWN', 'EINHERJAR_DESPAWN', utils.bind(onMobDespawn, chamberData))
        mob:addListener('ENGAGE', 'EINHERJAR_ENGAGE', utils.bind(onMobEngage, chamberData))
        table.insert(chamberData.mobs, mob)
    end

    mob:spawn()
    mob:setLocalVar('[ein]chamber', chamberData.id)
    mob:setLocalVar('[ein]type', newMobType)

    for mod, value in pairs(chamberData.mobMods) do
        mob:setMobMod(mod, value)
    end

    if newMobType == mobType.SPECIAL then
        -- Special mobs have unique roaming properties
        mob:setMobMod(xi.mobMod.ROAM_COOL, 8)
        mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 60)
        mob:setMobMod(xi.mobMod.ROAM_RATE, 5)
    elseif newMobType == mobType.REGULAR then
        mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 20)
    end

    for mod, value in pairs(chamberData.mods) do
        mob:setMod(mod, value)
    end

    log(chamberData.id, 'Spawned mob: ' .. mob:getName() .. '[' .. mob:getID() .. ']')

    -- Special case: Hrungnir spawns a clone
    if mob:getID() == ID.mob.HRUNGNIR then
        local clone = GetMobByID(ID.mob.HRUNGNIR_CLONE)
        if clone then
            clone:setSpawn(
                mob:getXPos() + 1,
                mob:getYPos(),
                mob:getZPos(),
                mob:getRotPos()
            )
            xi.einherjar.spawnMob(clone, mobType.BOSS, chamberData)
        end
    end
end

-- Spawn mobs for the next wave, including the boss on the last wave
-- Mobs are grouped randomly and spawned in a random position within a range
xi.einherjar.cycleWave = function(chamberData)
    if not chamberData.encounters.waves[chamberData.waveIndex + 1] then
        log(chamberData.id, 'All waves cleared! Showing armoury crate.')
        npcUtil.showCrate(chamberData.lootCrate)
        chamberData.lootCrate:setLocalVar('[ein]chamber', chamberData.id)
        return
    end

    log(chamberData.id, string.format('Cycling to next wave %d -> %d', chamberData.waveIndex, chamberData.waveIndex + 1))
    chamberData.waveIndex = chamberData.waveIndex + 1

    local waveMobs = xi.einherjar.subDivideMobs(chamberData.encounters.waves[chamberData.waveIndex])

    -- Spawn mobs with group-based and individual random variation
    for _, subGroup in ipairs(waveMobs) do
        -- Group center position relative to the chamber center
        local groupCenterX, groupCenterY, groupCenterZ = unpack(xi.einherjar.getRandomPosForMobGroup(chamberData.id, 3, 15))

        for _, mobId in ipairs(subGroup) do
            local newMob = GetMobByID(mobId)

            if newMob then
                newMob:setSpawn(
                    groupCenterX + math.random(-3, 3),
                    groupCenterY,
                    groupCenterZ + math.random(-7, 7),
                    math.random(0, 255)
                )
                xi.einherjar.spawnMob(newMob, mobType.REGULAR, chamberData)
            end
        end
    end

    -- On last wave, also spawn the boss
    if
        chamberData.waveIndex == chamberData.encounters.waveCount and
        chamberData.encounters.boss
    then
        local newBoss = GetMobByID(chamberData.encounters.boss)
        if newBoss then
            newBoss:setSpawn(unpack(xi.einherjar.getRandomPosForMobGroup(chamberData.id, 0, 0)))
            xi.einherjar.spawnMob(newBoss, mobType.BOSS, chamberData)
        end
    end
end

--=============================
-- Zone events listeners
--=============================

local function onChamberTick(chamberData)
    if not chamberData.eventsQueue or next(chamberData.eventsQueue) == nil then
        return
    end

    local currentTime = os.time()

    for timestamp, event in pairs(chamberData.eventsQueue) do
        if currentTime >= timestamp then
            log(chamberData.id, 'Executing event at ' .. timestamp)
            event()
            chamberData.eventsQueue[timestamp] = nil
        end
    end
end

-- On every zone tick, check if chambers have events to process
xi.einherjar.onZoneTick = function(zone)
    for _, chamberData in pairs(chambersInstances) do
        if chamberData then
            onChamberTick(chamberData)
        end
    end
end

-- Zoning out without dropping glass forfeits ichor rewards
xi.einherjar.onZoneOut = function(chamberData, player)
    if chamberData.players[player:getID()] then
        log(chamberData.id, 'Player zoned out: ' .. player:getName() .. ' (' .. player:getID() .. ')')
        chamberData.players[player:getID()] = nil
    end
end

-- Check if player has a matching lamp, else they get warped to entrance
xi.einherjar.onReconnection = function(chamberData, player)
    local playerId = player:getID()

    if #xi.einherjar.getMatchingLamps(player, chamberData.id, chamberData.startTime) == 0 then
        return false
    end

    chamberData.players[playerId] = player
    log(chamberData.id, 'Player reconnected: ' .. player:getName() .. ' (' .. playerId .. ')')
    xi.einherjar.onChamberEnter(chamberData, player, true)

    return true
end
