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
        { itemId = xi.item.MANNEQUIN_HANDS, weight = 1000 }, -- Mannequin Hands
    },

    {
        { itemId = xi.item.JAR_OF_TOAD_OIL,        weight = 250 }, -- Jar Of Toad Oil
        { itemId = xi.item.POTION,                 weight = 300 }, -- Potion
        { itemId = xi.item.POTION_P1,              weight = 180 }, -- Potion +1
        { itemId = xi.item.AIR_SPIRIT_PACT,        weight = 130 }, -- Air Spirit Pact
        { itemId = xi.item.SQUARE_OF_COTTON_CLOTH, weight = 280 }, -- Square Of Cotton Cloth
    },

    {
        { itemId = xi.item.MYTHRIL_BEASTCOIN,     weight = 250 }, -- Mythril Beastcoin
        { itemId = xi.item.GANKO,                 weight = 190 }, -- Ganko
        { itemId = xi.item.SQUARE_OF_WOOL_CLOTH,  weight = 270 }, -- Square Of Wool Cloth
        { itemId = xi.item.PLATOON_DISC,          weight = 145 }, -- Platoon Disc
        { itemId = xi.item.SQUARE_OF_GRASS_CLOTH, weight = 295 }, -- Square Of Grass Cloth
        { itemId = xi.item.SQUARE_OF_LINEN_CLOTH, weight = 260 }, -- Square Of Linen Cloth
    },

    {
        { itemId = xi.item.NONE,           weight = 800 }, -- Nothing
        { itemId = xi.item.PLATOON_CUTTER, weight = 167 }, -- Platoon Cutter
    },

    {
        quantity = 2,
        { itemId = xi.item.NONE,                weight = 500 },  -- Nothing
        { itemId = xi.item.VIAL_OF_FIEND_BLOOD, weight = 500 },  -- Vial Of Fiend Blood
    },

    {
        { itemId = xi.item.PLATOON_EDGE,           weight = 235 }, -- Platoon Edge
        { itemId = xi.item.PLATOON_GUN,            weight = 235 }, -- Platoon Gun
        { itemId = xi.item.PLATOON_SPATHA,         weight = 235 }, -- Platoon Spatha
        { itemId = xi.item.PLATOON_POLE,           weight = 235 }, -- Platoon Pole
        { itemId = xi.item.GUNROMARU,              weight = 255 }, -- Gunromaru
        { itemId = xi.item.MANNEQUIN_HEAD,         weight = 260 }, -- Mannequin Head
        { itemId = xi.item.SCROLL_OF_DRAIN,        weight = 250 }, -- Scroll Of Drain
        { itemId = xi.item.VIAL_OF_BEASTMAN_BLOOD, weight = 190 }, -- Vial Of Beastman Blood
    },
}

return content:register()
