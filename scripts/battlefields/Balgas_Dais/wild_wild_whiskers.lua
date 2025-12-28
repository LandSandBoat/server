-----------------------------------
-- Wild Wild Whiskers
-- Balga's Dais BCNM60, Moon Orb
-- !additem 1130
-----------------------------------
local balgasID = zones[xi.zone.BALGAS_DAIS]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.BALGAS_DAIS,
    battlefieldId    = xi.battlefield.id.WILD_WILD_WHISKERS,
    maxPlayers       = 3,
    levelCap         = 60,
    timeLimit        = utils.minutes(15),
    index            = 14,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.MOON_ORB, wearMessage = balgasID.text.A_CRACK_HAS_FORMED, wornMessage = balgasID.text.ORB_IS_CRACKED },
})

content:addEssentialMobs({ 'Macan_Gadangan' })

content.loot =
{
    {
        { itemId = xi.item.GIL,                      weight = 10000, amount = 15000 },
    },

    {
        quantity = 3,
        { itemId = xi.item.HIGH_QUALITY_COEURL_HIDE, weight = 10000 },
    },

    {
        { itemId = xi.item.CHUNK_OF_ADAMAN_ORE,      weight = 10000 },
    },

    {
        { itemId = xi.item.HERMES_QUENCHER,          weight = 10000 },
    },

    {
        { itemId = xi.item.ICARUS_WING,              weight = 10000 },
    },

    {
        { itemId = xi.item.GLEEMANS_BELT,            weight =  3500 },
        { itemId = xi.item.PENITENTS_ROPE,           weight =  6500 },
    },

    {
        { itemId = xi.item.TELEPORT_RING_MEA,        weight =  5000 },
        { itemId = xi.item.TELEPORT_RING_YHOAT,      weight =  5000 },
    },

    {
        { itemId = xi.item.NONE,                     weight =  9500 },
        { itemId = xi.item.WALKURE_MASK,             weight =   500 },
    },

    {
        { itemId = xi.item.RED_ROCK,                 weight =   400 },
        { itemId = xi.item.YELLOW_ROCK,              weight =   400 },
        { itemId = xi.item.BLUE_ROCK,                weight =   400 },
        { itemId = xi.item.GREEN_ROCK,               weight =   400 },
        { itemId = xi.item.TRANSLUCENT_ROCK,         weight =   400 },
        { itemId = xi.item.PURPLE_ROCK,              weight =   400 },
        { itemId = xi.item.WHITE_ROCK,               weight =   400 },
        { itemId = xi.item.BLACK_ROCK,               weight =   400 },
        { itemId = xi.item.AQUAMARINE,               weight =   400 },
        { itemId = xi.item.CHRYSOBERYL,              weight =   400 },
        { itemId = xi.item.FLUORITE,                 weight =   400 },
        { itemId = xi.item.JADEITE,                  weight =   400 },
        { itemId = xi.item.MOONSTONE,                weight =   400 },
        { itemId = xi.item.PAINITE,                  weight =   400 },
        { itemId = xi.item.SUNSTONE,                 weight =   400 },
        { itemId = xi.item.ZIRCON,                   weight =   400 },
        { itemId = xi.item.MAHOGANY_LOG,             weight =   400 },
        { itemId = xi.item.EBONY_LOG,                weight =   400 },
        { itemId = xi.item.STEEL_INGOT,              weight =   400 },
        { itemId = xi.item.MYTHRIL_INGOT,            weight =   400 },
        { itemId = xi.item.GOLD_INGOT,               weight =   400 },
        { itemId = xi.item.DARKSTEEL_INGOT,          weight =   400 },
        { itemId = xi.item.HI_RERAISER,              weight =   600 },
        { itemId = xi.item.VILE_ELIXIR_P1,           weight =   600 },
    },
}

return content:register()
