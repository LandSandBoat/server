-----------------------------------
-- Area: Temenos
-- Name: Temenos Eastern Tower
-- !addkeyitem white_card
-- !addkeyitem cosmo_cleanse
-- !pos 580.000 -2.375 104.000 37
-----------------------------------
local ID = require("scripts/zones/Temenos/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/limbus")
require("scripts/globals/items")
require("scripts/globals/keyitems")
-----------------------------------

local content = Limbus:new({
    zoneId           = xi.zone.TEMENOS,
    battlefieldId    = xi.battlefield.id.TEMENOS_EASTERN_TOWER,
    maxPlayers       = 18,
    timeLimit        = utils.minutes(30),
    index            = 1,
    area             = 2,
    entryNpc         = 'Matter_Diffusion_Module',
    requiredKeyItems = { xi.ki.COSMO_CLEANSE, xi.ki.WHITE_CARD, message = ID.text.YOU_INSERT_THE_CARD_POLISHED },
    name             = "TEMENOS_EASTERN_TOWER",
    timeExtension    = 15,
})

local despawnFloorMobs = function(crateOffset, count)
    local mobOffset = crateOffset + count
    for i = 1, count do
        local mob = GetMobByID(mobOffset + i - 1)
        if mob:isAlive() then
            -- Pseudo death as the mob shouldn't drop items, give xp or even broadcast a message that it has died
            mob:setAnimation(xi.animation.DEATH)
            mob:stun(16000) -- This will stop it from doing anything
            mob:timer(15000, function(mobArg)
                mob:setStatus(xi.status.DISAPPEAR)
            end)
        end
    end
end

local despawnFloorCrates = function(crateOffset, count)
    for i = 1, count do
        local crate = GetEntityByID(crateOffset + i - 1)
        if crate:getLocalVar("opened") == 0 then
            crate:setLocalVar("opened", 1)
            npcUtil.disappearCrate(crate)
        end
    end
end

local lockFloorCrates = function(crateOffset, count)
    for i = 1, count do
        local crate = GetEntityByID(crateOffset + i - 1)
        if crate:getLocalVar("opened") == 0 then
            crate:setLocalVar("opened", 1)
            crate:addListener("ON_TRIGGER", "TRIGGER_LOCKED_CRATE", function(player, npc)
                player:messageSpecial(ID.text.CANNOT_OPEN_CHEST)
            end)
        end
    end
end

local unlockFloorCrates = function(floor, mobCount, battlefield, mob, count)
    local crateOffset = ID.TEMENOS_EASTERN_TOWER.npc.CRATE_OFFSETS[floor]
    local unlockedCrate = false
    for i = 1, mobCount do
        local crate = GetEntityByID(crateOffset + i - 1)
        crate:removeListener("TRIGGER_LOCKED_CRATE")
        if crate:getStatus() == xi.status.NORMAL then
            crate:setLocalVar("opened", 0)
            unlockedCrate = true
        end
    end

    if not unlockedCrate then
        content:openDoor(battlefield, floor)
    end
end

local setupItemCrate = function(crateID, floor, crateOffset, count)
    local crate = GetEntityByID(crateID)
    xi.limbus.hideCrate(crate)
    crate:setModelId(961)
    crate:removeListener("TRIGGER_LOCKED_CRATE")
    crate:addListener("ON_TRIGGER", "TRIGGER_CRATE", function(player, npc)
        npcUtil.openCrate(npc, function()
            despawnFloorMobs(crateOffset, count)
            despawnFloorCrates(crateOffset, count)
            content:handleLootRolls(player:getBattlefield(), content.loot[floor], npc)

            -- Opening the last floor crate leads to victory
            if floor == 7 then
                local battlefield = player:getBattlefield()
                battlefield:setLocalVar("cutsceneTimer", content.delayToExit)
                battlefield:setStatus(xi.battlefield.status.WON)
            else
                content:openDoor(player:getBattlefield(), floor)
            end
        end)
    end)
end

