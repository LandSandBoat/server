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
        { itemId = xi.item.GIL,                 weight = 10000, amount = 15000 },
    },

    {
        { itemId = xi.item.BLACK_PEARL,         weight = 10000 },
    },

    {
        quantity = 2,
        { itemId = xi.item.PEARL,               weight = 10000 },
    },

    {
        quantity = 3,
        { itemId = xi.item.PIECE_OF_OXBLOOD,    weight = 10000 },
    },

    {
        { itemId = xi.item.TELEPORT_RING_ALTEP, weight =  5000 },
        { itemId = xi.item.TELEPORT_RING_DEM,   weight =  5000 },
    },

    {
        { itemId = xi.item.AJARI_BEAD_NECKLACE, weight =  4750 },
        { itemId = xi.item.PHILOMATH_STOLE,     weight =  4750 },
        { itemId = xi.item.WALKURE_MASK,        weight =   500 },
    },

    {
        { itemId = xi.item.AQUAMARINE,          weight =   400 },
        { itemId = xi.item.CHRYSOBERYL,         weight =   400 },
        { itemId = xi.item.FLUORITE,            weight =   400 },
        { itemId = xi.item.JADEITE,             weight =   400 },
        { itemId = xi.item.MOONSTONE,           weight =   400 },
        { itemId = xi.item.PAINITE,             weight =   400 },
        { itemId = xi.item.SUNSTONE,            weight =   400 },
        { itemId = xi.item.ZIRCON,              weight =   400 },
        { itemId = xi.item.BLACK_ROCK,          weight =   400 },
        { itemId = xi.item.BLUE_ROCK,           weight =   400 },
        { itemId = xi.item.GREEN_ROCK,          weight =   400 },
        { itemId = xi.item.PURPLE_ROCK,         weight =   400 },
        { itemId = xi.item.RED_ROCK,            weight =   400 },
        { itemId = xi.item.TRANSLUCENT_ROCK,    weight =   400 },
        { itemId = xi.item.WHITE_ROCK,          weight =   400 },
        { itemId = xi.item.YELLOW_ROCK,         weight =   400 },
        { itemId = xi.item.EBONY_LOG,           weight =   400 },
        { itemId = xi.item.MAHOGANY_LOG,        weight =   400 },
        { itemId = xi.item.DARKSTEEL_INGOT,     weight =   400 },
        { itemId = xi.item.GOLD_INGOT,          weight =   400 },
        { itemId = xi.item.MYTHRIL_INGOT,       weight =   400 },
        { itemId = xi.item.STEEL_INGOT,         weight =   400 },
        { itemId = xi.item.DEMON_HORN,          weight =   400 },
        { itemId = xi.item.CORAL_FRAGMENT,      weight =   400 },
        { itemId = xi.item.HI_RERAISER,         weight =   200 },
        { itemId = xi.item.VILE_ELIXIR_P1,      weight =   200 },
    },

    -- This drop rate is not a mistake
    -- https://www.ffxiah.com/forum/topic/54987/up-in-arms-bcnm/2/#3648004
    -- Thorny noted only 3 drops out of 17,000 runs. Extremely rare.
    -- BG Wiki States its also "signficantly rarer" than UR. (.1%)
    {
        { itemId = xi.item.NONE,                weight =  9999 },
        { itemId = xi.item.KRAKEN_CLUB,         weight =     1 },
    },
}

return content:register()
