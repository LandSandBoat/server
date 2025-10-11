-----------------------------------
-- Royale Ramble
-- Balga's Dais KSNM, Lachesis Orb
-- !additem 1178
-- TODO Code Queen of Cups / Batons spawning when any King engaged. Add mechanics & spell lists. (the other kings despawn) - Check functionality of Trump Crown. Fix spawn points.
-----------------------------------
local balgasID = zones[xi.zone.BALGAS_DAIS]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.BALGAS_DAIS,
    battlefieldId    = xi.battlefield.id.ROYALE_RAMBLE,
    maxPlayers       = 6,
    timeLimit        = utils.minutes(30),
    index            = 16,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.LACHESIS_ORB, wearMessage = balgasID.text.A_CRACK_HAS_FORMED, wornMessage = balgasID.text.ORB_IS_CRACKED },
    armouryCrates    =
    {
        balgasID.mob.KING_OF_CUPS + 6,
        balgasID.mob.KING_OF_CUPS + 13,
        balgasID.mob.KING_OF_CUPS + 20,
    },

    experimental     = true,
})

content.groups =
{
    {
        mobs      = { 'King_of_Cups', 'King_of_Batons', 'King_of_Swords', 'King_of_Coins' },
        allDeath  = utils.bind(content.handleAllMonstersDefeated, content),
    },

    {
        mobs      = { 'Queens_of_Cups', 'Queen_of_Batons' },
        spawned  = false,
    },
}

content.loot =
{
    {
        { itemId = xi.item.GIL,                        weight = 1000, amount = 24000 },
    },

    {
        { itemId = xi.item.KING_OF_CUPS_CARD,          weight = 250 },
        { itemId = xi.item.KING_OF_BATONS_CARD,        weight = 250 },
        { itemId = xi.item.KING_OF_SWORDS_CARD,        weight = 250 },
        { itemId = xi.item.KING_OF_COINS_CARD,         weight = 250 },
    },

    {
        { itemId = xi.item.ORICHALCUM_INGOT,           weight = 1000 },
    },

    {
        { itemId = xi.item.COFFINMAKER,                weight = 250 },
        { itemId = xi.item.DESTROYERS,                 weight = 250 },
        { itemId = xi.item.DISSECTOR,                  weight = 250 },
        { itemId = xi.item.GONDO_SHIZUNORI,            weight = 250 },
    },

    {
        { itemId = xi.item.TRUMP_CROWN,                weight = 600 },
        { itemId = xi.item.CLAYMORE_GRIP,              weight = 100 },
        { itemId = xi.item.POLE_GRIP,                  weight = 100 },
        { itemId = xi.item.SWORD_STRAP,                weight = 200 },
    },

    {
        { itemId = xi.item.HIERARCH_BELT,              weight = 250 },
        { itemId = xi.item.PALMERINS_SHIELD,           weight = 250 },
        { itemId = xi.item.TRAINERS_GLOVES,            weight = 250 },
        { itemId = xi.item.WARWOLF_BELT,               weight = 250 },
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
