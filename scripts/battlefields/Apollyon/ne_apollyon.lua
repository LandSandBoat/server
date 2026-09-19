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
    requiredKeyItems = { xi.keyItem.COSMO_CLEANSE, xi.keyItem.BLACK_CARD, message = ID.text.YOU_INSERT_THE_CARD_POLISHED },
    lossEventParams  = { [5] = 1 },
    name             = 'NE_APOLLYON',
    lootCrateId      = ID.npc.NE_LOOT_CRATE,
    exitLocation     = 1,
    timeExtension    = 5,
})

-- Loot crate spawns when all dhalmel are dead or both manticores are dead, whichever happens first.
local function showLootCrate(battlefield)
    if battlefield:getLocalVar('lootCrateShown') == 0 then
        battlefield:setLocalVar('lootCrateShown', 1)
        npcUtil.showCrate(GetNPCByID(ID.npc.NE_LOOT_CRATE))
    end
end

-- If a Manticore dies while any Troglodyte Dhalmel is still alive, the surviving manticore gets 100% DA + 30% MDT.
local function empowerSurvivingManticore(deadMob)
    local survivorId = ID.mob.NE_CRIOSPHINX

    if deadMob:getID() == ID.mob.NE_CRIOSPHINX then
        survivorId = ID.mob.NE_HIERACOSPHINX
    end

    local survivor = GetMobByID(survivorId)

    if
        not survivor or
        not survivor:isAlive() or
        survivor:getLocalVar('empowered') == 1
    then
        return
    end

    local dhalmelAlive = false

    for offset = 0, 7 do
        local dhalmel = GetMobByID(ID.mob.NE_TROGLODYTE_DHALMEL_OFFSET + offset)

        if dhalmel and dhalmel:isAlive() then
            dhalmelAlive = true
            break
        end
    end

    if not dhalmelAlive then
        return
    end

    survivor:setLocalVar('empowered', 1)
    survivor:setMod(xi.mod.DOUBLE_ATTACK, 100)
    survivor:setMod(xi.mod.DMGMAGIC, -3000)
    survivor:injectActionPacket(survivor:getID(), 11, 432, 0, 24, 0, 603, 0)
end

function content:onBattlefieldInitialize(battlefield)
    Limbus.onBattlefieldInitialize(self, battlefield)

    for i, crateID in ipairs(ID.NE_APOLLYON.npc.TIME_CRATES) do
        npcUtil.showCrate(GetNPCByID(crateID))
    end

    for i, crateID in ipairs(ID.NE_APOLLYON.npc.RECOVER_CRATES) do
        npcUtil.showCrate(GetMobByID(crateID))
    end
end

function content:onBattlefieldRegister(player, battlefield)
    Limbus.onBattlefieldRegister(self, player, battlefield)

    -- Floor 3 scales with the size of the alliance that registered the battlefield.
    battlefield:setLocalVar('allianceSize', player:getAllianceSize())
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
        stationary = false,
    },

    -- Floor 2
    {
        mobs  = { 'Bialozar_Boss' },
        death = function(battlefield, mob, count)
            xi.limbus.spawnFrom(mob, ID.NE_APOLLYON.npc.ITEM_CRATES[2])
        end,
    },

    {
        mobs = { 'Sirin', 'Cornu' },
    },

    {
        -- Bialozar and Thiazi x2
        mobs        = { 'Bialozar', 'Thiazi' },
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
                mobIds     = {},
                stationary = false,
                setup      = function(battlefieldInner, cleanerMobs)
                    for _, cleanerMob in ipairs(cleanerMobs) do
                        cleanerMob:setModelSize(3)
                        cleanerMob:setHitboxSize(5.3)
                    end
                end,

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

            -- Scales based on the amount of the players
            local mobCount = utils.clamp(battlefield:getLocalVar('allianceSize') + 1, 5, 15)

            for offset = 0, mobCount - 1 do
                local mobId = ID.mob.NE_APOLLYON_SWEEPER_OFFSET + offset

                if offset % 5 == 0 then
                    table.insert(sweepers.mobIds, mobId)
                elseif offset % 5 == 1 then
                    table.insert(cleanersLarge.mobIds, mobId)
                else
                    table.insert(cleanersSmall.mobIds, mobId)
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
            showLootCrate(battlefield)
        end,
    },

    {
        mobs  = { 'Criosphinx', 'Hieracosphinx' },
        death = function(battlefield, mob, count)
            empowerSurvivingManticore(mob)
        end,

        allDeath = function(battlefield, mob)
            showLootCrate(battlefield)
        end,
    }
}

