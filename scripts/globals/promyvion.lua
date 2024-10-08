xi = xi or {}
xi.promyvion = xi.promyvion or {}

local demID   = zones[xi.zone.PROMYVION_DEM]
local hollaID = zones[xi.zone.PROMYVION_HOLLA]
local meaID   = zones[xi.zone.PROMYVION_MEA]
local vahzlID = zones[xi.zone.PROMYVION_VAHZL]

-----------------------------------
-- Information Tables
-----------------------------------
local receptacleInfoTable =
{
    [xi.zone.PROMYVION_DEM] =
    {
        -- [Mob ID (Memory receptacle)] = { Portal Group, Number of Strays, Associated "Memory stream" NPC ID }
        [demID.mob.MEMORY_RECEPTACLE_TABLE[1] ] = { 1, 3, demID.npc.MEMORY_STREAM_OFFSET      }, -- Floor 1: Portal
        [demID.mob.MEMORY_RECEPTACLE_TABLE[2] ] = { 3, 5, demID.npc.MEMORY_STREAM_OFFSET + 4  }, -- Floor 2: Portal SE - Destination: North
        [demID.mob.MEMORY_RECEPTACLE_TABLE[3] ] = { 2, 5, demID.npc.MEMORY_STREAM_OFFSET + 5  }, -- Floor 2: Portal NE - Destination: South
        [demID.mob.MEMORY_RECEPTACLE_TABLE[4] ] = { 2, 5, demID.npc.MEMORY_STREAM_OFFSET + 6  }, -- Floor 2: Portal SW - Destination: South
        [demID.mob.MEMORY_RECEPTACLE_TABLE[5] ] = { 3, 5, demID.npc.MEMORY_STREAM_OFFSET + 7  }, -- Floor 2: Portal NW - Destination: North
        [demID.mob.MEMORY_RECEPTACLE_TABLE[6] ] = { 4, 7, demID.npc.MEMORY_STREAM_OFFSET + 1  }, -- Floor 3 (South): Portal NE
        [demID.mob.MEMORY_RECEPTACLE_TABLE[7] ] = { 4, 7, demID.npc.MEMORY_STREAM_OFFSET + 2  }, -- Floor 3 (South): Portal NW
        [demID.mob.MEMORY_RECEPTACLE_TABLE[8] ] = { 4, 7, demID.npc.MEMORY_STREAM_OFFSET + 3  }, -- Floor 3 (South): Portal SW
        [demID.mob.MEMORY_RECEPTACLE_TABLE[9] ] = { 5, 7, demID.npc.MEMORY_STREAM_OFFSET + 8  }, -- Floor 3 (North): Portal SW
        [demID.mob.MEMORY_RECEPTACLE_TABLE[10]] = { 5, 7, demID.npc.MEMORY_STREAM_OFFSET + 9  }, -- Floor 3 (North): Portal NE
        [demID.mob.MEMORY_RECEPTACLE_TABLE[11]] = { 5, 7, demID.npc.MEMORY_STREAM_OFFSET + 10 }, -- Floor 3 (North): Portal SE
    },

    [xi.zone.PROMYVION_HOLLA] =
    {
        -- [Mob ID (Memory receptacle)] = { Portal Group, Number of Strays, Associated "Memory stream" NPC ID }
        [hollaID.mob.MEMORY_RECEPTACLE_TABLE[1] ] = { 1, 3, hollaID.npc.MEMORY_STREAM_OFFSET + 7  }, -- Floor 1: Portal
        [hollaID.mob.MEMORY_RECEPTACLE_TABLE[2] ] = { 3, 5, hollaID.npc.MEMORY_STREAM_OFFSET + 3  }, -- Floor 2: Portal NW - Destination: East
        [hollaID.mob.MEMORY_RECEPTACLE_TABLE[3] ] = { 2, 5, hollaID.npc.MEMORY_STREAM_OFFSET + 4  }, -- Floor 2: Portal SW - Destination: West
        [hollaID.mob.MEMORY_RECEPTACLE_TABLE[4] ] = { 3, 5, hollaID.npc.MEMORY_STREAM_OFFSET + 5  }, -- Floor 2: Portal SE - Destination: East
        [hollaID.mob.MEMORY_RECEPTACLE_TABLE[5] ] = { 2, 5, hollaID.npc.MEMORY_STREAM_OFFSET + 6  }, -- Floor 2: Portal NE - Destination: West
        [hollaID.mob.MEMORY_RECEPTACLE_TABLE[6] ] = { 4, 7, hollaID.npc.MEMORY_STREAM_OFFSET      }, -- Floor 3 (West): Portal NE
        [hollaID.mob.MEMORY_RECEPTACLE_TABLE[7] ] = { 4, 7, hollaID.npc.MEMORY_STREAM_OFFSET + 1  }, -- Floor 3 (West): Portal NW
        [hollaID.mob.MEMORY_RECEPTACLE_TABLE[8] ] = { 4, 7, hollaID.npc.MEMORY_STREAM_OFFSET + 2  }, -- Floor 3 (West): Portal SW
        [hollaID.mob.MEMORY_RECEPTACLE_TABLE[9] ] = { 5, 7, hollaID.npc.MEMORY_STREAM_OFFSET + 8  }, -- Floor 3 (East): Portal NW
        [hollaID.mob.MEMORY_RECEPTACLE_TABLE[10]] = { 5, 7, hollaID.npc.MEMORY_STREAM_OFFSET + 9  }, -- Floor 3 (East): Portal NE
        [hollaID.mob.MEMORY_RECEPTACLE_TABLE[11]] = { 5, 7, hollaID.npc.MEMORY_STREAM_OFFSET + 10 }, -- Floor 3 (East): Portal SE
    },

    [xi.zone.PROMYVION_MEA] =
    {
        -- [Mob ID (Memory receptacle)] = { Portal Group, Number of Strays, Associated "Memory stream" NPC ID }
        [meaID.mob.MEMORY_RECEPTACLE_TABLE[1] ] = { 1, 3, meaID.npc.MEMORY_STREAM_OFFSET      }, -- Floor 1: Portal
        [meaID.mob.MEMORY_RECEPTACLE_TABLE[2] ] = { 3, 5, meaID.npc.MEMORY_STREAM_OFFSET + 3  }, -- Floor 2: Portal N  - Destination: East
        [meaID.mob.MEMORY_RECEPTACLE_TABLE[3] ] = { 2, 5, meaID.npc.MEMORY_STREAM_OFFSET + 7  }, -- Floor 2: Portal SW - Destination: West
        [meaID.mob.MEMORY_RECEPTACLE_TABLE[4] ] = { 2, 5, meaID.npc.MEMORY_STREAM_OFFSET + 8  }, -- Floor 2: Portal S  - Destination: West
        [meaID.mob.MEMORY_RECEPTACLE_TABLE[5] ] = { 3, 5, meaID.npc.MEMORY_STREAM_OFFSET + 9  }, -- Floor 2: Portal SE - Destination: East
        [meaID.mob.MEMORY_RECEPTACLE_TABLE[6] ] = { 4, 7, meaID.npc.MEMORY_STREAM_OFFSET + 1  }, -- Floor 3 (West): Portal SW
        [meaID.mob.MEMORY_RECEPTACLE_TABLE[7] ] = { 4, 7, meaID.npc.MEMORY_STREAM_OFFSET + 2  }, -- Floor 3 (West): Portal S
        [meaID.mob.MEMORY_RECEPTACLE_TABLE[8] ] = { 4, 7, meaID.npc.MEMORY_STREAM_OFFSET + 4  }, -- Floor 3 (West): Portal SE
        [meaID.mob.MEMORY_RECEPTACLE_TABLE[9] ] = { 5, 7, meaID.npc.MEMORY_STREAM_OFFSET + 5  }, -- Floor 3 (East): Portal NW
        [meaID.mob.MEMORY_RECEPTACLE_TABLE[10]] = { 5, 7, meaID.npc.MEMORY_STREAM_OFFSET + 6  }, -- Floor 3 (East): Portal NE
        [meaID.mob.MEMORY_RECEPTACLE_TABLE[11]] = { 5, 7, meaID.npc.MEMORY_STREAM_OFFSET + 10 }, -- Floor 3 (East): Portal SW
    },

    [xi.zone.PROMYVION_VAHZL] =
    {
        -- [Mob ID (Memory receptacle)] = { Portal Group, Number of Strays, Associated "Memory stream" NPC ID }
        [vahzlID.mob.MEMORY_RECEPTACLE_TABLE[1] ] = { 1, 3, vahzlID.npc.MEMORY_STREAM_OFFSET + 2  }, -- Floor 1: Portal S
        [vahzlID.mob.MEMORY_RECEPTACLE_TABLE[2] ] = { 1, 3, vahzlID.npc.MEMORY_STREAM_OFFSET + 3  }, -- Floor 1: Portal N
        [vahzlID.mob.MEMORY_RECEPTACLE_TABLE[3] ] = { 2, 5, vahzlID.npc.MEMORY_STREAM_OFFSET      }, -- Floor 2: Portal N
        [vahzlID.mob.MEMORY_RECEPTACLE_TABLE[4] ] = { 2, 5, vahzlID.npc.MEMORY_STREAM_OFFSET + 1  }, -- Floor 2: Portal S
        [vahzlID.mob.MEMORY_RECEPTACLE_TABLE[5] ] = { 3, 5, vahzlID.npc.MEMORY_STREAM_OFFSET + 5  }, -- Floor 3: Portal W
        [vahzlID.mob.MEMORY_RECEPTACLE_TABLE[6] ] = { 3, 5, vahzlID.npc.MEMORY_STREAM_OFFSET + 6  }, -- Floor 3: Portal N
        [vahzlID.mob.MEMORY_RECEPTACLE_TABLE[7] ] = { 3, 5, vahzlID.npc.MEMORY_STREAM_OFFSET + 7  }, -- Floor 3: Portal S
        [vahzlID.mob.MEMORY_RECEPTACLE_TABLE[8] ] = { 3, 5, vahzlID.npc.MEMORY_STREAM_OFFSET + 8  }, -- Floor 3: Portal E
        [vahzlID.mob.MEMORY_RECEPTACLE_TABLE[9] ] = { 4, 7, vahzlID.npc.MEMORY_STREAM_OFFSET + 4  }, -- Floor 4: Portal SW
        [vahzlID.mob.MEMORY_RECEPTACLE_TABLE[10]] = { 4, 7, vahzlID.npc.MEMORY_STREAM_OFFSET + 9  }, -- Floor 4: Portal SE
        [vahzlID.mob.MEMORY_RECEPTACLE_TABLE[11]] = { 4, 7, vahzlID.npc.MEMORY_STREAM_OFFSET + 10 }, -- Floor 4: Portal NE
    },
}

