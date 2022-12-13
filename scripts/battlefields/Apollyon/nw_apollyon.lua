-----------------------------------
-- Area: Apollyon
-- Name: NW Apollyon
-- !addkeyitem red_card
-- !addkeyitem cosmo_cleanse
-- !pos -600 -0.5 -600 38
-----------------------------------
local ID = require("scripts/zones/Apollyon/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/limbus")
require("scripts/globals/items")
require("scripts/globals/keyitems")
-----------------------------------

local content = Limbus:new({
    zoneId           = xi.zone.APOLLYON,
    battlefieldId    = xi.battlefield.id.NW_APOLLYON,
    maxPlayers       = 18,
    timeLimit        = utils.minutes(30),
    index            = 1,
    area             = 2,
    entryNpc         = '_127',
    requiredKeyItems = { xi.ki.COSMO_CLEANSE, xi.ki.RED_CARD, message = ID.text.YOU_INSERT_THE_CARD_POLISHED },
    name             = "NW_APOLLYON",
    timeExtension   = 5,
})

function content:onBattlefieldInitialise(battlefield)
    Limbus.onBattlefieldInitialise(self, battlefield)

    for i, crateID in ipairs(ID.NW_APOLLYON.npc.TIME_CRATES) do
        npcUtil.showCrate(GetNPCByID(crateID))
    end

    for i, crateID in ipairs(ID.NW_APOLLYON.npc.RECOVER_CRATES) do
        npcUtil.showCrate(GetMobByID(crateID))
    end
end

local empowerBoss = function(battlefield, mobs)
    local boss = mobs[1]
    boss:addMod(xi.mod.ATTP, 100)
    boss:addMod(xi.mod.ACC, 50)
end

local depowerBoss = function(bossID)
    local boss = GetMobByID(bossID)
    boss:delMod(xi.mod.ATTP, 100)
    boss:delMod(xi.mod.ACC, 50)
end

