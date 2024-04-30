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
        { item = xi.item.GIL, weight = 1000, amount = 15000 }, -- Gil
    },

    {
        { item = xi.item.BLACK_PEARL, weight = 1000 }, -- Black Pearl
    },

    {
        quantity = 2,
        { item = xi.item.PEARL, weight = 1000 }, -- Pearl
    },

    {
        quantity = 3,
        { item = xi.item.PIECE_OF_OXBLOOD, weight = 1000 }, -- Piece Of Oxblood
    },

    {
        { item = xi.item.TELEPORT_RING_ALTEP, weight = 447 }, -- Teleport Ring Altep
        { item = xi.item.TELEPORT_RING_DEM,   weight = 487 }, -- Teleport Ring Dem
    },

    {
        { item = xi.item.AJARI_BEAD_NECKLACE, weight = 494 }, -- Ajari Bead Necklace
        { item = xi.item.PHILOMATH_STOLE,     weight = 449 }, -- Philomath Stole
    },

    {
        { item = xi.item.AQUAMARINE,       weight =  51 }, -- Aquamarine
        { item = xi.item.CHRYSOBERYL,      weight =  32 }, -- Chrysoberyl
        { item = xi.item.DARKSTEEL_INGOT,  weight =  39 }, -- Darksteel Ingot
        { item = xi.item.EBONY_LOG,        weight =  21 }, -- Ebony Log
        { item = xi.item.HI_RERAISER,      weight =  32 }, -- Hi-reraiser
        { item = xi.item.GOLD_INGOT,       weight =  55 }, -- Gold Ingot
        { item = xi.item.JADEITE,          weight =  62 }, -- Jadeite
        { item = xi.item.MYTHRIL_INGOT,    weight =  81 }, -- Mythril Ingot
        { item = xi.item.MOONSTONE,        weight =  56 }, -- Moonstone
        { item = xi.item.PAINITE,          weight = 195 }, -- Painite
        { item = xi.item.STEEL_INGOT,      weight =  58 }, -- Steel Ingot
        { item = xi.item.SUNSTONE,         weight =  38 }, -- Sunstone
        { item = xi.item.TRANSLUCENT_ROCK, weight =  11 }, -- Translucent Rock
        { item = xi.item.VILE_ELIXIR_P1,   weight =  21 }, -- Vile Elixir +1
        { item = xi.item.YELLOW_ROCK,      weight =  15 }, -- Yellow Rock
        { item = xi.item.ZIRCON,           weight =  26 }, -- Zircon
        { item = xi.item.RED_ROCK,         weight =  21 }, -- Red Rock
        { item = xi.item.MAHOGANY_LOG,     weight =  17 }, -- Mahogany Log
        { item = xi.item.BLUE_ROCK,        weight =   9 }, -- Blue Rock
        { item = xi.item.FLUORITE,         weight =  62 }, -- Fluorite
        { item = xi.item.PURPLE_ROCK,      weight =  11 }, -- Purple Rock
        { item = xi.item.BLACK_ROCK,       weight =  11 }, -- Black Rock
        { item = xi.item.GREEN_ROCK,       weight =  11 }, -- Green Rock
        { item = xi.item.WHITE_ROCK,       weight =   9 }, -- White Rock
    },

    {
        { item = xi.item.NONE,         weight =  939 }, -- Nothing
        { item = xi.item.KRAKEN_CLUB,  weight =    7 }, -- Kraken Club
        { item = xi.item.WALKURE_MASK, weight =   54 }, -- Walkure Mask
    },
}

return content:register()
