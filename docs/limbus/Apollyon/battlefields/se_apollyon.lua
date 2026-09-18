-----------------------------------
-- Area: Apollyon
-- Name: SE Apollyon
-- !addkeyitem black_card
-- !addkeyitem cosmo_cleanse
-- !pos 600 -0.5 -600 38
-----------------------------------
local ID = zones[xi.zone.APOLLYON]
-----------------------------------

local content = Limbus:new({
    zoneId           = xi.zone.APOLLYON,
    battlefieldId    = xi.battlefield.id.SE_APOLLYON,
    maxPlayers       = 18,
    timeLimit        = utils.minutes(30),
    index            = 2,
    area             = 3,
    entryNpc         = '_12i',
    requiredKeyItems = { xi.keyItem.COSMO_CLEANSE, xi.keyItem.BLACK_CARD, message = ID.text.YOU_INSERT_THE_CARD_POLISHED },
    lossEventParams  = { [5] = 1 },
    name             = 'SE_APOLLYON',
    lootCrateId      = ID.npc.SE_LOOT_CRATE,
    exitLocation     = 1,
    timeExtension    = 10,
})

content.paths =
{
    [ID.mob.SE_TIEHOLTSODI] =
    {
        { x = 151.0, y = 0.0, z = -528.0,  wait = 10000 },
        { x = 147.0, y = 0.0, z = -468.05, wait = 10000 },
    },

    [ID.mob.SE_ADAMANTSHELL_OFFSET] =
    {
        { x = 138.0, y = -2.0,  z = -496.0, wait = 2500 },
        { x = 142.0, y = -1.11, z = -500.0, wait = 2500 },
    },

    [ID.mob.SE_ADAMANTSHELL_OFFSET + 1] =
    {
        { x = 139.0, y = -2.0, z = -496.0, wait = 2500 },
        { x = 138.0, y =  0.0, z = -485.0, wait = 2500 },
    },

    [ID.mob.SE_ADAMANTSHELL_OFFSET + 2] =
    {
        { x = 129.0, y =  0.0, z = -504.0, wait = 2500 },
        { x = 138.0, y = -2.0, z = -497.0, wait = 2500 },
    },

    [ID.mob.SE_ADAMANTSHELL_OFFSET + 3] =
    {
        { x = 183.0, y = 0.0, z = -554.0, wait = 2500 },
        { x = 185.0, y = 0.0, z = -535.0, wait = 2500 },
    },

    [ID.mob.SE_ADAMANTSHELL_OFFSET + 4] =
    {
        { x = 185.0, y = 0.0, z = -535.0, wait = 2500 },
        { x = 183.0, y = 0.0, z = -554.0, wait = 2500 },
    },

    [ID.mob.SE_ADAMANTSHELL_OFFSET + 5] =
    {
        { x = 195.0, y = 0.0, z = -446.0, wait = 2500 },
        { x = 215.0, y = 0.0, z = -436.0, wait = 2500 },
    },

    [ID.mob.SE_ADAMANTSHELL_OFFSET + 6] =
    {
        { x = 212.0, y = 0.0, z = -441.0, wait = 2500 },
        { x = 192.0, y = 0.0, z = -441.0, wait = 2500 },
    },

    [ID.mob.SE_ADAMANTSHELL_OFFSET + 7] =
    {
        { x = 190.0, y = 0.0, z = -436.0, wait = 2500 },
        { x = 208.0, y = 0.0, z = -448.0, wait = 2500 },
    },

    [ID.mob.SE_FLYING_SPEAR_OFFSET] =
    {
        { x = 505.0, y = 0.0, z = -305.0, wait = 10000 },
        { x = 490.0, y = 0.0, z = -287.0, wait = 10000 },
    },

    [ID.mob.SE_FLYING_SPEAR_OFFSET + 1] =
    {
        { x = 558.0, y = 0.0, z = -348.0, wait = 10000 },
        { x = 540.0, y = 0.0, z = -347.0, wait = 10000 },
    },

    [ID.mob.SE_FLYING_SPEAR_OFFSET + 2] =
    {
        { x = 619.0, y = 0.0, z = -337.0, wait = 10000 },
        { x = 633.0, y = 0.0, z = -332.0, wait = 10000 },
    },

    [ID.mob.SE_FLYING_SPEAR_OFFSET + 3] =
    {
        { x = 600.0, y = 0.0, z = -381.0, wait = 10000 },
        { x = 599.0, y = 0.0, z = -365.0, wait = 10000 },
    },

    [ID.mob.SE_FLYING_SPEAR_OFFSET + 4] =
    {
        { x = 541.0, y = 0.0, z = -368.0, wait = 10000 },
        { x = 530.0, y = 0.0, z = -353.0, wait = 10000 },
    },

    [ID.mob.SE_FLYING_SPEAR_OFFSET + 5] =
    {
        { x = 560.0, y = 0.0, z = -346.0, wait = 10000 },
        { x = 538.0, y = 0.0, z = -353.0, wait = 10000 },
    },

    [ID.mob.SE_FLYING_SPEAR_OFFSET + 6] =
    {
        { x = 616.0, y = 0.0, z = -380.0, wait = 10000 },
        { x = 610.0, y = 0.0, z = -364.0, wait = 10000 },
    },

    [ID.mob.SE_FLYING_SPEAR_OFFSET + 7] =
    {
        { x = 577.0, y = 0.0, z = -367.0, wait = 10000 },
        { x = 560.0, y = 0.0, z = -314.0, wait = 10000 },
    },
}

