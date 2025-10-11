-----------------------------------
-- Season's Greetings
-- Balga's Dais KSNM, Clotho Orb
-- !additem 1175
-----------------------------------
local balgasID = zones[xi.zone.BALGAS_DAIS]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.BALGAS_DAIS,
    battlefieldId    = xi.battlefield.id.SEASONS_GREETINGS,
    maxPlayers       = 6,
    timeLimit        = utils.minutes(30),
    index            = 15,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.CLOTHO_ORB, wearMessage = balgasID.text.A_CRACK_HAS_FORMED, wornMessage = balgasID.text.ORB_IS_CRACKED },
    armouryCrates    =
    {
        balgasID.mob.GILAGOGE_TLUGVI + 4,
        balgasID.mob.GILAGOGE_TLUGVI + 9,
        balgasID.mob.GILAGOGE_TLUGVI + 14,
    },

    experimental     = true,
})

content.groups =
{
    {
        mobIds =
        {
            {
                balgasID.mob.GILAGOGE_TLUGVI,
                balgasID.mob.GILAGOGE_TLUGVI + 1,
                balgasID.mob.GILAGOGE_TLUGVI + 2,
                balgasID.mob.GILAGOGE_TLUGVI + 3,
            },

            {
                balgasID.mob.GILAGOGE_TLUGVI + 5,
                balgasID.mob.GILAGOGE_TLUGVI + 6,
                balgasID.mob.GILAGOGE_TLUGVI + 7,
                balgasID.mob.GILAGOGE_TLUGVI + 8,
            },

            {
                balgasID.mob.GILAGOGE_TLUGVI + 10,
                balgasID.mob.GILAGOGE_TLUGVI + 11,
                balgasID.mob.GILAGOGE_TLUGVI + 12,
                balgasID.mob.GILAGOGE_TLUGVI + 13,
            },
        },
        superlink = false,
        allDeath  = utils.bind(content.handleAllMonstersDefeated, content),
    },
}

content.loot =
{
    {
        { itemId = xi.item.GIL,                        weight = 1000, amount = 24000 },
    },

    {
        { itemId = xi.item.LACQUER_TREE_LOG,           weight = 350 },
        { itemId = xi.item.DIVINE_LOG,                 weight = 350 },
        { itemId = xi.item.SWORD_STRAP,                weight = 150 },
        { itemId = xi.item.POLE_GRIP,                  weight = 100 },
        { itemId = xi.item.SPEAR_STRAP,                weight = 150 },
    },

    {
        { itemId = xi.item.SUBDUER,                    weight = 200 },
        { itemId = xi.item.MORGENSTERN,                weight = 200 },
        { itemId = xi.item.RAMPAGER,                   weight = 200 },
        { itemId = xi.item.THYRSUSSTAB,                weight = 200 },
        { itemId = xi.item.EXPUNGER,                   weight = 200 },
    },

    {
        { itemId = xi.item.ADAMAN_INGOT,               weight = 250 },
        { itemId = xi.item.ORICHALCUM_INGOT,           weight = 250 },
        { itemId = xi.item.ROOT_SABOTS,                weight = 500 },
    },

    {
        { itemId = xi.item.DURANDAL,                   weight = 250 },
        { itemId = xi.item.HOPLITES_HARPE,             weight = 250 },
        { itemId = xi.item.SORROWFUL_HARP,             weight = 250 },
        { itemId = xi.item.ATTILAS_EARRING,            weight = 250 },
    },

    {
        { itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE,     weight =  50 },
        { itemId = xi.item.CHUNK_OF_GOLD_ORE,          weight =  50 },
        { itemId = xi.item.CHUNK_OF_MYTHRIL_ORE,       weight =  50 },
        { itemId = xi.item.CHUNK_OF_PLATINUM_ORE,      weight =  50 },
        { itemId = xi.item.EBONY_LOG,                  weight =  50 },
        { itemId = xi.item.MAHOGANY_LOG,               weight =  50 },
        { itemId = xi.item.PETRIFIED_LOG,              weight =  50 },
        { itemId = xi.item.PHILOSOPHERS_STONE,         weight =  50 },
        { itemId = xi.item.SPOOL_OF_GOLD_THREAD,       weight =  50 },
        { itemId = xi.item.SQUARE_OF_RAINBOW_CLOTH,    weight =  50 },
        { itemId = xi.item.SQUARE_OF_RAXA,             weight =  50 },
        { itemId = xi.item.CORAL_FRAGMENT,             weight =  50 },
        { itemId = xi.item.DEMON_HORN,                 weight =  50 },
        { itemId = xi.item.HANDFUL_OF_WYVERN_SCALES,   weight =  50 },
        { itemId = xi.item.RAM_HORN,                   weight =  50 },
        { itemId = xi.item.SLAB_OF_GRANITE,            weight =  50 },
        { itemId = xi.item.RERAISER,                   weight =  50 },
        { itemId = xi.item.HI_RERAISER,                weight =  50 },
        { itemId = xi.item.VILE_ELIXIR,                weight =  50 },
        { itemId = xi.item.VILE_ELIXIR_P1,             weight =  50 },
    },

    {
        { itemId = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD, weight =  63 },
        { itemId = xi.item.SQUARE_OF_DAMASCENE_CLOTH,  weight =  62 },
        { itemId = xi.item.DAMASCUS_INGOT,             weight =  62 },
        { itemId = xi.item.SPOOL_OF_MALBORO_FIBER,     weight =  63 },
        { itemId = xi.item.PHILOSOPHERS_STONE,         weight = 200 },
        { itemId = xi.item.PHOENIX_FEATHER,            weight = 350 },
        { itemId = xi.item.SQUARE_OF_RAXA,             weight = 200 },
    },
}

return content:register()
