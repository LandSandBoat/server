-----------------------------------
-- Area: Promyvion-Dem
--   NM: Memory Receptacle
-----------------------------------
local ID = zones[xi.zone.PROMYVION_DEM]
-----------------------------------
local entity = {}

local receptacleInfoTable =
{
    [ID.mob.MEMORY_RECEPTACLE_TABLE[1] ] = { 1, 3, ID.npc.MEMORY_STREAM_OFFSET      }, -- Floor 1 MR
    [ID.mob.MEMORY_RECEPTACLE_TABLE[2] ] = { 2, 5, ID.npc.MEMORY_STREAM_OFFSET + 4  }, -- Floor 2 MR SE - Destination: North
    [ID.mob.MEMORY_RECEPTACLE_TABLE[3] ] = { 3, 5, ID.npc.MEMORY_STREAM_OFFSET + 5  }, -- Floor 2 MR NE - Destination: South
    [ID.mob.MEMORY_RECEPTACLE_TABLE[4] ] = { 3, 5, ID.npc.MEMORY_STREAM_OFFSET + 6  }, -- Floor 2 MR SW - Destination: South
    [ID.mob.MEMORY_RECEPTACLE_TABLE[5] ] = { 2, 5, ID.npc.MEMORY_STREAM_OFFSET + 7  }, -- floor 2 MR NW - Destination: North
    [ID.mob.MEMORY_RECEPTACLE_TABLE[6] ] = { 5, 7, ID.npc.MEMORY_STREAM_OFFSET + 1  }, -- Floor 3 (South) MR NE
    [ID.mob.MEMORY_RECEPTACLE_TABLE[7] ] = { 5, 7, ID.npc.MEMORY_STREAM_OFFSET + 2  }, -- Floor 3 (South) MR NW
    [ID.mob.MEMORY_RECEPTACLE_TABLE[8] ] = { 5, 7, ID.npc.MEMORY_STREAM_OFFSET + 3  }, -- Floor 3 (South) MR SW
    [ID.mob.MEMORY_RECEPTACLE_TABLE[9] ] = { 4, 7, ID.npc.MEMORY_STREAM_OFFSET + 8  }, -- Floor 3 (North) MR SW
    [ID.mob.MEMORY_RECEPTACLE_TABLE[10]] = { 4, 7, ID.npc.MEMORY_STREAM_OFFSET + 9  }, -- Floor 3 (North) MR NE
    [ID.mob.MEMORY_RECEPTACLE_TABLE[11]] = { 4, 7, ID.npc.MEMORY_STREAM_OFFSET + 10 }, -- Floor 3 (North) MR SE
}

local portalGroupTable =
{
    [1] = { ID.npc.MEMORY_STREAM_OFFSET },                                                                        -- Floor 1
    [2] = { ID.npc.MEMORY_STREAM_OFFSET + 4, ID.npc.MEMORY_STREAM_OFFSET + 7 },                                   -- Floor 2 leading North
    [3] = { ID.npc.MEMORY_STREAM_OFFSET + 5, ID.npc.MEMORY_STREAM_OFFSET + 6 },                                   -- Floor 2 leading South
    [4] = { ID.npc.MEMORY_STREAM_OFFSET + 8, ID.npc.MEMORY_STREAM_OFFSET + 9, ID.npc.MEMORY_STREAM_OFFSET + 10 }, -- Floor 3 North
    [5] = { ID.npc.MEMORY_STREAM_OFFSET + 1, ID.npc.MEMORY_STREAM_OFFSET + 2, ID.npc.MEMORY_STREAM_OFFSET + 3  }, -- Floor 3 South
}

local function checkForStrays(mob)
    local mobId   = mob:getID()
    local strayId = 0

    -- Check for alive/dead strays.
    for i = mobId + 1, mobId + receptacleInfoTable[mobId][2] do
        if not GetMobByID(i):isSpawned() then
            strayId = i
            break
        end
    end

    return strayId
end

local function spawnStray(mob, strayId)
    -- Save mob to spawn.
    mob:setLocalVar('[Stray]Id', strayId)

    -- 1: Raise Receptacle.
    mob:setAnimationSub(1)

    -- 2: Pop Stray.
    mob:timer(875, function(mobArg)
        local stray = GetMobByID(mobArg:getLocalVar('[Stray]Id'))
        mobArg:setLocalVar('[Stray]Id', 0)

        stray:spawn()
    end)

    -- 3: Lower Receptacle.
    mob:timer(1750, function(mobArg)
        mobArg:setAnimationSub(2)
    end)
end

entity.onMobInitialize = function(mob)
    mob:setAutoAttackEnabled(false) -- Receptacles only use TP moves.
    mob:addMod(xi.mod.DEF, 55)
end

