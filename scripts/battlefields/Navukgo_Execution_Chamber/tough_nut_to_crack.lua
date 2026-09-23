-----------------------------------
-- Tough Nut to Crack
-- Navukgo Execution Chamber, Confidential Imperial Order
-- !addkeyitem CONFIDENTIAL_IMPERIAL_ORDER
-- TODO: Get real drop weights
-----------------------------------
local ID = zones[xi.zone.NAVUKGO_EXECUTION_CHAMBER]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.NAVUKGO_EXECUTION_CHAMBER,
    battlefieldId    = xi.battlefield.id.TOUGH_NUT_TO_CRACK,
    maxPlayers       = 6,
    levelCap         = 60,
    timeLimit        = utils.minutes(30),
    index            = 0,
    entryNpc         = '_1s0',
    exitNpcs         = { '_1s1', '_1s2', '_1s3' },
    requiredKeyItems = { xi.keyItem.CONFIDENTIAL_IMPERIAL_ORDER, onlyInitiator = true, message = ID.text.IMPERIAL_ORDER_BREAKS },
})

content:addEssentialMobs({ 'Watch_Wamoura' })

content.loot =
{
    {
        { itemId = xi.item.GIL,                         weight = 10000, amount = 8000 },
    },

    {
        { itemId = xi.item.NONE,                        weight =  5000 },
        { itemId = xi.item.GOBNIUS_RING,                weight =  1250 },
        { itemId = xi.item.BUSKERS_EARRING,             weight =  1250 },
        { itemId = xi.item.PIRATES_CAPE,                weight =  1250 },
        { itemId = xi.item.STRIKE_SUBLIGAR,             weight =  1250 },
    },

    {
        { itemId = xi.item.AGILITY_POTION,              weight =  2500 },
        { itemId = xi.item.VITALITY_POTION,             weight =  2500 },
        { itemId = xi.item.STRENGTH_POTION,             weight =  2500 },
        { itemId = xi.item.DEXTERITY_POTION,            weight =  2500 },
    },

    {
        { itemId = xi.item.CHUNK_OF_PLATINUM_ORE,       weight =  4000 },
        { itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE,      weight =  4000 },
        { itemId = xi.item.CHUNK_OF_ADAMAN_ORE,         weight =  1000 },
        { itemId = xi.item.CHUNK_OF_ORICHALCUM_ORE,     weight =  1000 },
    },

    {
        { itemId = xi.item.NONE,                        weight =  5000 },
        { itemId = xi.item.CHUNK_OF_PLATINUM_ORE,       weight =  2000 },
        { itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE,      weight =  2000 },
        { itemId = xi.item.CHUNK_OF_ADAMAN_ORE,         weight =   500 },
        { itemId = xi.item.CHUNK_OF_ORICHALCUM_ORE,     weight =   500 },
    },

    {
        { itemId = xi.item.NONE,                        weight =  5000 },
        { itemId = xi.item.ALUMINUM_SHEET,              weight =  1250 },
        { itemId = xi.item.IYO_SCALE,                   weight =  1250 },
        { itemId = xi.item.SQUARE_OF_MOBLINWEAVE,       weight =  1250 },
        { itemId = xi.item.PETRIFIED_LOG,               weight =  1250 },
    },

    {
        { itemId = xi.item.SCROLL_OF_AERO_IV,           weight =  1250 },
        { itemId = xi.item.SCROLL_OF_CARNAGE_ELEGY,     weight =  1250 },
        { itemId = xi.item.SCROLL_OF_MAIDENS_VIRELAI,   weight =  1250 },
        { itemId = xi.item.SCROLL_OF_FLARE,             weight =  1250 },
        { itemId = xi.item.SCROLL_OF_FLOOD,             weight =  1250 },
        { itemId = xi.item.SCROLL_OF_TORNADO,           weight =  1250 },
        { itemId = xi.item.DARK_SPIRIT_PACT,            weight =  1250 },
        { itemId = xi.item.LIGHT_SPIRIT_PACT,           weight =  1250 },
    },

    {
        { itemId = xi.item.GLASS_SHEET,                 weight =  2000 },
        { itemId = xi.item.BUNDLE_OF_HOMUNCULUS_NERVES, weight =  2000 },
        { itemId = xi.item.SQUARE_OF_POLYFLAN,          weight =  2000 },
        { itemId = xi.item.DEMON_HORN,                  weight =  2000 },
        { itemId = xi.item.MYTHRIL_GEAR_MACHINE,        weight =  2000 },
    },

    {
        { itemId = xi.item.CHOCOBO_EGG_A_LITTLE_WARM,   weight = 10000 },
    },

    {
        { itemId = xi.item.WAMOURA_COCOON,              weight = 10000 },
    },
}

return content:register()
