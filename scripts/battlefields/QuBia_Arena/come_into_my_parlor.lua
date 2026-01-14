-----------------------------------
-- Come Into My Parlor
-- Qu'Bia Arena KSNM(30), Clotho Orb
-- !additem 1175
-----------------------------------
local qubiaID = zones[xi.zone.QUBIA_ARENA]
-----------------------------------

local content = Battlefield:new({
    zoneId        = xi.zone.QUBIA_ARENA,
    battlefieldId = xi.battlefield.id.COME_INTO_MY_PARLOR,
    maxPlayers    = 6,
    timeLimit     = utils.minutes(30),
    index         = 1,
    entryNpc      = 'BC_Entrance',
    exitNpc       = 'Burning_Circle',
    requiredItems = { xi.item.CLOTHO_ORB, wearMessage = qubiaID.text.A_CRACK_HAS_FORMED, wornMessage = qubiaID.text.ORB_IS_CRACKED },
})

content.groups =
{
    {
        mobs     = { 'Anansi' },
    },

    {
        mobs     = { 'Son_of_Anansi' },
        spawned  = false,
        allDeath = utils.bind(content.handleAllMonstersDefeated, content),
    }
}

content.loot =
{
    {
        { itemId = xi.item.GIL,                        weight = 10000, amount = 24000 },
    },

    {
        { itemId = xi.item.NONE,                       weight =  1000 },
        { itemId = xi.item.GUARDIAN_EARRING,           weight =   600 },
        { itemId = xi.item.KAMPFER_EARRING,            weight =   600 },
        { itemId = xi.item.CONJURERS_EARRING,          weight =   600 },
        { itemId = xi.item.SHINOBI_EARRING,            weight =   600 },
        { itemId = xi.item.TRACKERS_EARRING,           weight =   600 },
        { itemId = xi.item.SORCERERS_EARRING,          weight =   600 },
        { itemId = xi.item.SOLDIERS_EARRING,           weight =   600 },
        { itemId = xi.item.TAMERS_EARRING,             weight =   600 },
        { itemId = xi.item.MEDICINE_EARRING,           weight =   600 },
        { itemId = xi.item.DRAKE_EARRING,              weight =   600 },
        { itemId = xi.item.FENCERS_EARRING,            weight =   600 },
        { itemId = xi.item.MINSTRELS_EARRING,          weight =   600 },
        { itemId = xi.item.ROGUES_EARRING,             weight =   600 },
        { itemId = xi.item.RONIN_EARRING,              weight =   600 },
        { itemId = xi.item.SLAYERS_EARRING,            weight =   600 },
    },

    {
        { itemId = xi.item.NONE,                       weight =  3000 },
        { itemId = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD, weight =   435 },
        { itemId = xi.item.SQUARE_OF_DAMASCENE_CLOTH,  weight =   435 },
        { itemId = xi.item.DAMASCUS_INGOT,             weight =   435 },
        { itemId = xi.item.SPOOL_OF_MALBORO_FIBER,     weight =   435 },
        { itemId = xi.item.PHILOSOPHERS_STONE,         weight =  1400 },
        { itemId = xi.item.PHOENIX_FEATHER,            weight =  2450 },
        { itemId = xi.item.SQUARE_OF_RAXA,             weight =  1400 },
    },

    {
        { itemId = xi.item.OCEAN_ROPE,                 weight =  1600 },
        { itemId = xi.item.JUNGLE_ROPE,                weight =  1600 },
        { itemId = xi.item.STEPPE_ROPE,                weight =  1600 },
        { itemId = xi.item.DESERT_ROPE,                weight =  1600 },
        { itemId = xi.item.FOREST_ROPE,                weight =  1600 },
        { itemId = xi.item.SCROLL_OF_CURE_V,           weight =   400 },
        { itemId = xi.item.SCROLL_OF_SHELL_IV,         weight =   400 },
        { itemId = xi.item.LIGHT_SPIRIT_PACT,          weight =   400 },
        { itemId = xi.item.SCROLL_OF_RAISE_III,        weight =   400 },
        { itemId = xi.item.SCROLL_OF_THUNDER_III,      weight =   400 },
    },

    {
        { itemId = xi.item.NONE,                       weight =  7000 },
        { itemId = xi.item.GUARDIAN_EARRING,           weight =   200 },
        { itemId = xi.item.KAMPFER_EARRING,            weight =   200 },
        { itemId = xi.item.CONJURERS_EARRING,          weight =   200 },
        { itemId = xi.item.SHINOBI_EARRING,            weight =   200 },
        { itemId = xi.item.TRACKERS_EARRING,           weight =   200 },
        { itemId = xi.item.SORCERERS_EARRING,          weight =   200 },
        { itemId = xi.item.SOLDIERS_EARRING,           weight =   200 },
        { itemId = xi.item.TAMERS_EARRING,             weight =   200 },
        { itemId = xi.item.MEDICINE_EARRING,           weight =   200 },
        { itemId = xi.item.DRAKE_EARRING,              weight =   200 },
        { itemId = xi.item.FENCERS_EARRING,            weight =   200 },
        { itemId = xi.item.MINSTRELS_EARRING,          weight =   200 },
        { itemId = xi.item.ROGUES_EARRING,             weight =   200 },
        { itemId = xi.item.RONIN_EARRING,              weight =   200 },
        { itemId = xi.item.SLAYERS_EARRING,            weight =   200 },
    },

    {
        { itemId = xi.item.NONE,                       weight =  2500 },
        { itemId = xi.item.VILE_ELIXIR,                weight =  1250 },
        { itemId = xi.item.VILE_ELIXIR_P1,             weight =  1250 },
        { itemId = xi.item.CLAYMORE_GRIP,              weight =  1500 },
        { itemId = xi.item.POLE_GRIP,                  weight =  2000 },
        { itemId = xi.item.SPEAR_STRAP,                weight =  1500 },
    },

    {
        { itemId = xi.item.NONE,                       weight =  3600 },
        { itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE,     weight =   400 },
        { itemId = xi.item.CHUNK_OF_GOLD_ORE,          weight =   400 },
        { itemId = xi.item.CHUNK_OF_MYTHRIL_ORE,       weight =   400 },
        { itemId = xi.item.CHUNK_OF_PLATINUM_ORE,      weight =   400 },
        { itemId = xi.item.EBONY_LOG,                  weight =   400 },
        { itemId = xi.item.MAHOGANY_LOG,               weight =   400 },
        { itemId = xi.item.PETRIFIED_LOG,              weight =   400 },
        { itemId = xi.item.PHILOSOPHERS_STONE,         weight =   400 },
        { itemId = xi.item.SPOOL_OF_GOLD_THREAD,       weight =   400 },
        { itemId = xi.item.SQUARE_OF_RAINBOW_CLOTH,    weight =   400 },
        { itemId = xi.item.SQUARE_OF_RAXA,             weight =   400 },
        { itemId = xi.item.CORAL_FRAGMENT,             weight =   400 },
        { itemId = xi.item.DEMON_HORN,                 weight =   400 },
        { itemId = xi.item.HANDFUL_OF_WYVERN_SCALES,   weight =   400 },
        { itemId = xi.item.RAM_HORN,                   weight =   400 },
        { itemId = xi.item.SLAB_OF_GRANITE,            weight =   400 },
    },

    {
        { itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE,     weight =   550 },
        { itemId = xi.item.CHUNK_OF_GOLD_ORE,          weight =   560 },
        { itemId = xi.item.CHUNK_OF_MYTHRIL_ORE,       weight =   560 },
        { itemId = xi.item.CHUNK_OF_PLATINUM_ORE,      weight =   550 },
        { itemId = xi.item.EBONY_LOG,                  weight =   560 },
        { itemId = xi.item.MAHOGANY_LOG,               weight =   560 },
        { itemId = xi.item.PETRIFIED_LOG,              weight =   550 },
        { itemId = xi.item.PHILOSOPHERS_STONE,         weight =   550 },
        { itemId = xi.item.SPOOL_OF_GOLD_THREAD,       weight =   560 },
        { itemId = xi.item.SQUARE_OF_RAINBOW_CLOTH,    weight =   560 },
        { itemId = xi.item.SQUARE_OF_RAXA,             weight =   550 },
        { itemId = xi.item.CORAL_FRAGMENT,             weight =   550 },
        { itemId = xi.item.DEMON_HORN,                 weight =   550 },
        { itemId = xi.item.HANDFUL_OF_WYVERN_SCALES,   weight =   550 },
        { itemId = xi.item.RAM_HORN,                   weight =   560 },
        { itemId = xi.item.SLAB_OF_GRANITE,            weight =   560 },
        { itemId = xi.item.RERAISER,                   weight =   560 },
        { itemId = xi.item.HI_RERAISER,                weight =   560 },
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
