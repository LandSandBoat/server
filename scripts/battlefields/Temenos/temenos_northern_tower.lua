-----------------------------------
-- Area: Temenos
-- Name: Temenos Northern Tower
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
    battlefieldId    = xi.battlefield.id.TEMENOS_NORTHERN_TOWER,
    maxPlayers       = 18,
    timeLimit        = utils.minutes(30),
    index            = 0,
    area             = 1,
    entryNpc         = 'Matter_Diffusion_Module',
    requiredKeyItems = { xi.ki.COSMO_CLEANSE, xi.ki.WHITE_CARD, message = ID.text.YOU_INSERT_THE_CARD_POLISHED },
    name             = "TEMENOS_NORTHERN_TOWER",
    timeExtension    = 15,
})

content.handleMobDeathVortex = function(floor, battlefield, mob, count)
    if count == 1 then
        content:openDoor(battlefield, floor)
    end
end

content.handleAllMobDeathCrate = function(floor, battlefield, mob)
    npcUtil.showCrate(GetNPCByID(ID.TEMENOS_NORTHERN_TOWER.npc.ITEM_CRATES[floor]))
    npcUtil.showCrate(GetNPCByID(ID.TEMENOS_NORTHERN_TOWER.npc.TIME_CRATES[floor]))
    xi.limbus.showRecoverCrate(ID.TEMENOS_NORTHERN_TOWER.npc.RECOVER_CRATES[floor])
end

content.paths =
{

    [ID.TEMENOS_NORTHERN_TOWER.mob.MOBLIN_DUSTMAN] =
    {
        { x = 340.000, y = 68.000, z = 436.000, wait = 10000 },
        { x = 340.000, y = 68.000, z = 456.000, wait = 10000 },
    },

    [ID.TEMENOS_NORTHERN_TOWER.mob.MOBLIN_DUSTMAN + 1] =
    {
        { x = 344.000, y = 68.000, z = 460.000, wait = 10000 },
        { x = 364.000, y = 68.000, z = 460.000, wait = 10000 },
    },

    [ID.TEMENOS_NORTHERN_TOWER.mob.MOBLIN_DUSTMAN + 2] =
    {
        { x = 370.000, y = 74.000, z = 432.000, wait = 10000 },
        { x = 370.000, y = 74.000, z = 408.000, wait = 10000 },
    },

    [ID.TEMENOS_NORTHERN_TOWER.mob.MOBLIN_DUSTMAN + 3] =
    {
        { x = 374.000, y = 74.000, z = 408.000, wait = 10000 },
        { x = 374.000, y = 74.000, z = 432.000, wait = 10000 },
    },

    [ID.TEMENOS_NORTHERN_TOWER.mob.KARI] =
    {
        { x = 186.000, y = -82.000, z = 464.000, wait = 3000 },
        { x = 214.000, y = -82.000, z = 466.000, wait = 3000 },
        { x = 214.000, y = -82.000, z = 494.000, wait = 3000 },
        { x = 186.000, y = -82.000, z = 494.000, wait = 3000 },
    },

    [ID.TEMENOS_NORTHERN_TOWER.mob.TELCHINES_DRAGOON] =
    {
        { x = 30.000, y = 80.000, z = 419.500, wait = 10000 },
        { x = 50.000, y = 80.000, z = 419.500, wait = 10000 },
    },

    [ID.TEMENOS_NORTHERN_TOWER.mob.TELCHINES_MONK] =
    {
        { x = 30.000, y = 80.000, z = 420.500, wait = 10000 },
        { x = 10.000, y = 80.000, z = 420.500, wait = 10000 },
    },

    [ID.TEMENOS_NORTHERN_TOWER.mob.TELCHINES_MONK + 1] =
    {
        { x = 70.000, y = 80.000, z = 420.500, wait = 10000 },
        { x = 50.000, y = 80.000, z = 420.500, wait = 10000 },
    },

    [ID.TEMENOS_NORTHERN_TOWER.mob.KINDRED_BLACK_MAGE] =
    {
        { x = -92.000, y = -80.000, z = 427.000, wait = 5000 },
        { x = -148.000, y = -80.000, z = 427.000, wait = 5000 },
    },

    [ID.TEMENOS_NORTHERN_TOWER.mob.KINDRED_BLACK_MAGE + 1] =
    {
        { x = -92.000, y = -80.000, z = 430.000, wait = 5000 },
        { x = -148.000, y = -80.000, z = 430.000, wait = 5000 },
    },

    [ID.TEMENOS_NORTHERN_TOWER.mob.KINDRED_BLACK_MAGE + 2] =
    {
        { x = -148.000, y = -80.000, z = 410.000, wait = 5000 },
        { x = -92.000, y = -80.000, z = 410.000, wait = 5000 },
    },

    [ID.TEMENOS_NORTHERN_TOWER.mob.KINDRED_BLACK_MAGE + 3] =
    {
        { x = -148.000, y = -80.000, z = 413.000, wait = 5000 },
        { x = -92.000, y = -80.000, z = 413.000, wait = 5000 },
    },

    [ID.TEMENOS_NORTHERN_TOWER.mob.CRYPTONBERRY_ABDUCTOR] =
    {
        { x = -456.000, y = -80.000, z = 420.500, wait = 30000 },
        { x = -424.000, y = -80.000, z = 420.500, wait = 30000 },
    },

    [ID.TEMENOS_NORTHERN_TOWER.mob.CRYPTONBERRY_DESIGNATOR] =
    {
        { x = -424.000, y = -80.000, z = 419.500, wait = 30000 },
        { x = -456.000, y = -80.000, z = 419.500, wait = 30000 },
    },

    [ID.TEMENOS_NORTHERN_TOWER.mob.CRYPTONBERRY_ABDUCTOR + 4] =
    {
        { x = -460.500, y = -80.000, z = 416.000, wait = 10000 },
        { x = -460.500, y = -80.000, z = 408.000, wait = 10000 },
    },

    [ID.TEMENOS_NORTHERN_TOWER.mob.CRYPTONBERRY_DESIGNATOR + 4] =
    {
        { x = -459.500, y = -80.000, z = 416.000, wait = 10000 },
        { x = -459.500, y = -80.000, z = 408.000, wait = 10000 },
    },

    [ID.TEMENOS_NORTHERN_TOWER.mob.CRYPTONBERRY_ABDUCTOR + 8] =
    {
        { x = -419.500, y = -80.000, z = 416.000, wait = 10000 },
        { x = -419.500, y = -80.000, z = 408.000, wait = 10000 },
    },

    [ID.TEMENOS_NORTHERN_TOWER.mob.CRYPTONBERRY_DESIGNATOR + 8] =
    {
        { x = -420.500, y = -80.000, z = 416.000, wait = 10000 },
        { x = -420.500, y = -80.000, z = 408.000, wait = 10000 },
    },
}

