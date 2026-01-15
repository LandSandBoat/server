-----------------------------------
-- Royal Jelly
-- Waughroon Shrine BCNM40, Star Orb
-- !additem 1131
-----------------------------------
local waughroonID = zones[xi.zone.WAUGHROON_SHRINE]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.WAUGHROON_SHRINE,
    battlefieldId    = xi.battlefield.id.ROYAL_JELLY,
    maxPlayers       = 3,
    levelCap         = 40,
    timeLimit        = utils.minutes(15),
    index            = 13,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.STAR_ORB, wearMessage = waughroonID.text.A_CRACK_HAS_FORMED, wornMessage = waughroonID.text.ORB_IS_CRACKED },

})

-- base queens that must be dead to get win, but doesn't start spawned
content:addEssentialMobs({ 'Queen_Jelly' })
content.groups[1].spawned = false

content:addEssentialMobs({ 'Princess_Jelly' })

content.loot =
{
    {
        { itemId = xi.item.GIL,                   weight = 10000, amount = 5000 },
    },

    {
        { itemId = xi.item.NONE,                  weight =  9000 },
        { itemId = xi.item.ARCHERS_RING,          weight =  1000 },
    },

    {
        { itemId = xi.item.MARKSMANS_RING,        weight =  4000 },
        { itemId = xi.item.DUSKY_STAFF,           weight =  1000 },
        { itemId = xi.item.HIMMEL_STOCK,          weight =  1000 },
        { itemId = xi.item.SEALED_MACE,           weight =  1000 },
        { itemId = xi.item.SHIKAR_BOW,            weight =  1000 },
    },

    {
        { itemId = xi.item.MANA_RING,             weight =  4000 },
        { itemId = xi.item.GRUDGE_SWORD,          weight =  1000 },
        { itemId = xi.item.DE_SAINTRES_AXE,       weight =  1000 },
        { itemId = xi.item.BUZZARD_TUCK,          weight =  1000 },
        { itemId = xi.item.SCROLL_OF_UTSUSEMI_NI, weight =  1000 },
    },

    {
        { itemId = xi.item.SCROLL_OF_ICE_SPIKES,  weight =  2500 },
        { itemId = xi.item.SCROLL_OF_REFRESH,     weight =  2000 },
        { itemId = xi.item.SCROLL_OF_UTSUSEMI_NI, weight =  1500 },
        { itemId = xi.item.MYTHRIL_BEASTCOIN,     weight =  1000 },
        { itemId = xi.item.GOLD_BEASTCOIN,        weight =  1000 },
        { itemId = xi.item.BLACK_ROCK,            weight =   100 },
        { itemId = xi.item.BLUE_ROCK,             weight =   100 },
        { itemId = xi.item.GREEN_ROCK,            weight =   100 },
        { itemId = xi.item.PURPLE_ROCK,           weight =   100 },
        { itemId = xi.item.RED_ROCK,              weight =   100 },
        { itemId = xi.item.TRANSLUCENT_ROCK,      weight =   100 },
        { itemId = xi.item.WHITE_ROCK,            weight =   100 },
        { itemId = xi.item.YELLOW_ROCK,           weight =   100 },
        { itemId = xi.item.AMETRINE,              weight =   100 },
        { itemId = xi.item.BLACK_PEARL,           weight =   100 },
        { itemId = xi.item.GARNET,                weight =   100 },
        { itemId = xi.item.GOSHENITE,             weight =   100 },
        { itemId = xi.item.PEARL,                 weight =   100 },
        { itemId = xi.item.PERIDOT,               weight =   100 },
        { itemId = xi.item.SPHENE,                weight =   100 },
        { itemId = xi.item.TURQUOISE,             weight =   100 },
        { itemId = xi.item.ROSEWOOD_LOG,          weight =   100 },
        { itemId = xi.item.OAK_LOG,               weight =   100 },
        { itemId = xi.item.VILE_ELIXIR,           weight =   100 },
        { itemId = xi.item.RERAISER,              weight =   100 },
    },

    {
        { itemId = xi.item.FIRE_SPIRIT_PACT,      weight =  2000 },
        { itemId = xi.item.SCROLL_OF_ABSORB_STR,  weight =  1000 },
        { itemId = xi.item.SCROLL_OF_ERASE,       weight =  2000 },
        { itemId = xi.item.SCROLL_OF_PHALANX,     weight =  2000 },
        { itemId = xi.item.STEEL_SHEET,           weight =  1500 },
        { itemId = xi.item.STEEL_INGOT,           weight =  1500 },
    },

    {
        quantity = 2,
        { itemId = xi.item.VIAL_OF_SLIME_OIL,     weight = 10000 },
    },
}

return content:register()
