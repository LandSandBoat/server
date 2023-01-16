-----------------------------------
-- Garrison
-----------------------------------
require('scripts/globals/mobs')
require('scripts/globals/common')
require('scripts/globals/items')
require('scripts/globals/npc_util')
require('scripts/globals/status')
require('scripts/globals/utils')
require('scripts/globals/zone')
require('scripts/globals/pathfind')
-----------------------------------
xi = xi or {}
xi.garrison = xi.garrison or {}
xi.garrison.lookup = xi.garrison.lookup or {}

xi.garrison.state =
{
    INACTIVE   = 0,
    SPAWN_NPCS = 1,
    WAITING    = 2,
    SPAWN_MOBS = 3,
    ACTIVE     = 4,
    ENDED      = 5,
}

-----------------------------------
-- Data
-----------------------------------

-- Loot for each Garrison, by level
xi.garrison.loot =
{
    [20] =
    {
        { itemId = xi.items.DRAGON_CHRONICLES, dropRate = 1000 },
        { itemId = xi.items.GARRISON_TUNICA,   dropRate = 350  },
        { itemId = xi.items.GARRISON_BOOTS,    dropRate = 350  },
        { itemId = xi.items.GARRISON_HOSE,     dropRate = 350  },
        { itemId = xi.items.GARRISON_GLOVES,   dropRate = 350  },
        { itemId = xi.items.GARRISON_SALLET,   dropRate = 350  },
    },
    [30] =
    {
        { itemId = xi.items.DRAGON_CHRONICLES, dropRate = 1000 },
        { itemId = xi.items.MILITARY_GUN,      dropRate = 350  },
        { itemId = xi.items.MILITARY_POLE,     dropRate = 350  },
        { itemId = xi.items.MILITARY_HARP,     dropRate = 350  },
        { itemId = xi.items.MILITARY_PICK,     dropRate = 350  },
        { itemId = xi.items.MILITARY_SPEAR,    dropRate = 350  },
        { itemId = xi.items.MILITARY_AXE,      dropRate = 350  },
    },
    [40] =
    {
        { itemId = xi.items.DRAGON_CHRONICLES, dropRate = 1000 },
        { itemId = xi.items.VARIABLE_MANTLE,   dropRate = 350  },
        { itemId = xi.items.VARIABLE_CAPE,     dropRate = 350  },
        { itemId = xi.items.PROTEAN_RING,      dropRate = 350  },
        { itemId = xi.items.VARIABLE_RING,     dropRate = 350  },
        { itemId = xi.items.MECURIAL_EARRING,  dropRate = 350  },
    },
    [50] =
    {
        { itemId = xi.items.DRAGON_CHRONICLES, dropRate = 1000 },
        { itemId = xi.items.UNDEAD_EARRING,    dropRate = 350  },
        { itemId = xi.items.ARCANA_EARRING,    dropRate = 350  },
        { itemId = xi.items.VERMIN_EARRING,    dropRate = 350  },
        { itemId = xi.items.BIRD_EARRING,      dropRate = 350  },
        { itemId = xi.items.AMORPH_EARRING,    dropRate = 350  },
        { itemId = xi.items.LIZARD_EARRING,    dropRate = 350  },
        { itemId = xi.items.AQUAN_EARRING,     dropRate = 350  },
        { itemId = xi.items.PLANTOID_EARRING,  dropRate = 350  },
        { itemId = xi.items.BEAST_EARRING,     dropRate = 350  },
        { itemId = xi.items.DEMON_EARRING,     dropRate = 350  },
        { itemId = xi.items.DRAGON_EARRING,    dropRate = 350  },
        { itemId = xi.items.REFRESH_EARRING,   dropRate = 350  },
        { itemId = xi.items.ACCURATE_EARRING,  dropRate = 350  },
    },
    [99] =
    {
        { itemId = xi.items.MIRATETES_MEMOIRS, dropRate = 1000 },
        { itemId = xi.items.MIGHTY_BOW,        dropRate = 350  },
        { itemId = xi.items.MIGHTY_CUDGEL,     dropRate = 350  },
        { itemId = xi.items.MIGHTY_POLE,       dropRate = 350  },
        { itemId = xi.items.MIGHTY_TALWAR,     dropRate = 350  },
        { itemId = xi.items.RAI_KUNIMITSU,     dropRate = 350  },
        { itemId = xi.items.NUKEMARU,          dropRate = 350  },
        { itemId = xi.items.MIGHTY_PICK,       dropRate = 350  },
        { itemId = xi.items.MIGHTY_KNIFE,      dropRate = 350  },
        { itemId = xi.items.MIGHTY_ZAGHNAL,    dropRate = 350  },
        { itemId = xi.items.MIGHTY_LANCE,      dropRate = 350  },
        { itemId = xi.items.MIGHTY_AXE,        dropRate = 350  },
        { itemId = xi.items.MIGHTY_PATAS,      dropRate = 350  },
        { itemId = xi.items.MIGHTY_SWORD,      dropRate = 350  },
    },
}