local setupMysticCrate = function(crateID, floor, crateOffset, count)
    local crate = GetEntityByID(crateID)
    xi.limbus.hideCrate(crate)
    crate:setModelId(961)
    crate:removeListener("TRIGGER_LOCKED_CRATE")
    crate:addListener("ON_TRIGGER", "TRIGGER_CRATE", function(player, npc)
        npcUtil.openCrate(npc, function()
            despawnFloorMobs(crateOffset, count)
            lockFloorCrates(crateOffset, count)

            -- Skip over the crates and mobs which are always equal in size
            local mysticID = crateOffset + count * 2
            -- Spawn the Mystic Avatar
            local mystic = GetMobByID(mysticID)
            mystic:setSpawn(npc:getXPos(), npc:getYPos(), npc:getZPos(), npc:getRotPos())
            mystic:spawn()
            mystic:updateEnmity(player)
        end)
    end)
end

local setupTimeCrate = function(crateID, floor, crateOffset, count)
    local crate = GetEntityByID(crateID)
    xi.limbus.hideCrate(crate)
    crate:setModelId(962)
    crate:removeListener("TRIGGER_LOCKED_CRATE")
    crate:addListener("ON_TRIGGER", "TRIGGER_CRATE", function(player, npc)
        npcUtil.openCrate(crate, function()
            despawnFloorMobs(crateOffset, count)
            despawnFloorCrates(crateOffset, count)
            content:openDoor(player:getBattlefield(), floor)
            content:extendTimeLimit(zones[content.zoneId], player:getBattlefield())
        end)
    end)
end

local setupRecoverCrate = function(crateID, floor, crateOffset, count)
    local crate = GetEntityByID(crateID)
    xi.limbus.hideCrate(crate)
    crate:setModelId(960)
    crate:removeListener("TRIGGER_LOCKED_CRATE")
    crate:addListener("ON_TRIGGER", "TRIGGER_CRATE", function(player, npc)
        npcUtil.openCrate(crate, function()
            despawnFloorMobs(crateOffset, count)
            despawnFloorCrates(crateOffset, count)
            content:openDoor(player:getBattlefield(), floor)
            -- Use wz_recover_all to heal players
            crate:useMobAbility(1531, player)
        end)
    end)
end

function content:onBattlefieldInitialise(battlefield)
    Limbus.onBattlefieldInitialise(self, battlefield)

    local crateSetupFuncs =
    {
        setupItemCrate,
        setupMysticCrate,
        setupTimeCrate,
        setupRecoverCrate,
    }

    -- Crates are always spawned with sequential IDs
    -- Randomize crate type order by shuffling setup functions
    for floor, crateOffset in ipairs(ID.TEMENOS_EASTERN_TOWER.npc.CRATE_OFFSETS) do
        local count = (floor == 7 and 2) or 4
        local setupFuncs = utils.shuffle(utils.slice(crateSetupFuncs, 1, count))
        for i = 1, count do
            setupFuncs[i](crateOffset + i - 1, floor, crateOffset, count)
        end
    end
end

content.handleMobDeath = function(floor, battlefield, mob, count)
    -- Crate type randomization happens in onBattlefieldRegister
    local crateID = ID.TEMENOS_EASTERN_TOWER.npc.CRATE_OFFSETS[floor] + count - 1
    xi.limbus.spawnFrom(mob, crateID)
end