local portalGroupTable =
{
    [xi.zone.PROMYVION_DEM] =
    {
        [1] = { demID.npc.MEMORY_STREAM_OFFSET },                                                                              -- Floor 1
        [2] = { demID.npc.MEMORY_STREAM_OFFSET + 5, demID.npc.MEMORY_STREAM_OFFSET + 6 },                                      -- Floor 2 leading South
        [3] = { demID.npc.MEMORY_STREAM_OFFSET + 4, demID.npc.MEMORY_STREAM_OFFSET + 7 },                                      -- Floor 2 leading North
        [4] = { demID.npc.MEMORY_STREAM_OFFSET + 1, demID.npc.MEMORY_STREAM_OFFSET + 2, demID.npc.MEMORY_STREAM_OFFSET + 3  }, -- Floor 3 South
        [5] = { demID.npc.MEMORY_STREAM_OFFSET + 8, demID.npc.MEMORY_STREAM_OFFSET + 9, demID.npc.MEMORY_STREAM_OFFSET + 10 }, -- Floor 3 North
    },

    [xi.zone.PROMYVION_HOLLA] =
    {
        [1] = { hollaID.npc.MEMORY_STREAM_OFFSET + 7 },                                                                              -- Floor 1
        [2] = { hollaID.npc.MEMORY_STREAM_OFFSET + 4, hollaID.npc.MEMORY_STREAM_OFFSET + 6 },                                        -- Floor 2 leading West
        [3] = { hollaID.npc.MEMORY_STREAM_OFFSET + 3, hollaID.npc.MEMORY_STREAM_OFFSET + 5 },                                        -- Floor 2 leading East
        [4] = { hollaID.npc.MEMORY_STREAM_OFFSET,     hollaID.npc.MEMORY_STREAM_OFFSET + 1, hollaID.npc.MEMORY_STREAM_OFFSET + 2  }, -- Floor 3 West
        [5] = { hollaID.npc.MEMORY_STREAM_OFFSET + 8, hollaID.npc.MEMORY_STREAM_OFFSET + 9, hollaID.npc.MEMORY_STREAM_OFFSET + 10 }, -- Floor 3 East
    },

    [xi.zone.PROMYVION_MEA] =
    {
        [1] = { meaID.npc.MEMORY_STREAM_OFFSET },                                                                              -- Floor 1
        [2] = { meaID.npc.MEMORY_STREAM_OFFSET + 7, meaID.npc.MEMORY_STREAM_OFFSET + 8 },                                      -- Floor 2 leading West
        [3] = { meaID.npc.MEMORY_STREAM_OFFSET + 3, meaID.npc.MEMORY_STREAM_OFFSET + 9 },                                      -- Floor 2 leading East
        [4] = { meaID.npc.MEMORY_STREAM_OFFSET + 1, meaID.npc.MEMORY_STREAM_OFFSET + 2, meaID.npc.MEMORY_STREAM_OFFSET + 4  }, -- Floor 3 West
        [5] = { meaID.npc.MEMORY_STREAM_OFFSET + 5, meaID.npc.MEMORY_STREAM_OFFSET + 6, meaID.npc.MEMORY_STREAM_OFFSET + 10 }, -- Floor 3 East
    },

    [xi.zone.PROMYVION_VAHZL] =
    {
        [1] = { vahzlID.npc.MEMORY_STREAM_OFFSET + 2, vahzlID.npc.MEMORY_STREAM_OFFSET + 3 },                                                                             -- Floor 1
        [2] = { vahzlID.npc.MEMORY_STREAM_OFFSET,     vahzlID.npc.MEMORY_STREAM_OFFSET + 1 },                                                                             -- Floor 2
        [3] = { vahzlID.npc.MEMORY_STREAM_OFFSET + 5, vahzlID.npc.MEMORY_STREAM_OFFSET + 6, vahzlID.npc.MEMORY_STREAM_OFFSET + 7, vahzlID.npc.MEMORY_STREAM_OFFSET + 8 }, -- Floor 3
        [4] = { vahzlID.npc.MEMORY_STREAM_OFFSET + 4, vahzlID.npc.MEMORY_STREAM_OFFSET + 9, vahzlID.npc.MEMORY_STREAM_OFFSET + 10 },                                      -- Floor 4
    },
}

