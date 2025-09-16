-----------------------------------
-- Confrontation
--
-- Confrontation is a status effect that isolates a player or group of players
-- until it wears off or is removed. Affected characters suffer no personal ill effects,
-- but cannot be aided by anyone who is not participating in the same battle, nor can
-- they interact with players or mobs outside of the battle.
--
-- How to remove the effect
-- - Finishing the battle by completing all objectives will remove this effect.
-- - Failing to complete the battle will remove the effect.
--
-- How the effect is inflicted/gained
-- - Spawning an NM at a Field Parchment as part of an elite training regime for Fields of Valor.
-- - Initiating ANNM battles. (?)
-- - Certain battles fought as part of A Crystalline Prophecy or A Moogle Kupo d'Etat.
-- - Spawning a Zone Boss in Dynamis.
--
-- Other Notes
-- - Any summoned pets and trusts (excluding pet wyverns) are dismissed when placed under this status effect.
-- - Often, but not always, accompanied by a Level Restriction.
-----------------------------------
require('scripts/globals/npc_util')
-----------------------------------
xi = xi or {}
xi.confrontation = xi.confrontation or {}

xi.confrontation.lookup = {}

---@param mobs table
---@return nil
xi.confrontation.despawnMobs = function(mobs)
    for _, mob in ipairs(mobs) do
        if mob:isSpawned() then
            DespawnMob(mob:getID())
        end
    end
end

local msgIfExists = function(player, msgID, offset)
    if
        not player or
        not msgID
    then
        return
    end

    player:messageSpecial(msgID + (offset or 0))
end

-- will early exit with false return if confrontation doesn't define a distanceLimit
-- will default to warn 5 times before failing confrontation
-- messages are in the zone's IDs.lua text table offset from CONFRONTATION_DISENGAGED:
-- -1: warning you have left the area
-- +1: returned to area
--  0: confrontation has ended
local confrontationDistCheck = function(player, npc, distanceLimit, distanceWarnLimit)
    if
        not (player and
        npc and
        distanceLimit and
        distanceLimit > 0)
    then
        return false
    end

    local endMsg = zones[player:getZoneID()].text.CONFRONTATION_DISENGAGED
    local prevOutOfRange = player:getLocalVar('Confrontation_Dist')
    if player:checkDistance(npc) < distanceLimit then
        player:setLocalVar('Confrontation_Dist', 0)
        if prevOutOfRange > 0 then
            -- you have returned to the area
            msgIfExists(player, endMsg, 1)
        end
    else
        -- running out of range
        player:setLocalVar('Confrontation_Dist', prevOutOfRange + 1)
        if prevOutOfRange >= (distanceWarnLimit or 5) then
            -- the confrontation has ended
            msgIfExists(player, endMsg)

            return true
        else
            -- you have ventured too far
            msgIfExists(player, endMsg, -1)
        end
    end

    return false
end