content.groups =
{
    -- Floor 1
    {
        mobs = { "Moblin_Dustman" },
        mobMods = { [xi.mobMod.DETECTION] = xi.detects.HEARING },
        death = utils.bind(content.handleMobDeathVortex, 1),
    },

    {
        mobs = { "Goblin_Slaughterman" },
        mobMods = { [xi.mobMod.DETECTION] = xi.detects.HEARING },
        allDeath = utils.bind(content.handleAllMobDeathCrate, 1),
    },

    -- Floor 2
    {
        mobs = { "Kari" },
        mobMods = { [xi.mobMod.DETECTION] = xi.detects.HEARING },
        death = utils.bind(content.handleMobDeathVortex, 2),
    },

    {
        mobs =
        {
            "Skadi",
            "Thrym",
            "Beli",
        },

        mobMods = { [xi.mobMod.DETECTION] = xi.detects.HEARING },
        allDeath = utils.bind(content.handleAllMobDeathCrate, 2),
    },

    -- Floor 3
    {
        mobs =
        {
            "Telchines_Monk",
            "Telchines_Dragoon",
        },

        death = utils.bind(content.handleMobDeathVortex, 3),
    },

    { mobs = { "Telchiness_Wyvern" } },

    {
        mobs =
        {
            "Telchines_Bard",
            "Telchines_White_Mage",
        },

        allDeath = utils.bind(content.handleAllMobDeathCrate, 3),
    },

    -- Floor 4
    {
        mobs = { "Kindred_Black_Mage" },
        mobMods = { [xi.mobMod.DETECTION] = xi.detects.HEARING },
        death = utils.bind(content.handleMobDeathVortex, 4),
    },

    {
        mobs =
        {
            "Kindred_Warrior",
            "Kindred_Dark_Knight",
            "Kindred_Summoner",
        },

        mobMods = { [xi.mobMod.DETECTION] = xi.detects.HEARING },
        allDeath = utils.bind(content.handleAllMobDeathCrate, 4),
    },

    {
        mobs =
        {
            "Kindreds_Elemental",
            "Kindreds_Avatar",
        }
    },

    -- Floor 5
    {
        mobs =
        {
            "Praetorian_Guard_CCXX",
            "Praetorian_Guard_LXXIII",
            "Praetorian_Guard_CXLVIII",
            "Praetorian_Guard_CCCXI",
        },

        death = utils.bind(content.handleMobDeathVortex, 5),
        allDeath = utils.bind(content.handleAllMobDeathCrate, 5),
    },

    -- Floor 6
    {
        mobs =
        {
            "Cryptonberry_Abductor",
            "Cryptonberry_Designator",
        },

        mobMods = { [xi.mobMod.DETECTION] = xi.detects.HEARING },
        death = utils.bind(content.handleMobDeathVortex, 6),
    },

    {
        mobs =
        {
            "Tonberrys_Elemental",
            "Tonberrys_Avatar",
        },
    },

    {
        mobs =
        {
            "Cryptonberry_Charmer",
            "Cryptonberry_Skulker",
        },

        mobMods = { [xi.mobMod.DETECTION] = xi.detects.HEARING },
        allDeath = utils.bind(content.handleAllMobDeathCrate, 6),
    },

    -- Floor 7
    {
        mobs =
        {
            "Goblin_Warlord",
            "Goblin_Fencer",
            "Goblin_Theurgist",
        },

        mobMods = { [xi.mobMod.DETECTION] = xi.detects.HEARING },
        allDeath = function(battlefield, mob)
            npcUtil.showCrate(GetNPCByID(ID.TEMENOS_NORTHERN_TOWER.npc.LOOT_CRATE))
        end
    },

}