content.paths =
{
    [ID.TEMENOS_EASTERN_TOWER.mob.ICE_ELEMENTAL] =
    {
        { x = 200.000, y = -161.000, z = 190.000, wait = 5000 },
        { x = 200.000, y = -161.000, z = 198.000, wait = 5000 },
    },

    [ID.TEMENOS_EASTERN_TOWER.mob.ICE_ELEMENTAL + 1] =
    {
        { x = 190.000, y = -161.000, z = 200.000, wait = 5000 },
        { x = 198.000, y = -161.000, z = 200.000, wait = 5000 },
    },

    [ID.TEMENOS_EASTERN_TOWER.mob.ICE_ELEMENTAL + 2] =
    {
        { x = 200.000, y = -161.000, z = 210.000, wait = 5000 },
        { x = 200.000, y = -161.000, z = 202.000, wait = 5000 },
    },

    [ID.TEMENOS_EASTERN_TOWER.mob.ICE_ELEMENTAL + 3] =
    {
        { x = 210.000, y = -161.000, z = 200.000, wait = 5000 },
        { x = 202.000, y = -161.000, z = 200.000, wait = 5000 },
    },

    [ID.TEMENOS_EASTERN_TOWER.mob.AIR_ELEMENTAL + 1] =
    {
        { x = 20.000, y = 6.000, z = 140.000 },
        { x = 20.000, y = 6.000, z = 148.000 },
    },

    [ID.TEMENOS_EASTERN_TOWER.mob.AIR_ELEMENTAL + 3] =
    {
        { x = 60.000, y = 6.000, z = 140.000 },
        { x = 60.000, y = 6.000, z = 148.000 },
    },

    [ID.TEMENOS_EASTERN_TOWER.mob.THUNDER_ELEMENTAL] =
    {
        { x = -312.000, y = 0.000, z = 128.000, wait = 5000 },
        { x = -312.000, y = 0.000, z = 152.000, wait = 5000 },
    },

    [ID.TEMENOS_EASTERN_TOWER.mob.THUNDER_ELEMENTAL + 1] =
    {
        { x = -300.000, y = 0.000, z = 128.000, wait = 5000 },
        { x = -300.000, y = 0.000, z = 152.000, wait = 5000 },
    },

    [ID.TEMENOS_EASTERN_TOWER.mob.THUNDER_ELEMENTAL + 2] =
    {
        { x = -248.000, y = 0.000, z = 128.000, wait = 5000 },
        { x = -248.000, y = 0.000, z = 152.000, wait = 5000 },
    },

    [ID.TEMENOS_EASTERN_TOWER.mob.THUNDER_ELEMENTAL + 3] =
    {
        { x = -260.000, y = 0.000, z = 128.000, wait = 5000 },
        { x = -260.000, y = 0.000, z = 152.000, wait = 5000 },
    },

}

content.groups =
{
    {
        mobs = { "Armoury_Crate_E" },
        setup = function(battlefield, crates)
            for _, crate in ipairs(crates) do
                crate:setBattleID(1) -- Different battle ID prevents the crate from being hit by AOEs
            end
        end
    },

    {
        mobs =
        {
            "Fire_Elemental_E",
            "Ice_Elemental_E",
            "Air_Elemental_E",
            "Earth_Elemental_E",
            "Thunder_Elemental_E",
            "Water_Elemental_E",
            "Dark_Elemental_E",
        },

        -- NOTE: Elementals take double physical damage because their family resistance is 25% so it totals to 50% resistance
        mods =
        {
            [xi.mod.UDMGPHYS] = 10000,
            [xi.mod.UDMGMAGIC] = -5000,
            [xi.mod.FASTCAST] = 20,
        },

        mobMods =
        {
            [xi.mobMod.DETECTION] = bit.bor(xi.detects.HEARING, xi.detects.MAGIC),
            [xi.mobMod.LINK_RADIUS] = 7,
            [xi.mobMod.MAGIC_RANGE] = 10,
        },
        isParty = true,
    },

    {
        mobs = { "Fire_Elemental_E" },
        death = utils.bind(content.handleMobDeath, 1),
    },

    {
        mobs = { "Mystic_Avatar_Ifrit_E" },
        spawned = false,
        death = utils.bind(unlockFloorCrates, 1, 4),
    },

    {
        mobs = { "Ice_Elemental_E" },
        death = utils.bind(content.handleMobDeath, 2),
    },

    {
        mobs = { "Mystic_Avatar_Shiva_E" },
        spawned = false,
        death = utils.bind(unlockFloorCrates, 2, 4),
    },

    {
        mobs = { "Air_Elemental_E" },
        death = utils.bind(content.handleMobDeath, 3),
    },

    {
        mobs = { "Mystic_Avatar_Garuda_E" },
        spawned = false,
        death = utils.bind(unlockFloorCrates, 3, 4),
    },

    {
        mobs = { "Earth_Elemental_E" },
        death = utils.bind(content.handleMobDeath, 4),
    },

    {
        mobs = { "Mystic_Avatar_Titan_E" },
        spawned = false,
        death = utils.bind(unlockFloorCrates, 4, 4),
    },

    {
        mobs = { "Thunder_Elemental_E" },
        death = utils.bind(content.handleMobDeath, 5),
    },

    {
        mobs = { "Mystic_Avatar_Ramuh_E" },
        spawned = false,
        death = utils.bind(unlockFloorCrates, 5, 4),
    },

    {
        mobs = { "Water_Elemental_E" },
        death = utils.bind(content.handleMobDeath, 6),
    },

    {
        mobs = { "Mystic_Avatar_LeviathanE" },
        spawned = false,
        death = utils.bind(unlockFloorCrates, 6, 4),
    },

    {
        mobs = { "Dark_Elemental_E" },
        allDeath = function(battlefield, mob)
            npcUtil.showCrate(GetEntityByID(ID.TEMENOS_EASTERN_TOWER.npc.CRATE_OFFSETS[7]))
            npcUtil.showCrate(GetEntityByID(ID.TEMENOS_EASTERN_TOWER.npc.CRATE_OFFSETS[7] + 1))
        end,
    },

    {
        mobs = { "Mystic_Avatar_Fenrir_E" },
        spawned = false,
        death = utils.bind(unlockFloorCrates, 7, 2),
    },
}

