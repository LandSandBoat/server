-----------------------------------
-- Shooting Fish
-- Horlais Peak BCNM20, Cloudy Orb
-- !additem 1551
-----------------------------------
local horlaisID = zones[xi.zone.HORLAIS_PEAK]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.HORLAIS_PEAK,
    battlefieldId    = xi.battlefield.id.SHOOTING_FISH,
    maxPlayers       = 3,
    levelCap         = 20,
    timeLimit        = utils.minutes(15),
    index            = 9,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.CLOUDY_ORB, wearMessage = horlaisID.text.A_CRACK_HAS_FORMED, wornMessage = horlaisID.text.ORB_IS_CRACKED },
})

content:addEssentialMobs({ 'Sniper_Pugil', 'Archer_Pugil' })

content.loot =
{
    {
        { itemId = xi.item.GIL,                     weight = 10000, amount = 1500 },
    },

    {
        quantity = 2,
        { itemId = xi.item.MYTHRIL_BEASTCOIN,       weight =  2000 },
        { itemId = xi.item.BLACK_ROCK,              weight =   250 },
        { itemId = xi.item.PURPLE_ROCK,             weight =   250 },
        { itemId = xi.item.WHITE_ROCK,              weight =   250 },
        { itemId = xi.item.GREEN_ROCK,              weight =   250 },
        { itemId = xi.item.YELLOW_ROCK,             weight =   250 },
        { itemId = xi.item.BLUE_ROCK,               weight =   250 },
        { itemId = xi.item.RED_ROCK,                weight =   250 },
        { itemId = xi.item.TRANSLUCENT_ROCK,        weight =   250 },
        { itemId = xi.item.PLATOON_BOW,             weight =   750 },
        { itemId = xi.item.PLATOON_MACE,            weight =   750 },
        { itemId = xi.item.PLATOON_DISC,            weight =   750 },
        { itemId = xi.item.PLATOON_GUN,             weight =   750 },
        { itemId = xi.item.PLATOON_CESTI,           weight =   750 },
        { itemId = xi.item.PLATOON_CUTTER,          weight =   750 },
        { itemId = xi.item.PLATOON_SPATHA,          weight =   750 },
        { itemId = xi.item.PLATOON_ZAGHNAL,         weight =   750 },
    },

    {
        { itemId = xi.item.SHALL_SHELL,             weight = 10000 },
    },

    {
        { itemId = xi.item.NONE,                    weight =  5000 },
        { itemId = xi.item.SHALL_SHELL,             weight =  2500 },
        { itemId = xi.item.HANDFUL_OF_PUGIL_SCALES, weight =  2500 },
    },

    {
        { itemId = xi.item.SCROLL_OF_BLAZE_SPIKES,  weight =  3500 },
        { itemId = xi.item.SCROLL_OF_HORDE_LULLABY, weight =  3500 },
        { itemId = xi.item.THUNDER_SPIRIT_PACT,     weight =  2500 },
        { itemId = xi.item.SCROLL_OF_WARP,          weight =   500 },
    },

    {
        { itemId = xi.item.MANNEQUIN_HEAD,          weight = 10000 },
    },

    {
        { itemId = xi.item.NONE,                    weight =  9500 },
        { itemId = xi.item.MANNEQUIN_BODY,          weight =   500 },
    },
}

return content:register()
