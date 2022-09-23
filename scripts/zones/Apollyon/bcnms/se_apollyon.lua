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
    [16933006] =
    {
        { x = 151.0, y = 0.0, z = -528.0, wait = 10000 },
        { x = 147.0, y = 0.0, z = -468.05, wait = 10000 },
    },
    [16933007] =
    {
        { x = 138.0, y = -2.0, z = -496.0, wait = 2500 },
        { x = 142.0, y = -1.11, z = -500.0, wait = 2500 },
    },
    [16933008] =
    {
        { x = 139.0, y = -2.0, z = -496.0, wait = 2500 },
        { x = 138.0, y = 0.0, z = -485.0, wait = 2500 },
    },
    [16933009] =
    {
        { x = 129.0, y = 0.0, z = -504.0, wait = 2500 },
        { x = 138.0, y = -2.0, z = -497.0, wait = 2500 },
    },
    [16933010] =
    {
        { x = 183.0, y = 0.0, z = -554.0, wait = 2500 },
        { x = 185.0, y = 0.0, z = -535.0, wait = 2500 },
    },
    [16933011] =
    {
        { x = 185.0, y = 0.0, z = -535.0, wait = 2500 },
        { x = 183.0, y = 0.0, z = -554.0, wait = 2500 },
    },
    [16933012] =
    {
        { x = 195.0, y = 0.0, z = -446.0, wait = 2500 },
        { x = 215.0, y = 0.0, z = -436.0, wait = 2500 },
    },
    [16933013] =
    {
        { x = 212.0, y = 0.0, z = -441.0, wait = 2500 },
        { x = 192.0, y = 0.0, z = -441.0, wait = 2500 },
    },
    [16933014] =
    {
        { x = 190.0, y = 0.0, z = -436.0, wait = 2500 },
        { x = 208.0, y = 0.0, z = -448.0, wait = 2500 },
    },
    [16933033] =
    {
        { x = 505.0, y = 0.0, z = -305.0, wait = 10000 },
        { x = 490.0, y = 0.0, z = -287.0, wait = 10000 },
    },
    [16933034] =
    {
        { x = 558.0, y = 0.0, z = -348.0, wait = 10000 },
        { x = 540.0, y = 0.0, z = -347.0, wait = 10000 },
    },
    [16933035] =
    {
        { x = 619.0, y = 0.0, z = -337.0, wait = 10000 },
        { x = 633.0, y = 0.0, z = -332.0, wait = 10000 },
    },
    [16933036] =
    {
        { x = 600.0, y = 0.0, z = -381.0, wait = 10000 },
        { x = 599.0, y = 0.0, z = -365.0, wait = 10000 },
    },
    [16933037] =
    {
        { x = 541.0, y = 0.0, z = -368.0, wait = 10000 },
        { x = 530.0, y = 0.0, z = -353.0, wait = 10000 },
    },
    [16933038] =
    {
        { x = 560.0, y = 0.0, z = -346.0, wait = 10000 },
        { x = 538.0, y = 0.0, z = -353.0, wait = 10000 },
    },
    [16933039] =
    {
        { x = 616.0, y = 0.0, z = -380.0, wait = 10000 },
        { x = 610.0, y = 0.0, z = -364.0, wait = 10000 },
    },
    [16933040] =
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
        { { itemid = xi.items.ANCIENT_BEASTCOIN, droprate = xi.battlefield.dropChance.NORMAL } },
        { { itemid = xi.items.ANCIENT_BEASTCOIN, droprate = xi.battlefield.dropChance.NORMAL } },
        { { itemid = xi.items.ANCIENT_BEASTCOIN, droprate = xi.battlefield.dropChance.NORMAL } },
        { { itemid = xi.items.ANCIENT_BEASTCOIN, droprate = xi.battlefield.dropChance.NORMAL } },
        {
            { itemid = xi.items.NONE, droprate = xi.battlefield.dropChance.NORMAL },
            { itemid = xi.items.SQUARE_OF_CARDINAL_CLOTH, droprate = xi.battlefield.dropChance.NORMAL },
        },
        {
            { itemid = xi.items.NONE, droprate = xi.battlefield.dropChance.NORMAL },
            { itemid = xi.items.SPOOL_OF_LIGHT_FILAMENT, droprate = xi.battlefield.dropChance.NORMAL },
        },
    },
    [ID.SE_APOLLYON.npc.ITEM_CRATES[2]] =
    {
        { { itemid = xi.items.ANCIENT_BEASTCOIN, droprate = xi.battlefield.dropChance.NORMAL } },
        { { itemid = xi.items.ANCIENT_BEASTCOIN, droprate = xi.battlefield.dropChance.NORMAL } },
        { { itemid = xi.items.ANCIENT_BEASTCOIN, droprate = xi.battlefield.dropChance.NORMAL } },
        { { itemid = xi.items.ANCIENT_BEASTCOIN, droprate = xi.battlefield.dropChance.NORMAL } },
        {
            { itemid = xi.items.NONE, droprate = xi.battlefield.dropChance.NORMAL },
            { itemid = xi.items.SQUARE_OF_CHARCOAL_COTTON, droprate = xi.battlefield.dropChance.NORMAL },
            { itemid = xi.items.SPOOL_OF_DIABOLIC_YARN, droprate = xi.battlefield.dropChance.NORMAL },
            { itemid = xi.items.FETID_LANOLIN_CUBE, droprate = xi.battlefield.dropChance.NORMAL },
        },
        {
            { itemid = xi.items.NONE, droprate = xi.battlefield.dropChance.NORMAL },
            { itemid = xi.items.ANCIENT_BRASS_INGOT, droprate = xi.battlefield.dropChance.NORMAL },
        },
    },
    [ID.SE_APOLLYON.npc.ITEM_CRATES[3]] =
    {
        { { itemid = xi.items.ANCIENT_BEASTCOIN, droprate = xi.battlefield.dropChance.NORMAL } },
        { { itemid = xi.items.ANCIENT_BEASTCOIN, droprate = xi.battlefield.dropChance.NORMAL } },
        { { itemid = xi.items.ANCIENT_BEASTCOIN, droprate = xi.battlefield.dropChance.NORMAL } },
        { { itemid = xi.items.ANCIENT_BEASTCOIN, droprate = xi.battlefield.dropChance.NORMAL } },
        {
            { itemid = xi.items.SQUARE_OF_FLAMESHUN_CLOTH, droprate = xi.battlefield.dropChance.NORMAL },
            { itemid = xi.items.BLACK_RIVET, droprate = xi.battlefield.dropChance.NORMAL },
            { itemid = xi.items.SQUARE_OF_BROWN_DOESKIN, droprate = xi.battlefield.dropChance.NORMAL },
            { itemid = xi.items.SQUARE_OF_CANVAS_TOILE, droprate = xi.battlefield.dropChance.NORMAL },
        },
        {
            { itemid = xi.items.NONE, droprate = xi.battlefield.dropChance.EXTREMELY_HIGH },
            { itemid = xi.items.SHEET_OF_KUROGANE, droprate = xi.battlefield.dropChance.NORMAL },
        },
    },
    [ID.SE_APOLLYON.npc.LOOT_CRATE] =
    {
        { { itemid = xi.items.ANCIENT_BEASTCOIN, droprate = xi.battlefield.dropChance.NORMAL } },
        { { itemid = xi.items.ANCIENT_BEASTCOIN, droprate = xi.battlefield.dropChance.NORMAL } },
        { { itemid = xi.items.ANCIENT_BEASTCOIN, droprate = xi.battlefield.dropChance.NORMAL } },
        { { itemid = xi.items.ANCIENT_BEASTCOIN, droprate = xi.battlefield.dropChance.NORMAL } },
        { { itemid = xi.items.ANCIENT_BEASTCOIN, droprate = xi.battlefield.dropChance.NORMAL } },
        {
            { itemid = xi.items.ARGYRO_RIVET, droprate = xi.battlefield.dropChance.NORMAL },
            { itemid = xi.items.BLUE_RIVET, droprate = xi.battlefield.dropChance.NORMAL },
            { itemid = xi.items.SQUARE_OF_CORDUROY_CLOTH, droprate = xi.battlefield.dropChance.NORMAL },
            { itemid = xi.items.WHITE_RIVET, droprate = xi.battlefield.dropChance.NORMAL },
        },
        {
            { itemid = xi.items.SPOOL_OF_BENEDICT_YARN, droprate = xi.battlefield.dropChance.NORMAL },
            { itemid = xi.items.POT_OF_EBONY_LACQUER, droprate = xi.battlefield.dropChance.NORMAL },
        },
    },
}

return area:createBattlefield()