-- Zone Data, used for the spawning of enemies and allies
-- allies: { Sandoria name, Bastok name, Windurst name }
xi.garrison.data =
{
    [xi.zone.WEST_RONFAURE] =
    {
        itemReq = xi.items.RED_CRYPTEX,
        textRegion = 0,
        levelCap = 20,
        mobBoss = "Orcish_Fighterchief",
        allies = { "Trader", "Patrician", "Scholar" },
        xPos = -436,
        yPos = -20,
        zPos = -217,
        xChange = 0,
        zChange = 2,
        xSecondLine = 2,
        zSecondLine = 0,
        xThirdLine = 4,
        zThirdLine = 0,
        rot = 0,
    },
    [xi.zone.NORTH_GUSTABERG] =
    {
        itemReq = xi.items.DARKSTEEL_ENGRAVING,
        textRegion = 1,
        levelCap = 20,
        mobBoss = "Lead_Quadav",
        allies = { "Trader", "Patrician", "Scholar" },
        xPos = -580, -- TODO: Needs adjusting
        yPos = 40,
        zPos = 69,
        xChange = 1,
        zChange = 2,
        xSecondLine = 2,
        zSecondLine = 0,
        xThirdLine = 4,
        zThirdLine = 0,
        rot = 106,
    },
    [xi.zone.WEST_SARUTABARUTA] =
    {
        itemReq = xi.items.SEVEN_KNOT_QUIPU,
        textRegion = 2,
        levelCap = 20,
        mobBoss = "Yagudo_Condottiere",
        allies = { "Trader", "Patrician", "Scholar" },
        xPos = -20, -- TODO: Needs adjusting
        yPos = -12,
        zPos = 325,
        xChange = 0,
        zChange = 2,
        xSecondLine = 2,
        zSecondLine = 0,
        xThirdLine = 4,
        zThirdLine = 0,
        rot = 115,
    },
    [xi.zone.VALKURM_DUNES] =
    {
        itemReq = xi.items.GALKA_FANG_SACK,
        textRegion = 3,
        levelCap = 30,
        mobBoss = "Goblin_Swindler",
        allies = { "Trader", "Patrician", "Scholar" },
        xPos = 141, -- TODO: Needs adjusting
        yPos = -8,
        zPos = 87,
        xChange = -2,
        zChange = -2,
        xSecondLine = 2,
        zSecondLine = 0,
        xThirdLine = 4,
        zThirdLine = 0,
        rot = 32,
    },
    [xi.zone.JUGNER_FOREST] =
    {
        itemReq = xi.items.JADE_CRYPTEX,
        textRegion = 4,
        levelCap = 30,
        mobBoss = "Orcish_Colonel",
        allies = { "Trader", "Patrician", "Scholar" },
        xPos = 54, -- TODO: Needs adjusting
        yPos = 1,
        zPos = -1,
        xChange = -2,
        zChange = 0,
        xSecondLine = 0,
        zSecondLine = 2,
        xThirdLine = 0,
        zThirdLine = 4,
        rot = 210,
    },
    [xi.zone.PASHHOW_MARSHLANDS] =
    {
        itemReq = xi.items.SILVER_ENGRAVING,
        textRegion = 5,
        levelCap = 30,
        mobBoss = "Cobalt_Quadav",
        allies = { "Trader", "Patrician", "Scholar" },
        xPos = 458, -- TODO: Needs adjusting
        yPos = 24,
        zPos = 421,
        xChange = -2,
        zChange = -2,
        xSecondLine = 2,
        zSecondLine = 0,
        xThirdLine = 4,
        zThirdLine = 0,
        rot = 130,
    },
    [xi.zone.BUBURIMU_PENINSULA] =
    {
        itemReq = xi.items.MITHRA_FANG_SACK,
        textRegion = 6,
        levelCap = 30,
        mobBoss = "Goblin_Guide",
        allies = { "Trader", "Patrician", "Scholar" },
        xPos = -485, -- TODO: Needs adjusting
        yPos = -29,
        zPos = 58,
        xChange = -2,
        zChange = 0,
        xSecondLine = 0,
        zSecondLine = -2,
        xThirdLine = 0,
        zThirdLine = -4,
        rot = 0,
    },
    [xi.zone.MERIPHATAUD_MOUNTAINS] =
    {
        itemReq = xi.items.THIRTEEN_KNOT_QUIPU,
        textRegion = 7,
        levelCap = 30,
        mobBoss = "Yagudo_Missionary",
        allies = { "Trader", "Patrician", "Scholar" },
        xPos = -299, -- TODO: Needs adjusting
        yPos = 17,
        zPos = 411,
        xChange = 2,
        zChange = -2,
        xSecondLine = 0,
        zSecondLine = 2,
        xThirdLine = 0,
        zThirdLine = 4,
        rot = 30,
    },
    [xi.zone.QUFIM_ISLAND] =
    {
        itemReq = xi.items.RAM_LEATHER_MISSIVE,
        textRegion = 10,
        levelCap = 30,
        mobBoss = "Hunting_Chief",
        allies = { "Trader", "Patrician", "Scholar" },
        xPos = -247, -- TODO: Needs adjusting
        yPos = -19,
        zPos = 310,
        xChange = -2,
        zChange = 0,
        xSecondLine = 0,
        zSecondLine = -2,
        xThirdLine = 0,
        zThirdLine = -4,
        rot = 0,
    },
    [xi.zone.BEAUCEDINE_GLACIER] =
    {
        itemReq = xi.items.TIGER_LEATHER_MISSIVE,
        textRegion = 8,
        levelCap = 40,
        mobBoss = "Gigas_Overseer",
        allies = { "Trader", "Patrician", "Scholar" },
        xPos = -25, -- TODO: Needs adjusting
        yPos = -60,
        zPos = -110,
        xChange = -2,
        zChange = -1,
        xSecondLine = 0,
        zSecondLine = -1,
        xThirdLine = 0,
        zThirdLine = -2,
        rot = 220,
    },
    [xi.zone.THE_SANCTUARY_OF_ZITAH] =
    {
        itemReq = xi.items.HOUND_FANG_SACK,
        textRegion = 11,
        levelCap = 40,
        mobBoss = "Goblin_Doyen",
        allies = { "Trader", "Patrician", "Scholar" },
        xPos = -43,
        yPos = 1,
        zPos = -140,
        xChange = -2,
        zChange = 0,
        xSecondLine = 0,
        zSecondLine = 2,
        xThirdLine = 0,
        zThirdLine = 4,
        rot = 180,
    },
    [xi.zone.YUHTUNGA_JUNGLE] =
    {
        itemReq = xi.items.SHEEP_LEATHER_MISSIVE,
        textRegion = 14,
        levelCap = 40,
        mobBoss = "Sahagin_Patriarch",
        allies = { "Trader", "Patrician", "Scholar" },
        xPos = -248,
        yPos = 1,
        zPos = -392,
        xChange = -2,
        zChange = 0,
        xSecondLine = 0,
        zSecondLine = 2,
        xThirdLine = 0,
        zThirdLine = 4,
        rot = 180,
    },
    [xi.zone.XARCABARD] =
    {
        itemReq = xi.items.BEHEMOTH_LEATHER_MISSIVE,
        textRegion = 9,
        levelCap = 50,
        mobBoss = "Demon_Aristocrat",
        allies = { "Trader", "Patrician", "Scholar" },
        xPos = 216, -- TODO: Needs adjusting
        yPos = -22,
        zPos = -208,
        xChange = 2,
        zChange = 0,
        xSecondLine = 0,
        zSecondLine = 2,
        xThirdLine = 0,
        zThirdLine = 4,
        rot = 90,
    },
    [xi.zone.EASTERN_ALTEPA_DESERT] =
    {
        itemReq = xi.items.DHALMEL_LEATHER_MISSIVE,
        textRegion = 12,
        levelCap = 50,
        mobBoss = "Centurio_XIII-V",
        allies = { "Trader", "Patrician", "Scholar" },
        xPos = -245,
        yPos = -9,
        zPos = -249,
        xChange = 0,
        zChange = 2,
        xSecondLine = 2,
        zSecondLine = 0,
        xThirdLine = 4,
        zThirdLine = 0,
        rot = 0,
    },
    [xi.zone.YHOATOR_JUNGLE] =
    {
        itemReq = xi.items.COEURL_LEATHER_MISSIVE,
        textRegion = 15,
        levelCap = 50,
        mobBoss = "Tonberry_Decimator",
        allies = { "Trader", "Patrician", "Scholar" },
        xPos = 214,
        yPos = 1,
        zPos = -80,
        xChange = 1,
        zChange = 2,
        xSecondLine = 2,
        zSecondLine = -1,
        xThirdLine = 4,
        zThirdLine = -2,
        rot = 0,
    },
    [xi.zone.CAPE_TERIGGAN] =
    {
        itemReq = xi.items.BUNNY_FANG_SACK,
        textRegion = 13,
        levelCap = 99,
        mobBoss = "Goblin_Boss",
        allies = { "Trader", "Patrician", "Scholar" },
        xPos = -174,
        yPos = 8,
        zPos = -61,
        xChange = 0,
        zChange = 2,
        xSecondLine = 2,
        zSecondLine = 0,
        xThirdLine = 4,
        zThirdLine = 0,
        rot = 0,
    },
}

