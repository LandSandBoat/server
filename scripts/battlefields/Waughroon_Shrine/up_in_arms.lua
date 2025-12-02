-----------------------------------
-- Up in Arms
-- Waughroon Shrine BCNM60, Moon Orb
-- !additem 1130
-----------------------------------
local waughroonID = zones[xi.zone.WAUGHROON_SHRINE]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.WAUGHROON_SHRINE,
    battlefieldId    = xi.battlefield.id.UP_IN_ARMS,
    maxPlayers       = 3,
    levelCap         = 60,
    timeLimit        = utils.minutes(15),
    index            = 15,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.MOON_ORB, wearMessage = waughroonID.text.A_CRACK_HAS_FORMED, wornMessage = waughroonID.text.ORB_IS_CRACKED },
})

content:addEssentialMobs({ 'Fee' })

content.loot =
{
    {
        { itemId = xi.item.GIL, weight = 1000, amount = 15000 }, -- Gil
    },

    {
        { itemId = xi.item.BLACK_PEARL, weight = 1000 }, -- Black Pearl
    },

    {
        quantity = 2,
        { itemId = xi.item.PEARL, weight = 1000 }, -- Pearl
    },

    {
        quantity = 3,
        { itemId = xi.item.PIECE_OF_OXBLOOD, weight = 1000 }, -- Piece Of Oxblood
    },

    {
        { itemId = xi.item.TELEPORT_RING_ALTEP, weight = 447 }, -- Teleport Ring Altep
        { itemId = xi.item.TELEPORT_RING_DEM,   weight = 487 }, -- Teleport Ring Dem
    },

    {
        { itemId = xi.item.AJARI_BEAD_NECKLACE, weight = 494 }, -- Ajari Bead Necklace
        { itemId = xi.item.PHILOMATH_STOLE,     weight = 449 }, -- Philomath Stole
    },

    {
        { itemId = xi.item.AQUAMARINE,       weight =  51 }, -- Aquamarine
        { itemId = xi.item.CHRYSOBERYL,      weight =  32 }, -- Chrysoberyl
        { itemId = xi.item.DARKSTEEL_INGOT,  weight =  39 }, -- Darksteel Ingot
        { itemId = xi.item.EBONY_LOG,        weight =  21 }, -- Ebony Log
        { itemId = xi.item.HI_RERAISER,      weight =  32 }, -- Hi-reraiser
        { itemId = xi.item.GOLD_INGOT,       weight =  55 }, -- Gold Ingot
        { itemId = xi.item.JADEITE,          weight =  62 }, -- Jadeite
        { itemId = xi.item.MYTHRIL_INGOT,    weight =  81 }, -- Mythril Ingot
        { itemId = xi.item.MOONSTONE,        weight =  56 }, -- Moonstone
        { itemId = xi.item.PAINITE,          weight = 195 }, -- Painite
        { itemId = xi.item.STEEL_INGOT,      weight =  58 }, -- Steel Ingot
        { itemId = xi.item.SUNSTONE,         weight =  38 }, -- Sunstone
        { itemId = xi.item.TRANSLUCENT_ROCK, weight =  11 }, -- Translucent Rock
        { itemId = xi.item.VILE_ELIXIR_P1,   weight =  21 }, -- Vile Elixir +1
        { itemId = xi.item.YELLOW_ROCK,      weight =  15 }, -- Yellow Rock
        { itemId = xi.item.ZIRCON,           weight =  26 }, -- Zircon
        { itemId = xi.item.RED_ROCK,         weight =  21 }, -- Red Rock
        { itemId = xi.item.MAHOGANY_LOG,     weight =  17 }, -- Mahogany Log
        { itemId = xi.item.BLUE_ROCK,        weight =   9 }, -- Blue Rock
        { itemId = xi.item.FLUORITE,         weight =  62 }, -- Fluorite
        { itemId = xi.item.PURPLE_ROCK,      weight =  11 }, -- Purple Rock
        { itemId = xi.item.BLACK_ROCK,       weight =  11 }, -- Black Rock
        { itemId = xi.item.GREEN_ROCK,       weight =  11 }, -- Green Rock
        { itemId = xi.item.WHITE_ROCK,       weight =   9 }, -- White Rock
    },

    {
        { itemId = xi.item.NONE,         weight =  939 }, -- Nothing
        { itemId = xi.item.KRAKEN_CLUB,  weight =    7 }, -- Kraken Club
        { itemId = xi.item.WALKURE_MASK, weight =   54 }, -- Walkure Mask
    },
}

return content:register()