-----------------------------------
-- Local functions
-----------------------------------
-- Check available strays to pop.
local function checkForStrays(mob)
    local zoneId  = mob:getZone():getID()
    local mobId   = mob:getID()
    local strayId = 0

    -- Check for alive/dead strays.
    for i = mobId + 1, mobId + receptacleInfoTable[zoneId][mobId][2] do
        if not GetMobByID(i):isSpawned() then
            strayId = i
            break
        end
    end

    return strayId
end

-- Handle receptacle animation (up-pop-down) and stray spawn.
local function spawnStray(mob, strayId)
    -- Save mob to spawn.
    mob:setLocalVar('[Stray]Id', strayId)

    -- 1: Raise Receptacle.
    mob:setAnimationSub(5)

    -- 2: Pop Stray.
    mob:timer(875, function(mobArg)
        local stray = GetMobByID(mobArg:getLocalVar('[Stray]Id'))
        if stray then
            mobArg:setLocalVar('[Stray]Id', 0)
            stray:spawn()
        end
    end)

    -- 3: Lower Receptacle.
    mob:timer(1750, function(mobArg)
        mobArg:setAnimationSub(6)
    end)

    -- 4: Reset Receptacle (Makes it SLIGHTLY brighter).
    mob:timer(3000, function(mobArg)
        mobArg:setAnimationSub(4)
    end)
