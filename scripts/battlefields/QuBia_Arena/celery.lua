-----------------------------------
-- Celery
-- Qu'Bia Arena BCNM60, Moon Orb
-- !additem 1130
-----------------------------------
local qubiaID = zones[xi.zone.QUBIA_ARENA]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.QUBIA_ARENA,
    battlefieldId    = xi.battlefield.id.CELERY,
    maxPlayers       = 3,
    levelCap         = 60,
    timeLimit        = utils.minutes(15),
    index            = 16,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.MOON_ORB, wearMessage = qubiaID.text.A_CRACK_HAS_FORMED, wornMessage = qubiaID.text.ORB_IS_CRACKED },
})

content:addEssentialMobs({ 'Annihilated_Anthony', 'Shredded_Samson', 'Mauled_Murdock', 'Punctured_Percy' })

content.loot =
{
    {
        { itemId = xi.item.LIBATION_ABJURATION,     weight = 10000 },
    },

    {
        { itemId = xi.item.OBLATION_ABJURATION,     weight = 10000 },
    },

    {
        { itemId = xi.item.SQUARE_OF_RAINBOW_CLOTH, weight = 10000 },
    },

    {
        quantity = 3,
        { itemId = xi.item.SQUARE_OF_SILK_CLOTH,    weight = 10000 },
    },

    {
        { itemId = xi.item.TELEPORT_RING_DEM,       weight =  2500 },
        { itemId = xi.item.TELEPORT_RING_MEA,       weight =  2500 },
        { itemId = xi.item.NURSEMAIDS_HARP,         weight =  2500 },
        { itemId = xi.item.TRAILERS_KUKRI,          weight =  2500 },
    },

    {
        { itemId = xi.item.ELUSIVE_EARRING,         weight =  2500 },
        { itemId = xi.item.KNIGHTLY_MANTLE,         weight =  2500 },
        { itemId = xi.item.HI_ETHER_TANK,           weight =  2500 },
        { itemId = xi.item.HI_POTION_TANK,          weight =  2500 },
    },

    {
        { itemId = xi.item.NONE,                    weight =  9500 },
        { itemId = xi.item.WALKURE_MASK,            weight =   500 },
    },

    {
        { itemId = xi.item.AQUAMARINE,              weight =   500 },
        { itemId = xi.item.CHRYSOBERYL,             weight =   500 },
        { itemId = xi.item.DARKSTEEL_INGOT,         weight =  1000 },
        { itemId = xi.item.EBONY_LOG,               weight =   500 },
        { itemId = xi.item.FLUORITE,                weight =   500 },
        { itemId = xi.item.GOLD_INGOT,              weight =   500 },
        { itemId = xi.item.HI_RERAISER,             weight =   500 },
        { itemId = xi.item.JADEITE,                 weight =   500 },
        { itemId = xi.item.MAHOGANY_LOG,            weight =   500 },
        { itemId = xi.item.MOONSTONE,               weight =   500 },
        { itemId = xi.item.MYTHRIL_INGOT,           weight =   500 },
        { itemId = xi.item.PAINITE,                 weight =   500 },
        { itemId = xi.item.RED_ROCK,                weight =   500 },
        { itemId = xi.item.STEEL_INGOT,             weight =   500 },
        { itemId = xi.item.SUNSTONE,                weight =   500 },
        { itemId = xi.item.TRANSLUCENT_ROCK,        weight =   500 },
        { itemId = xi.item.WHITE_ROCK,              weight =   500 },
        { itemId = xi.item.VILE_ELIXIR_P1,          weight =   500 },
        { itemId = xi.item.ZIRCON,                  weight =   500 },
    },
}

return content:register()
