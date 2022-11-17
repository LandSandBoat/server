-----------------------------------
-- Garrison
-----------------------------------
require('scripts/globals/common')
require('scripts/globals/npc_util')
require('scripts/globals/garrison_data')
require('scripts/globals/mobs')
require('scripts/globals/npc_util')
require('scripts/globals/pathfind')
require('scripts/globals/utils')
require('scripts/globals/zone')
-----------------------------------
xi = xi or {}
xi.garrison = xi.garrison or {}

xi.garrison.state =
{
    SPAWN_NPCS          = 0,
    BATTLE              = 1,
    SPAWN_MOBS          = 2,
    SPAWN_BOSS          = 3,
    ADVANCE_WAVE        = 4,
    GRANT_LOOT          = 5,
    ENDED               = 6,
}

-----------------------------------
-- Helpers: Logging / Messaging
-----------------------------------

-- Prints the given message if DEBUG_GARRISON is enabled
local debugLog = function(msg)
    if xi.settings.main.DEBUG_GARRISON then
        print("[Garrison]: " .. msg)
    end
end

-- Prints the given message with printf if DEBUG_GARRISON is enabled
local debugLogf = function(msg, ...)
    if xi.settings.main.DEBUG_GARRISON then
        printf("[Garrison]: " .. msg, ...)
    end
end

-- Shows the given server message to all players if DEBUG_GARRISON is enabled
local debugPrintToPlayers = function(players, msg)
    if xi.settings.main.DEBUG_GARRISON then
        for _, player in pairs(players) do
            player:PrintToPlayer(msg)
        end
    end
end

-- Sends a message packet to all players
local messagePlayers = function(npc, players, msg)
    for _, player in ipairs(players) do
        player:messageText(npc, msg)
    end
end

-----------------------------------
-- Helpers: Spawning
-----------------------------------

-- Add level restriction effect
-- If a party member is KO'd during the Garrison, they're out.
-- Any players that are KO'd lose their level restriction and will be unable to help afterward.
-- Giving this the CONFRONTATION flag hooks into the target validation systme and stops outsiders
-- participating, for mobs, allies, and players.
xi.garrison.addLevelCap = function(entity, cap)
    entity:addStatusEffectEx(
        xi.effect.LEVEL_RESTRICTION,
        xi.effect.LEVEL_RESTRICTION,
        cap,
        0,
        0,
        0,
        0,
        0,
        -- Note the level restriction does not wear on death.
        -- Some sources say it does, but we have captures showing otherwise.
        xi.effectFlag.ON_ZONE + xi.effectFlag.CONFRONTATION)
end

-- Randomly assigns aggro between the given groups of entity IDs
xi.garrison.aggroGroups = function(group1, group2)
    for _, entityId1 in pairs(group1) do
        for _, entityId2 in pairs(group2) do
            local entity1 = GetMobByID(entityId1)
            local entity2 = GetMobByID(entityId2)

            if entity1 == nil or entity2 == nil then
                printf("[warning] Could not apply aggro because either %i or %i are not valid entities", entityId1, entityId2)
            else
                entity1:addEnmity(entity2, math.random(1, 5), math.random(1, 5))
                entity2:addEnmity(entity1, math.random(1, 5), math.random(1, 5))
            end
        end
    end
end

-- Spawns and npc for the given zone and with the given name, look, pose
-- Uses dynamic entities
xi.garrison.spawnNPC = function(zone, zoneData, x, y, z, rot, name, look)
    local mob = zone:insertDynamicEntity({
        objtype = xi.objType.MOB,
        allegiance = xi.allegiance.PLAYER,
        name = name,
        x = x,
        y = y,
        z = z,
        rotation = rot,
        look = look,

        -- TODO: Make relevant group and pool entries for NPCs
        groupId = 35,
        groupZoneId = xi.zone.NORTH_GUSTABERG,

        releaseIdOnDisappear = true,
        specialSpawnAnimation = true,
    })

    -- Use the mob object as you normally would
    mob:setSpawn(x, y, z, rot)
    mob:setMobMod(xi.mobMod.NO_DROPS, 1)
    mob:setRoamFlags(xi.roamFlag.SCRIPTED)

    mob:spawn()

    DisallowRespawn(mob:getID(), true)
    mob:setSpeed(25)
    mob:setAllegiance(1)

    -- NPCs don't cast spells or use TP skills
    mob:setMagicCastingEnabled(false)
    mob:setMobAbilityEnabled(false)

    -- Death listener for tracking win/lose condition
    mob:addListener("DEATH", "GARRISON_NPC_DEATH", function(mobArg)
        zoneData.deadNPCCount = zoneData.deadNPCCount + 1
    end)

    return mob
