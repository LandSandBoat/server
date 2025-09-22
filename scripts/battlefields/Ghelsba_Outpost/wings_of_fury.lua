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
        { itemId = xi.item.BAT_FANG, weight = 1000 }, -- Bat Fang
    },

    {
        { itemId = xi.item.THUNDER_SPIRIT_PACT, weight = 306 }, -- Thunder Spirit Pact
        { itemId = xi.item.SCROLL_OF_INVISIBLE, weight = 319 }, -- Scroll Of Invisible
        { itemId = xi.item.SCROLL_OF_SNEAK,     weight = 125 }, -- Scroll Of Sneak
        { itemId = xi.item.SCROLL_OF_DEODORIZE, weight = 222 }, -- Scroll Of Deodorize
    },

    {
        { itemId = xi.item.GANKO,             weight = 153 }, -- Ganko
        { itemId = xi.item.PLATOON_EDGE,      weight = 139 }, -- Platoon Edge
        { itemId = xi.item.PLATOON_AXE,       weight =  83 }, -- Platoon Axe
        { itemId = xi.item.PLATOON_POLE,      weight =  97 }, -- Platoon Pole
        { itemId = xi.item.PLATOON_DAGGER,    weight = 125 }, -- Platoon Dagger
        { itemId = xi.item.MYTHRIL_BEASTCOIN, weight = 444 }, -- Mythril Beastcoin
        { itemId = xi.item.TRANSLUCENT_ROCK,  weight =  56 }, -- Translucent Rock
    },

    {
        { itemId = xi.item.GUNROMARU,      weight = 111 }, -- Gunromaru
        { itemId = xi.item.PLATOON_DAGGER, weight = 139 }, -- Platoon Dagger
        { itemId = xi.item.PLATOON_EDGE,   weight = 139 }, -- Platoon Edge
        { itemId = xi.item.PLATOON_LANCE,  weight =  42 }, -- Platoon Lance
        { itemId = xi.item.PLATOON_SWORD,  weight = 181 }, -- Platoon Sword
        { itemId = xi.item.PURPLE_ROCK,    weight =  97 }, -- Purple Rock
        { itemId = xi.item.RED_ROCK,       weight =  69 }, -- Red Rock
        { itemId = xi.item.WHITE_ROCK,     weight =  14 }, -- White Rock
        { itemId = xi.item.BLACK_ROCK,     weight =  28 }, -- Black Rock
        { itemId = xi.item.GREEN_ROCK,     weight =  28 }, -- Green Rock
        { itemId = xi.item.YELLOW_ROCK,    weight =  14 }, -- Yellow Rock
        { itemId = xi.item.BLUE_ROCK,      weight =  69 }, -- Blue Rock
    },

    {
        { itemId = xi.item.NONE,        weight = 389 }, -- nothing
        { itemId = xi.item.ASTRAL_RING, weight = 167 }, -- astral_ring
        { itemId = xi.item.BAT_WING,    weight = 444 }, -- bat_wing
    },
}

return content:register()
