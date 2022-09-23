-----------------------------------
-- Area: Appolyon
-- Name: SE Apollyon
-----------------------------------
local ID = require("scripts/zones/Apollyon/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/limbus")
require("scripts/globals/items")
require("scripts/globals/keyitems")
-----------------------------------

local area = LimbusArea:new("SE_APOLLYON", xi.ki.BLACK_CARD)

area.paths =
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

area.groups =
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
        death = function(mob, count)
            xi.limbus.openDoor(mob:getBattlefield(), ID.SE_APOLLYON.npc.PORTAL[1])
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
        death = function(mob, count)
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
        death = function(mob, count)
            xi.limbus.openDoor(mob:getBattlefield(), ID.SE_APOLLYON.npc.PORTAL[2])
        end,
    },
    {
        mobs = { "Adamantshell" },
        mods =
        {
            [xi.mod.SLASH_SDT] = 0,
            [xi.mod.PIERCE_SDT] = 1250,
        },
        death = function(mob, count)
            if count == 2 then
                xi.limbus.showCrate(ID.SE_APOLLYON.npc.TIME_CRATES[2])
            elseif count == 4 then
                xi.limbus.showRecoverCrate(ID.SE_APOLLYON.npc.RECOVER_CRATES[2])
            elseif count == 8 then
                xi.limbus.showCrate(ID.SE_APOLLYON.npc.ITEM_CRATES[2])
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
        death = function(mob, count)
            xi.limbus.openDoor(mob:getBattlefield(), ID.SE_APOLLYON.npc.PORTAL[3])
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
        setup = function(mobs)
            local battlefield = mobs[1]:getBattlefield()
            local timeCrateIndex, recoverCrateIndex, itemCrateIndex = unpack(utils.uniqueRandomTable(1, 6, 3))

            battlefield:setLocalVar("timeCrateIndex", timeCrateIndex)
            battlefield:setLocalVar("recoverCrateIndex", recoverCrateIndex)
            battlefield:setLocalVar("itemCrateIndex", itemCrateIndex)
        end,
        death = function(mob, count)
            local battlefield = mob:getBattlefield()
            if count == 2 then
                local crate = GetNPCByID(ID.SE_APOLLYON.npc.TIME_CRATES[3])
                crate:setPos(floorThreeCratePositions[battlefield:getLocalVar("timeCrateIndex")])
                xi.limbus.showCrate(ID.SE_APOLLYON.npc.TIME_CRATES[3])

            elseif count == 4 then
                local crate = GetMobByID(ID.SE_APOLLYON.npc.RECOVER_CRATES[3])
                crate:setPos(floorThreeCratePositions[battlefield:getLocalVar("recoverCrateIndex")])
                xi.limbus.showRecoverCrate(ID.SE_APOLLYON.npc.RECOVER_CRATES[3])

            elseif count == 8 then
                local crate = GetNPCByID(ID.SE_APOLLYON.npc.ITEM_CRATES[3])
                crate:setPos(floorThreeCratePositions[battlefield:getLocalVar("itemCrateIndex")])
                xi.limbus.showCrate(ID.SE_APOLLYON.npc.ITEM_CRATES[3])
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
            [xi.mod.UDMGMAGIC] = -10000,
        },
        setup = function(mobs)
            for _, mob in ipairs(mobs) do
                -- Prevent boss from being targetable until first mob Flying_Spear is killed
                mob:setUntargetable(true)
                mob:setStatus(xi.status.NORMAL)
                mob:setMobMod(xi.mobMod.NO_AGGRO, 1)
                mob:setMobMod(xi.mobMod.NO_LINK, 1)
            end
        end,
    },
    {
        mobs = { "Flying_Spear" },
        mods =
        {
            [xi.mod.MAGIC_NULL] = 100,
        },
        death = function(mob, count)
            local boss = mob:getZone():queryEntitiesByName("Evil_Armory")[1]
            boss:setMod(xi.mod.UDMGPHYS, (8 - count) * -1000)
            if count == 1 then
                -- Make the boss become targetable after the first kill
                boss:setUntargetable(false)
                boss:setStatus(xi.status.MOB)
                boss:setMobMod(xi.mobMod.NO_AGGRO, 0)
                boss:setMobMod(xi.mobMod.NO_LINK, 0)
            end
        end,
        all_death = function(mob)
            local boss = mob:getZone():queryEntitiesByName("Evil_Armory")[1]
            boss:setMod(xi.mod.UDMGMAGIC, 0)
        end,
    },
}

