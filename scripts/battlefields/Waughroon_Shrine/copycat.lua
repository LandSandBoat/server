-----------------------------------
-- Copycat
-- Waughroon Shrine KSNM30, Clotho Orb
-- !additem 1175
-----------------------------------
local waughroonID = zones[xi.zone.WAUGHROON_SHRINE]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.WAUGHROON_SHRINE,
    battlefieldId    = xi.battlefield.id.COPYCAT,
    maxPlayers       = 6,
    timeLimit        = utils.minutes(30),
    index            = 16,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.CLOTHO_ORB, wearMessage = waughroonID.text.A_CRACK_HAS_FORMED, wornMessage = waughroonID.text.ORB_IS_CRACKED },
    armouryCrates    =
    {
        waughroonID.mob.OSSCHAART + 1,
        waughroonID.mob.OSSCHAART + 7,
        waughroonID.mob.OSSCHAART + 13,
    },
})

content.groups =
{
    {
        mobIds =
        {
            {
                waughroonID.mob.OSSCHAART,
            },

            {
                waughroonID.mob.OSSCHAART + 6,
            },

            {
                waughroonID.mob.OSSCHAART + 12,
            },
        },
        allDeath = utils.bind(content.handleAllMonstersDefeated, content),
    },

    {
        mobIds =
        {
            {
                waughroonID.mob.OSSCHAART + 2, -- Bat
                waughroonID.mob.OSSCHAART + 3, -- Wyvern
                waughroonID.mob.OSSCHAART + 4, -- Avatar
                waughroonID.mob.OSSCHAART + 5, -- Automaton
            },

            {
                waughroonID.mob.OSSCHAART + 8,  -- Bat
                waughroonID.mob.OSSCHAART + 9,  -- Wyvern
                waughroonID.mob.OSSCHAART + 10, -- Avatar
                waughroonID.mob.OSSCHAART + 11, -- Automaton
            },

            {
                waughroonID.mob.OSSCHAART + 14, -- Bat
                waughroonID.mob.OSSCHAART + 15, -- Wyvern
                waughroonID.mob.OSSCHAART + 16, -- Avatar
                waughroonID.mob.OSSCHAART + 17, -- Automaton
            },
        },
        spawned = false,
    },
}

content.loot =
{
    {
        { itemId = xi.item.GIL,                        weight = 10000, amount = 24000 },
    },

    {
        { itemId = xi.item.ADAMAN_INGOT,               weight = 10000 },
    },

    {
        { itemId = xi.item.COFFINMAKER,                weight =  2500 },
        { itemId = xi.item.DESTROYERS,                 weight =  2500 },
        { itemId = xi.item.EXPUNGER,                   weight =  2500 },
        { itemId = xi.item.RETRIBUTOR,                 weight =  2500 },
    },

    {
        { itemId = xi.item.AHRIMAN_LENS,               weight =  3500 },
        { itemId = xi.item.AHRIMAN_WING,               weight =  3500 },
        { itemId = xi.item.SWORD_STRAP,                weight =  1500 },
        { itemId = xi.item.POLE_GRIP,                  weight =  1000 },
        { itemId = xi.item.SPEAR_STRAP,                weight =  1500 },
    },

    {
        { itemId = xi.item.ADAMAN_INGOT,               weight =  2500 },
        { itemId = xi.item.ORICHALCUM_INGOT,           weight =  2500 },
        { itemId = xi.item.FUMA_SUNE_ATE,              weight =  5000 },
    },

    {
        { itemId = xi.item.DURANDAL,                   weight =  2500 },
        { itemId = xi.item.HOPLITES_HARPE,             weight =  2500 },
        { itemId = xi.item.SORROWFUL_HARP,             weight =  2500 },
        { itemId = xi.item.ATTILAS_EARRING,            weight =  2500 },
    },

    {
        { itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE,     weight =   500 },
        { itemId = xi.item.CHUNK_OF_GOLD_ORE,          weight =   500 },
        { itemId = xi.item.CHUNK_OF_MYTHRIL_ORE,       weight =   500 },
        { itemId = xi.item.CHUNK_OF_PLATINUM_ORE,      weight =   500 },
        { itemId = xi.item.EBONY_LOG,                  weight =   500 },
        { itemId = xi.item.MAHOGANY_LOG,               weight =   500 },
        { itemId = xi.item.PETRIFIED_LOG,              weight =   500 },
        { itemId = xi.item.PHILOSOPHERS_STONE,         weight =   500 },
        { itemId = xi.item.SPOOL_OF_GOLD_THREAD,       weight =   500 },
        { itemId = xi.item.SQUARE_OF_RAINBOW_CLOTH,    weight =   500 },
        { itemId = xi.item.SQUARE_OF_RAXA,             weight =   500 },
        { itemId = xi.item.CORAL_FRAGMENT,             weight =   500 },
        { itemId = xi.item.DEMON_HORN,                 weight =   500 },
        { itemId = xi.item.HANDFUL_OF_WYVERN_SCALES,   weight =   500 },
        { itemId = xi.item.RAM_HORN,                   weight =   500 },
        { itemId = xi.item.SLAB_OF_GRANITE,            weight =   500 },
        { itemId = xi.item.RERAISER,                   weight =   500 },
        { itemId = xi.item.HI_RERAISER,                weight =   500 },
        { itemId = xi.item.VILE_ELIXIR,                weight =   500 },
        { itemId = xi.item.VILE_ELIXIR_P1,             weight =   500 },
    },

    {
        { itemId = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD, weight =   625 },
        { itemId = xi.item.SQUARE_OF_DAMASCENE_CLOTH,  weight =   625 },
        { itemId = xi.item.DAMASCUS_INGOT,             weight =   625 },
        { itemId = xi.item.SPOOL_OF_MALBORO_FIBER,     weight =   625 },
        { itemId = xi.item.PHILOSOPHERS_STONE,         weight =  2000 },
        { itemId = xi.item.PHOENIX_FEATHER,            weight =  3500 },
        { itemId = xi.item.SQUARE_OF_RAXA,             weight =  2000 },
    },
}

return content:register()
