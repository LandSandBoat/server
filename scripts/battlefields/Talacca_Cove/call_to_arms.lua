-----------------------------------
-- Call to Arms
-- Talacca Cove, Confidential Imperial Order
-- !addkeyitem CONFIDENTIAL_IMPERIAL_ORDER
-----------------------------------
local ID = zones[xi.zone.TALACCA_COVE]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.TALACCA_COVE,
    battlefieldId    = xi.battlefield.id.CALL_TO_ARMS,
    maxPlayers       = 6,
    levelCap         = 60,
    timeLimit        = utils.minutes(30),
    index            = 0,
    entryNpc         = '_1l0',
    exitNpcs         = { '_1l1', '_1l2', '_1l3' },
    requiredKeyItems = { xi.ki.CONFIDENTIAL_IMPERIAL_ORDER, onlyInitiator = true, message = ID.text.IMPERIAL_ORDER_BREAKS },
})

content.groups = {
    {
        mobs = { 'Imp_Bandsman' },
    },

    {
        mobs     = { 'Imp_Bandsman', 'Imp_Bandsman_Add' },
        spawned  = false,
        allDeath = utils.bind(content.handleAllMonstersDefeated, content),
    },
}

content.loot =
{
    {
        { itemId = xi.item.GIL,                         weight = 10000, amount = 8000 },
    },

    {
        { itemId = xi.item.AGILITY_POTION,              weight =  2500 },
        { itemId = xi.item.VITALITY_POTION,             weight =  2500 },
        { itemId = xi.item.STRENGTH_POTION,             weight =  2500 },
        { itemId = xi.item.DEXTERITY_POTION,            weight =  2500 },
    },

    {
        { itemId = xi.item.GLASS_SHEET,                 weight =  2500 },
        { itemId = xi.item.BUNDLE_OF_HOMUNCULUS_NERVES, weight =  2500 },
        { itemId = xi.item.SQUARE_OF_POLYFLAN,          weight =  2500 },
        { itemId = xi.item.PETRIFIED_LOG,               weight =  2500 },
    },

    {
        { itemId = xi.item.SCROLL_OF_MAIDENS_VIRELAI,   weight =  1250 },
        { itemId = xi.item.SCROLL_OF_CARNAGE_ELEGY,     weight =  1250 },
        { itemId = xi.item.SCROLL_OF_AERO_IV,           weight =  1250 },
        { itemId = xi.item.SCROLL_OF_FLARE,             weight =  1250 },
        { itemId = xi.item.SCROLL_OF_FLOOD,             weight =  1250 },
        { itemId = xi.item.SCROLL_OF_TORNADO,           weight =  1250 },
        { itemId = xi.item.DARK_SPIRIT_PACT,            weight =  1250 },
        { itemId = xi.item.LIGHT_SPIRIT_PACT,           weight =  1250 },
    },

    {
        { itemId = xi.item.CHOCOBO_EGG_A_LITTLE_WARM,   weight = 10000 },
    },

    {
        { itemId = xi.item.IMP_WING,                    weight = 10000 },
    },

    {
        { itemId = xi.item.NONE,                        weight =  5000 },
        { itemId = xi.item.TEMPLAR_SABATONS,            weight =  1250 },
        { itemId = xi.item.BUSKERS_CAPE,                weight =  1250 },
        { itemId = xi.item.DOMINION_RING,               weight =  1250 },
        { itemId = xi.item.IMMORTALS_EARRING,           weight =  1250 },
    },

    {
        { itemId = xi.item.NONE,                        weight =  4000 },
        { itemId = xi.item.CHUNK_OF_PLATINUM_ORE,       weight =  1500 },
        { itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE,      weight =  1500 },
        { itemId = xi.item.CHUNK_OF_ADAMAN_ORE,         weight =  1500 },
        { itemId = xi.item.CHUNK_OF_ORICHALCUM_ORE,     weight =  1500 },
    },
}

return content:register()