local allyLooks =
{
    ["Patrician"] = -- Gustaberg Sandoria
    {
        "0x01000C030010262000303A403A5008611B700000",
    },
    ["Trader"] = -- Dunes Sandoria
    {
        "0x010009040010762076303A400650736000700000",
        "0x010006030010762076303A400650736000700000",
    },
    ["Recruit"] = -- Gustaberg Bastok
    {
        "0x01000701361005206630664066500C6129700000",
    },
    ["Candidate"] = -- West Saru Windurst
    {
        "0x010007070110322032300E401550AC6000700000",
        "0x01000E0718101820183015401850B76024700000",
    },
    ["Scholar"] = -- Dunes Windurst
    {
        "0x01000B051C1073201430144014506C6000700000",
        "0x0100010777106920693066406950B46000700000",
        "0x010000067D107820033066406850E96000700000",
    },
}

-----------------------------------
-- Helpers
-----------------------------------

-- Add level restriction effect
-- If a party member is KO'd during the Garrison, they're out.
-- Any players that are KO'd lose their level restriction and will be unable to help afterward.
-- Giving this the CONFRONTATION flag hooks into the target validation systme and stops outsiders
-- participating, for mobs, allies, and players.
local addLevelCap = function(entity, cap)
    entity:addStatusEffectEx(
        xi.effect.LEVEL_RESTRICTION,
        xi.effect.LEVEL_RESTRICTION,
        cap,
        0,
        0,
        0,
        0,
        0,
        xi.effectFlag.DEATH + xi.effectFlag.ON_ZONE + xi.effectFlag.CONFRONTATION)
