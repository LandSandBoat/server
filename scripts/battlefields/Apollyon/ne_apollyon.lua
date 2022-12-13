-----------------------------------
-- Area: Apollyon
-- Name: NE Apollyon
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
    battlefieldId    = xi.battlefield.id.NE_APOLLYON,
    maxPlayers       = 18,
    timeLimit        = utils.minutes(30),
    index            = 3,
    area             = 4,
    entryNpc         = '_12i',
    requiredKeyItems = { xi.ki.COSMO_CLEANSE, xi.ki.BLACK_CARD, message = ID.text.YOU_INSERT_THE_CARD_POLISHED },
    lossEventParams  = { [5] = 1 },
    name             = "NE_APOLLYON",
    exitLocation     = 1,
    timeExtension   = 5,
})

function content:onBattlefieldInitialise(battlefield)
    Limbus.onBattlefieldInitialise(self, battlefield)

    for i, crateID in ipairs(ID.NE_APOLLYON.npc.TIME_CRATES) do
        npcUtil.showCrate(GetNPCByID(crateID))
    end

    for i, crateID in ipairs(ID.NE_APOLLYON.npc.RECOVER_CRATES) do
        npcUtil.showCrate(GetMobByID(crateID))
    end
end

content.paths =
{
    [ID.NE_APOLLYON.mob.GOOBBUE_HARVESTER] =
    {
        { x = 425.0, y = 0.0, z = 22.0, wait = 1000 },
        { x = 475.0, y = 0.0, z = 22.0, wait = 1000 },
    },

    [ID.NE_APOLLYON.mob.TROGLODYTE_DHALMEL[1]] =
    {
        { x = 525.0, y = -0.5, z = 315.0 },
        { x = 550.0, y = -0.5, z = 310.0 },
        { x = 580.0, y = -0.5, z = 300.0 },
        { x = 588.0, y = -0.5, z = 285.0 },
        { x = 580.0, y = -0.5, z = 300.0 },
        { x = 550.0, y = -0.5, z = 310.0 },
    },

    [ID.NE_APOLLYON.mob.TROGLODYTE_DHALMEL[2]] =
    {
        { x = 550.0, y = -0.5, z = 310.0 },
        { x = 580.0, y = -0.5, z = 300.0 },
        { x = 588.0, y = -0.5, z = 285.0 },
        { x = 585.0, y = -0.5, z = 265.0 },
        { x = 588.0, y = -0.5, z = 285.0 },
        { x = 580.0, y = -0.5, z = 300.0 },
    },

    [ID.NE_APOLLYON.mob.TROGLODYTE_DHALMEL[3]] =
    {
        { x = 580.0, y = -0.5, z = 300.0 },
        { x = 588.0, y = -0.5, z = 285.0 },
        { x = 585.0, y = -0.5, z = 265.0 },
        { x = 565.0, y = -0.5, z = 250.0 },
        { x = 585.0, y = -0.5, z = 265.0 },
        { x = 588.0, y = -0.5, z = 285.0 },
    },

    [ID.NE_APOLLYON.mob.TROGLODYTE_DHALMEL[4]] =
    {
        { x = 588.0, y = -0.5, z = 285.0 },
        { x = 585.0, y = -0.5, z = 265.0 },
        { x = 565.0, y = -0.5, z = 250.0 },
        { x = 540.0, y = -0.5, z = 260.0 },
        { x = 565.0, y = -0.5, z = 250.0 },
        { x = 585.0, y = -0.5, z = 265.0 },
    },

    [ID.NE_APOLLYON.mob.TROGLODYTE_DHALMEL[5]] =
    {
        { x = 585.0, y = -0.5, z = 265.0 },
        { x = 565.0, y = -0.5, z = 250.0 },
        { x = 540.0, y = -0.5, z = 260.0 },
        { x = 530.0, y = -0.5, z = 280.0 },
        { x = 540.0, y = -0.5, z = 260.0 },
        { x = 565.0, y = -0.5, z = 250.0 },
    },

    [ID.NE_APOLLYON.mob.TROGLODYTE_DHALMEL[6]] =
    {
        { x = 565.0, y = -0.5, z = 250.0 },
        { x = 540.0, y = -0.5, z = 260.0 },
        { x = 530.0, y = -0.5, z = 280.0 },
        { x = 525.0, y = -0.5, z = 315.0 },
        { x = 530.0, y = -0.5, z = 280.0 },
        { x = 540.0, y = -0.5, z = 260.0 },
    },

    [ID.NE_APOLLYON.mob.TROGLODYTE_DHALMEL[7]] =
    {
        { x = 540.0, y = -0.5, z = 260.0 },
        { x = 530.0, y = -0.5, z = 280.0 },
        { x = 525.0, y = -0.5, z = 315.0 },
        { x = 550.0, y = -0.5, z = 310.0 },
        { x = 525.0, y = -0.5, z = 315.0 },
        { x = 530.0, y = -0.5, z = 280.0 },
    },

    [ID.NE_APOLLYON.mob.TROGLODYTE_DHALMEL[8]] =
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
        mobs = { "Barometz_Boss", "Borametz_Boss", "Goobbue_Harvester" },
        stationary = false,
        setup = function(battlefield, mobs)
            local bosses = utils.shuffle(mobs)
            bosses[1]:setLocalVar("item", 1)
            bosses[2]:setLocalVar("vortex", 1)
        end,

        death = function(battlefield, mob, count)
            if mob:getLocalVar("item") == 1 then
                xi.limbus.spawnFrom(mob, ID.NE_APOLLYON.npc.ITEM_CRATES[1])
            elseif mob:getLocalVar("vortex") == 1 then
                content:openDoor(battlefield, 1)
            end
        end,
    },

    {
        mobs = { "Barometz", "Borametz", "Barometz_Boss", "Borametz_Boss" },
        mobMods = { [xi.mobMod.ALLI_HATE] = 50 },
        stationary = false,
    },

    -- Floor 2
    {
        mobs = { "Bialozar_Boss" },
        mobMods = { [xi.mobMod.DETECTION] = xi.detects.HEARING },
        death = function(battlefield, mob, count)
            xi.limbus.spawnFrom(mob, ID.NE_APOLLYON.npc.ITEM_CRATES[2])
        end,
    },

    {
        mobs = { "Sirin", "Cornu" },
    },

    {
        -- Bialozar and Thiazi x2
        mobs = { "Bialozar", "Thiazi" },
        mobMods = { [xi.mobMod.DETECTION] = xi.detects.HEARING },
        randomDeath = function(battlefield, mob)
            content:openDoor(battlefield, 2)

            -- Determine which mobs should be in floor three and add their group
            local sweepers =
            {
                mobIds = {},
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
                mobIds = {},
                stationary = false,
            }

            -- Every 6 players we add another group of mobs (1 Sweeper and 4 Cleaners)
            table.insert(sweepers.mobIds, ID.NE_APOLLYON.mob.APOLLYON_SWEEPER[1])
            table.insert(cleanersLarge.mobIds, ID.NE_APOLLYON.mob.APOLLYON_SWEEPER[1] + 1)
            table.insert(cleanersSmall.mobIds, ID.NE_APOLLYON.mob.APOLLYON_SWEEPER[1] + 2)
            table.insert(cleanersSmall.mobIds, ID.NE_APOLLYON.mob.APOLLYON_SWEEPER[1] + 3)
            table.insert(cleanersSmall.mobIds, ID.NE_APOLLYON.mob.APOLLYON_SWEEPER[1] + 4)

            local playerCount = #battlefield:getPlayers()
            if playerCount > 6 then
                table.insert(sweepers.mobIds, ID.NE_APOLLYON.mob.APOLLYON_SWEEPER[2])
                table.insert(cleanersLarge.mobIds, ID.NE_APOLLYON.mob.APOLLYON_SWEEPER[2] + 1)
                table.insert(cleanersSmall.mobIds, ID.NE_APOLLYON.mob.APOLLYON_SWEEPER[2] + 2)
                table.insert(cleanersSmall.mobIds, ID.NE_APOLLYON.mob.APOLLYON_SWEEPER[2] + 3)
                table.insert(cleanersSmall.mobIds, ID.NE_APOLLYON.mob.APOLLYON_SWEEPER[2] + 4)
                if playerCount > 12 then
                    table.insert(sweepers.mobIds, ID.NE_APOLLYON.mob.APOLLYON_SWEEPER[3])
                    table.insert(cleanersLarge.mobIds, ID.NE_APOLLYON.mob.APOLLYON_SWEEPER[3] + 1)
                    table.insert(cleanersSmall.mobIds, ID.NE_APOLLYON.mob.APOLLYON_SWEEPER[3] + 2)
                    table.insert(cleanersSmall.mobIds, ID.NE_APOLLYON.mob.APOLLYON_SWEEPER[3] + 3)
                    table.insert(cleanersSmall.mobIds, ID.NE_APOLLYON.mob.APOLLYON_SWEEPER[3] + 4)
                end
            end

            battlefield:addGroups({ sweepers, cleanersLarge, cleanersSmall }, false)
        end,
    },

    -- Floor 3
    -- These mobs are added in the above group when the floor door opens

    -- Floor 4
    {
        mobs = { "Hyperion", "Okeanos", "Cronos" },
        stationary = false,
        randomDeath = function(battlefield, mob)
            content:openDoor(mob:getBattlefield(), 4)
        end,
    },

    {
        mobs = { "Hyperion" },
        mods = { [xi.mod.MAGIC_NULL] = 100 },
    },

    {
        mobs = { "Okeanos" },
        mods = { [xi.mod.NULL_RANGED_DAMAGE] = 100 },
    },

    {
        mobs = { "Cronos" },
        mods = { [xi.mod.NULL_PHYSICAL_DAMAGE] = 100 },
    },

    {
        mobs = { "Kerkopes_Boss" },
        stationary = false,
        death = function(battlefield, mob, count)
            xi.limbus.spawnFrom(mob, ID.NE_APOLLYON.npc.ITEM_CRATES[4])
        end,
    },

    {
        mobs = { "Kerkopes" },
        stationary = false,
    },

    -- Floor 5
    {
        mobs = { "Troglodyte_Dhalmel" },
        allDeath = function(battlefield, mob)
            npcUtil.showCrate(GetNPCByID(ID.NE_APOLLYON.npc.LOOT_CRATE))
        end,
    },

    {
        mobs = { "Criosphinx", "Hieracosphinx" },
        mods =
        {
            [xi.mod.GRAVITY_MEVA] = 75,
            [xi.mod.BIND_MEVA] = 75,
            [xi.mod.SLEEP_MEVA] = 75,
        },
    }
}

