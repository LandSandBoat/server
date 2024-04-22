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
        { item = xi.item.BUNCH_OF_WILD_PAMAMAS, weight = 1000 }, -- bunch_of_wild_pamamas
    },

    {
        { item = xi.item.NONE,             weight = 300 }, -- nothing
        { item = xi.item.DUSKY_STAFF,      weight = 100 }, -- dusky_staff
        { item = xi.item.JONGLEURS_DAGGER, weight = 100 }, -- jongleurs_dagger
        { item = xi.item.CALVELEYS_DAGGER, weight = 100 }, -- calveleys_dagger
        { item = xi.item.SEALED_MACE,      weight = 100 }, -- sealed_mace
        { item = xi.item.HIMMEL_STOCK,     weight = 100 }, -- himmel_stock
        { item = xi.item.KAGEHIDE,         weight = 100 }, -- kagehide
        { item = xi.item.OHAGURO,          weight = 100 }, -- ohaguro
    },

    {
        { item = xi.item.NONE,          weight = 100 }, -- nothing
        { item = xi.item.GENIN_EARRING, weight = 300 }, -- genin_earring
        { item = xi.item.AGILE_GORGET,  weight = 300 }, -- agile_gorget
        { item = xi.item.JAGD_GORGET,   weight = 300 }, -- jagd_gorget
    },

    {
        { item = xi.item.NONE,                 weight = 370 }, -- nothing
        { item = xi.item.TURQUOISE,            weight = 100 }, -- turquoise
        { item = xi.item.BUNCH_OF_PAMAMAS,     weight = 100 }, -- bunch_of_pamamas
        { item = xi.item.SQUARE_OF_SILK_CLOTH, weight = 110 }, -- square_of_silk_cloth
        { item = xi.item.ROSEWOOD_LOG,         weight = 140 }, -- rosewood_log
        { item = xi.item.PEARL,                weight = 180 }, -- pearl
    },

    {
        { item = xi.item.SCROLL_OF_PHALANX,    weight = 250 }, -- scroll_of_phalanx
        { item = xi.item.SCROLL_OF_ABSORB_STR, weight = 250 }, -- scroll_of_absorb
        { item = xi.item.SCROLL_OF_REFRESH,    weight = 250 }, -- scroll_of_refresh
        { item = xi.item.SCROLL_OF_ERASE,      weight = 250 }, -- scroll_of_erase
    },

    {
        { item = xi.item.NONE,           weight = 600 }, -- nothing
        { item = xi.item.GOLD_BEASTCOIN, weight = 400 }, -- gold_beastcoin
    },
}

return content:register()
