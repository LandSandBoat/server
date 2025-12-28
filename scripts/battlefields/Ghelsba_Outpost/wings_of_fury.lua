-----------------------------------
-- Wings of Fury
-- Ghelsba Outpost BCNM20, Cloudy Orb
-- !additem 1551
-----------------------------------
local ghelsbaID = zones[xi.zone.GHELSBA_OUTPOST]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.GHELSBA_OUTPOST,
    battlefieldId    = xi.battlefield.id.WINGS_OF_FURY,
    maxPlayers       = 3,
    levelCap         = 20,
    timeLimit        = utils.minutes(15),
    index            = 2,
    area             = 1,
    entryNpc         = 'Hut_Door',
    requiredItems    = { xi.item.CLOUDY_ORB, wearMessage = ghelsbaID.text.A_CRACK_HAS_FORMED, wornMessage = ghelsbaID.text.ORB_IS_CRACKED },
    armouryCrates    =
    {
        ghelsbaID.mob.COLO_COLO + 3,
    },
})

content:addEssentialMobs({ 'Colo-colo', 'Furies' })

content.loot =
{
    {
        { itemId = xi.item.GIL,                 weight = 10000, amount = 1500 },
    },

    {
        quantity = 2,
        { itemId = xi.item.MYTHRIL_BEASTCOIN,   weight =  2000 },
        { itemId = xi.item.BLACK_ROCK,          weight =   250 },
        { itemId = xi.item.BLUE_ROCK,           weight =   250 },
        { itemId = xi.item.GREEN_ROCK,          weight =   250 },
        { itemId = xi.item.PURPLE_ROCK,         weight =   250 },
        { itemId = xi.item.RED_ROCK,            weight =   250 },
        { itemId = xi.item.TRANSLUCENT_ROCK,    weight =   250 },
        { itemId = xi.item.WHITE_ROCK,          weight =   250 },
        { itemId = xi.item.YELLOW_ROCK,         weight =   250 },
        { itemId = xi.item.GANKO,               weight =   750 },
        { itemId = xi.item.GUNROMARU,           weight =   750 },
        { itemId = xi.item.PLATOON_AXE,         weight =   750 },
        { itemId = xi.item.PLATOON_DAGGER,      weight =   750 },
        { itemId = xi.item.PLATOON_EDGE,        weight =   750 },
        { itemId = xi.item.PLATOON_LANCE,       weight =   750 },
        { itemId = xi.item.PLATOON_POLE,        weight =   750 },
        { itemId = xi.item.PLATOON_SWORD,       weight =   750 },
    },

    {
        { itemId = xi.item.BAT_FANG,            weight = 10000 },
    },

    {
        { itemId = xi.item.NONE,                weight =  3500 },
        { itemId = xi.item.ASTRAL_RING,         weight =  1500 },
        { itemId = xi.item.BAT_WING,            weight =  5000 },
    },

    {
        { itemId = xi.item.THUNDER_SPIRIT_PACT, weight =  2500 },
        { itemId = xi.item.SCROLL_OF_INVISIBLE, weight =  2500 },
        { itemId = xi.item.SCROLL_OF_SNEAK,     weight =  2500 },
        { itemId = xi.item.SCROLL_OF_DEODORIZE, weight =  2500 },
    },
}

return content:register()
