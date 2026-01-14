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

content:addEssentialMobs({ 'Opo-opo_Monarch', 'Opo-opo_Heir', 'Myrmidon_Spo-spo', 'Myrmidon_Apu-apu', 'Myrmidon_Epa-epa' })

content.loot =
{
    {
        { itemId = xi.item.GIL,                   weight = 10000, amount = 5000 },
    },

    {
        { itemId = xi.item.KAGEHIDE,              weight =  1000 },
        { itemId = xi.item.OHAGURO,               weight =  1000 },
        { itemId = xi.item.CALVELEYS_DAGGER,      weight =  1000 },
        { itemId = xi.item.SEALED_MACE,           weight =  1000 },
        { itemId = xi.item.AGILE_GORGET,          weight =  4000 },
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
        { itemId = xi.item.MYTHRIL_BEASTCOIN,     weight =   100 },
        { itemId = xi.item.ROSEWOOD_LOG,          weight =   100 },
        { itemId = xi.item.OAK_LOG,               weight =   100 },
        { itemId = xi.item.VILE_ELIXIR,           weight =   100 },
    },

    {
        { itemId = xi.item.HIMMEL_STOCK,          weight =  1000 },
        { itemId = xi.item.DUSKY_STAFF,           weight =  1000 },
        { itemId = xi.item.JONGLEURS_DAGGER,      weight =  1000 },
        { itemId = xi.item.SHIKAR_BOW,            weight =  1000 },
        { itemId = xi.item.JAGD_GORGET,           weight =  4000 },
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
        { itemId = xi.item.MYTHRIL_BEASTCOIN,     weight =   100 },
        { itemId = xi.item.ROSEWOOD_LOG,          weight =   100 },
        { itemId = xi.item.OAK_LOG,               weight =   100 },
        { itemId = xi.item.RERAISER,              weight =   100 },
    },

    {
        { itemId = xi.item.SCROLL_OF_ICE_SPIKES,  weight =  3000 },
        { itemId = xi.item.SCROLL_OF_REFRESH,     weight =  2000 },
        { itemId = xi.item.SCROLL_OF_UTSUSEMI_NI, weight =  2000 },
        { itemId = xi.item.GOLD_BEASTCOIN,        weight =  3000 },
    },

    {
        { itemId = xi.item.FIRE_SPIRIT_PACT,      weight =  2000 },
        { itemId = xi.item.SCROLL_OF_ABSORB_STR,  weight =  1000 },
        { itemId = xi.item.SCROLL_OF_ERASE,       weight =  2000 },
        { itemId = xi.item.SCROLL_OF_PHALANX,     weight =  2000 },
        { itemId = xi.item.SQUARE_OF_SILK_CLOTH,  weight =  3000 },
    },

    {
        { itemId = xi.item.BUNCH_OF_PAMAMAS,      weight = 10000 },
    },

    {
        { itemId = xi.item.BUNCH_OF_WILD_PAMAMAS, weight = 10000 },
    },
}

return content:register()