content.loot =
{
    [ID.NE_APOLLYON.npc.ITEM_CRATES[1]] =
    {
        {
            quantity = 3,
            { item =  1875, weight = 1000 }, -- Ancient Beastcoin
        },

        {
            { item =     0, weight = 1000 }, -- Nothing
            { item =  1875, weight = 1000 }, -- Ancient Beastcoin
        },

        {
            { item =  1953, weight = 304 }, -- SAM
            { item =  1943, weight =  18 }, -- PLD
            { item =  1941, weight = 200 }, -- THF
            { item =  2715, weight = 200 }, -- DNC
            { item =  2661, weight =  36 }, -- PUP
            { item =  1933, weight =  18 }, -- MNK
            { item =  1939, weight =  36 }, -- RDM
            { item =  1935, weight = 411 }, -- WHM
            { item =  2717, weight = 482 }, -- SCH
            { item =  1947, weight =  18 }, -- BST
        },

        {
            { item =     0, weight = 1000 }, -- SAM
            { item =  1953, weight =  304 }, -- SAM
            { item =  1943, weight =   18 }, -- PLD
            { item =  1941, weight =  200 }, -- THF
            { item =  2715, weight =  200 }, -- DNC
            { item =  2661, weight =   36 }, -- PUP
            { item =  1933, weight =   18 }, -- MNK
            { item =  1939, weight =   36 }, -- RDM
            { item =  1935, weight =  411 }, -- WHM
            { item =  2717, weight =  482 }, -- SCH
            { item =  1947, weight =   18 }, -- BST
        },
    },

    -- NE_Apollyon floor 2
    [ID.NE_APOLLYON.npc.ITEM_CRATES[2]] =
    {
        {
            quantity = 3,
            { item =  1875, weight = 1000 }, -- Ancient Beastcoin
        },

        {
            { item =     0, weight = 1000 }, -- Nothing
            { item =  1875, weight = 1000 }, -- Ancient Beastcoin
        },

        {
            { item =  1947, weight =  26 }, -- BST
            { item =  1933, weight =  53 }, -- MNK
            { item =  1943, weight =  26 }, -- PLD
            { item =  2661, weight =  26 }, -- PUP
            { item =  1937, weight = 395 }, -- BLM
            { item =  1957, weight = 289 }, -- DRG
            { item =  1941, weight =  53 }, -- THF
            { item =  1939, weight = 112 }, -- RDM
            { item =  2657, weight = 477 }, -- BLU
        },

        {
            { item =     0, weight =  1000 }, -- Nothing
            { item =  1947, weight =    26 }, -- BST
            { item =  1933, weight =    53 }, -- MNK
            { item =  1943, weight =    26 }, -- PLD
            { item =  2661, weight =    26 }, -- PUP
            { item =  1937, weight =   395 }, -- BLM
            { item =  1957, weight =   289 }, -- DRG
            { item =  1941, weight =    53 }, -- THF
            { item =  1939, weight =   112 }, -- RDM
            { item =  2657, weight =   477 }, -- BLU
        },
    },

    -- NE_Apollyon floor 3
    [ID.NE_APOLLYON.npc.ITEM_CRATES[3]] =
    {
        {
            quantity = 4,
            { item =  1875, weight = 1000 }, -- Ancient Beastcoin
        },

        {
            { item =     0, weight = 1000 }, -- Nothing
            { item =  1931, weight =  788 }, -- WAR
            { item =  1939, weight =   30 }, -- RDM
            { item =  1953, weight =  130 }, -- SAM
            { item =  1957, weight =  100 }, -- DRG
            { item =  1947, weight =   90 }, -- BST
            { item =  1933, weight =   30 }, -- MNK
            { item =  1941, weight =   99 }, -- THF
            { item =  2661, weight =   61 }, -- PUP
            { item =  2715, weight =   30 }, -- DNC
            { item =  1943, weight =  160 }, -- PLD
        },

        {
            { item =     0, weight = 1000 }, -- Nothing
            { item =  1931, weight =  788 }, -- WAR
            { item =  1939, weight =   30 }, -- RDM
            { item =  1953, weight =  130 }, -- SAM
            { item =  1957, weight =  100 }, -- DRG
            { item =  1947, weight =   90 }, -- BST
            { item =  1933, weight =   30 }, -- MNK
            { item =  1941, weight =   99 }, -- THF
            { item =  2661, weight =   61 }, -- PUP
            { item =  2715, weight =   30 }, -- DNC
            { item =  1943, weight =  160 }, -- PLD
        },

        {
            { item =     0, weight = 180 }, -- Nothing
            { item =  1633, weight =  30 }, -- Clot Plasma
            { item =   821, weight =  40 }, -- Rainbow Thread
            { item =  1311, weight =  50 }, -- Oxblood
            { item =  1883, weight =  40 }, -- Shell Powder
            { item =  2004, weight =  20 }, -- Carapace Powder
        },

        {
            { item =     0, weight = 180 }, -- Nothing
            { item =  1633, weight =  30 }, -- Clot Plasma
            { item =   821, weight =  40 }, -- Rainbow Thread
            { item =  1311, weight =  50 }, -- Oxblood
            { item =  1883, weight =  40 }, -- Shell Powder
            { item =  2004, weight =  20 }, -- Carapace Powder
        },
    },

    -- NE_Apollyon floor 4
    [ID.NE_APOLLYON.npc.ITEM_CRATES[4]] =
    {
        {
            quantity = 6,
            { item =  1875, weight = 1000 }, -- Ancient Beastcoin
        },

        {
            { item =     0, weight = 1000 }, -- Nothing
            { item =  1875, weight = 1000 }, -- Ancient Beastcoin
        },

        {
            { item =  1949, weight = 326 }, -- BRD
            { item =  1945, weight = 256 }, -- DRK
            { item =  1951, weight = 395 }, -- RNG
            { item =  1959, weight = 279 }, -- SMN
            { item =  1955, weight = 256 }, -- NIN
            { item =  2659, weight = 326 }, -- COR
        },

        {
            { item =     0, weight = 1000 }, -- Nothing
            { item =  1949, weight =  326 }, -- BRD
            { item =  1945, weight =  256 }, -- DRK
            { item =  1951, weight =  395 }, -- RNG
            { item =  1959, weight =  279 }, -- SMN
            { item =  1955, weight =  256 }, -- NIN
            { item =  2659, weight =  326 }, -- COR
        },
    },

    -- NE_Apollyon floor 5
    [ID.NE_APOLLYON.npc.LOOT_CRATE] =
    {
        {
            quantity = 7,
            { item =  1875, weight = 1000 }, -- Ancient Beastcoin
        },

        {
            { item =  1910, weight = 1000 }, -- Smoky Chip
        },

        {
            { item =     0, weight = 100 }, -- Nothing
            { item =  2127, weight =  59 }, -- Metal Chip
        },
    },
}

return content:register()