end

-- Spawns all npcs for the zone in the given garrison starting npc
xi.garrison.spawnNPCs = function(zone, zoneData)
    local xPos     = zoneData.xPos
    local yPos     = zoneData.yPos
    local zPos     = zoneData.zPos
    local rot      = zoneData.rot

    -- xi.nation starts at 0. Since we use it as index, add off by 1
    local regionIndex = GetRegionOwner(zone:getRegionID()) + 1
    local allyName    = xi.garrison.allyNames[zoneData.levelCap][regionIndex]
    local allyLooks   = xi.garrison.allyLooks[zoneData.levelCap][regionIndex]

    -- Spawn 1 npc per player in alliance
    for i = 1, #zoneData.players do
        local mob = xi.garrison.spawnNPC(zone, zoneData, xPos, yPos, zPos, rot, allyName, utils.randomEntry(allyLooks))
        mob:setMobLevel(zoneData.levelCap - math.floor(zoneData.levelCap / 5))
        xi.garrison.addLevelCap(mob, zoneData.levelCap)
        table.insert(zoneData.npcs, mob:getID())

        if i == 6 then
            xPos = zoneData.xPos - zoneData.xSecondLine
            zPos = zoneData.zPos - zoneData.zSecondLine
        elseif i == 12 then
            xPos = zoneData.xPos - zoneData.xThirdLine
            zPos = zoneData.zPos - zoneData.zThirdLine
        else
            xPos = xPos - zoneData.xChange
            zPos = zPos - zoneData.zChange
        end
    end
end

-- Spawns a mob with the given id for the given zone.
xi.garrison.spawnMob = function(mobID, zoneData)
    local mob = SpawnMob(mobID)
    if mob == nil then
        return nil
    end

    xi.garrison.addLevelCap(mob, zoneData.levelCap)
    mob:setRoamFlags(xi.roamFlag.SCRIPTED)
    table.insert(zoneData.mobs, mobID)

    -- Death listener for tracking win/lose condition
    mob:addListener("DEATH", "GARRISON_MOB_DEATH", function(mobArg)
        zoneData.deadMobCount = zoneData.deadMobCount + 1
    end)

    -- A wave is considered complete when all mobs are done despawning
    -- and not just dead. This matters a lot because of spawn timings.
    -- I.e: If mob A dies on wave 1, and another instance of mob A is supposed
    -- to spawn on wave 2, it will not spawn as long as the previous mob is still
    -- despawning
    -- For this reason, we track both death and despawn as separate events
    mob:addListener("DESPAWN", "GARRISON_MOB_DESPAWN", function(mobArg)
        zoneData.despawnedMobCount = zoneData.despawnedMobCount + 1
    end)

    return mob
end