local floorThreeCratePositions =
{
    { 423, 0, -379 },
    { 363, 0, -307 },
    { 337, 0, -330 },
    { 370, 0, -330 },
    { 325, 0, -328 },
    { 333, 0, -279 },
    { 366, 0, -313 },
    { 356, 0, -275 },
    { 320, 0, -294 },
    { 310, 0, -334 },
    { 330, 0, -305 },
    { 368, 0, -276 },
}

content.groups =
{
    -- Floor 1
    {
        -- Boss
        mobs       = { 'Ghost_Clot' },

        death = function(battlefield, mob, count)
            content:openDoor(mob:getBattlefield(), 1)
        end,
    },
    {
        mobs       = { 'Metalloid_Amoeba' },

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
        mobs = { 'Tieholtsodi' },

        death = function(battlefield, mob, count)
            content:openDoor(mob:getBattlefield(), 2)
        end,
    },
    {
        mobs = { 'Adamantshell' },

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
        mobs       = { 'Grave_Digger' },

        death = function(battlefield, mob, count)
            content:openDoor(mob:getBattlefield(), 3)
        end,
    },
    {
        mobs = { 'Inhumer' },

        setup = function(battlefield, mobs)
            local timeCrateIndex, recoverCrateIndex, itemCrateIndex = unpack(utils.uniqueRandomTable(1, 6, 3))

            battlefield:setLocalVar('timeCrateIndex', timeCrateIndex)
            battlefield:setLocalVar('recoverCrateIndex', recoverCrateIndex)
            battlefield:setLocalVar('itemCrateIndex', itemCrateIndex)
        end,

        death = function(battlefield, mob, count)
            if count == 2 then
                local crate = GetNPCByID(ID.SE_APOLLYON.npc.TIME_CRATES[3])
                if crate then
                    crate:setPos(floorThreeCratePositions[battlefield:getLocalVar('timeCrateIndex')])
                    npcUtil.showCrate(GetNPCByID(ID.SE_APOLLYON.npc.TIME_CRATES[3]))
                end
            elseif count == 4 then
                local crate = GetMobByID(ID.SE_APOLLYON.npc.RECOVER_CRATES[3])
                if crate then
                    crate:setPos(floorThreeCratePositions[battlefield:getLocalVar('recoverCrateIndex')])
                    xi.limbus.showRecoverCrate(ID.SE_APOLLYON.npc.RECOVER_CRATES[3])
                end
            elseif count == 8 then
                local crate = GetNPCByID(ID.SE_APOLLYON.npc.ITEM_CRATES[3])
                if crate then
                    crate:setPos(floorThreeCratePositions[battlefield:getLocalVar('itemCrateIndex')])
                    npcUtil.showCrate(GetNPCByID(ID.SE_APOLLYON.npc.ITEM_CRATES[3]))
                end
            end
        end,
    },

    -- Floor 4
    {
        mobs       = { 'Evil_Armory' },
        stationary = true,

        allDeath = function(battlefield, mob)
            npcUtil.showCrate(GetNPCByID(ID.npc.SE_LOOT_CRATE))
        end
    },
    {
        mobs = { 'Flying_Spear' },

        death = function(battlefield, mob, count)
            local boss = mob:getZone():queryEntitiesByName('Evil_Armory')[1]

            -- Increase delay per kill
            local delay = 3000
            if count == 8 then
                delay = 5000

                -- Boss loses magic immunity when all 8 are dead
                boss:setMod(xi.mod.NULL_MAGICAL_DAMAGE, 0)
            elseif count >= 5 then
                delay = 4000

                -- Increase physical damage taken
                boss:setMod(xi.mod.SLASH_SDT, 20000)
                boss:setMod(xi.mod.PIERCE_SDT, 20000)
                boss:setMod(xi.mod.IMPACT_SDT, 20000)
                boss:setMod(xi.mod.HTH_SDT, 20000)
            end

            boss:setDelay(delay)

            if count == 1 then
                -- Make the boss become targetable after the first kill
                boss:setBattleID(0)
                boss:setStatus(xi.status.UPDATE)
                boss:setMobMod(xi.mobMod.NO_AGGRO, 0)
                boss:setMobMod(xi.mobMod.NO_LINK, 0)
            end
        end,

        allDeath = function(battlefield, mob)
            local boss = mob:getZone():queryEntitiesByName('Evil_Armory')[1]
            boss:setMod(xi.mod.NULL_MAGICAL_DAMAGE, 0)
        end,
    },
}

