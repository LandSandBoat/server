-----------------------------------
-- Area: Apollyon
-- Name: NE Apollyon
-- !addkeyitem black_card
-- !addkeyitem cosmo_cleanse
-- !pos 600 -0.5 -600 38
-----------------------------------
local ID = zones[xi.zone.APOLLYON]
-----------------------------------

local content = Limbus:new({
    zoneId           = xi.zone.APOLLYON,
    battlefieldId    = xi.battlefield.id.NE_APOLLYON,
    maxPlayers       = 18,
    timeLimit        = utils.minutes(30),
    index            = 3,
    area             = 4,
    entryNpc         = '_12i',
    requiredKeyItems = { xi.ki.COSMO_CLEANSE, xi.ki.BLACK_CARD, message = ID.text.YOU_INSERT_THE_CARD_POLISHED },
    lossEventParams  = { [5] = 1 },
    name             = 'NE_APOLLYON',
    lootCrateId      = ID.npc.NE_LOOT_CRATE,
    exitLocation     = 1,
    timeExtension    = 5,
})

function content:onBattlefieldInitialize(battlefield)
    Limbus.onBattlefieldInitialize(self, battlefield)

    for i, crateID in ipairs(ID.NE_APOLLYON.npc.TIME_CRATES) do
        npcUtil.showCrate(GetNPCByID(crateID))
    end

    for i, crateID in ipairs(ID.NE_APOLLYON.npc.RECOVER_CRATES) do
        npcUtil.showCrate(GetMobByID(crateID))
    end
end

content.paths =
{
    [ID.mob.NE_GOOBBUE_HARVESTER] =
    {
        { x = 425.0, y = 0.0, z = 22.0, wait = 1000 },
        { x = 475.0, y = 0.0, z = 22.0, wait = 1000 },
    },

    [ID.mob.NE_TROGLODYTE_DHALMEL_OFFSET] =
    {
        { x = 525.0, y = -0.5, z = 315.0 },
        { x = 550.0, y = -0.5, z = 310.0 },
        { x = 580.0, y = -0.5, z = 300.0 },
        { x = 588.0, y = -0.5, z = 285.0 },
        { x = 580.0, y = -0.5, z = 300.0 },
        { x = 550.0, y = -0.5, z = 310.0 },
    },

    [ID.mob.NE_TROGLODYTE_DHALMEL_OFFSET + 1] =
    {
        { x = 550.0, y = -0.5, z = 310.0 },
        { x = 580.0, y = -0.5, z = 300.0 },
        { x = 588.0, y = -0.5, z = 285.0 },
        { x = 585.0, y = -0.5, z = 265.0 },
        { x = 588.0, y = -0.5, z = 285.0 },
        { x = 580.0, y = -0.5, z = 300.0 },
    },

    [ID.mob.NE_TROGLODYTE_DHALMEL_OFFSET + 2] =
    {
        { x = 580.0, y = -0.5, z = 300.0 },
        { x = 588.0, y = -0.5, z = 285.0 },
        { x = 585.0, y = -0.5, z = 265.0 },
        { x = 565.0, y = -0.5, z = 250.0 },
        { x = 585.0, y = -0.5, z = 265.0 },
        { x = 588.0, y = -0.5, z = 285.0 },
    },

    [ID.mob.NE_TROGLODYTE_DHALMEL_OFFSET + 3] =
    {
        { x = 588.0, y = -0.5, z = 285.0 },
        { x = 585.0, y = -0.5, z = 265.0 },
        { x = 565.0, y = -0.5, z = 250.0 },
        { x = 540.0, y = -0.5, z = 260.0 },
        { x = 565.0, y = -0.5, z = 250.0 },
        { x = 585.0, y = -0.5, z = 265.0 },
    },

    [ID.mob.NE_TROGLODYTE_DHALMEL_OFFSET + 4] =
    {
        { x = 585.0, y = -0.5, z = 265.0 },
        { x = 565.0, y = -0.5, z = 250.0 },
        { x = 540.0, y = -0.5, z = 260.0 },
        { x = 530.0, y = -0.5, z = 280.0 },
        { x = 540.0, y = -0.5, z = 260.0 },
        { x = 565.0, y = -0.5, z = 250.0 },
    },

    [ID.mob.NE_TROGLODYTE_DHALMEL_OFFSET + 5] =
    {
        { x = 565.0, y = -0.5, z = 250.0 },
        { x = 540.0, y = -0.5, z = 260.0 },
        { x = 530.0, y = -0.5, z = 280.0 },
        { x = 525.0, y = -0.5, z = 315.0 },
        { x = 530.0, y = -0.5, z = 280.0 },
        { x = 540.0, y = -0.5, z = 260.0 },
    },

    [ID.mob.NE_TROGLODYTE_DHALMEL_OFFSET + 6] =
    {
        { x = 540.0, y = -0.5, z = 260.0 },
        { x = 530.0, y = -0.5, z = 280.0 },
        { x = 525.0, y = -0.5, z = 315.0 },
        { x = 550.0, y = -0.5, z = 310.0 },
        { x = 525.0, y = -0.5, z = 315.0 },
        { x = 530.0, y = -0.5, z = 280.0 },
    },

    [ID.mob.NE_TROGLODYTE_DHALMEL_OFFSET + 7] =
    {
        { x = 530.0, y = -0.5, z = 280.0 },
        { x = 525.0, y = -0.5, z = 315.0 },
        { x = 550.0, y = -0.5, z = 310.0 },
        { x = 580.0, y = -0.5, z = 300.0 },
        { x = 550.0, y = -0.5, z = 310.0 },
        { x = 525.0, y = -0.5, z = 315.0 },
    },

}

