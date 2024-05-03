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

    experimental = true,
})

-- base queens that must be dead to get win, but doesn't start spawned
content:addEssentialMobs({ 'Queen_Jelly' })
content.groups[1].spawned = false

content:addEssentialMobs({ 'Princess_Jelly' })

content.loot =
{
    {
        quantity = 2,
        { item = xi.item.VIAL_OF_SLIME_OIL, weight = 1000 },
    },

    {
        { item = xi.item.NONE,         weight = 909 },
        { item = xi.item.ARCHERS_RING, weight =  91 },
    },

    {
        { item = xi.item.MANA_RING,             weight = 469 },
        { item = xi.item.GRUDGE_SWORD,          weight = 152 },
        { item = xi.item.DE_SAINTRES_AXE,       weight = 120 },
        { item = xi.item.BUZZARD_TUCK,          weight = 118 },
        { item = xi.item.SCROLL_OF_UTSUSEMI_NI, weight = 106 },
    },

    {
        { item = xi.item.MARKSMANS_RING, weight = 258 },
        { item = xi.item.DUSKY_STAFF,    weight = 152 },
        { item = xi.item.HIMMEL_STOCK,   weight = 101 },
        { item = xi.item.SEALED_MACE,    weight  = 98 },
        { item = xi.item.SHIKAR_BOW,     weight  = 98 },
    },

    {
        { item = xi.item.SCROLL_OF_ABSORB_STR, weight = 123 },
        { item = xi.item.SCROLL_OF_ERASE,      weight = 165 },
        { item = xi.item.SCROLL_OF_PHALANX,    weight = 140 },
        { item = xi.item.FIRE_SPIRIT_PACT,     weight = 145 },
        { item = xi.item.STEEL_SHEET,          weight = 229 },
        { item = xi.item.STEEL_INGOT,          weight = 238 },
    },

    {
        { item = xi.item.SCROLL_OF_REFRESH,     weight = 263 },
        { item = xi.item.SCROLL_OF_ICE_SPIKES,  weight = 246 },
        { item = xi.item.SCROLL_OF_UTSUSEMI_NI, weight = 177 },
        { item = xi.item.GOLD_BEASTCOIN,        weight = 182 },
        { item = xi.item.MYTHRIL_BEASTCOIN,     weight = 133 },
        { item = xi.item.PERIDOT,               weight =  27 },
        { item = xi.item.TURQUOISE,             weight =  20 },
        { item = xi.item.BLACK_PEARL,           weight =  15 },
        { item = xi.item.GOSHENITE,             weight =  15 },
        { item = xi.item.SPHENE,                weight =  15 },
        { item = xi.item.AMETRINE,              weight =  10 },
        { item = xi.item.GARNET,                weight =   7 },
        { item = xi.item.BLACK_ROCK,            weight =  12 },
        { item = xi.item.GREEN_ROCK,            weight =   7 },
        { item = xi.item.WHITE_ROCK,            weight =   7 },
        { item = xi.item.BLUE_ROCK,             weight =   2 },
        { item = xi.item.TRANSLUCENT_ROCK,      weight =   2 },
        { item = xi.item.OAK_LOG,               weight =   5 },
        { item = xi.item.ROSEWOOD_LOG,          weight =   5 },
        { item = xi.item.VILE_ELIXIR,           weight =  10 },
        { item = xi.item.RERAISER,              weight =   2 },
    },
}

return content:register()