content.loot =
{
    [1] =
    {
        {
            quantity = 5,
            { item =  1875, weight = 1000 },
        },

        {
            quantity = 2,
            { item =     0, weight = 1000 },
            { item =  1875, weight = 1000 },
        },

        {
            { item =  1944, weight =  65 },
            { item =  1936, weight =  97 },
            { item =  1946, weight =  40 },
            { item =  1942, weight =  95 },
            { item =  2660, weight = 194 },
            { item =  2714, weight =  32 },
            { item =  1950, weight = 161 },
        },
    },

    [2] =
    {
        {
            quantity = 5,
            { item =  1875, weight = 1000 },
        },

        {
            quantity = 3,
            { item =     0, weight = 1000 },
            { item =  1875, weight = 1000 },
        },

        {
            { item =  1936, weight = 367 },
            { item =  1952, weight =  70 },
            { item =  1950, weight =  40 },
            { item =  1942, weight = 333 },
            { item =  1958, weight =  20 },
            { item =  1956, weight = 106 },
            { item =  1938, weight =  33 },
            { item =  1944, weight =  76 },
            { item =  1948, weight =  95 },
            { item =  2658, weight =  67 },
            { item =  1946, weight = 133 },
        },

        {
            { item =     0, weight = 350 },
            { item =  1936, weight = 367 },
            { item =  1952, weight =  70 },
            { item =  1950, weight =  40 },
            { item =  1942, weight = 333 },
            { item =  1958, weight =  20 },
            { item =  1956, weight = 106 },
            { item =  1938, weight =  33 },
            { item =  1944, weight =  76 },
            { item =  1948, weight =  95 },
            { item =  2658, weight =  67 },
            { item =  1946, weight = 133 },
        },
    },

    [3] =
    {
        {
            quantity = 5,
            { item =  1875, weight = 1000 },
        },

        {
            quantity = 3,
            { item =     0, weight = 1000 },
            { item =  1875, weight = 1000 },
        },

        {
            { item =  1942, weight = 625 },
            { item =  1944, weight = 102 },
            { item =  1950, weight =  42 },
            { item =  1952, weight =  83 },
            { item =  1946, weight =  50 },
            { item =  1940, weight =  83 },
            { item =  1936, weight =  70 },
            { item =  1938, weight =  42 },
            { item =  1948, weight =  42 },
            { item =  2660, weight = 292 },
        },

        {
            { item =     0, weight = 300 },
            { item =  1942, weight = 625 },
            { item =  1944, weight = 102 },
            { item =  1950, weight =  42 },
            { item =  1952, weight =  83 },
            { item =  1946, weight =  50 },
            { item =  1940, weight =  83 },
            { item =  1936, weight =  70 },
            { item =  1938, weight =  42 },
            { item =  1948, weight =  42 },
            { item =  2660, weight = 292 },
        },
    },

    [4] =
    {
        {
            quantity = 6,
            { item =  1875, weight = 1000 },
        },

        {
            quantity = 2,
            { item =     0, weight = 1000 },
            { item =  1875, weight = 1000 },
        },

        {
            { item =  1950, weight = 417 },
            { item =  1956, weight =  75 },
            { item =  1944, weight = 208 },
            { item =  1940, weight = 167 },
            { item =  1946, weight =  62 },
            { item =  1936, weight =  69 },
            { item =  2660, weight = 208 },
            { item =  1952, weight =  42 },
            { item =  2658, weight =  83 },
        },

        {
            { item =     0, weight = 400 },
            { item =  1950, weight = 417 },
            { item =  1956, weight =  75 },
            { item =  1944, weight = 208 },
            { item =  1940, weight = 167 },
            { item =  1946, weight =  62 },
            { item =  1936, weight =  69 },
            { item =  2660, weight = 208 },
            { item =  1952, weight =  42 },
            { item =  2658, weight =  83 },
        },
    },

    [5] =
    {
        {
            quantity = 6,
            { item =  1875, weight = 1000 },
        },

        {
            { item =     0, weight = 1000 },
            { item =  1875, weight = 1000 },
        },

        {
            { item =  1944, weight = 208 },
            { item =  1938, weight =  42 },
            { item =  1946, weight =  36 },
            { item =  1940, weight =  83 },
            { item =  1942, weight =  20 },
            { item =  1952, weight =  94 },
            { item =  1956, weight =  42 },
            { item =  1936, weight =  49 },
            { item =  1950, weight = 167 },
            { item =  2714, weight = 458 },
        },

        {
            { item =     0, weight = 200 },
            { item =  1944, weight = 208 },
            { item =  1938, weight =  42 },
            { item =  1946, weight =  36 },
            { item =  1940, weight =  83 },
            { item =  1942, weight =  20 },
            { item =  1952, weight =  94 },
            { item =  1956, weight =  42 },
            { item =  1936, weight =  49 },
            { item =  1950, weight = 167 },
            { item =  2714, weight = 458 },
        },
    },

    [6] =
    {
        {
            quantity = 6,
            { item =  1875, weight = 1000 },
        },

        {
            { item =     0, weight = 1000 },
            { item =  1875, weight = 1000 },
        },

        {
            { item =  1942, weight =  68 },
            { item =  1948, weight =  74 },
            { item =  1936, weight = 259 },
            { item =  1940, weight =  74 },
            { item =  1956, weight =  74 },
            { item =  1950, weight =  62 },
            { item =  2656, weight = 150 },
            { item =  1938, weight =  76 },
            { item =  1952, weight =  53 },
            { item =  2658, weight = 111 },
            { item =  2714, weight = 370 },
            { item =  1946, weight = 333 },
        },

        {
            { item =     0, weight = 300 },
            { item =  1942, weight =  68 },
            { item =  1948, weight =  74 },
            { item =  1936, weight = 259 },
            { item =  1940, weight =  74 },
            { item =  1956, weight =  74 },
            { item =  1950, weight =  62 },
            { item =  2656, weight = 150 },
            { item =  1938, weight =  76 },
            { item =  1952, weight =  53 },
            { item =  2658, weight = 111 },
            { item =  2714, weight = 370 },
            { item =  1946, weight = 333 },
        },
    },

    [7] =
    {
        {
            quantity = 7,
            { item =  1875, weight = 1000 },
        },

        {
            { item =  1942, weight =  38 },
            { item =  1950, weight =  67 },
            { item =  1944, weight = 100 },
            { item =  1936, weight = 233 },
            { item =  1946, weight =  80 },
            { item =  2660, weight = 333 },
            { item =  2714, weight =  67 },
        },

        {
            { item =  1905, weight = 1000 },
        },

        {
            { item =     0, weight = 100 },
            { item =  2127, weight =  55 },
        },
    },
}

return content:register()
