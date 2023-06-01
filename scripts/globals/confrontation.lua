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
require("scripts/globals/npc_util")
require("scripts/globals/zone")
-----------------------------------

xi = xi or {}
xi.confrontation = xi.confrontation or {}

xi.confrontation.lookup = {}

xi.confrontation.check = function(lookupKey, setupTimer)
    -- Get the list of mobs from the
    local lookup = xi.confrontation.lookup[lookupKey]
    local didWin = false
    local didLose = false

    local players = {}
    for _, id in ipairs(lookup.registeredPlayerIds) do
        table.insert(players, GetPlayerByID(id))
    end

    local mobs = {}
    for _, id in ipairs(lookup.mobIds) do
        table.insert(mobs, GetMobByID(id))
    end

    -- Check to see if the players are still valid
    local validPlayerCount = 0
    for _, m in ipairs(players) do
        if
            m:isAlive() and
            m:getZoneID() == lookup.npc:getZoneID() and
            m:getStatusEffect(xi.effect.CONFRONTATION):getPower() == lookupKey
        then
            validPlayerCount = validPlayerCount + 1
        end
    end

    if validPlayerCount == 0 then
        didLose = true
    end

    -- Check to see if the mobs are still valid
    local validMobCount = 0
    for _, m in pairs(mobs) do
        if
            m:isAlive() and
            m:getZoneID() == lookup.npc:getZoneID() and
            m:getStatusEffect(xi.effect.CONFRONTATION):getPower() == lookupKey
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
            if didWin and type(lookup.onWin) == "function" then
                lookup.onWin(member)
            elseif didLose and type(lookup.onLose) == "function" then
                lookup.onLose(member)
            end
        end

        -- Despawn Mobs
        for _, mob in ipairs(mobs) do
            if mob:isSpawned() then
                DespawnMob(mob:getID())
            end
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

xi.confrontation.start = function(player, npc, mobIds, winFunc, loseFunc)
    -- Generate lookup ID from spawn npc data
    local lookupKey = bit.rshift(npc:getID(), 16)

    -- Extract mobIds
    local mobs = {}
    if type(mobIds) == "number" then
        table.insert(mobs, mobIds)
    elseif type(mobIds) == "table" then
        for _, v in pairs(mobIds) do
            if type(v) == "number" then
                table.insert(mobs, v)
            end
        end
    end

    mobIds = mobs

    -- Tag alliance members with the confrontation effect
    local registeredPlayerIds = {}
    local alliance = player:getAlliance()
    for _, member in ipairs(alliance) do
        -- Using the pop npc's ID as the "key"
        member:addStatusEffect(xi.effect.CONFRONTATION, lookupKey, 0, 0)
        local effect = member:getStatusEffect(xi.effect.CONFRONTATION)
        effect:setFlag(effect:getFlag() + xi.effectFlag.ON_ZONE)
        table.insert(registeredPlayerIds, member:getID())
    end

    -- Tag mobs with the confrontation effect
    for _, mobId in pairs(mobs) do
        local mob = GetMobByID(mobId)
        mob:addStatusEffect(xi.effect.CONFRONTATION, lookupKey, 0, 0)
        mob:addListener("DEATH", "CONFRONTATION_DEATH", function(mobArg)
            mobArg:removeListener("CONFRONTATION_DEATH")
            xi.confrontation.check(npc, false)
        end)
    end

    -- Cache the lists into the global lookup
    xi.confrontation.lookup[lookupKey] = {}
    xi.confrontation.lookup[lookupKey].npc = npc
    xi.confrontation.lookup[lookupKey].registeredPlayerIds = registeredPlayerIds
    xi.confrontation.lookup[lookupKey].mobIds = mobIds
    xi.confrontation.lookup[lookupKey].onWin = winFunc
    xi.confrontation.lookup[lookupKey].onLose = loseFunc

    -- Pop!
    npcUtil.popFromQM(player, npc, mobIds, { look = true, claim = true, hide = 1 })

    -- Set up timed checks
    xi.confrontation.check(lookupKey, true)
end
