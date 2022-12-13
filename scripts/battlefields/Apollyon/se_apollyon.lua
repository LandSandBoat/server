-----------------------------------
-- Area: Apollyon
-- Name: SE Apollyon
-- !addkeyitem black_card
-- !addkeyitem cosmo_cleanse
-- !pos 600 -0.5 -600 38
-----------------------------------
local ID = require("scripts/zones/Apollyon/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/limbus")
require("scripts/globals/items")
require("scripts/globals/keyitems")
-----------------------------------

local content = Limbus:new({
    zoneId           = xi.zone.APOLLYON,
    battlefieldId    = xi.battlefield.id.SE_APOLLYON,
    maxPlayers       = 18,
    timeLimit        = utils.minutes(30),
    index            = 2,
    area             = 3,
    entryNpc         = '_12i',
    requiredKeyItems = { xi.ki.COSMO_CLEANSE, xi.ki.BLACK_CARD, message = ID.text.YOU_INSERT_THE_CARD_POLISHED },
    lossEventParams  = { [5] = 1 },
    name             = "SE_APOLLYON",
    exitLocation     = 1,
    timeExtension   = 10,
})

content.paths =
{
    [ID.SE_APOLLYON.mob.TIEHOLTSODI] =
    {
        { x = 151.0, y = 0.0, z = -528.0, wait = 10000 },
        { x = 147.0, y = 0.0, z = -468.05, wait = 10000 },
    },

    [ID.SE_APOLLYON.mob.ADAMANTSHELL[1]] =
    {
        { x = 138.0, y = -2.0, z = -496.0, wait = 2500 },
        { x = 142.0, y = -1.11, z = -500.0, wait = 2500 },
    },

    [ID.SE_APOLLYON.mob.ADAMANTSHELL[2]] =
    {
        { x = 139.0, y = -2.0, z = -496.0, wait = 2500 },
        { x = 138.0, y = 0.0, z = -485.0, wait = 2500 },
    },

    [ID.SE_APOLLYON.mob.ADAMANTSHELL[3]] =
    {
        { x = 129.0, y = 0.0, z = -504.0, wait = 2500 },
        { x = 138.0, y = -2.0, z = -497.0, wait = 2500 },
    },

    [ID.SE_APOLLYON.mob.ADAMANTSHELL[4]] =
    {
        { x = 183.0, y = 0.0, z = -554.0, wait = 2500 },
        { x = 185.0, y = 0.0, z = -535.0, wait = 2500 },
    },

    [ID.SE_APOLLYON.mob.ADAMANTSHELL[5]] =
    {
        { x = 185.0, y = 0.0, z = -535.0, wait = 2500 },
        { x = 183.0, y = 0.0, z = -554.0, wait = 2500 },
    },

    [ID.SE_APOLLYON.mob.ADAMANTSHELL[6]] =
    {
        { x = 195.0, y = 0.0, z = -446.0, wait = 2500 },
        { x = 215.0, y = 0.0, z = -436.0, wait = 2500 },
    },

    [ID.SE_APOLLYON.mob.ADAMANTSHELL[7]] =
    {
        { x = 212.0, y = 0.0, z = -441.0, wait = 2500 },
        { x = 192.0, y = 0.0, z = -441.0, wait = 2500 },
    },

    [ID.SE_APOLLYON.mob.ADAMANTSHELL[8]] =
    {
        { x = 190.0, y = 0.0, z = -436.0, wait = 2500 },
        { x = 208.0, y = 0.0, z = -448.0, wait = 2500 },
    },

    [ID.SE_APOLLYON.mob.FLYING_SPEAR[1]] =
    {
        { x = 505.0, y = 0.0, z = -305.0, wait = 10000 },
        { x = 490.0, y = 0.0, z = -287.0, wait = 10000 },
    },

    [ID.SE_APOLLYON.mob.FLYING_SPEAR[2]] =
    {
        { x = 558.0, y = 0.0, z = -348.0, wait = 10000 },
        { x = 540.0, y = 0.0, z = -347.0, wait = 10000 },
    },

    [ID.SE_APOLLYON.mob.FLYING_SPEAR[3]] =
    {
        { x = 619.0, y = 0.0, z = -337.0, wait = 10000 },
        { x = 633.0, y = 0.0, z = -332.0, wait = 10000 },
    },

    [ID.SE_APOLLYON.mob.FLYING_SPEAR[4]] =
    {
        { x = 600.0, y = 0.0, z = -381.0, wait = 10000 },
        { x = 599.0, y = 0.0, z = -365.0, wait = 10000 },
    },

    [ID.SE_APOLLYON.mob.FLYING_SPEAR[5]] =
    {
        { x = 541.0, y = 0.0, z = -368.0, wait = 10000 },
        { x = 530.0, y = 0.0, z = -353.0, wait = 10000 },
    },

    [ID.SE_APOLLYON.mob.FLYING_SPEAR[6]] =
    {
        { x = 560.0, y = 0.0, z = -346.0, wait = 10000 },
        { x = 538.0, y = 0.0, z = -353.0, wait = 10000 },
    },

    [ID.SE_APOLLYON.mob.FLYING_SPEAR[7]] =
    {
        { x = 616.0, y = 0.0, z = -380.0, wait = 10000 },
        { x = 610.0, y = 0.0, z = -364.0, wait = 10000 },
    },

    [ID.SE_APOLLYON.mob.FLYING_SPEAR[8]] =
    {
        { x = 577.0, y = 0.0, z = -367.0, wait = 10000 },
        { x = 560.0, y = 0.0, z = -314.0, wait = 10000 },
    },
}