content.paths =
{
    [ID.NW_APOLLYON.mob.PLUTO] =
    {
        { x = -458.0, y = 0.0, z = 46.0, wait = 5000 },
        { x = -458.0, y = 0.0, z = -14.0, wait = 5000 },
    },

    [ID.NW_APOLLYON.mob.BARDHA[1]] =
    {
        { x = -418.0, y = 0.0, z = 36.0, wait = 2500 },
        { x = -390.0, y = 0.0, z = 62.0, wait = 2500 },
    },

    [ID.NW_APOLLYON.mob.BARDHA[2]] =
    {
        { x = -410.0, y = 0.0, z = 68.0, wait = 2500 },
        { x = -396.0, y = 0.0, z = 34.0, wait = 2500 },
    },

    [ID.NW_APOLLYON.mob.BARDHA[3]] =
    {
        { x = -456.0, y = 0.0, z = 24.0, wait = 2500 },
        { x = -432.0, y = 0.0, z = 19.0, wait = 2500 },
    },

    [ID.NW_APOLLYON.mob.BARDHA[4]] =
    {
        { x = -502.0, y = 0.0, z = 30.0, wait = 2500 },
        { x = -476.0, y = 0.0, z = 23.0, wait = 2500 },
    },

    [ID.NW_APOLLYON.mob.BARDHA[5]] =
    {
        { x = -448.0, y = 0.0, z = 22.0, wait = 2500 },
        { x = -425.0, y = 0.0, z = 23.0, wait = 2500 },
    },

    [ID.NW_APOLLYON.mob.BARDHA[6]] =
    {
        { x = -429.0, y = 0.0, z = -28.0, wait = 2500 },
        { x = -450.0, y = 0.0, z = -24.0, wait = 2500 },
    },

    [ID.NW_APOLLYON.mob.BARDHA[7]] =
    {
        { x = -460.0, y = 0.0, z = 55.0, wait = 2500 },
        { x = -414.0, y = 0.0, z = 31.0, wait = 2500 },
    },

    [ID.NW_APOLLYON.mob.ZLATOROG] =
    {
        { x = -384.0, y = 0.0,  z = 268.0, wait = 5000 },
        { x = -336.0, y = -0.5, z = 320.0, wait = 5000 },
    },

    [ID.NW_APOLLYON.mob.MOUNTAIN_BUFFALO[1]] =
    {
        { x = -306.0, y = 0.0, z = 317.0, wait = 5000 },
        { x = -295.0, y = 0.0, z = 354.0, wait = 5000 },
    },

    [ID.NW_APOLLYON.mob.MOUNTAIN_BUFFALO[2]] =
    {
        { x = -329.0, y = 0.0, z = 283.0, wait = 5000 },
        { x = -345.0, y = 0.0, z = 281.0, wait = 5000 },
    },

    [ID.NW_APOLLYON.mob.MOUNTAIN_BUFFALO[3]] =
    {
        { x = -334.0, y = 0.0, z = 222.0, wait = 5000 },
        { x = -373.0, y = 0.0, z = 252.0, wait = 5000 },
    },

    [ID.NW_APOLLYON.mob.MOUNTAIN_BUFFALO[4]] =
    {
        { x = -334.0, y = 0.0,  z = 233.0, wait = 5000 },
        { x = -345.0, y = -1.0, z = 246.0, wait = 5000 },
    },

    [ID.NW_APOLLYON.mob.MOUNTAIN_BUFFALO[5]] =
    {
        { x = -315.0, y = 0.0, z = 233.0, wait = 5000 },
        { x = -317.0, y = 0.0, z = 263.0, wait = 5000 },
    },

    [ID.NW_APOLLYON.mob.MOUNTAIN_BUFFALO[6]] =
    {
        { x = -366.0, y = 0.0, z = 235.0, wait = 5000 },
        { x = -350.0, y = 0.0, z = 280.0, wait = 5000 },
    },

    [ID.NW_APOLLYON.mob.MOUNTAIN_BUFFALO[7]] =
    {
        { x = -307.0, y = 0.0, z = 287.0, wait = 5000 },
        { x = -317.0, y = 0.0, z = 316.0, wait = 5000 },
    },

    [ID.NW_APOLLYON.mob.APOLLYON_SCAVENGER[1]] =
    {
        { x = -252.0, y = 0.0, z = 530.0, wait = 5000 },
        { x = -218.0, y = 0.0, z = 540.0, wait = 5000 },
    },

    [ID.NW_APOLLYON.mob.APOLLYON_SCAVENGER[2]] =
    {
        { x = -310.0, y = 0.0, z = 485.0, wait = 10000 },
        { x = -293.0, y = 0.0, z = 505.0, wait = 10000 },
    },

    [ID.NW_APOLLYON.mob.APOLLYON_SCAVENGER[4]] =
    {
        { x = -332.0, y = 0.0, z = 553.0, wait = 5000 },
        { x = -295.0, y = 0.0, z = 573.0, wait = 5000 },
    },

    [ID.NW_APOLLYON.mob.APOLLYON_SCAVENGER[5]] =
    {
        { x = -324.0, y = 0.0, z = 590.0, wait = 5000 },
        { x = -290.0, y = 0.0, z = 557.0, wait = 5000 },
    },

    [ID.NW_APOLLYON.mob.APOLLYON_SCAVENGER[6]] =
    {
        { x = -323.0, y = 0.0, z = 514.0, wait = 5000 },
        { x = -340.0, y = 0.0, z = 547.0, wait = 5000 },
    },

    [ID.NW_APOLLYON.mob.APOLLYON_SCAVENGER[7]] =
    {
        { x = -308.0, y = 0.0, z = 494.0, wait = 10000 },
        { x = -337.0, y = 0.0, z = 522.0, wait = 10000 },
    },

    [ID.NW_APOLLYON.mob.GORYNICH[1]] =
    {
        { x = -567.0, y = 0.0, z = 603.0, wait = 10000 },
        { x = -537.0, y = 0.0, z = 637.0, wait = 10000 },
    },

    [ID.NW_APOLLYON.mob.GORYNICH[2]] =
    {
        { x = -548.0, y = 0.0, z = 581.0, wait = 10000 },
        { x = -600.0, y = 0.0, z = 570.0, wait = 10000 },
    },

    [ID.NW_APOLLYON.mob.GORYNICH[3]] =
    {
        { x = -615.0, y = 0.0, z = 531.0, wait = 10000 },
        { x = -583.0, y = 0.0, z = 571.0, wait = 10000 },
    },

    [ID.NW_APOLLYON.mob.GORYNICH[4]] =
    {
        { x = -600.0, y = 0.0, z = 523.0, wait = 10000 },
        { x = -554.0, y = 0.0, z = 537.0, wait = 10000 },
    },

    [ID.NW_APOLLYON.mob.GORYNICH[5]] =
    {
        { x = -555.0, y = 0.0, z = 614.0, wait = 10000 },
        { x = -529.0, y = 0.0, z = 630.0, wait = 10000 },
    },

    [ID.NW_APOLLYON.mob.KAISER_BEHEMOTH] =
    {
        { x = -533.384, y = 0.000, z = 317.332 },
        { x = -572.622, y = 0.000, z = 321.561 },
        { x = -586.765, y = 0.000, z = 306.422 },
        { x = -592.706, y = 0.000, z = 271.736 },
        { x = -604.253, y = 0.000, z = 248.940 },
        { x = -590.466, y = 0.000, z = 232.526 },
        { x = -577.526, y = 0.000, z = 235.779 },
        { x = -564.415, y = 0.000, z = 244.076 },
        { x = -554.712, y = 0.000, z = 250.640 },
        { x = -534.004, y = 0.000, z = 248.469 },
        { x = -531.384, y = 0.000, z = 263.066 },
        { x = -524.566, y = 0.000, z = 290.070 },
        { x = -529.820, y = 0.000, z = 299.678 },
        { x = -530.384, y = 0.000, z = 305.172 },
        { x = -528.506, y = 0.000, z = 310.466 },
        { x = -536.660, y = 0.000, z = 317.356 },
    },
}