entity.onMobSpawn = function(mob)
    local mobId = mob:getID()

    -- Setup initial portals.
    if
        mobId == ID.mob.MEMORY_RECEPTACLE_TABLE[1] and
        mob:getLocalVar('[Portal]Chosen') == 0
    then
        for portalGroup = 1, 5 do
            local groupTable = portalGroupTable[portalGroup]                       -- Fetch the whole group entry.
            local newPortal  = GetNPCByID(groupTable[math.random(1, #groupTable)]) -- Fetch an NPC object from table, at random.

            newPortal:setLocalVar('[Portal]Chosen', 1) -- Mark new portal.
        end
    end

    -- Handle Stray pop cooldown.
    mob:setLocalVar('[Stray]CooldownIdle', os.time() + 60 * math.random(2, 6))
    mob:setLocalVar('[Stray]CooldownFight', 0)

    -- Handle decoration: Fade-in.
    local decoration = GetNPCByID(mobId - 1)

    decoration:updateToEntireZone(xi.status.NORMAL, xi.anim.NONE)
end

entity.onMobRoam = function(mob)
    -- Handle stray spawn.
    if os.time() >= mob:getLocalVar('[Stray]CooldownIdle') then
        local strayId = checkForStrays(mob)

        -- Spawn stray.
        if strayId > 0 then
            spawnStray(mob, strayId)
            GetMobByID(strayId):setLocalVar('[Stray]RangedEnmity', 1)
        end

        -- Handle cooldown.
        mob:setLocalVar('[Stray]CooldownIdle', os.time() + 60 * math.random(2, 6))
    end
end

entity.onMobEngage = function(mob, target)
    -- Handle initial TP.
    mob:setTP(3000)
end

entity.onMobFight = function(mob, target)
    local mobId         = mob:getID()
    local strayCooldown = mob:getLocalVar('[Stray]CooldownFight')

    -- Handle initial cooldown.
    if strayCooldown == 0 then
        strayCooldown = os.time() + 5 * math.random(2, 4)
        mob:setLocalVar('[Stray]CooldownFight', strayCooldown)
    end

    -- Handle stray spawn.
    if os.time() >= strayCooldown then
        local strayId = checkForStrays(mob)

        -- Spawn stray.
        if strayId > 0 then
            spawnStray(mob, strayId)
        end

        -- Handle cooldown.
        mob:setLocalVar('[Stray]CooldownFight', os.time() + 5 * math.random(2, 4))
    end

    -- Check for alive associated Strays and update enmity.
    for strayId = mobId + 1, mobId + receptacleInfoTable[mobId][2] do
        local stray = GetMobByID(strayId)

        if
            stray:isSpawned() and
            not stray:isEngaged()
        then
            if stray:getLocalVar('[Stray]RangedEnmity') == 1 then
                if target:checkDistance(mob) < 10 then
                    stray:updateEnmity(target)
                end
            else
                stray:updateEnmity(target)
            end
        end
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    -- When left alone after hitting it, Memory Receptacle uses it's skill every 1-3 minutes (aprox).
    mob:setMod(xi.mod.REGAIN, 50 * math.random(1, 3))
end

entity.onMobDeath = function(mob, player, optParams)
    if
        optParams.isKiller or
        optParams.noKiller
    then
        mob:timer(2000, function(mobArg)
            local mobId = mobArg:getID()

            -- Handle receptacle: Fast despawn.
            mobArg:setStatus(xi.status.CUTSCENE_ONLY)

            -- Handle portal: Open if it's the chosen portal.
            local portal = GetNPCByID(receptacleInfoTable[mobId][3]) -- Fetch mob's associated portal.

            if portal:getLocalVar('[Portal]Chosen') == 1 then
                portal:openDoor(180) -- Open portal for 3 minutes.
            end

            -- Handle decoration: Fade-out.
            GetNPCByID(mobId - 1):entityAnimationPacket(xi.animationString.STATUS_DISAPPEAR)
        end)
    end
end

entity.onMobDespawn = function(mob)
    local mobId = mob:getID()

    -- Handle portal: Choose new portal.
    local portal = GetNPCByID(receptacleInfoTable[mobId][3]) -- Fetch mob's associated portal.

    if portal:getLocalVar('[Portal]Chosen') == 1 then
        portal:setLocalVar('[Portal]Chosen', 0) -- Reset.

        -- Choose new portal.
        local groupTable = portalGroupTable[receptacleInfoTable[mobId][1]]     -- Fetch the whole group entry the mob belongs to.
        local newPortal  = GetNPCByID(groupTable[math.random(1, #groupTable)]) -- Fetch NPC object from table, at random.

        newPortal:setLocalVar('[Portal]Chosen', 1) -- Mark new portal.
    end

    -- Handle decoration: Reset.
    local decoration = GetNPCByID(mobId - 1)

    decoration:updateToEntireZone(xi.status.CUTSCENE_ONLY, xi.anim.DESPAWN)
    decoration:entityAnimationPacket(xi.animationString.STATUS_VISIBLE)
end

return entity