content.loot =
{
    [ID.TEMENOS_NORTHERN_TOWER.npc.ITEM_CRATES[1]] =
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
            quantity = 2,
            { item =     0, weight = 250 },
            { item =  1954, weight = 159 },
            { item =  1940, weight = 146 },
            { item =  1932, weight =  85 },
            { item =  1956, weight = 171 },
            { item =  1934, weight = 110 },
            { item =  2658, weight = 220 },
            { item =  2716, weight =  98 },
        },
    },

    [ID.TEMENOS_NORTHERN_TOWER.npc.ITEM_CRATES[2]] =
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
            quantity = 2,
            { item =     0, weight = 400 },
            { item =  1932, weight = 333 },
            { item =  1954, weight = 200 },
            { item =  1950, weight = 100 },
            { item =  1940, weight =  90 },
            { item =  1942, weight =  70 },
            { item =  1934, weight =  90 },
            { item =  1936, weight = 100 },
            { item =  1958, weight =  90 },
            { item =  2656, weight =  67 },
            { item =  1956, weight = 167 },
        },
    },

    [ID.TEMENOS_NORTHERN_TOWER.npc.ITEM_CRATES[3]] =
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
            quantity = 2,
            { item =  1956, weight =  27 },
            { item =  1932, weight = 324 },
            { item =  1950, weight =  80 },
            { item =  1934, weight = 189 },
            { item =  1930, weight =  50 },
            { item =  1940, weight =  27 },
            { item =  1936, weight =  81 },
            { item =  1944, weight =  80 },
            { item =  1958, weight =  81 },
            { item =  2658, weight = 270 },
            { item =  2714, weight = 108 },
        },
    },

    [ID.TEMENOS_NORTHERN_TOWER.npc.ITEM_CRATES[4]] =
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
            quantity = 2,
            { item =     0, weight = 300 },
            { item =  1942, weight =  90 },
            { item =  1934, weight = 435 },
            { item =  1956, weight =  80 },
            { item =  1940, weight = 174 },
            { item =  1958, weight =  87 },
            { item =  1954, weight =  90 },
            { item =  1936, weight =  87 },
            { item =  1930, weight =  43 },
            { item =  2656, weight =  27 },
            { item =  2658, weight = 261 },
        },
    },

    [ID.TEMENOS_NORTHERN_TOWER.npc.ITEM_CRATES[5]] =
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
            quantity = 2,
            { item =     0, weight = 200 },
            { item =  1954, weight =  67 },
            { item =  1940, weight = 353 },
            { item =  1936, weight =  87 },
            { item =  1956, weight = 110 },
            { item =  1958, weight =  87 },
            { item =  1942, weight =  50 },
            { item =  1950, weight =  60 },
            { item =  1932, weight =  59 },
            { item =  2716, weight = 100 },
            { item =  2714, weight = 110 },
        },
    },

    [ID.TEMENOS_NORTHERN_TOWER.npc.ITEM_CRATES[6]] =
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
            quantity = 2,
            { item =  1954, weight = 263 },
            { item =  1932, weight =  59 },
            { item =  1942, weight =  53 },
            { item =  1934, weight =  60 },
            { item =  1956, weight = 526 },
            { item =  1930, weight =  60 },
            { item =  1936, weight =  53 },
            { item =  1950, weight = 158 },
            { item =  2716, weight = 105 },
        },
    },

    [ID.TEMENOS_NORTHERN_TOWER.npc.LOOT_CRATE] =
    {
        {
            quantity = 6,
            { item =  1875, weight = 1000 },
        },

        {
            { item =  1956, weight = 240 },
            { item =  1932, weight = 120 },
            { item =  1940, weight = 200 },
            { item =  1934, weight =  40 },
            { item =  1954, weight = 120 },
            { item =  2658, weight = 200 },
            { item =  2716, weight =  80 },
        },

        {
            { item =  1904, weight = 1000 },
        },

        {
            { item =     0, weight = 100 },
            { item =  2127, weight =  55 },
        },
    },
}

return content:register()