content.loot =
{
    [ID.NE_APOLLYON.npc.ITEM_CRATES[1]] =
    {
        {
            quantity = 2,
            { itemId = xi.item.ANCIENT_BEASTCOIN,         weight = 10000 },
        },

        {
            { itemId = xi.item.NONE,                      weight =  5000 },
            { itemId = xi.item.ANCIENT_BEASTCOIN,         weight =  5000 },
        },

        {
            { itemId = xi.item.NONE,                      weight =  3000 },
            { itemId = xi.item.ARGYRO_RIVET,              weight =  1000 }, -- WAR
            { itemId = xi.item.ANCIENT_BRASS_INGOT,       weight =  1000 }, -- MNK
            { itemId = xi.item.SPOOL_OF_BENEDICT_YARN,    weight =  1000 }, -- WHM
            { itemId = xi.item.SPOOL_OF_DIABOLIC_YARN,    weight =  1000 }, -- BLM
            { itemId = xi.item.SQUARE_OF_CARDINAL_CLOTH,  weight =  1000 }, -- RDM
            { itemId = xi.item.SPOOL_OF_LIGHT_FILAMENT,   weight =  1000 }, -- THF
            { itemId = xi.item.WHITE_RIVET,               weight =  1000 }, -- PLD
            { itemId = xi.item.BLACK_RIVET,               weight =  1000 }, -- DRK
            { itemId = xi.item.FETID_LANOLIN_CUBE,        weight =  1000 }, -- BST
         -- { itemId = xi.item.GOLD_STUD,                 weight =  1000 }, -- DNC
        },

        {
            { itemId = xi.item.NONE,                      weight =  3000 },
            { itemId = xi.item.SQUARE_OF_BROWN_DOESKIN,   weight =  1000 }, -- BRD
            { itemId = xi.item.SQUARE_OF_CHARCOAL_COTTON, weight =  1000 }, -- RNG
            { itemId = xi.item.SHEET_OF_KUROGANE,         weight =  1000 }, -- SAM
            { itemId = xi.item.POT_OF_EBONY_LACQUER,      weight =  1000 }, -- NIN
            { itemId = xi.item.BLUE_RIVET,                weight =  1000 }, -- DRG
            { itemId = xi.item.SQUARE_OF_ASTRAL_LEATHER,  weight =  1000 }, -- SMN
            { itemId = xi.item.SQUARE_OF_FLAMESHUN_CLOTH, weight =  1000 }, -- BLU
            { itemId = xi.item.SQUARE_OF_CANVAS_TOILE,    weight =  1000 }, -- COR
            { itemId = xi.item.SQUARE_OF_CORDUROY_CLOTH,  weight =  1000 }, -- PUP
         -- { itemId = xi.item.ELECTRUM_STUD,             weight =  1000 }, -- SCH
        },

        {
            { itemId = xi.item.NONE,                      weight =  5000 },
            { itemId = xi.item.ANCIENT_BEASTCOIN,         weight =  5000 },
        },
    },

    [ID.NE_APOLLYON.npc.ITEM_CRATES[2]] =
    {
        {
            quantity = 3,
            { itemId = xi.item.ANCIENT_BEASTCOIN,         weight = 10000 },
        },

        {
            { itemId = xi.item.NONE,                      weight =  5000 },
            { itemId = xi.item.ANCIENT_BEASTCOIN,         weight =  5000 },
        },

        {
            { itemId = xi.item.NONE,                      weight =  3000 },
            { itemId = xi.item.ARGYRO_RIVET,              weight =  1000 }, -- WAR
            { itemId = xi.item.ANCIENT_BRASS_INGOT,       weight =  1000 }, -- MNK
            { itemId = xi.item.SPOOL_OF_BENEDICT_YARN,    weight =  1000 }, -- WHM
            { itemId = xi.item.SPOOL_OF_DIABOLIC_YARN,    weight =  1000 }, -- BLM
            { itemId = xi.item.SQUARE_OF_CARDINAL_CLOTH,  weight =  1000 }, -- RDM
            { itemId = xi.item.SPOOL_OF_LIGHT_FILAMENT,   weight =  1000 }, -- THF
            { itemId = xi.item.WHITE_RIVET,               weight =  1000 }, -- PLD
            { itemId = xi.item.BLACK_RIVET,               weight =  1000 }, -- DRK
            { itemId = xi.item.FETID_LANOLIN_CUBE,        weight =  1000 }, -- BST
         -- { itemId = xi.item.GOLD_STUD,                 weight =  1000 }, -- DNC
        },

        {
            { itemId = xi.item.NONE,                      weight =  3000 },
            { itemId = xi.item.SQUARE_OF_BROWN_DOESKIN,   weight =  1000 }, -- BRD
            { itemId = xi.item.SQUARE_OF_CHARCOAL_COTTON, weight =  1000 }, -- RNG
            { itemId = xi.item.SHEET_OF_KUROGANE,         weight =  1000 }, -- SAM
            { itemId = xi.item.POT_OF_EBONY_LACQUER,      weight =  1000 }, -- NIN
            { itemId = xi.item.BLUE_RIVET,                weight =  1000 }, -- DRG
            { itemId = xi.item.SQUARE_OF_ASTRAL_LEATHER,  weight =  1000 }, -- SMN
            { itemId = xi.item.SQUARE_OF_FLAMESHUN_CLOTH, weight =  1000 }, -- BLU
            { itemId = xi.item.SQUARE_OF_CANVAS_TOILE,    weight =  1000 }, -- COR
            { itemId = xi.item.SQUARE_OF_CORDUROY_CLOTH,  weight =  1000 }, -- PUP
         -- { itemId = xi.item.ELECTRUM_STUD,             weight =  1000 }, -- SCH
        },

        {
            { itemId = xi.item.NONE,                      weight =  5000 },
            { itemId = xi.item.ANCIENT_BEASTCOIN,         weight =  5000 },
        },
    },

    [ID.NE_APOLLYON.npc.ITEM_CRATES[3]] =
    {
        {
            quantity = 4,
            { itemId = xi.item.ANCIENT_BEASTCOIN,         weight = 10000 },
        },

        {
            { itemId = xi.item.NONE,                      weight =  5000 },
            { itemId = xi.item.ANCIENT_BEASTCOIN,         weight =  5000 },
        },

        {
            { itemId = xi.item.NONE,                      weight =  3000 },
            { itemId = xi.item.ARGYRO_RIVET,              weight =  1000 }, -- WAR
            { itemId = xi.item.ANCIENT_BRASS_INGOT,       weight =  1000 }, -- MNK
            { itemId = xi.item.SPOOL_OF_BENEDICT_YARN,    weight =  1000 }, -- WHM
            { itemId = xi.item.SPOOL_OF_DIABOLIC_YARN,    weight =  1000 }, -- BLM
            { itemId = xi.item.SQUARE_OF_CARDINAL_CLOTH,  weight =  1000 }, -- RDM
            { itemId = xi.item.SPOOL_OF_LIGHT_FILAMENT,   weight =  1000 }, -- THF
            { itemId = xi.item.WHITE_RIVET,               weight =  1000 }, -- PLD
            { itemId = xi.item.BLACK_RIVET,               weight =  1000 }, -- DRK
            { itemId = xi.item.FETID_LANOLIN_CUBE,        weight =  1000 }, -- BST
         -- { itemId = xi.item.GOLD_STUD,                 weight =  1000 }, -- DNC
        },

        {
            { itemId = xi.item.NONE,                      weight =  3000 },
            { itemId = xi.item.SQUARE_OF_BROWN_DOESKIN,   weight =  1000 }, -- BRD
            { itemId = xi.item.SQUARE_OF_CHARCOAL_COTTON, weight =  1000 }, -- RNG
            { itemId = xi.item.SHEET_OF_KUROGANE,         weight =  1000 }, -- SAM
            { itemId = xi.item.POT_OF_EBONY_LACQUER,      weight =  1000 }, -- NIN
            { itemId = xi.item.BLUE_RIVET,                weight =  1000 }, -- DRG
            { itemId = xi.item.SQUARE_OF_ASTRAL_LEATHER,  weight =  1000 }, -- SMN
            { itemId = xi.item.SQUARE_OF_FLAMESHUN_CLOTH, weight =  1000 }, -- BLU
            { itemId = xi.item.SQUARE_OF_CANVAS_TOILE,    weight =  1000 }, -- COR
            { itemId = xi.item.SQUARE_OF_CORDUROY_CLOTH,  weight =  1000 }, -- PUP
         -- { itemId = xi.item.ELECTRUM_STUD,             weight =  1000 }, -- SCH
        },

        {
            quantity = 2,
            { itemId = xi.item.NONE,                      weight = 10000 },
            { itemId = xi.item.CHUNK_OF_ADAMAN_ORE,       weight =  1000 },
            { itemId = xi.item.HANDFUL_OF_CLOT_PLASMA,    weight =  1000 },
            { itemId = xi.item.DARKSTEEL_SHEET,           weight =  1000 },
            { itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE,    weight =  1000 },
            { itemId = xi.item.PIECE_OF_OXBLOOD,          weight =  1000 },
            { itemId = xi.item.LIGHT_STEEL_INGOT,         weight =  1000 },
            { itemId = xi.item.SPOOL_OF_RAINBOW_THREAD,   weight =  1000 },
            { itemId = xi.item.PONZE_OF_SHELL_POWDER,     weight =  1000 },
        },
    },

    [ID.NE_APOLLYON.npc.ITEM_CRATES[4]] =
    {
        {
            quantity = 5,
            { itemId = xi.item.ANCIENT_BEASTCOIN,         weight = 10000 },
        },

        {
            quantity = 2,
            { itemId = xi.item.NONE,                      weight =  5000 },
            { itemId = xi.item.ANCIENT_BEASTCOIN,         weight =  5000 },
        },

        {
            { itemId = xi.item.NONE,                      weight =  3000 },
            { itemId = xi.item.ARGYRO_RIVET,              weight =  1000 }, -- WAR
            { itemId = xi.item.ANCIENT_BRASS_INGOT,       weight =  1000 }, -- MNK
            { itemId = xi.item.SPOOL_OF_BENEDICT_YARN,    weight =  1000 }, -- WHM
            { itemId = xi.item.SPOOL_OF_DIABOLIC_YARN,    weight =  1000 }, -- BLM
            { itemId = xi.item.SQUARE_OF_CARDINAL_CLOTH,  weight =  1000 }, -- RDM
            { itemId = xi.item.SPOOL_OF_LIGHT_FILAMENT,   weight =  1000 }, -- THF
            { itemId = xi.item.WHITE_RIVET,               weight =  1000 }, -- PLD
            { itemId = xi.item.BLACK_RIVET,               weight =  1000 }, -- DRK
            { itemId = xi.item.FETID_LANOLIN_CUBE,        weight =  1000 }, -- BST
         -- { itemId = xi.item.GOLD_STUD,                 weight =  1000 }, -- DNC
        },

        {
            { itemId = xi.item.NONE,                      weight =  3000 },
            { itemId = xi.item.SQUARE_OF_BROWN_DOESKIN,   weight =  1000 }, -- BRD
            { itemId = xi.item.SQUARE_OF_CHARCOAL_COTTON, weight =  1000 }, -- RNG
            { itemId = xi.item.SHEET_OF_KUROGANE,         weight =  1000 }, -- SAM
            { itemId = xi.item.POT_OF_EBONY_LACQUER,      weight =  1000 }, -- NIN
            { itemId = xi.item.BLUE_RIVET,                weight =  1000 }, -- DRG
            { itemId = xi.item.SQUARE_OF_ASTRAL_LEATHER,  weight =  1000 }, -- SMN
            { itemId = xi.item.SQUARE_OF_FLAMESHUN_CLOTH, weight =  1000 }, -- BLU
            { itemId = xi.item.SQUARE_OF_CANVAS_TOILE,    weight =  1000 }, -- COR
            { itemId = xi.item.SQUARE_OF_CORDUROY_CLOTH,  weight =  1000 }, -- PUP
         -- { itemId = xi.item.ELECTRUM_STUD,             weight =  1000 }, -- SCH
        },
    },

    [ID.npc.NE_LOOT_CRATE] =
    {
        {
            quantity = 6,
            { itemId = xi.item.ANCIENT_BEASTCOIN,         weight = 10000 },
        },

        {
            { itemId = xi.item.NONE,                      weight =  3000 },
            { itemId = xi.item.ARGYRO_RIVET,              weight =  1000 }, -- WAR
            { itemId = xi.item.ANCIENT_BRASS_INGOT,       weight =  1000 }, -- MNK
            { itemId = xi.item.SPOOL_OF_BENEDICT_YARN,    weight =  1000 }, -- WHM
            { itemId = xi.item.SPOOL_OF_DIABOLIC_YARN,    weight =  1000 }, -- BLM
            { itemId = xi.item.SQUARE_OF_CARDINAL_CLOTH,  weight =  1000 }, -- RDM
            { itemId = xi.item.SPOOL_OF_LIGHT_FILAMENT,   weight =  1000 }, -- THF
            { itemId = xi.item.WHITE_RIVET,               weight =  1000 }, -- PLD
            { itemId = xi.item.BLACK_RIVET,               weight =  1000 }, -- DRK
            { itemId = xi.item.FETID_LANOLIN_CUBE,        weight =  1000 }, -- BST
         -- { itemId = xi.item.GOLD_STUD,                 weight =  1000 }, -- DNC
        },

        {
            { itemId = xi.item.NONE,                      weight =  3000 },
            { itemId = xi.item.SQUARE_OF_BROWN_DOESKIN,   weight =  1000 }, -- BRD
            { itemId = xi.item.SQUARE_OF_CHARCOAL_COTTON, weight =  1000 }, -- RNG
            { itemId = xi.item.SHEET_OF_KUROGANE,         weight =  1000 }, -- SAM
            { itemId = xi.item.POT_OF_EBONY_LACQUER,      weight =  1000 }, -- NIN
            { itemId = xi.item.BLUE_RIVET,                weight =  1000 }, -- DRG
            { itemId = xi.item.SQUARE_OF_ASTRAL_LEATHER,  weight =  1000 }, -- SMN
            { itemId = xi.item.SQUARE_OF_FLAMESHUN_CLOTH, weight =  1000 }, -- BLU
            { itemId = xi.item.SQUARE_OF_CANVAS_TOILE,    weight =  1000 }, -- COR
            { itemId = xi.item.SQUARE_OF_CORDUROY_CLOTH,  weight =  1000 }, -- PUP
         -- { itemId = xi.item.ELECTRUM_STUD,             weight =  1000 }, -- SCH
        },

        {
            { itemId = xi.item.SMOKY_CHIP,                weight = 10000 },
        },

        {
            { itemId = xi.item.NONE,                      weight = 10000 },
            { itemId = xi.item.METAL_CHIP,                weight =  1000 },
        },
    },
}

return content:register()