content.groups =
{
    -- Floor 1
    {
        mobs       = { 'Barometz_Boss', 'Borametz_Boss', 'Goobbue_Harvester' },
        stationary = false,
        setup      = function(battlefield, mobs)
            local bosses = utils.shuffle(mobs)
            bosses[1]:setLocalVar('item', 1)
            bosses[2]:setLocalVar('vortex', 1)
        end,

        death = function(battlefield, mob, count)
            if mob:getLocalVar('item') == 1 then
                xi.limbus.spawnFrom(mob, ID.NE_APOLLYON.npc.ITEM_CRATES[1])
            elseif mob:getLocalVar('vortex') == 1 then
                content:openDoor(battlefield, 1)
            end
        end,
    },

    {
        mobs       = { 'Barometz', 'Borametz', 'Barometz_Boss', 'Borametz_Boss' },
        mobMods    = { [xi.mobMod.ALLI_HATE] = 50 },
        stationary = false,
    },

    -- Floor 2
    {
        mobs    = { 'Bialozar_Boss' },
        mobMods = { [xi.mobMod.DETECTION] = xi.detects.HEARING },
        death   = function(battlefield, mob, count)
            xi.limbus.spawnFrom(mob, ID.NE_APOLLYON.npc.ITEM_CRATES[2])
        end,
    },

    {
        mobs = { 'Sirin', 'Cornu' },
    },

    {
        -- Bialozar and Thiazi x2
        mobs        = { 'Bialozar', 'Thiazi' },
        mobMods     = { [xi.mobMod.DETECTION] = xi.detects.HEARING },
        randomDeath = function(battlefield, mob)
            content:openDoor(battlefield, 2)

            -- Determine which mobs should be in floor three and add their group
            local sweepers =
            {
                mobIds      = {},
                randomDeath = function(battlefieldInner, sweeperMob)
                    content:openDoor(battlefieldInner, 3)
                end,
            }

            local cleanersLarge =
            {
                mobIds = {},
                stationary = false,

                randomDeath = function(battlefieldInner, cleanerMob)
                    xi.limbus.spawnFrom(cleanerMob, ID.NE_APOLLYON.npc.ITEM_CRATES[3])
                end,
            }

            local cleanersSmall =
            {
                -- Apollyon Cleaners (Small)
                mobIds     = {},
                stationary = false,
            }

            -- Every 6 players we add another group of mobs (1 Sweeper and 4 Cleaners)
            table.insert(sweepers.mobIds, ID.mob.NE_APOLLYON_SWEEPER_OFFSET)
            table.insert(cleanersLarge.mobIds, ID.mob.NE_APOLLYON_SWEEPER_OFFSET + 1)
            table.insert(cleanersSmall.mobIds, ID.mob.NE_APOLLYON_SWEEPER_OFFSET + 2)
            table.insert(cleanersSmall.mobIds, ID.mob.NE_APOLLYON_SWEEPER_OFFSET + 3)
            table.insert(cleanersSmall.mobIds, ID.mob.NE_APOLLYON_SWEEPER_OFFSET + 4)

            local playerCount = #battlefield:getPlayers()

            if playerCount > 6 then
                table.insert(sweepers.mobIds, ID.mob.NE_APOLLYON_SWEEPER_OFFSET + 5)
                table.insert(cleanersLarge.mobIds, ID.mob.NE_APOLLYON_SWEEPER_OFFSET + 6)
                table.insert(cleanersSmall.mobIds, ID.mob.NE_APOLLYON_SWEEPER_OFFSET + 7)
                table.insert(cleanersSmall.mobIds, ID.mob.NE_APOLLYON_SWEEPER_OFFSET + 8)
                table.insert(cleanersSmall.mobIds, ID.mob.NE_APOLLYON_SWEEPER_OFFSET + 9)

                if playerCount > 12 then
                    table.insert(sweepers.mobIds, ID.mob.NE_APOLLYON_SWEEPER_OFFSET + 10)
                    table.insert(cleanersLarge.mobIds, ID.mob.NE_APOLLYON_SWEEPER_OFFSET + 11)
                    table.insert(cleanersSmall.mobIds, ID.mob.NE_APOLLYON_SWEEPER_OFFSET + 12)
                    table.insert(cleanersSmall.mobIds, ID.mob.NE_APOLLYON_SWEEPER_OFFSET + 13)
                    table.insert(cleanersSmall.mobIds, ID.mob.NE_APOLLYON_SWEEPER_OFFSET + 14)
                end
            end

            battlefield:addGroups({ sweepers, cleanersLarge, cleanersSmall }, false)
        end,
    },

    -- Floor 3
    -- These mobs are added in the above group when the floor door opens

    -- Floor 4
    {
        mobs        = { 'Hyperion', 'Okeanos', 'Cronos' },
        stationary  = false,
        randomDeath = function(battlefield, mob)
            content:openDoor(mob:getBattlefield(), 4)
        end,
    },

    {
        mobs = { 'Hyperion' },
        mods = { [xi.mod.NULL_MAGICAL_DAMAGE] = 100 },
    },

    {
        mobs = { 'Okeanos' },
        mods = { [xi.mod.NULL_RANGED_DAMAGE] = 100 },
    },

    {
        mobs = { 'Cronos' },
        mods = { [xi.mod.NULL_PHYSICAL_DAMAGE] = 100 },
    },

    {
        mobs       = { 'Kerkopes_Boss' },
        stationary = false,
        death      = function(battlefield, mob, count)
            xi.limbus.spawnFrom(mob, ID.NE_APOLLYON.npc.ITEM_CRATES[4])
        end,
    },

    {
        mobs       = { 'Kerkopes' },
        stationary = false,
    },

    -- Floor 5
    {
        mobs     = { 'Troglodyte_Dhalmel' },
        allDeath = function(battlefield, mob)
            npcUtil.showCrate(GetNPCByID(ID.npc.NE_LOOT_CRATE))
        end,
    },

    {
        mobs = { 'Criosphinx', 'Hieracosphinx' },
        mods =
        {
            [xi.mod.GRAVITY_MEVA] = 75,
            [xi.mod.BIND_MEVA   ] = 75,
            [xi.mod.SLEEP_MEVA  ] = 75,
        },
    }
}