---@param lookupKey integer
---@param setupTimer boolean
---@return nil
xi.confrontation.check = function(lookupKey, setupTimer)
    -- Get the confrontation information
    local lookup = xi.confrontation.lookup[lookupKey]

    if not lookup then
        return
    end

    local didWin = false
    local didLose = false

    local players = {}
    for _, id in ipairs(lookup.registeredPlayerIds) do
        local player = GetPlayerByID(id)

        if player then
            table.insert(players, player)
        end
    end

    local mobs = {}
    for _, id in ipairs(lookup.mobIds) do
        table.insert(mobs, GetMobByID(id))
    end

    -- Check to see if the players are still valid
    local validPlayerCount = 0
    for _, member in ipairs(players) do
        if
            member:isAlive() and
            member:getZoneID() == lookup.npc:getZoneID() and
            member:hasStatusEffect(xi.effect.CONFRONTATION) and
            member:getStatusEffect(xi.effect.CONFRONTATION):getPower() == lookupKey
        then
            validPlayerCount = validPlayerCount + 1

            -- send out-of-range messages multiple times in a row then fail the confrontation if any member stays out of range long enough
            if confrontationDistCheck(member, lookup.npc, lookup.distanceLimit, lookup.distanceWarnLimit) then
                didLose = true
            end
        end
    end

    if validPlayerCount == 0 then
        didLose = true
    end

    if lookup.timeLimit then
        if GetSystemTime() > lookup.timeLimit then
            didLose = true
        end
    end

    -- Check to see if the mobs are still valid
    local validMobCount = 0
    for _, mob in pairs(mobs) do
        if
            mob:isAlive() and
            mob:getZoneID() == lookup.npc:getZoneID() and
            mob:hasStatusEffect(xi.effect.CONFRONTATION) and
            mob:getStatusEffect(xi.effect.CONFRONTATION):getPower() == lookupKey
        then
            validMobCount = validMobCount + 1
        end
    end

    if validMobCount == 0 then
        didWin = true
    end

    if didWin or didLose then
        for _, member in ipairs(players) do
            -- Clear effect
            member:delStatusEffect(xi.effect.CONFRONTATION)

            -- Fire callbacks
            if didWin and type(lookup.onWin) == 'function' then
                lookup.onWin(member)
            elseif didLose and type(lookup.onLose) == 'function' then
                lookup.onLose(member)
            end
        end

        -- Despawn mobs if lost, otherwise let them despawn naturally
        if didLose then
            xi.confrontation.despawnMobs(mobs)
        end

        -- Reset mobs/npcs/variables that may not be handled by win/lose
        if lookup.cleanUp then
            lookup.cleanUp()
        end

        xi.confrontation.lookup[lookupKey] = nil
    else -- Check again soon
        if setupTimer then
            lookup.npc:timer(2400, function(npcArg)
                xi.confrontation.check(bit.rshift(npcArg:getID(), 16), true)
            end)
        end
    end
end

---@param player CBaseEntity
---@param npc CBaseEntity
---@param mobIds table|integer
---@param params table
---@return nil
xi.confrontation.start = function(player, npc, mobIds, params)
    -- Generate lookup ID from spawn npc data
    local lookupKey = bit.rshift(npc:getID(), 16)

    params = params or {}

    -- Extract mobIds
    local mobs = {}
    if type(mobIds) == 'number' then
        table.insert(mobs, mobIds)
    elseif type(mobIds) == 'table' then
        for _, v in pairs(mobIds) do
            if type(v) == 'number' then
                table.insert(mobs, v)
            end
        end
    end

    mobIds = mobs

    -- Tag alliance members with the confrontation effect
    local alliance = {}
    if type(params.playerList) == 'table' then
        alliance = params.playerList
    else
        alliance = player:getAlliance()
    end

    local registeredPlayerIds = {}

    for _, member in ipairs(alliance) do
        -- Using the pop npc's ID as the 'key'
        member:addStatusEffect(xi.effect.CONFRONTATION, lookupKey, 0, 0)
        table.insert(registeredPlayerIds, member:getID())
    end

    -- Tag mobs with the confrontation effect
    for _, mobId in pairs(mobs) do
        local mob = GetMobByID(mobId)

        if mob then
            mob:addStatusEffect(xi.effect.CONFRONTATION, lookupKey, 0, 0)
            mob:addListener('DEATH', 'CONFRONTATION_DEATH', function(mobArg)
                mobArg:removeListener('CONFRONTATION_DEATH')
                xi.confrontation.check(lookupKey, false)
            end)
        end
    end

    -- Cache the lists into the global lookup
    local lookup = {}

    lookup.npc                 = npc
    lookup.registeredPlayerIds = registeredPlayerIds
    lookup.mobIds              = mobIds
    lookup.onWin               = params.onWin
    lookup.onLose              = params.onLose
    lookup.cleanUp             = params.cleanUp
    lookup.distanceLimit       = params.distanceLimit
    lookup.distanceWarnLimit   = params.distanceWarnLimit

    if params.timeLimit then
        lookup.timeLimit = GetSystemTime() + params.timeLimit
    end

    xi.confrontation.lookup[lookupKey] = lookup

    -- Pop!
    if params.allRegPlayerEnmity then
        npcUtil.popFromQM(player, npc, mobIds, { look = true, claim = true, hide = 1, enmityPlayerList = alliance })
    else
        npcUtil.popFromQM(player, npc, mobIds, { look = true, claim = true, hide = 1 })
    end

    -- Set up timed checks
    xi.confrontation.check(lookupKey, true)
end
