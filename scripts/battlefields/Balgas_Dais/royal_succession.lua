-----------------------------------
-- Royal Succession
-- Balga's Dais BCNM40, Star Orb
-- !additem 1131
-----------------------------------
local balgasID = zones[xi.zone.BALGAS_DAIS]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.BALGAS_DAIS,
    battlefieldId    = xi.battlefield.id.ROYAL_SUCCESSION,
    maxPlayers       = 3,
    levelCap         = 40,
    timeLimit        = utils.minutes(15),
    index            = 12,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.STAR_ORB, wearMessage = balgasID.text.A_CRACK_HAS_FORMED, wornMessage = balgasID.text.ORB_IS_CRACKED },
})

content:addEssentialMobs({
    'Opo-opo_Monarch',
    'Opo-opo_Heir',
    'Myrmidon_Spo-spo',
    'Myrmidon_Apu-apu',
    'Myrmidon_Epa-epa',
})

content.loot =
{
    {
        { itemId = xi.item.BUNCH_OF_WILD_PAMAMAS, weight = 1000 }, -- bunch_of_wild_pamamas
    },

    {
        { itemId = xi.item.NONE,             weight = 300 }, -- nothing
        { itemId = xi.item.DUSKY_STAFF,      weight = 100 }, -- dusky_staff
        { itemId = xi.item.JONGLEURS_DAGGER, weight = 100 }, -- jongleurs_dagger
        { itemId = xi.item.CALVELEYS_DAGGER, weight = 100 }, -- calveleys_dagger
        { itemId = xi.item.SEALED_MACE,      weight = 100 }, -- sealed_mace
        { itemId = xi.item.HIMMEL_STOCK,     weight = 100 }, -- himmel_stock
        { itemId = xi.item.KAGEHIDE,         weight = 100 }, -- kagehide
        { itemId = xi.item.OHAGURO,          weight = 100 }, -- ohaguro
    },

    {
        { itemId = xi.item.NONE,          weight = 100 }, -- nothing
        { itemId = xi.item.GENIN_EARRING, weight = 300 }, -- genin_earring
        { itemId = xi.item.AGILE_GORGET,  weight = 300 }, -- agile_gorget
        { itemId = xi.item.JAGD_GORGET,   weight = 300 }, -- jagd_gorget
    },

    {
        { itemId = xi.item.NONE,                 weight = 370 }, -- nothing
        { itemId = xi.item.TURQUOISE,            weight = 100 }, -- turquoise
        { itemId = xi.item.BUNCH_OF_PAMAMAS,     weight = 100 }, -- bunch_of_pamamas
        { itemId = xi.item.SQUARE_OF_SILK_CLOTH, weight = 110 }, -- square_of_silk_cloth
        { itemId = xi.item.ROSEWOOD_LOG,         weight = 140 }, -- rosewood_log
        { itemId = xi.item.PEARL,                weight = 180 }, -- pearl
    },

    {
        { itemId = xi.item.SCROLL_OF_PHALANX,    weight = 250 }, -- scroll_of_phalanx
        { itemId = xi.item.SCROLL_OF_ABSORB_STR, weight = 250 }, -- scroll_of_absorb
        { itemId = xi.item.SCROLL_OF_REFRESH,    weight = 250 }, -- scroll_of_refresh
        { itemId = xi.item.SCROLL_OF_ERASE,      weight = 250 }, -- scroll_of_erase
    },

    {
        { itemId = xi.item.NONE,           weight = 600 }, -- nothing
        { itemId = xi.item.GOLD_BEASTCOIN, weight = 400 }, -- gold_beastcoin
    },
}

return content:register()