content.groups =
{
    {
        mobs = { "Pluto" },
        mods =
        {
            [xi.mod.GRAVITY_MEVA] = -25,
            [xi.mod.BIND_MEVA] = -25,
        },

        setup = empowerBoss,
        death = function(battlefield, mob, count)
            xi.limbus.spawnFrom(mob, ID.NW_APOLLYON.npc.ITEM_CRATES[1])
        end,
    },

    {
        mobs = { "Bardha" },
        mods =
        {
            [xi.mod.GRAVITY_MEVA] = -25,
            [xi.mod.BIND_MEVA] = -25,
            [xi.mod.SLEEP_MEVA] = -25,
        },

        allDeath = function(battlefield, mob)
            depowerBoss(ID.NW_APOLLYON.mob.PLUTO)
        end,

        randomDeath = function(battlefield, mob)
            content:openDoor(battlefield, 1)
        end,
    },

    -- Floor 2
    {
        mobs = { "Zlatorog" },
        mods =
        {
            [xi.mod.GRAVITY_MEVA] = -25,
            [xi.mod.BIND_MEVA] = -25,
            [xi.mod.SLEEP_MEVA] = -25,
        },

        setup = empowerBoss,
        death = function(battlefield, mob, count)
            xi.limbus.spawnFrom(mob, ID.NW_APOLLYON.npc.ITEM_CRATES[2])
        end,
    },

    {
        mobs = { "Mountain_Buffalo" },
        mods =
        {
            [xi.mod.GRAVITY_MEVA] = -25,
            [xi.mod.BIND_MEVA] = -25,
            [xi.mod.SLEEP_MEVA] = -25,
        },

        allDeath = function(battlefield, mob)
            depowerBoss(ID.NW_APOLLYON.mob.ZLATOROG)
        end,

        randomDeath = function(battlefield, mob)
            content:openDoor(battlefield, 2)
        end,
    },

    -- Floor 3
    {
        mobs = { "Millenary_Mossback" },
        stationary = true,
        setup = empowerBoss,
        death = function(battlefield, mob, count)
            xi.limbus.spawnFrom(mob, ID.NW_APOLLYON.npc.ITEM_CRATES[3])
        end,
    },

    {
        mobs = { "Apollyon_Scavenger" },
        mods =
        {
            [xi.mod.GRAVITY_MEVA] = -25,
            [xi.mod.BIND_MEVA] = -25,
            [xi.mod.SLEEP_MEVA] = -25,
        },

        stationary = true,
        allDeath = function(battlefield, mob)
            depowerBoss(ID.NW_APOLLYON.mob.MILLENARY_MOSSBACK)
        end,

        randomDeath = function(battlefield, mob)
            content:openDoor(battlefield, 3)
        end,
    },

    -- Floor 4
    {
        mobs = { "Cynoprosopi" },
        mods =
        {
            [xi.mod.GRAVITY_MEVA] = -25,
            [xi.mod.BIND_MEVA] = -25,
        },

        setup = empowerBoss,
        death = function(battlefield, mob, count)
            xi.limbus.spawnFrom(mob, ID.NW_APOLLYON.npc.ITEM_CRATES[4])
        end,
    },
    {
        --
        mobs = { "Gorynich" },
        mods =
        {
            [xi.mod.GRAVITY_MEVA] = -25,
            [xi.mod.BIND_MEVA] = -25,
            [xi.mod.SLEEP_MEVA] = -25,
        },

        allDeath = function(battlefield, mob)
            depowerBoss(ID.NW_APOLLYON.mob.CYNOPROSOPI)
        end,

        randomDeath = function(battlefield, mob)
            content:openDoor(battlefield, 4)
        end,
    },

    -- Floor 5
    {
        mobs = { "Kaiser_Behemoth" },
        mobMods =
        {
            [xi.mobMod.ALLI_HATE] = 50,
            [xi.mobMod.MAGIC_COOL] = 30,
            [xi.mobMod.SEVERE_SPELL_CHANCE] = 100,
        },

        setup = empowerBoss,
        death = function(battlefield, mob, count)
            npcUtil.showCrate(GetNPCByID(ID.NW_APOLLYON.npc.LOOT_CRATE))
        end,
    },

    {
        mobs = { "Kronprinz_Behemoth" },
        mods =
        {
            [xi.mod.GRAVITY_MEVA] = -25,
            [xi.mod.BIND_MEVA] = 25,
            [xi.mod.SLEEP_MEVA] = 25,
        },

        mobMods = { [xi.mobMod.ALLI_HATE] = 50 },
        stationary = false,
        allDeath = function(battlefield, mob)
            depowerBoss(ID.NW_APOLLYON.mob.KAISER_BEHEMOTH)
        end,
    },
}