-- Given a starting mobID, return the list of randomly selected
-- mob ids. The amount of mobs selected is determined by numMobs.
-- The ids in the given excludedMobs table will not be included in the result.
-- This method assumes that the mob pool is composed by mobIDs
-- that are sequential between firstMobID and lastMobID
-- e.g: If firstMobId = 1, lastMobID = 4 and numMobs is 2,
-- Then 2 ids randomly selected between { 1, 2, 3, 4 } will be returned
-- without repetitions.
xi.garrison.pickMobsFromPool = function(firstMobID, lastMobID, numMobs, excludedMobIDs)
    -- unfiltered pool, from first to last mob id (inclusive)
    local unfilteredPool = utils.range(firstMobID, lastMobID)

    -- filter the pool, removing excludedMobIDs
    local pool = {}
    local excludedSet = set(excludedMobIDs)
    for _, v in ipairs(unfilteredPool) do
        if not excludedSet[v] then
            table.insert(pool, v)
        end
    end

    -- validate input
    local mobs = {}
    if numMobs > #pool then
        printf("[warning] pickMobsFromPool called with numMobs > mobIds. Num Mobs: %i. Pool size: %i", numMobs, #pool)
        numMobs = #pool
    end

    if numMobs <= 0 then
        printf("[error] Invalid numMobs picked. Should be > 0.")
        return {}
    end

    -- Now we can apply a common algorithm used to "shuffle a deck of cards"
    for i = 1, numMobs do
        -- Pick random index from J to pool end. Add the picked element to result
        local pickedIndex = math.random(i, #pool)
        table.insert(mobs, pool[pickedIndex])

        -- Now swap the picked element with the first element of the array.
        -- This effectively makes the picked element not elegible for future picks.
        pool[pickedIndex], pool[i] = pool[i], pool[pickedIndex]
    end

    return mobs
end

-----------------------------------
-- Main Functions
-----------------------------------

xi.garrison.tick = nil -- Prototype
xi.garrison.tick = function(npc)
    local zone         = npc:getZone()
    local zoneData     = xi.garrison.zoneData[zone:getID()]
    local ID           = zones[npc:getZoneID()]
    local entityMapper = function (_, entityId) return GetPlayerByID(entityId) end
    local players      = utils.map(zoneData.players, entityMapper)

    switch (zoneData.state) : caseof
    {
        [xi.garrison.state.SPAWN_NPCS] = function()
            debugLog("State: Spawn NPCs")
            xi.garrison.spawnNPCs(zone, zoneData)

            zoneData.stateTime = os.time()
            zoneData.state = xi.garrison.state.BATTLE
        end,

        [xi.garrison.state.BATTLE] = function()
            debugLog("State: Battle")

            -- We do not cache player entity state as they can reraise or DC,
            -- making caching more error prone
            local isAliveFn = function(_, player) return player ~= nil and player:isAlive() end
            local allPlayersDead = not utils.any(players, isAliveFn)

            -- This caching works because the same mob ID is never used to respawn a mob
            -- within the same wave.
            local allMobsDead      = zoneData.deadMobCount == #zoneData.mobs
            local allMobsDespawned = zoneData.despawnedMobCount == #zoneData.mobs

            -- case 1: Either npcs or players are dead. End event.
            local allNPCsDead = #zoneData.npcs == zoneData.deadNPCCount
            if allNPCsDead or allPlayersDead then
                -- You fought hard, and you proved yourself worthy...
                debugPrintToPlayers(players, "Mission failed by death")
                messagePlayers(npc, players, ID.text.GARRISON_BASE + 39)
                zoneData.state = xi.garrison.state.ENDED
                return
            end

            -- case 2: More mobs to spawn in this wave, and past next spawn time. Spawn Mobs.
            local shouldSpawnMobs = os.time() >= zoneData.nextSpawnTime
            local isLastGroup = zoneData.groupIndex > xi.garrison.waves.groupsPerWave[zoneData.waveIndex]
            if shouldSpawnMobs and not isLastGroup then
                zoneData.state = xi.garrison.state.SPAWN_MOBS
                return
            end

            -- case 3: All mobs spawned for last wave. Spawn boss
            local isLastWave = zoneData.waveIndex == #xi.garrison.waves.groupsPerWave
            if shouldSpawnMobs and isLastWave and isLastGroup and not zoneData.bossSpawned then
                zoneData.state = xi.garrison.state.SPAWN_BOSS
                return
            end

            -- case 4: All Mobs despawned and this was last group. Check if we advance to next wave
            if allMobsDespawned and isLastGroup and not isLastWave then
                zoneData.state = xi.garrison.state.ADVANCE_WAVE
                return
            end

            -- case 5: All mobs are dead and this was last group and last wave. Grant loot.
            if allMobsDead and isLastGroup and isLastWave and zoneData.bossSpawned then
                zoneData.state = xi.garrison.state.GRANT_LOOT
                return
            end

            -- case 6: Timeout
            if os.time() > zoneData.endTime then
                -- You fought hard, and you proved yourself worthy...
                debugPrintToPlayers(players, "Mission failed by timeout")
                messagePlayers(npc, players, ID.text.GARRISON_BASE + 39)

                zoneData.state = xi.garrison.state.ENDED
            end
        end,

        [xi.garrison.state.SPAWN_BOSS] = function()
            debugLog("State: Spawn Boss")
            debugPrintToPlayers(players, "Spawning boss")

            local bossID = zone:queryEntitiesByName(zoneData.mobBoss)[1]:getID()
            local mob = xi.garrison.spawnMob(bossID, zoneData)
            if mob == nil then
                print("[error] Could not spawn boss (%i). Ending garrison.", bossID)
                zoneData.state = xi.garrison.state.ENDED
                return
            end

            xi.garrison.aggroGroups({ bossID }, zoneData.npcs)
            zoneData.bossSpawned = true
            zoneData.state = xi.garrison.state.BATTLE
        end,

        [xi.garrison.state.ADVANCE_WAVE] = function()
            debugLog("State: Advance Wave")
            debugLogf("Wave Idx: %i. Waves: %i", zoneData.waveIndex, #xi.garrison.waves.groupsPerWave)
            debugLogf("Next wave: %i", zoneData.waveIndex)
            debugPrintToPlayers(players, "Wave " .. zoneData.waveIndex .. " cleared")

            zoneData.waveIndex = zoneData.waveIndex + 1
            zoneData.groupIndex = 1
            zoneData.nextSpawnTime = os.time() + xi.garrison.waves.delayBetweenGroups
            zoneData.state = xi.garrison.state.BATTLE
            zoneData.mobs = {}
            -- reset mob state cache, but not npc since they dont respawn each wave
            zoneData.deadMobCount      = 0
            zoneData.despawnedMobCount = 0
        end,

        [xi.garrison.state.SPAWN_MOBS] = function()
            debugLog("State: Spawn Mobs")

            -- There are always at most 8 mobs + 1 boss for Garrison, so we will look up the
            -- boss's ID using their name and then subtract 8 to get the starting mob ID.
            local firstMobID = zone:queryEntitiesByName(zoneData.mobBoss)[1]:getID() - 8
            local numMobs = xi.garrison.waves.mobsPerGroup
            local poolSize = xi.garrison.waves.mobsPerGroup * xi.garrison.waves.groupsPerWave[zoneData.waveIndex]
            local lastMobID = firstMobID + poolSize - 1

            -- Pick mobs randomly and spawn them
            local mobIDs = xi.garrison.pickMobsFromPool(firstMobID, lastMobID, numMobs, zoneData.mobs)
            for _, mobID in ipairs(mobIDs) do
                xi.garrison.spawnMob(mobID, zoneData)
            end

            -- Once the mobs are spawned, make them aggro whatever NPCs are already up
            -- This method should work fine even if some of these mobs or npcs are invalid / dead
            xi.garrison.aggroGroups(mobIDs, zoneData.npcs)

            debugPrintToPlayers(players, "Spawn: " .. #zoneData.mobs .. "/" .. poolSize .. ". Wave: " .. zoneData.waveIndex)
            zoneData.nextSpawnTime = os.time() + xi.garrison.waves.delayBetweenGroups
            zoneData.state = xi.garrison.state.BATTLE
            zoneData.groupIndex = zoneData.groupIndex + 1
        end,

        [xi.garrison.state.GRANT_LOOT] = function()
            debugLog("State: Grant Loot")
            debugPrintToPlayers(players, "Mission success")

            messagePlayers(npc, players, ID.text.GARRISON_BASE + 36)
            xi.garrison.handleLootRolls(xi.garrison.loot[zoneData.levelCap], zoneData.players)
            zoneData.state = xi.garrison.state.ENDED
        end,

        [xi.garrison.state.ENDED] = function()
            debugLog("State: Ended")

            xi.garrison.stop(zone)
        end,
    }

    if zoneData.isRunning then
        npc:timer(1000, function(npcArg)
            xi.garrison.tick(npcArg)
        end)
    end
end

xi.garrison.start = function(player, npc)
    local zone           = player:getZone()
    local zoneData       = xi.garrison.zoneData[zone:getID()]
    zoneData.players     = {}
    zoneData.npcs        = {}
    zoneData.mobs        = {}
    zoneData.state       = xi.garrison.state.SPAWN_NPCS
    zoneData.isRunning    = true
    zoneData.stateTime   = os.time()
    zoneData.waveIndex   = 1
    zoneData.groupIndex  = 1
    zoneData.bossSpawned = false
    -- First mob spawn takes xi.garrison.waves.delayBetweenGroups to start
    zoneData.nextSpawnTime = os.time() + xi.garrison.waves.delayBetweenGroups
    zoneData.endTime           = os.time() + xi.settings.main.GARRISON_TIME_LIMIT
    zoneData.deadNPCCount      = 0
    zoneData.deadMobCount      = 0
    zoneData.despawnedMobCount = 0

    -- Adds level cap / registers lockout for all players
    -- We register lockout at the beginning and end, in case players DC
    for _, member in pairs(player:getAlliance()) do
        if member:getZoneID() == player:getZoneID() then
            xi.garrison.addLevelCap(member, zoneData.levelCap)
            xi.garrison.savePlayerLockout(member)

            table.insert(zoneData.players, member:getID())
        end
    end

    -- The starting NPC is the 'anchor' for all timers and logic for this Garrison
    xi.garrison.tick(npc)
end

-- Stops and cleans up the current garrison event (if any) on the given zone
-- Can be called externally from GM commands
xi.garrison.stop = function(zone)
    local zoneData = xi.garrison.zoneData[zone:getID()]
    for _, entityId in pairs(zoneData.players or {}) do
        local entity = GetPlayerByID(entityId)
        if entity ~= nil then
            entity:delStatusEffect(xi.effect.LEVEL_RESTRICTION)
            xi.garrison.savePlayerLockout(entity)
        end
    end

    for _, entityId in pairs(zoneData.npcs or {}) do
        DespawnMob(entityId, zone)
    end

    for _, entityId in pairs(zoneData.mobs or {}) do
        DespawnMob(entityId, zone)
    end

    zoneData.players     = {}
    zoneData.npcs        = {}
    zoneData.mobs        = {}
    zoneData.isRunning   = false
end

xi.garrison.onTrade = function(player, npc, trade, guardNation)
    if not xi.settings.main.ENABLE_GARRISON then
        debugLog("Garrison not enabled. Set ENABLE_GARRISON if desired.")
        return false
    end

    local zoneData = xi.garrison.zoneData[player:getZoneID()]
    if npcUtil.tradeHasExactly(trade, zoneData.itemReq) then
        if not xi.garrison.validateEntry(zoneData, player, npc, guardNation) then
            debugLog("Player does not meet entry requirements")
            return false
        end

        -- Start CS
        player:startEvent(32753 + player:getNation())
        player:setLocalVar('GARRISON_NPC', npc:getID())
        return true
    end

    return false
end

xi.garrison.onTrigger = function(player, npc)
    if not xi.settings.main.ENABLE_GARRISON then
        return false
    end

    return false
end

xi.garrison.onEventFinish = function(player, csid, option, guardNation, guardType, guardRegion)
    if not xi.settings.main.ENABLE_GARRISON then
        debugLog("Garrison not enabled. Set ENABLE_GARRISON if desired.")
        return false
    end

    if csid == 32753 + player:getNation() and option == 0 then
        player:confirmTrade()
        local npc = GetNPCByID(player:getLocalVar('GARRISON_NPC'))
        xi.garrison.start(player, npc)
        return true
    end

    return false
end

-- Distributes loot amongst all players
-- TODO: Use a central loot system: https://github.com/LandSandBoat/server/issues/3188
xi.garrison.handleLootRolls = function(lootTable, players)
    local max = 0

    for _, entry in ipairs(lootTable) do
        max = max + entry.droprate
    end

    local roll = math.random(max)

    for _, entry in pairs(lootTable) do
        max = max - entry.droprate

        if roll > max then
            if entry.itemid ~= 0 then
                for _, entityId in ipairs(players) do
                    local player = GetPlayerByID(entityId)
                    if player ~= nil then
                        player:addTreasure(entry.itemid)
                        return
                    end
                end
            end

            break
        end
    end
end

-----------------------------------
-- Entry
-----------------------------------

-- Validates that the player meets the requirements to enter garrison:
-- * Another garrison is not currently active
-- * Outpost is controlled by the player's nation, or GARRISON_NATION_BYPASS setting is true
-- * No player in the alliance (in zone) is level synced
-- * Player hasn't entered garrison since last tally, or GARRISON_ONCE_PER_WEEK setting is false
-- * Player has not finished a garrison since in the last GARRISON_LOCKOUT seconds
-- * Player does not have more than GARRISON_PARTY_LIMIT alliance memebrs
-- * Player is at least at GARRISON_RANK rank level
xi.garrison.validateEntry = function(zoneData, player, npc, guardNation)
    local ID = zones[player:getZoneID()]
    if zoneData.isRunning then
        debugLog("Another garrison in progress")
        player:messageText(npc, ID.text.GARRISON_BASE + 1)
        return false
    end

    local sameZone = function (_, v) return v ~= nil and v:getZoneID() == player:getZoneID() end
    local membersInZone = utils.filterArray(player:getAlliance(), sameZone)

    -- This assumes that only the player trading the item has to be from the right nation
    if xi.settings.main.GARRISON_NATION_BYPASS == false and guardNation ~= player:getNation() then
        debugLog("Outpost not controller by player's nation")
        player:messageSpecial(ID.text.GARRISON_BASE + player:getNation(), zoneData.itemReq)
        return false
    end

    if utils.any(membersInZone, function(_, v) return v:isLevelSync() end) then
        -- Your party is unable to participate because certain members' levels are restricted
        debugLog("One or more alliance members have level sync on")
        player:messageText(npc, ID.text.MEMBERS_LEVELS_ARE_RESTRICTED, false)
        return false
    end

    if #membersInZone > xi.settings.main.GARRISON_PARTY_LIMIT then
        -- This is a custom message. I don't believe retail has this limitation
        debugLogf("Alliance exceeds member limit: %d", xi.settings.main.GARRISON_PARTY_LIMIT)
        player:PrintToPlayer(printf("Maximum garrison alliance size is %d", xi.settings.main.GARRISON_PARTY_LIMIT))
        return false
    end

    local doesNotMeetRank = function(_, v)
        return v:getRank(v:getNation()) < xi.settings.main.GARRISON_RANK
    end
    if utils.any(membersInZone, doesNotMeetRank) then
        -- These young participants are quite spirited, but they lack valuable battle experience
        debugLogf("Leader does not meet required rank: %d", xi.settings.main.GARRISON_RANK)
        player:messageText(npc, ID.text.GARRISON_BASE + 4)
        return false
    end

    if xi.garrison.isAnyPlayerOnEntryCooldown(membersInZone) then
        -- We commend you on your services in helping us avert the beastmen's attack. I do not see them attacking us again any time soon
        debugLogf("Alliance members on cooldown")
        player:messageText(npc, ID.text.GARRISON_BASE + 40)
        return false
    end

    return true
end

-- Stores data related to player entry time / lockout
xi.garrison.savePlayerLockout = function(player)
    local nextEntryTime = os.time() + xi.settings.main.GARRISON_LOCKOUT
    if xi.settings.main.GARRISON_ONCE_PER_WEEK then
        nextEntryTime = math.max(nextEntryTime, getConquestTally())
    end

    player:setCharVar("[Garrison]NextEntryTime", nextEntryTime)
end

-- Returns true if any player in the given table has entered garrison too recently
-- according to the GARRISON_LOCKOUT and GARRISON_ONCE_PER_WEEK settings
-- and their last entry time
xi.garrison.isAnyPlayerOnEntryCooldown = function(players)
    for _, player in pairs(players) do
        local nextValidAttemptTime = player:getCharVar("[Garrison]NextEntryTime")
        if os.time() < nextValidAttemptTime then
            debugLogf("Cooldown time remaining: %d", nextValidAttemptTime - os.time())
            return true
        end
    end

    return false
end
