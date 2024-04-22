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
        { item = xi.item.MANNEQUIN_HANDS, weight = 1000 }, -- Mannequin Hands
    },

    {
        { item = xi.item.JAR_OF_TOAD_OIL,        weight = 250 }, -- Jar Of Toad Oil
        { item = xi.item.POTION,                 weight = 300 }, -- Potion
        { item = xi.item.POTION_P1,              weight = 180 }, -- Potion +1
        { item = xi.item.AIR_SPIRIT_PACT,        weight = 130 }, -- Air Spirit Pact
        { item = xi.item.SQUARE_OF_COTTON_CLOTH, weight = 280 }, -- Square Of Cotton Cloth
    },

    {
        { item = xi.item.MYTHRIL_BEASTCOIN,     weight = 250 }, -- Mythril Beastcoin
        { item = xi.item.GANKO,                 weight = 190 }, -- Ganko
        { item = xi.item.SQUARE_OF_WOOL_CLOTH,  weight = 270 }, -- Square Of Wool Cloth
        { item = xi.item.PLATOON_DISC,          weight = 145 }, -- Platoon Disc
        { item = xi.item.SQUARE_OF_GRASS_CLOTH, weight = 295 }, -- Square Of Grass Cloth
        { item = xi.item.SQUARE_OF_LINEN_CLOTH, weight = 260 }, -- Square Of Linen Cloth
    },

    {
        { item = xi.item.NONE,           weight = 800 }, -- Nothing
        { item = xi.item.PLATOON_CUTTER, weight = 167 }, -- Platoon Cutter
    },

    {
        quantity = 2,
        { item = xi.item.NONE,                weight = 500 },  -- Nothing
        { item = xi.item.VIAL_OF_FIEND_BLOOD, weight = 500 },  -- Vial Of Fiend Blood
    },

    {
        { item = xi.item.PLATOON_EDGE,           weight = 235 }, -- Platoon Edge
        { item = xi.item.PLATOON_GUN,            weight = 235 }, -- Platoon Gun
        { item = xi.item.PLATOON_SPATHA,         weight = 235 }, -- Platoon Spatha
        { item = xi.item.PLATOON_POLE,           weight = 235 }, -- Platoon Pole
        { item = xi.item.GUNROMARU,              weight = 255 }, -- Gunromaru
        { item = xi.item.MANNEQUIN_HEAD,         weight = 260 }, -- Mannequin Head
        { item = xi.item.SCROLL_OF_DRAIN,        weight = 250 }, -- Scroll Of Drain
        { item = xi.item.VIAL_OF_BEASTMAN_BLOOD, weight = 190 }, -- Vial Of Beastman Blood
    },
}

return content:register()