area.loot =
{
    [ID.SE_APOLLYON.npc.ITEM_CRATES[1]] =
    {
        {
            { itemid = 1875, droprate = 1000 }, -- Ancient Beastcoin
        },

        {
            { itemid = 1875, droprate = 1000 }, -- Ancient Beastcoin
        },

        {
            { itemid = 1875, droprate = 1000 }, -- Ancient Beastcoin
        },

        {
            { itemid = 1875, droprate = 1000 }, -- Ancient Beastcoin
        },

        {
            { itemid =    0, droprate = 1000 }, -- Nothing
            { itemid = 1939, droprate =  350 }, -- RDM
            { itemid = 1941, droprate =  278 }, -- THF
            { itemid = 1959, droprate =  174 }, -- SMN
            { itemid = 1949, droprate =  200 }, -- BRD
            { itemid = 1945, droprate =   47 }, -- DRK
            { itemid = 1951, droprate =   49 }, -- RNG
            { itemid = 1955, droprate =  200 }, -- NIN
            { itemid = 2659, droprate =   62 }, -- COR
            { itemid = 2715, droprate =  407 }, -- DNC
        },

        {
            { itemid =    0, droprate = 1000 }, -- Nothing
            { itemid = 1939, droprate =  350 }, -- RDM
            { itemid = 1941, droprate =  278 }, -- THF
            { itemid = 1959, droprate =  174 }, -- SMN
            { itemid = 1949, droprate =  200 }, -- BRD
            { itemid = 1945, droprate =   47 }, -- DRK
            { itemid = 1951, droprate =   49 }, -- RNG
            { itemid = 1955, droprate =  200 }, -- NIN
            { itemid = 2659, droprate =   62 }, -- COR
            { itemid = 2715, droprate =  407 }, -- DNC
        },
    },
    [ID.SE_APOLLYON.npc.ITEM_CRATES[2]] =
    {
        {
            { itemid = 1875, droprate = 1000 }, -- Ancient Beastcoin
        },

        {
            { itemid = 1875, droprate = 1000 }, -- Ancient Beastcoin
        },

        {
            { itemid = 1875, droprate = 1000 }, -- Ancient Beastcoin
        },

        {
            { itemid = 1875, droprate = 1000 }, -- Ancient Beastcoin
        },

        {
            { itemid = 1959, droprate =  47 }, -- SMN
            { itemid = 1949, droprate =  30 }, -- BRD
            { itemid = 1943, droprate = 200 }, -- PLD
            { itemid = 1947, droprate = 460 }, -- BST
            { itemid = 2661, droprate = 400 }, -- PUP
            { itemid = 1951, droprate =  20 }, -- RNG
            { itemid = 1955, droprate =  80 }, -- NIN
            { itemid = 1945, droprate =  90 }, -- DRK
            { itemid = 2659, droprate = 100 }, -- COR
            { itemid = 2715, droprate = 120 }, -- DNC
        },

        {
            { itemid =    0, droprate = 999 }, -- Nothing
            { itemid = 1959, droprate =  47 }, -- SMN
            { itemid = 1949, droprate =  30 }, -- BRD
            { itemid = 1943, droprate = 200 }, -- PLD
            { itemid = 1947, droprate = 460 }, -- BST
            { itemid = 2661, droprate = 400 }, -- PUP
            { itemid = 1951, droprate =  20 }, -- RNG
            { itemid = 1955, droprate =  80 }, -- NIN
            { itemid = 1945, droprate =  90 }, -- DRK
            { itemid = 2659, droprate = 100 }, -- COR
            { itemid = 2715, droprate = 120 }, -- DNC
        },
    },
    [ID.SE_APOLLYON.npc.ITEM_CRATES[3]] =
    {
        {
            { itemid = 1875, droprate = 1000 }, -- Ancient Beastcoin
        },

        {
            { itemid = 1875, droprate = 1000 }, -- Ancient Beastcoin
        },

        {
            { itemid = 1875, droprate = 1000 }, -- Ancient Beastcoin
        },

        {
            { itemid = 1875, droprate = 1000 }, -- Ancient Beastcoin
        },

        {
            { itemid =    0, droprate = 999 }, -- Nothing
            { itemid = 1955, droprate =  59 }, -- NIN
            { itemid = 1959, droprate = 139 }, -- SMN
            { itemid = 1949, droprate =  39 }, -- BRD
            { itemid = 1681, droprate =  39 }, -- Light Steel
            { itemid =  645, droprate =  39 }, -- Darksteel Ore
            { itemid = 1933, droprate = 627 }, -- MNK
        },

        {
            { itemid =    0, droprate = 500 }, -- Nothing
            { itemid = 1945, droprate = 159 }, -- DRK
            { itemid = 1951, droprate = 139 }, -- RNG
            { itemid = 2659, droprate =  39 }, -- COR
            { itemid =  664, droprate =  20 }, -- Darksteel Sheet
            { itemid =  646, droprate =  20 }, -- Adaman Ore
            { itemid = 1931, droprate = 200 }, -- WAR
        },
    },
    [ID.SE_APOLLYON.npc.LOOT_CRATE] =
    {
        {
            { itemid = 1875, droprate = 1000 }, -- Ancient Beastcoin
        },

        {
            { itemid = 1875, droprate = 1000 }, -- Ancient Beastcoin
        },

        {
            { itemid = 1875, droprate = 1000 }, -- Ancient Beastcoin
        },

        {
            { itemid = 1875, droprate = 1000 }, -- Ancient Beastcoin
        },

        {
            { itemid = 1875, droprate = 1000 }, -- Ancient Beastcoin
        },

        {
            { itemid = 1935, droprate = 220 }, -- WHM
            { itemid = 1937, droprate = 300 }, -- BLM
            { itemid = 1957, droprate = 260 }, -- DRG
            { itemid = 1953, droprate = 340 }, -- SAM
            { itemid = 2657, droprate = 220 }, -- BLU
            { itemid = 2717, droprate = 180 }, -- SCH
            { itemid = 1931, droprate = 300 }, -- WAR
        },

        {
            { itemid = 1935, droprate = 220 }, -- WHM
            { itemid = 1937, droprate = 300 }, -- BLM
            { itemid = 1957, droprate = 260 }, -- DRG
            { itemid = 1953, droprate = 340 }, -- SAM
            { itemid = 2657, droprate = 220 }, -- BLU
            { itemid = 2717, droprate = 180 }, -- SCH
            { itemid = 1931, droprate = 300 }, -- WAR
        },

        {
            { itemid = 1909, droprate = 1000 }, -- Smalt Chip
        },

        {
            { itemid = 2127, droprate =  59 }, -- Metal Chip
            { itemid =    0, droprate = 100 }, -- Nothing
        },
    },
}

return area:createBattlefield()