content.loot =
{
    [ID.NE_APOLLYON.npc.ITEM_CRATES[1]] =
    {
        {
            quantity = 2,
            { item = xi.item.ANCIENT_BEASTCOIN, weight = xi.loot.weight.NORMAL },
        },

        {
            { item = xi.item.NONE,              weight = xi.loot.weight.NORMAL },
            { item = xi.item.ANCIENT_BEASTCOIN, weight = xi.loot.weight.NORMAL },
        },

        {
            { item = xi.item.SQUARE_OF_CARDINAL_CLOTH,  weight = xi.loot.weight.NORMAL },
            { item = xi.item.SQUARE_OF_CHARCOAL_COTTON, weight = xi.loot.weight.NORMAL },
            { item = xi.item.SQUARE_OF_ASTRAL_LEATHER,  weight = xi.loot.weight.NORMAL },
            { item = xi.item.GOLD_STUD,                 weight = xi.loot.weight.NORMAL },
        },

        {
            { item = xi.item.NONE,               weight = xi.loot.weight.VERY_HIGH },
            { item = xi.item.BLACK_RIVET,        weight = xi.loot.weight.LOW       },
            { item = xi.item.FETID_LANOLIN_CUBE, weight = xi.loot.weight.LOW       },
            { item = xi.item.SHEET_OF_KUROGANE,  weight = xi.loot.weight.LOW       },
            { item = xi.item.ELECTRUM_STUD,      weight = xi.loot.weight.LOW       },
        },

        {
            { item = xi.item.NONE,              weight = xi.loot.weight.NORMAL },
            { item = xi.item.ANCIENT_BEASTCOIN, weight = xi.loot.weight.NORMAL },
        },
    },

    [ID.NE_APOLLYON.npc.ITEM_CRATES[2]] =
    {
        {
            quantity = 3,
            { item = xi.item.ANCIENT_BEASTCOIN, weight = xi.loot.weight.NORMAL },
        },

        {
            { item = xi.item.NONE,              weight = xi.loot.weight.NORMAL },
            { item = xi.item.ANCIENT_BEASTCOIN, weight = xi.loot.weight.NORMAL },
        },

        {
            { item = xi.item.ARGYRO_RIVET,              weight = xi.loot.weight.NORMAL },
            { item = xi.item.FETID_LANOLIN_CUBE,        weight = xi.loot.weight.NORMAL },
            { item = xi.item.SHEET_OF_KUROGANE,         weight = xi.loot.weight.NORMAL },
            { item = xi.item.SQUARE_OF_FLAMESHUN_CLOTH, weight = xi.loot.weight.NORMAL },
        },

        {
            { item = xi.item.NONE,                      weight = xi.loot.weight.VERY_HIGH },
            { item = xi.item.ANCIENT_BRASS_INGOT,       weight = xi.loot.weight.LOW       },
            { item = xi.item.SQUARE_OF_CHARCOAL_COTTON, weight = xi.loot.weight.LOW       },
            { item = xi.item.SQUARE_OF_BROWN_DOESKIN,   weight = xi.loot.weight.LOW       },
            { item = xi.item.SQUARE_OF_CANVAS_TOILE,    weight = xi.loot.weight.LOW       },
        },

        {
            { item = xi.item.NONE,              weight = xi.loot.weight.NORMAL },
            { item = xi.item.ANCIENT_BEASTCOIN, weight = xi.loot.weight.NORMAL },
        },
    },

    [ID.NE_APOLLYON.npc.ITEM_CRATES[3]] =
    {
        {
            quantity = 4,
            { item = xi.item.ANCIENT_BEASTCOIN, weight = xi.loot.weight.NORMAL },
        },

        {
            { item = xi.item.NONE,              weight = xi.loot.weight.NORMAL },
            { item = xi.item.ANCIENT_BEASTCOIN, weight = xi.loot.weight.NORMAL },
        },

        {
            { item = xi.item.SPOOL_OF_BENEDICT_YARN,  weight = xi.loot.weight.NORMAL },
            { item = xi.item.SPOOL_OF_LIGHT_FILAMENT, weight = xi.loot.weight.NORMAL },
            { item = xi.item.BLUE_RIVET,              weight = xi.loot.weight.NORMAL },
            { item = xi.item.ELECTRUM_STUD,           weight = xi.loot.weight.NORMAL },
        },

        {
            { item = xi.item.NONE,                     weight = xi.loot.weight.VERY_HIGH },
            { item = xi.item.SQUARE_OF_CARDINAL_CLOTH, weight = xi.loot.weight.LOW       },
            { item = xi.item.WHITE_RIVET,              weight = xi.loot.weight.LOW       },
            { item = xi.item.SQUARE_OF_ASTRAL_LEATHER, weight = xi.loot.weight.LOW       },
            { item = xi.item.SQUARE_OF_CORDUROY_CLOTH, weight = xi.loot.weight.LOW       },
        },

        {
            quantity = 2,
            { item = xi.item.NONE,                    weight = xi.loot.weight.VERY_HIGH },
            { item = xi.item.CHUNK_OF_ADAMAN_ORE,     weight = xi.loot.weight.VERY_LOW  },
            { item = xi.item.HANDFUL_OF_CLOT_PLASMA,  weight = xi.loot.weight.VERY_LOW  },
            { item = xi.item.DARKSTEEL_SHEET,         weight = xi.loot.weight.VERY_LOW  },
            { item = xi.item.CHUNK_OF_DARKSTEEL_ORE,  weight = xi.loot.weight.VERY_LOW  },
            { item = xi.item.PIECE_OF_OXBLOOD,        weight = xi.loot.weight.VERY_LOW  },
            { item = xi.item.LIGHT_STEEL_INGOT,       weight = xi.loot.weight.VERY_LOW  },
            { item = xi.item.SPOOL_OF_RAINBOW_THREAD, weight = xi.loot.weight.VERY_LOW  },
            { item = xi.item.PONZE_OF_SHELL_POWDER,   weight = xi.loot.weight.VERY_LOW  },
        },
    },

    [ID.NE_APOLLYON.npc.ITEM_CRATES[4]] =
    {
        {
            quantity = 5,
            { item = xi.item.ANCIENT_BEASTCOIN, weight = xi.loot.weight.NORMAL },
        },

        {
            quantity = 2,
            { item = xi.item.NONE,              weight = xi.loot.weight.NORMAL },
            { item = xi.item.ANCIENT_BEASTCOIN, weight = xi.loot.weight.NORMAL },
        },

        {
            { item = xi.item.SPOOL_OF_DIABOLIC_YARN,   weight = xi.loot.weight.NORMAL },
            { item = xi.item.BLACK_RIVET,              weight = xi.loot.weight.NORMAL },
            { item = xi.item.POT_OF_EBONY_LACQUER,     weight = xi.loot.weight.NORMAL },
            { item = xi.item.SQUARE_OF_CORDUROY_CLOTH, weight = xi.loot.weight.NORMAL },
        },

        {
            { item = xi.item.NONE,                    weight = xi.loot.weight.VERY_HIGH },
            { item = xi.item.ARGYRO_RIVET,            weight = xi.loot.weight.LOW       },
            { item = xi.item.SPOOL_OF_LIGHT_FILAMENT, weight = xi.loot.weight.LOW       },
            { item = xi.item.BLUE_RIVET,              weight = xi.loot.weight.LOW       },
            { item = xi.item.GOLD_STUD,               weight = xi.loot.weight.LOW       },
        },
    },

    [ID.npc.NE_LOOT_CRATE] =
    {
        {
            quantity = 6,
            { item = xi.item.ANCIENT_BEASTCOIN, weight = xi.loot.weight.NORMAL },
        },

        {
            { item = xi.item.ANCIENT_BRASS_INGOT,     weight = xi.loot.weight.NORMAL },
            { item = xi.item.WHITE_RIVET,             weight = xi.loot.weight.NORMAL },
            { item = xi.item.SQUARE_OF_BROWN_DOESKIN, weight = xi.loot.weight.NORMAL },
            { item = xi.item.SQUARE_OF_CANVAS_TOILE,  weight = xi.loot.weight.NORMAL },
        },

        {
            { item = xi.item.NONE,                      weight = xi.loot.weight.VERY_HIGH },
            { item = xi.item.SPOOL_OF_BENEDICT_YARN,    weight = xi.loot.weight.LOW       },
            { item = xi.item.SPOOL_OF_DIABOLIC_YARN,    weight = xi.loot.weight.LOW       },
            { item = xi.item.POT_OF_EBONY_LACQUER,      weight = xi.loot.weight.LOW       },
            { item = xi.item.SQUARE_OF_FLAMESHUN_CLOTH, weight = xi.loot.weight.LOW       },
        },

        {
            { item = xi.item.SMOKY_CHIP, weight = xi.loot.weight.NORMAL },
        },

        {
            { item = xi.item.NONE,       weight = xi.loot.weight.VERY_HIGH },
            { item = xi.item.METAL_CHIP, weight = xi.loot.weight.VERY_LOW  },
        },
    },
}

return content:register()
