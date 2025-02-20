-----------------------------------
-- Promyvion global file
-----------------------------------
require('scripts/globals/combat/element_tables')
-----------------------------------
xi = xi or {}
xi.promyvion = xi.promyvion or {}
-----------------------------------
local demID   = zones[xi.zone.PROMYVION_DEM]
local hollaID = zones[xi.zone.PROMYVION_HOLLA]
local meaID   = zones[xi.zone.PROMYVION_MEA]
local vahzlID = zones[xi.zone.PROMYVION_VAHZL]

-----------------------------------
-- Information Tables
-----------------------------------
xi.promyvion.mobType =
{
    WANDERER =  1,
    STRAY    =  2,
    WEEPER   =  3,
    SEETHER  =  4,
    THINKER  =  5,
    GORGER   =  6,
    CRAVER   =  7,
    DRIFTER  =  8,
    LAMENTER =  9,
    RAGER    = 10,
}

-- Contains model IDs and subAnimations, in elemental order, per mob type.
local mobTable =
{
    [xi.promyvion.mobType.WANDERER] = { { 1108,  6 }, { 1110,  5 }, { 1110,  6 }, { 1107,  6 }, { 1107,  5 }, { 1106,  6 }, { 1108,  5 }, { 1106,  5 } },
    [xi.promyvion.mobType.STRAY   ] = { { 1108, 14 }, { 1110, 13 }, { 1110, 14 }, { 1107, 14 }, { 1107, 13 }, { 1106, 14 }, { 1108, 13 }, { 1106, 13 } },
    [xi.promyvion.mobType.WEEPER  ] = { { 1114,  6 }, { 1115,  5 }, { 1115,  6 }, { 1113,  6 }, { 1113,  5 }, { 1112,  6 }, { 1114,  5 }, { 1112,  5 } },
    [xi.promyvion.mobType.SEETHER ] = { { 1120,  6 }, { 1121,  5 }, { 1121,  6 }, { 1119,  6 }, { 1119,  5 }, { 1117,  6 }, { 1120,  5 }, { 1117,  5 } },
    [xi.promyvion.mobType.THINKER ] = { { 1126, 14 }, { 1127, 13 }, { 1127, 14 }, { 1124, 14 }, { 1124, 13 }, { 1123, 14 }, { 1126, 13 }, { 1123, 13 } },
    [xi.promyvion.mobType.GORGER  ] = { { 1131, 14 }, { 1132, 13 }, { 1132, 14 }, { 1130, 14 }, { 1130, 13 }, { 1129, 14 }, { 1131, 13 }, { 1129, 13 } },
    [xi.promyvion.mobType.CRAVER  ] = { { 1137, 14 }, { 1138, 13 }, { 1138, 14 }, { 1135, 14 }, { 1135, 13 }, { 1134, 14 }, { 1137, 13 }, { 1134, 13 } },
    [xi.promyvion.mobType.DRIFTER ] = { { 3616,  6 }, { 3617,  5 }, { 3617,  6 }, { 3615,  6 }, { 3615,  5 }, { 3614,  6 }, { 3616,  5 }, { 3614,  5 } },
    [xi.promyvion.mobType.LAMENTER] = { { 3621,  6 }, { 3622,  5 }, { 3622,  6 }, { 3620,  6 }, { 3620,  5 }, { 3619,  6 }, { 3621,  5 }, { 3619,  5 } },
    [xi.promyvion.mobType.RAGER   ] = { { 3626,  6 }, { 3627,  5 }, { 3627,  6 }, { 3625,  6 }, { 3625,  5 }, { 3624,  6 }, { 3626,  5 }, { 3624,  5 } },
}

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
-- Mob global functions (Element setup)
-----------------------------------
xi.promyvion.emptyOnMobSpawn = function(mob, mobType)
    local element    = math.random(xi.element.FIRE, xi.element.DARK)
    local opposite   = xi.combat.element.getOppositeElement(element)
    local complement = xi.element.NONE

    if element == xi.element.WATER then
        complement = xi.element.FIRE
    elseif element < xi.element.WATER then
        complement = element + 1
    end

    -- Setup resistances.
    for i = xi.element.FIRE, xi.element.DARK do
        local resRankModId = xi.combat.element.getElementalResistanceRankModifier(i)
        local value        = 0

        if
            i == element or
            i == complement
        then
            value = 11
        elseif i == opposite then
            value = -3
        end

        mob:setMod(resRankModId, value)
    end

    -- Set model and animationSub
    mob:setModelId(mobTable[mobType][element][1])
    mob:setAnimationSub(mobTable[mobType][element][2])
end

-----------------------------------
-- Memory Receptacle global functions
-----------------------------------
xi.promyvion.receptacleOnMobInitialize = function(mob)
    mob:setAutoAttackEnabled(false) -- Receptacles only use TP moves.
    mob:addMod(xi.mod.DEF, 55)
    -- mob:setMod(xi.mod.DESPAWN_TIME_REDUCTION, 10) -- TODO: Properly time in retail and then adjust timers for portal opening, decorations, etc...
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
