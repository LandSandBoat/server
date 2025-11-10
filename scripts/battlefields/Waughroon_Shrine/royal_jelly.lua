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
        quantity = 2,
        { itemId = xi.item.VIAL_OF_SLIME_OIL, weight = 1000 },
    },

    {
        { itemId = xi.item.NONE,         weight = 909 },
        { itemId = xi.item.ARCHERS_RING, weight =  91 },
    },

    {
        { itemId = xi.item.MANA_RING,             weight = 469 },
        { itemId = xi.item.GRUDGE_SWORD,          weight = 152 },
        { itemId = xi.item.DE_SAINTRES_AXE,       weight = 120 },
        { itemId = xi.item.BUZZARD_TUCK,          weight = 118 },
        { itemId = xi.item.SCROLL_OF_UTSUSEMI_NI, weight = 106 },
    },

    {
        { itemId = xi.item.MARKSMANS_RING, weight = 258 },
        { itemId = xi.item.DUSKY_STAFF,    weight = 152 },
        { itemId = xi.item.HIMMEL_STOCK,   weight = 101 },
        { itemId = xi.item.SEALED_MACE,    weight  = 98 },
        { itemId = xi.item.SHIKAR_BOW,     weight  = 98 },
    },

    {
        { itemId = xi.item.SCROLL_OF_ABSORB_STR, weight = 123 },
        { itemId = xi.item.SCROLL_OF_ERASE,      weight = 165 },
        { itemId = xi.item.SCROLL_OF_PHALANX,    weight = 140 },
        { itemId = xi.item.FIRE_SPIRIT_PACT,     weight = 145 },
        { itemId = xi.item.STEEL_SHEET,          weight = 229 },
        { itemId = xi.item.STEEL_INGOT,          weight = 238 },
    },

    {
        { itemId = xi.item.SCROLL_OF_REFRESH,     weight = 263 },
        { itemId = xi.item.SCROLL_OF_ICE_SPIKES,  weight = 246 },
        { itemId = xi.item.SCROLL_OF_UTSUSEMI_NI, weight = 177 },
        { itemId = xi.item.GOLD_BEASTCOIN,        weight = 182 },
        { itemId = xi.item.MYTHRIL_BEASTCOIN,     weight = 133 },
        { itemId = xi.item.PERIDOT,               weight =  27 },
        { itemId = xi.item.TURQUOISE,             weight =  20 },
        { itemId = xi.item.BLACK_PEARL,           weight =  15 },
        { itemId = xi.item.GOSHENITE,             weight =  15 },
        { itemId = xi.item.SPHENE,                weight =  15 },
        { itemId = xi.item.AMETRINE,              weight =  10 },
        { itemId = xi.item.GARNET,                weight =   7 },
        { itemId = xi.item.BLACK_ROCK,            weight =  12 },
        { itemId = xi.item.GREEN_ROCK,            weight =   7 },
        { itemId = xi.item.WHITE_ROCK,            weight =   7 },
        { itemId = xi.item.BLUE_ROCK,             weight =   2 },
        { itemId = xi.item.TRANSLUCENT_ROCK,      weight =   2 },
        { itemId = xi.item.OAK_LOG,               weight =   5 },
        { itemId = xi.item.ROSEWOOD_LOG,          weight =   5 },
        { itemId = xi.item.VILE_ELIXIR,           weight =  10 },
        { itemId = xi.item.RERAISER,              weight =   2 },
    },
}

return content:register()