end

local aggroGroups = function(group1, group2)
    for _, id1 in pairs(group1) do
        for _, id2 in pairs(group2) do
            GetMobByID(id1):addEnmity(GetMobByID(id2), math.random(1, 5), math.random(1, 5))
            GetMobByID(id2):addEnmity(GetMobByID(id1), math.random(1, 5), math.random(1, 5))
        end
    end
end

local spawnNPC = function(zone, x, y, z, rot, name, look)
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

    return mob
end

local spawnNPCs = function(npc)
    local zone     = npc:getZone()
    local zoneData = xi.garrison.data[zone:getID()]
    local xPos     = zoneData.xPos
    local yPos     = zoneData.yPos
    local zPos     = zoneData.zPos
    local rot      = zoneData.rot
    local allyName = zoneData.allies[GetRegionOwner(zone:getRegionID()) + 1]

    for i = 0, math.random(2, 6) do
        local mob = spawnNPC(zone, xPos, yPos, zPos, rot, allyName, utils.randomEntry(allyLooks[allyName]))
        mob:setMobLevel(zoneData.levelCap - math.floor(zoneData.levelCap / 5))
        addLevelCap(mob, zoneData.levelCap)
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

-----------------------------------
-- Main Functions
-----------------------------------

xi.garrison.tick = nil -- Prototype
xi.garrison.tick = function(npc)
    local zone     = npc:getZone()
    local zoneData = xi.garrison.data[zone:getID()]

    switch (zoneData.state) : caseof
    {
        [xi.garrison.state.INACTIVE] = function()
            -- print("State: Inactive")
            local time = os.time()
            if time > zoneData.stateTime + 2 then
                zoneData.stateTime = time
                zoneData.state = xi.garrison.state.SPAWN_NPCS
            end
        end,

        [xi.garrison.state.SPAWN_NPCS] = function()
            -- print("State: Spawn NPCs")
            spawnNPCs(npc)

            zoneData.stateTime = os.time()
            zoneData.state = xi.garrison.state.WAITING
        end,

        [xi.garrison.state.WAITING] = function()
            -- print("State: Waiting")

            local time = os.time()
            if time > zoneData.stateTime + 2 then
                zoneData.stateTime = time
                zoneData.state = xi.garrison.state.SPAWN_MOBS
            end
        end,

        [xi.garrison.state.SPAWN_MOBS] = function()
            -- print("State: Spawn Mobs")
            -- TODO: There is a delay before the mobs spawn
            -- There are always 8 mobs + 1 boss for Garrison, so we will look up the
            -- boss's ID using their name and then subtract 8 to get the starting mob ID.
            local firstMobID = zone:queryEntitiesByName(zoneData.mobBoss)[1]:getID() - 8
            for id = firstMobID, firstMobID do
                local mob = SpawnMob(id)
                addLevelCap(mob, zoneData.levelCap)
                mob:setRoamFlags(xi.roamFlag.SCRIPTED)
                table.insert(zoneData.mobs, mob:getID())
            end

            -- Once the mobs are spawned, make them aggro whatever NPCs are already up
            aggroGroups(zoneData.mobs, zoneData.npcs)

            zoneData.state = xi.garrison.state.ACTIVE
        end,

        [xi.garrison.state.ACTIVE] = function()
            -- print("State: Active")
            local allNPCsDead = true
            for _, entityId in pairs(zoneData.npcs) do
                -- TODO: Don't use GetMobByID here
                -- Keep a table with { bool: alive/dead, mob object } entries
                local entity = GetMobByID(entityId)
                if entity and entity:isAlive() then
                    allNPCsDead = false
                end
            end

            local allPlayersDead = true
            for _, entityId in pairs(zoneData.players) do
                local entity = GetPlayerByID(entityId)
                -- TODO: Only check valid players
                if entity and entity:isAlive() then
                    allPlayersDead = false
                end
            end

            local allMobsDead = true
            for _, entityId in pairs(zoneData.mobs) do
                -- TODO: Don't use GetMobByID here
                -- Keep a table with { bool: alive/dead, mob object } entries
                local entity = GetMobByID(entityId)
                if entity and entity:isAlive() then
                    allMobsDead = false
                end
            end

            if
                allNPCsDead or
                allPlayersDead or
                allMobsDead
            then
                -- TODO: Only check valid players
                for _, entityId in pairs(zoneData.players) do
                    local entity = GetPlayerByID(entityId)
                    entity:delStatusEffect(xi.effect.LEVEL_RESTRICTION)
                end

                for _, entityId in pairs(zoneData.npcs) do
                    DespawnMob(entityId)
                end

                for _, entityId in pairs(zoneData.mobs) do
                    DespawnMob(entityId)
                end

                zoneData.state = xi.garrison.state.ENDED
            end
        end,

        [xi.garrison.state.ENDED] = function()
            -- print("State: Ended")
            zoneData.continue = false
        end,
    }

    -- TODO: Check to see if current wave is complete

    -- TODO: Check to if all waves are completed

    if zoneData.continue then
        npc:timer(2000, function(npcArg)
            xi.garrison.tick(npcArg)
        end)
    end