content.loot =
{
    [ID.SE_APOLLYON.npc.ITEM_CRATES[1]] =
    {
        {
            quantity = 5,
            { itemId = xi.item.ANCIENT_BEASTCOIN,         weight = xi.loot.weight.NORMAL },
        },

        {
            { itemId = xi.item.NONE,                      weight = xi.loot.weight.NORMAL },
            { itemId = xi.item.ANCIENT_BEASTCOIN,         weight = xi.loot.weight.NORMAL },
        },

        {
            { itemId = xi.item.SPOOL_OF_BENEDICT_YARN,    weight = xi.loot.weight.NORMAL },
            { itemId = xi.item.SHEET_OF_KUROGANE,         weight = xi.loot.weight.NORMAL },
            { itemId = xi.item.POT_OF_EBONY_LACQUER,      weight = xi.loot.weight.NORMAL },
            { itemId = xi.item.SQUARE_OF_FLAMESHUN_CLOTH, weight = xi.loot.weight.NORMAL },
        },

        {
            { itemId = xi.item.NONE,                      weight = xi.loot.weight.VERY_HIGH },
            { itemId = xi.item.ARGYRO_RIVET,              weight = xi.loot.weight.LOW       },
            { itemId = xi.item.SPOOL_OF_BENEDICT_YARN,    weight = xi.loot.weight.LOW       },
            { itemId = xi.item.SQUARE_OF_BROWN_DOESKIN,   weight = xi.loot.weight.LOW       },
            { itemId = xi.item.SQUARE_OF_CANVAS_TOILE,    weight = xi.loot.weight.LOW       },
        },

        {
            { itemId = xi.item.NONE,                      weight = xi.loot.weight.NORMAL },
            { itemId = xi.item.ANCIENT_BEASTCOIN,         weight = xi.loot.weight.NORMAL },
        },
    },

    [ID.SE_APOLLYON.npc.ITEM_CRATES[2]] =
    {
        {
            quantity = 5,
            { itemId = xi.item.ANCIENT_BEASTCOIN,         weight = xi.loot.weight.NORMAL },
        },

        {
            { itemId = xi.item.NONE,                      weight = xi.loot.weight.NORMAL },
            { itemId = xi.item.ANCIENT_BEASTCOIN,         weight = xi.loot.weight.NORMAL },
        },

        {
            { itemId = xi.item.ANCIENT_BRASS_INGOT,       weight = xi.loot.weight.NORMAL },
            { itemId = xi.item.SQUARE_OF_CARDINAL_CLOTH,  weight = xi.loot.weight.NORMAL },
            { itemId = xi.item.SQUARE_OF_BROWN_DOESKIN,   weight = xi.loot.weight.NORMAL },
            -- { itemId = xi.item.ELECTRUM_STUD,             weight = xi.loot.weight.NORMAL },
        },

        {
            { itemId = xi.item.NONE,                      weight = xi.loot.weight.VERY_HIGH },
            { itemId = xi.item.SQUARE_OF_CARDINAL_CLOTH,  weight = xi.loot.weight.LOW       },
            { itemId = xi.item.WHITE_RIVET,               weight = xi.loot.weight.LOW       },
            { itemId = xi.item.POT_OF_EBONY_LACQUER,      weight = xi.loot.weight.LOW       },
            { itemId = xi.item.SQUARE_OF_FLAMESHUN_CLOTH, weight = xi.loot.weight.LOW       },
        },

        {
            { itemId = xi.item.NONE,                      weight = xi.loot.weight.NORMAL },
            { itemId = xi.item.ANCIENT_BEASTCOIN,         weight = xi.loot.weight.NORMAL },
        },
    },

    [ID.SE_APOLLYON.npc.ITEM_CRATES[3]] =
    {
        {
            quantity = 5,
            { itemId = xi.item.ANCIENT_BEASTCOIN,         weight = xi.loot.weight.NORMAL },
        },

        {
            quantity = 2,
            { itemId = xi.item.NONE,                      weight = xi.loot.weight.NORMAL },
            { itemId = xi.item.ANCIENT_BEASTCOIN,         weight = xi.loot.weight.NORMAL },
        },

        {
            { itemId = xi.item.ARGYRO_RIVET,              weight = xi.loot.weight.NORMAL },
            { itemId = xi.item.SPOOL_OF_DIABOLIC_YARN,    weight = xi.loot.weight.NORMAL },
            { itemId = xi.item.SQUARE_OF_ASTRAL_LEATHER,  weight = xi.loot.weight.NORMAL },
            -- { itemId = xi.item.GOLD_STUD,                 weight = xi.loot.weight.NORMAL },
        },

        {
            { itemId = xi.item.NONE,                      weight = xi.loot.weight.VERY_HIGH },
            { itemId = xi.item.SPOOL_OF_LIGHT_FILAMENT,   weight = xi.loot.weight.LOW       },
            { itemId = xi.item.BLACK_RIVET,               weight = xi.loot.weight.LOW       },
            { itemId = xi.item.SQUARE_OF_CHARCOAL_COTTON, weight = xi.loot.weight.LOW       },
            { itemId = xi.item.SQUARE_OF_CORDUROY_CLOTH,  weight = xi.loot.weight.LOW       },
        },

        {
            { itemId = xi.item.NONE,                      weight = xi.loot.weight.VERY_HIGH },
            { itemId = xi.item.SPOOL_OF_DIABOLIC_YARN,    weight = xi.loot.weight.LOW       },
            { itemId = xi.item.FETID_LANOLIN_CUBE,        weight = xi.loot.weight.LOW       },
            { itemId = xi.item.BLUE_RIVET,                weight = xi.loot.weight.LOW       },
            -- { itemId = xi.item.ELECTRUM_STUD,             weight = xi.loot.weight.LOW       },
        },

        {
            quantity = 2,
            { itemId = xi.item.NONE,                      weight = xi.loot.weight.VERY_HIGH },
            { itemId = xi.item.CHUNK_OF_ADAMAN_ORE,       weight = xi.loot.weight.VERY_LOW  },
            { itemId = xi.item.HANDFUL_OF_CLOT_PLASMA,    weight = xi.loot.weight.VERY_LOW  },
            { itemId = xi.item.DARKSTEEL_SHEET,           weight = xi.loot.weight.VERY_LOW  },
            { itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE,    weight = xi.loot.weight.VERY_LOW  },
            { itemId = xi.item.PIECE_OF_OXBLOOD,          weight = xi.loot.weight.VERY_LOW  },
            { itemId = xi.item.LIGHT_STEEL_INGOT,         weight = xi.loot.weight.VERY_LOW  },
            { itemId = xi.item.SPOOL_OF_RAINBOW_THREAD,   weight = xi.loot.weight.VERY_LOW  },
            { itemId = xi.item.PONZE_OF_SHELL_POWDER,     weight = xi.loot.weight.VERY_LOW  },
        },
    },

    [ID.npc.SE_LOOT_CRATE] =
    {
        {
            quantity = 5,
            { itemId = xi.item.ANCIENT_BEASTCOIN,         weight = xi.loot.weight.NORMAL },
        },

        {
            { itemId = xi.item.SPOOL_OF_LIGHT_FILAMENT,   weight = xi.loot.weight.NORMAL },
            { itemId = xi.item.WHITE_RIVET,               weight = xi.loot.weight.NORMAL },
            { itemId = xi.item.BLUE_RIVET,                weight = xi.loot.weight.NORMAL },
            { itemId = xi.item.SQUARE_OF_CORDUROY_CLOTH,  weight = xi.loot.weight.NORMAL },
        },

        {
            { itemId = xi.item.BLACK_RIVET,               weight = xi.loot.weight.NORMAL },
            { itemId = xi.item.FETID_LANOLIN_CUBE,        weight = xi.loot.weight.NORMAL },
            { itemId = xi.item.SQUARE_OF_CHARCOAL_COTTON, weight = xi.loot.weight.NORMAL },
            { itemId = xi.item.SQUARE_OF_CANVAS_TOILE,    weight = xi.loot.weight.NORMAL },
        },

        {
            { itemId = xi.item.NONE,                      weight = xi.loot.weight.VERY_HIGH },
            { itemId = xi.item.ANCIENT_BRASS_INGOT,       weight = xi.loot.weight.LOW       },
            { itemId = xi.item.SHEET_OF_KUROGANE,         weight = xi.loot.weight.LOW       },
            { itemId = xi.item.SQUARE_OF_ASTRAL_LEATHER,  weight = xi.loot.weight.LOW       },
            -- { itemId = xi.item.GOLD_STUD,                 weight = xi.loot.weight.LOW       },
        },

        {
            { itemId = xi.item.SMALT_CHIP,                weight = xi.loot.weight.NORMAL },
        },

        {
            { itemId = xi.item.NONE,                      weight = xi.loot.weight.VERY_HIGH },
            { itemId = xi.item.METAL_CHIP,                weight = xi.loot.weight.VERY_LOW  },
        },
    },
}

return content:register()