content.loot =
{
    [ID.NW_APOLLYON.npc.ITEM_CRATES[1]] =
    {
        {
            quantity = 2,
            { item =  1875, weight = 1000 }, -- Ancient Beastcoin
        },

        {
            { item =     0, weight = 100 }, -- Nothing
            { item =  1937, weight =  25 }, -- BLM
            { item =  2657, weight = 175 }, -- BLU
            { item =  1957, weight = 100 }, -- DRG
            { item =  1943, weight =  25 }, -- PLD
            { item =  1953, weight = 250 }, -- SAM
            { item =  2717, weight =  75 }, -- SCH
            { item =  1931, weight = 225 }, -- WAR
            { item =  1935, weight =  50 }, -- WHM
        },
    },

    [ID.NW_APOLLYON.npc.ITEM_CRATES[2]] =
    {
        {
            quantity = 2,
            { item =  1875, weight = 1000 }, -- Ancient Beastcoin
        },

        {
            { item =     0, weight = 100 }, -- Nothing
            { item =  1943, weight = 235 }, -- PLD
            { item =  2659, weight =  59 }, -- COR
            { item =  1945, weight = 235 }, -- DRK
            { item =  1955, weight = 147 }, -- NIN
            { item =  1951, weight = 118 }, -- RNG
            { item =  1959, weight = 176 }, -- SMN
            { item =  1935, weight = 110 }, -- WHM
        },
    },

    -- NW_Apollyon floor 3
    [ID.NW_APOLLYON.npc.ITEM_CRATES[3]] =
    {
        {
            quantity = 5,
            { item =     0, weight = 1000 }, -- Nothing
            { item =  1875, weight = 1000 }, -- Ancient Beastcoin
        },

        {
            { item =  1947, weight = 133 }, -- BST
            { item =  1933, weight = 133 }, -- MNK
            { item =  1943, weight = 133 }, -- PLD
            { item =  2661, weight = 133 }, -- PUP
            { item =  1939, weight = 110 }, -- RDM
            { item =  1941, weight = 400 }, -- THF
        },

        {
            { item =     0, weight = 400 }, -- Nothing
            { item =   646, weight =  50 }, -- Adaman Ore
            { item =  1633, weight =  50 }, -- Clot Plasma
            { item =   664, weight =  50 }, -- Darksteel Sheet
            { item =   645, weight =  50 }, -- Darksteel Ore
            { item =  1311, weight =  50 }, -- Oxblood
            { item =  1681, weight =  50 }, -- Light Steel
            { item =   821, weight =  50 }, -- Rainbow Thread
            { item =  1883, weight =  50 }, -- Shell Powder
        },

        {
            { item =     0, weight = 400 }, -- Nothing
            { item =   646, weight =  50 }, -- Adaman Ore
            { item =  1633, weight =  50 }, -- Clot Plasma
            { item =   664, weight =  50 }, -- Darksteel Sheet
            { item =   645, weight =  50 }, -- Darksteel Ore
            { item =  1311, weight =  50 }, -- Oxblood
            { item =  1681, weight =  50 }, -- Light Steel
            { item =   821, weight =  50 }, -- Rainbow Thread
            { item =  1883, weight =  50 }, -- Shell Powder
        },
    },

    -- NW_Apollyon floor 4
    [ID.NW_APOLLYON.npc.ITEM_CRATES[4]] =
    {
        {
            quantity = 7,
            { item =  1875, weight = 1000 }, -- Ancient Beastcoin
        },

        {
            quantity = 2,
            { item =     0, weight = 1000 }, -- Nothing
            { item =  1875, weight = 1000 }, -- Ancient Beastcoin
        },

        {
            { item =     0, weight = 100 }, -- Nothing
            { item =  1937, weight =  80 }, -- BLM
            { item =  2657, weight =  70 }, -- BLU
            { item =  1949, weight =  48 }, -- BRD
            { item =  1947, weight =  30 }, -- BST
            { item =  2659, weight =  25 }, -- COR
            { item =  1957, weight =  19 }, -- DRG
            { item =  1945, weight =  48 }, -- DRK
            { item =  1933, weight =  90 }, -- MNK
            { item =  1955, weight = 100 }, -- NIN
            { item =  2661, weight =  48 }, -- PUP
            { item =  1939, weight = 136 }, -- RDM
            { item =  1951, weight =  80 }, -- RNG
            { item =  1953, weight = 110 }, -- SAM
            { item =  1959, weight =  95 }, -- SMN
            { item =  2715, weight = 123 }, -- DNC
            { item =  1935, weight =  48 }, -- WHM
        },
    },

    -- NW_Apollyon floor 5
    [ID.NW_APOLLYON.npc.LOOT_CRATE] =
    {
        {
            quantity = 5,
            { item =  1875, weight = 1000 }, -- Ancient Beastcoin
        },

        {
            { item =  1937, weight = 109 }, -- BLM
            { item =  2657, weight = 152 }, -- BLU
            { item =  1949, weight = 283 }, -- BRD
            { item =  1947, weight = 109 }, -- BST
            { item =  2659, weight =  65 }, -- COR
            { item =  2715, weight = 130 }, -- DNC
            { item =  1957, weight =  65 }, -- DRG
            { item =  1945, weight = 174 }, -- DRK
            { item =  1933, weight = 130 }, -- MNK
            { item =  1955, weight = 196 }, -- NIN
            { item =  1943, weight = 174 }, -- PLD
            { item =  2661, weight = 174 }, -- PUP
            { item =  1939, weight = 109 }, -- RDM
            { item =  1951, weight = 130 }, -- RNG
            { item =  1953, weight = 304 }, -- SAM
            { item =  2717, weight =  87 }, -- SCH
            { item =  1959, weight = 217 }, -- SMN
            { item =  1941, weight = 174 }, -- THF
            { item =  1931, weight = 130 }, -- WAR
            { item =  1935, weight = 109 }, -- WHM
        },

        {
            { item =  1937, weight = 109 }, -- BLM
            { item =  2657, weight = 152 }, -- BLU
            { item =  1949, weight = 283 }, -- BRD
            { item =  1947, weight = 109 }, -- BST
            { item =  2659, weight =  65 }, -- COR
            { item =  2715, weight = 130 }, -- DNC
            { item =  1957, weight =  65 }, -- DRG
            { item =  1945, weight = 174 }, -- DRK
            { item =  1933, weight = 130 }, -- MNK
            { item =  1955, weight = 196 }, -- NIN
            { item =  1943, weight = 174 }, -- PLD
            { item =  2661, weight = 174 }, -- PUP
            { item =  1939, weight = 109 }, -- RDM
            { item =  1951, weight = 130 }, -- RNG
            { item =  1953, weight = 304 }, -- SAM
            { item =  2717, weight =  87 }, -- SCH
            { item =  1959, weight = 217 }, -- SMN
            { item =  1941, weight = 174 }, -- THF
            { item =  1931, weight = 130 }, -- WAR
            { item =  1935, weight = 109 }, -- WHM
        },

        {
            { item =     0, weight = 300 }, -- Nothing
            { item =  1937, weight = 109 }, -- BLM
            { item =  2657, weight = 152 }, -- BLU
            { item =  1949, weight = 283 }, -- BRD
            { item =  1947, weight = 109 }, -- BST
            { item =  2659, weight =  65 }, -- COR
            { item =  2715, weight = 130 }, -- DNC
            { item =  1957, weight =  65 }, -- DRG
            { item =  1945, weight = 174 }, -- DRK
            { item =  1933, weight = 130 }, -- MNK
            { item =  1955, weight = 196 }, -- NIN
            { item =  1943, weight = 174 }, -- PLD
            { item =  2661, weight = 174 }, -- PUP
            { item =  1939, weight = 109 }, -- RDM
            { item =  1951, weight = 130 }, -- RNG
            { item =  1953, weight = 304 }, -- SAM
            { item =  2717, weight =  87 }, -- SCH
            { item =  1959, weight = 217 }, -- SMN
            { item =  1941, weight = 174 }, -- THF
            { item =  1931, weight = 130 }, -- WAR
            { item =  1935, weight = 109 }, -- WHM
        },

        {
            { item =  1988, weight = 1000 }, -- Magenta Chip
        },

        {
            { item =     0, weight = 100 }, -- Nothing
            { item =  2127, weight =  59 }, -- Metal Chip
        },
    },
}

return content:register()