end

xi.garrison.start = function(player, npc)
    -- TODO: Write lockout information to player

    local zone         = player:getZone()
    local zoneData     = xi.garrison.data[zone:getID()]
    zoneData.players   = {}
    zoneData.npcs      = {}
    zoneData.mobs      = {}
    zoneData.state     = xi.garrison.state.INACTIVE
    zoneData.continue  = true
    zoneData.stateTime = os.time()

    for _, member in pairs(player:getAlliance()) do
        addLevelCap(member, zoneData.levelCap)
        table.insert(zoneData.players, member:getID())
    end

    -- The starting NPC is the 'anchor' for all timers and logic for this Garrison. Even though they
    xi.garrison.tick(npc)
end

xi.garrison.onTrade = function(player, npc, trade, guardNation)
    if not xi.settings.main.ENABLE_GARRISON then
        return false
    end

    -- TODO: If there is currently an active Garrison, bail out now

    local zoneData = xi.garrison.data[player:getZoneID()]
    if npcUtil.tradeHasExactly(trade, zoneData.itemReq) then
        -- TODO: Check lockout

        -- Start CS
        player:startEvent(32753 + player:getNation())
        player:setLocalVar("GARRISON_NPC", npc:getID())
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
        return false
    end

    if csid == 32753 + player:getNation() and option == 0 then
        player:confirmTrade()
        local npc = GetNPCByID(player:getLocalVar("GARRISON_NPC"))
        xi.garrison.start(player, npc)
        return true
    end

    return false
end
