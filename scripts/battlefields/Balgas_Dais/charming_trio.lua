-----------------------------------
-- Charming Trio
-- Balga's Dais BCNM20, Cloudy Orb
-----------------------------------
local balgasID = zones[xi.zone.BALGAS_DAIS]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.BALGAS_DAIS,
    battlefieldId    = xi.battlefield.id.CHARMING_TRIO,
    maxPlayers       = 3,
    levelCap         = 20,
    timeLimit        = utils.minutes(15),
    index            = 9,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.CLOUDY_ORB, wearMessage = balgasID.text.A_CRACK_HAS_FORMED, wornMessage = balgasID.text.ORB_IS_CRACKED },
})

content:addEssentialMobs({ 'Prune', 'Pepper', 'Phoedme' })

content.loot =
{
    {
        { itemId = xi.item.GIL,                    weight = 1000, amount = 1500 },
    },

    {
        quantity = 2,
        { itemId = xi.item.MYTHRIL_BEASTCOIN,      weight = 200 },
        { itemId = xi.item.SQUARE_OF_COTTON_CLOTH, weight =  50 },
        { itemId = xi.item.SQUARE_OF_WOOL_CLOTH,   weight =  50 },
        { itemId = xi.item.SQUARE_OF_GRASS_CLOTH,  weight =  50 },
        { itemId = xi.item.SQUARE_OF_LINEN_CLOTH,  weight =  50 },
        { itemId = xi.item.GUNROMARU,              weight =  75 },
        { itemId = xi.item.GANKO,                  weight =  75 },
        { itemId = xi.item.PLATOON_BOW,            weight =  75 },
        { itemId = xi.item.PLATOON_CUTTER,         weight =  75 },
        { itemId = xi.item.PLATOON_DISC,           weight =  75 },
        { itemId = xi.item.PLATOON_EDGE,           weight =  75 },
        { itemId = xi.item.PLATOON_GUN,            weight =  75 },
        { itemId = xi.item.PLATOON_MACE,           weight =  75 },
        { itemId = xi.item.PLATOON_POLE,           weight =  75 },
        { itemId = xi.item.PLATOON_SPATHA,         weight =  75 },
    },

    {
        { itemId = xi.item.VIAL_OF_FIEND_BLOOD,    weight = 1000 },
    },

    {
        { itemId = xi.item.NONE,                   weight = 400 },
        { itemId = xi.item.VIAL_OF_FIEND_BLOOD,    weight = 200 },
        { itemId = xi.item.JAR_OF_TOAD_OIL,        weight = 200 },
        { itemId = xi.item.VIAL_OF_BEASTMAN_BLOOD, weight = 200 },

    },

    {
        { itemId = xi.item.POTION,                 weight = 350 },
        { itemId = xi.item.POTION_P1,              weight = 350 },
        { itemId = xi.item.AIR_SPIRIT_PACT,        weight = 250 },
        { itemId = xi.item.SCROLL_OF_DRAIN,        weight =  50 },
    },

    {
        { itemId = xi.item.MANNEQUIN_HANDS,        weight = 1000 },
    },

    {
        { itemId = xi.item.NONE,                   weight = 950 },
        { itemId = xi.item.MANNEQUIN_HEAD,         weight =  50 },
    },
}

return content:register()