local floorThreeCratePositions =
{
    { 366.000, -0.500, -313.000 },
    { 313.021, 0.000, -317.754 },
    { 376.097, 0.000, -259.382 },
    { 321.552, 0.000, -293.187 },
    { 337.399, -0.388, -313.442 },
    { 354.661, -0.072, -273.424 },
}

content.groups =
{
    -- Floor 1
    {
        -- Boss
        mobs = { "Ghost_Clot" },
        stationary = true,
        mods =
        {
            [xi.mod.IMPACT_SDT] = 0,
            [xi.mod.HTH_SDT] = 0,
            [xi.mod.SLASH_SDT] = 1250,
        },

        death = function(battlefield, mob, count)
            content:openDoor(mob:getBattlefield(), 1)
        end,
    },
    {
        mobs = { "Metalloid_Amoeba" },
        stationary = true,
        mods =
        {
            [xi.mod.IMPACT_SDT] = 0,
            [xi.mod.HTH_SDT] = 0,
            [xi.mod.SLASH_SDT] = 1250,
        },

        death = function(battlefield, mob, count)
            if count == 2 then
                xi.limbus.spawnFrom(mob, ID.SE_APOLLYON.npc.TIME_CRATES[1])
            elseif count == 4 then
                xi.limbus.spawnRecoverFrom(mob, ID.SE_APOLLYON.npc.RECOVER_CRATES[1])
            elseif count == 8 then
                xi.limbus.spawnFrom(mob, ID.SE_APOLLYON.npc.ITEM_CRATES[1])
            end
        end,
    },

    -- Floor 2
    {
        mobs = { "Tieholtsodi" },
        mods =
        {
            [xi.mod.SLASH_SDT] = 0,
            [xi.mod.PIERCE_SDT] = 1250,
        },

        death = function(battlefield, mob, count)
            content:openDoor(mob:getBattlefield(), 2)
        end,
    },
    {
        mobs = { "Adamantshell" },
        mods =
        {
            [xi.mod.SLASH_SDT] = 0,
            [xi.mod.PIERCE_SDT] = 1250,
        },

        death = function(battlefield, mob, count)
            if count == 2 then
                npcUtil.showCrate(GetNPCByID(ID.SE_APOLLYON.npc.TIME_CRATES[2]))
            elseif count == 4 then
                xi.limbus.showRecoverCrate(ID.SE_APOLLYON.npc.RECOVER_CRATES[2])
            elseif count == 8 then
                npcUtil.showCrate(GetNPCByID(ID.SE_APOLLYON.npc.ITEM_CRATES[2]))
            end
        end,
    },

    -- Floor 3
    {
        mobs = { "Grave_Digger" },
        stationary = true,
        mods =
        {
            [xi.mod.PIERCE_SDT] = 0,
            [xi.mod.IMPACT_SDT] = 1250,
            [xi.mod.HTH_SDT] = 1250,
        },

        death = function(battlefield, mob, count)
            content:openDoor(mob:getBattlefield(), 3)
        end,
    },
    {
        mobs = { "Inhumer" },
        mods =
        {
            [xi.mod.PIERCE_SDT] = 0,
            [xi.mod.IMPACT_SDT] = 1250,
            [xi.mod.HTH_SDT] = 1250,
        },

        setup = function(battlefield, mobs)
            local timeCrateIndex, recoverCrateIndex, itemCrateIndex = unpack(utils.uniqueRandomTable(1, 6, 3))

            battlefield:setLocalVar("timeCrateIndex", timeCrateIndex)
            battlefield:setLocalVar("recoverCrateIndex", recoverCrateIndex)
            battlefield:setLocalVar("itemCrateIndex", itemCrateIndex)
        end,

        death = function(battlefield, mob, count)
            if count == 2 then
                local crate = GetNPCByID(ID.SE_APOLLYON.npc.TIME_CRATES[3])
                crate:setPos(floorThreeCratePositions[battlefield:getLocalVar("timeCrateIndex")])
                npcUtil.showCrate(GetNPCByID(ID.SE_APOLLYON.npc.TIME_CRATES[3]))

            elseif count == 4 then
                local crate = GetMobByID(ID.SE_APOLLYON.npc.RECOVER_CRATES[3])
                crate:setPos(floorThreeCratePositions[battlefield:getLocalVar("recoverCrateIndex")])
                xi.limbus.showRecoverCrate(ID.SE_APOLLYON.npc.RECOVER_CRATES[3])

            elseif count == 8 then
                local crate = GetNPCByID(ID.SE_APOLLYON.npc.ITEM_CRATES[3])
                crate:setPos(floorThreeCratePositions[battlefield:getLocalVar("itemCrateIndex")])
                npcUtil.showCrate(GetNPCByID(ID.SE_APOLLYON.npc.ITEM_CRATES[3]))
            end
        end,
    },

    -- Floor 4
    {
        mobs = { "Evil_Armory" },
        stationary = true,
        mods =
        {
            [xi.mod.UDMGPHYS] = -8000,
            [xi.mod.MAGIC_NULL] = 100,
        },

        setup = function(battlefield, mobs)
            for _, mob in ipairs(mobs) do
                -- Prevent boss from being targetable until first mob Flying_Spear is killed
                mob:setBattleID(1)
                mob:setStatus(xi.status.NORMAL)
                mob:setMobMod(xi.mobMod.NO_AGGRO, 1)
                mob:setMobMod(xi.mobMod.NO_LINK, 1)
            end
        end,

        allDeath = function(battlefield, mob)
            npcUtil.showCrate(GetNPCByID(ID.SE_APOLLYON.npc.LOOT_CRATE))
        end
    },
    {
        mobs = { "Flying_Spear" },
        mods =
        {
            [xi.mod.MAGIC_NULL] = 100,
        },

        death = function(battlefield, mob, count)
            local boss = mob:getZone():queryEntitiesByName("Evil_Armory")[1]
            boss:setMod(xi.mod.UDMGPHYS, (8 - count) * -1000)
            if count == 1 then
                -- Make the boss become targetable after the first kill
                boss:setBattleID(0)
                boss:setStatus(xi.status.MOB)
                boss:setMobMod(xi.mobMod.NO_AGGRO, 0)
                boss:setMobMod(xi.mobMod.NO_LINK, 0)
            end
        end,

        allDeath = function(battlefield, mob)
            local boss = mob:getZone():queryEntitiesByName("Evil_Armory")[1]
            boss:setMod(xi.mod.MAGIC_NULL, 0)
        end,
    },
}