end

-----------------------------------
-- Zone global functions
-----------------------------------
xi.promyvion.setupInitialPortals = function(zone)
    local zoneId = zone:getID()

    for portalGroup = 1, #portalGroupTable[zoneId] do
        local groupTable = portalGroupTable[zoneId][portalGroup]  -- Fetch the whole group entry.
        local newPortal  = GetNPCByID(groupTable[math.random(1, #groupTable)]) -- Fetch an NPC object from table, at random.

        if newPortal then
            newPortal:setLocalVar('[Portal]Chosen', 1) -- Mark new portal.
        end
    end
end

xi.promyvion.handlePortal = function(player, npcId, eventId)
    if
        player:getAnimation() == xi.anim.NONE and
        GetNPCByID(npcId):getAnimation() == xi.anim.OPEN_DOOR
    then
        player:startOptionalCutscene(eventId)
    end
end

-----------------------------------
-- Stray global functions
-----------------------------------
xi.promyvion.strayOnMobSpawn = function(mob)
    -- Strays only use animation-sub 13 and 14.
    -- They, however, use diferent models and said model has a color set, each alligned to an element.
    -- TODO: Investigate elements depending on model and animation-sub.
    local animationSub = 13 + math.random(0, 1)

    mob:setAnimationSub(animationSub)
end

-----------------------------------
-- Memory Receptacle global functions
-----------------------------------
xi.promyvion.receptacleOnMobInitialize = function(mob)
    mob:setAutoAttackEnabled(false) -- Receptacles only use TP moves.
    mob:addMod(xi.mod.DEF, 55)
end

xi.promyvion.receptacleOnMobSpawn = function(mob)
    -- Handle Stray pop cooldown.
    mob:setLocalVar('[Stray]CooldownIdle', os.time() + 60 * math.random(2, 6))
    mob:setLocalVar('[Stray]CooldownFight', 0)

    -- Handle decoration: Fade-in.
    local decoration = GetNPCByID(mob:getID() - 1)
    if decoration then
        decoration:updateToEntireZone(xi.status.NORMAL, xi.anim.NONE)
    end
end

xi.promyvion.receptacleOnMobRoam = function(mob)
    -- Handle idle stray spawn.
    -- NOTE: Strays poped when receptacles are idle don't automatically link unless they are in a certain range.
    if os.time() >= mob:getLocalVar('[Stray]CooldownIdle') then
        local strayId = checkForStrays(mob) -- Returns stray Id OR 0

        -- Spawn stray.
        if strayId > 0 then
            spawnStray(mob, strayId)
            GetMobByID(strayId):setLocalVar('[Stray]RangedEnmity', 1)
        end

        -- Handle cooldown.
        mob:setLocalVar('[Stray]CooldownIdle', os.time() + 60 * math.random(2, 6))
    end
end

xi.promyvion.receptacleOnMobEngage = function(mob)
    -- Handle initial TP.
    mob:setTP(3000)
end

xi.promyvion.receptacleOnMobFight = function(mob, target)
    local zoneId        = mob:getZone():getID()
    local mobId         = mob:getID()
    local strayCooldown = mob:getLocalVar('[Stray]CooldownFight')

    -- Handle initial cooldown.
    if strayCooldown == 0 then
        strayCooldown = os.time() + 5 * math.random(2, 4)
        mob:setLocalVar('[Stray]CooldownFight', strayCooldown)
    end

    -- Handle engaged stray spawn.
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
    for strayId = mobId + 1, mobId + receptacleInfoTable[zoneId][mobId][2] do
        local stray = GetMobByID(strayId)

        if
            stray and
            stray:isSpawned() and
            not stray:isEngaged()
        then
            -- This stray was spawned when receptacle was idle. Needs distance check.
            if stray:getLocalVar('[Stray]RangedEnmity') == 1 then
                if stray:checkDistance(mob) < 10 then
                    stray:updateEnmity(target)
                end
            -- This stray was spawned when receptacle was engaged in combat.
            else
                stray:updateEnmity(target)
            end
        end
    end
end

xi.promyvion.receptacleOnMobWeaponSkill = function(mob)
    -- When left alone after hitting it, Memory Receptacle uses it's skill every 1-3 minutes (aprox).
    mob:setMod(xi.mod.REGAIN, 50 * math.random(1, 3))
end

xi.promyvion.receptacleOnMobDeath = function(mob, optParams)
    if
        optParams.isKiller or
        optParams.noKiller
    then
        mob:timer(2000, function(mobArg)
            local zoneId = mobArg:getZone():getID()
            local mobId  = mobArg:getID()

            -- Handle receptacle: Fast despawn.
            mobArg:setStatus(xi.status.CUTSCENE_ONLY)

            -- Handle portal: Open if it's the chosen portal.
            local portal = GetNPCByID(receptacleInfoTable[zoneId][mobId][3]) -- Fetch mob's associated portal.

            if portal and portal:getLocalVar('[Portal]Chosen') == 1 then
                portal:openDoor(180) -- Open portal for 3 minutes.
            end

            -- Handle decoration: Fade-out.
            GetNPCByID(mobId - 1):entityAnimationPacket(xi.animationString.STATUS_DISAPPEAR)
        end)
    end
end

xi.promyvion.receptacleOnMobDespawn = function(mob)
    local zoneId = mob:getZone():getID()
    local mobId  = mob:getID()

    -- Handle portal: Choose new portal.
    local portal = GetNPCByID(receptacleInfoTable[zoneId][mobId][3]) -- Fetch mob's associated portal.

    if portal and portal:getLocalVar('[Portal]Chosen') == 1 then
        portal:setLocalVar('[Portal]Chosen', 0) -- Reset.

        -- Choose new portal.
        local mobGroup   = receptacleInfoTable[zoneId][mobId][1]               -- Fetch group ID the mob belongs to.
        local groupTable = portalGroupTable[zoneId][mobGroup]                  -- Fetch the whole group table.
        local newPortal  = GetNPCByID(groupTable[math.random(1, #groupTable)]) -- Fetch NPC object from table, at random.

        if newPortal then
            newPortal:setLocalVar('[Portal]Chosen', 1) -- Mark new portal.
        end
    end

    -- Handle receptacle: Reset animationSub.
    if mob:getAnimationSub() ~= 4 then
        mob:setAnimationSub(4)
    end

    -- Handle decoration: Reset.
    local decoration = GetNPCByID(mobId - 1)
    if decoration then
        decoration:updateToEntireZone(xi.status.CUTSCENE_ONLY, xi.anim.DESPAWN)
        decoration:entityAnimationPacket(xi.animationString.STATUS_VISIBLE)
    end
end