content.loot =
{
    [ID.SE_APOLLYON.npc.ITEM_CRATES[1]] =
    {
        {
            quantity = 4,
            { item =  1875, weight = 1000 }, -- Ancient Beastcoin
        },

        {
            { item =     0, weight = 1000 }, -- Nothing
            { item =  1939, weight =  350 }, -- RDM
            { item =  1941, weight =  278 }, -- THF
            { item =  1959, weight =  174 }, -- SMN
            { item =  1949, weight =  200 }, -- BRD
            { item =  1945, weight =   47 }, -- DRK
            { item =  1951, weight =   49 }, -- RNG
            { item =  1955, weight =  200 }, -- NIN
            { item =  2659, weight =   62 }, -- COR
            { item =  2715, weight =  407 }, -- DNC
        },

        {
            { item =     0, weight = 1000 }, -- Nothing
            { item =  1939, weight =  350 }, -- RDM
            { item =  1941, weight =  278 }, -- THF
            { item =  1959, weight =  174 }, -- SMN
            { item =  1949, weight =  200 }, -- BRD
            { item =  1945, weight =   47 }, -- DRK
            { item =  1951, weight =   49 }, -- RNG
            { item =  1955, weight =  200 }, -- NIN
            { item =  2659, weight =   62 }, -- COR
            { item =  2715, weight =  407 }, -- DNC
        },
    },
    [ID.SE_APOLLYON.npc.ITEM_CRATES[2]] =
    {
        {
            quantity = 4,
            { item =  1875, weight = 1000 }, -- Ancient Beastcoin
        },

        {
            { item =  1959, weight =  47 }, -- SMN
            { item =  1949, weight =  30 }, -- BRD
            { item =  1943, weight = 200 }, -- PLD
            { item =  1947, weight = 460 }, -- BST
            { item =  2661, weight = 400 }, -- PUP
            { item =  1951, weight =  20 }, -- RNG
            { item =  1955, weight =  80 }, -- NIN
            { item =  1945, weight =  90 }, -- DRK
            { item =  2659, weight = 100 }, -- COR
            { item =  2715, weight = 120 }, -- DNC
        },

        {
            { item =     0, weight = 999 }, -- Nothing
            { item =  1959, weight =  47 }, -- SMN
            { item =  1949, weight =  30 }, -- BRD
            { item =  1943, weight = 200 }, -- PLD
            { item =  1947, weight = 460 }, -- BST
            { item =  2661, weight = 400 }, -- PUP
            { item =  1951, weight =  20 }, -- RNG
            { item =  1955, weight =  80 }, -- NIN
            { item =  1945, weight =  90 }, -- DRK
            { item =  2659, weight = 100 }, -- COR
            { item =  2715, weight = 120 }, -- DNC
        },
    },
    [ID.SE_APOLLYON.npc.ITEM_CRATES[3]] =
    {
        {
            quantity = 4,
            { item =  1875, weight = 1000 }, -- Ancient Beastcoin
        },

        {
            { item =     0, weight = 999 }, -- Nothing
            { item =  1955, weight =  59 }, -- NIN
            { item =  1959, weight = 139 }, -- SMN
            { item =  1949, weight =  39 }, -- BRD
            { item =  1681, weight =  39 }, -- Light Steel
            { item =   645, weight =  39 }, -- Darksteel Ore
            { item =  1933, weight = 627 }, -- MNK
        },

        {
            { item =     0, weight = 500 }, -- Nothing
            { item =  1945, weight = 159 }, -- DRK
            { item =  1951, weight = 139 }, -- RNG
            { item =  2659, weight =  39 }, -- COR
            { item =   664, weight =  20 }, -- Darksteel Sheet
            { item =   646, weight =  20 }, -- Adaman Ore
            { item =  1931, weight = 200 }, -- WAR
        },
    },
    [ID.SE_APOLLYON.npc.LOOT_CRATE] =
    {
        {
            quantity = 5,
            { item =  1875, weight = 1000 }, -- Ancient Beastcoin
        },

        {
            { item =  1935, weight = 220 }, -- WHM
            { item =  1937, weight = 300 }, -- BLM
            { item =  1957, weight = 260 }, -- DRG
            { item =  1953, weight = 340 }, -- SAM
            { item =  2657, weight = 220 }, -- BLU
            { item =  2717, weight = 180 }, -- SCH
            { item =  1931, weight = 300 }, -- WAR
        },

        {
            { item =  1935, weight = 220 }, -- WHM
            { item =  1937, weight = 300 }, -- BLM
            { item =  1957, weight = 260 }, -- DRG
            { item =  1953, weight = 340 }, -- SAM
            { item =  2657, weight = 220 }, -- BLU
            { item =  2717, weight = 180 }, -- SCH
            { item =  1931, weight = 300 }, -- WAR
        },

        {
            { item =  1909, weight = 1000 }, -- Smalt Chip
        },

        {
            { item =  2127, weight =  59 }, -- Metal Chip
            { item =     0, weight = 100 }, -- Nothing
        },
    },
}

return content:register()
