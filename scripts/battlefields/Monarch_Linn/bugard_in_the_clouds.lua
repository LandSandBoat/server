-----------------------------------
-- Bugard in the Clouds
-- Level 50 ENM
-- !addkeyitem MONARCH_BEARD
-----------------------------------
local monarchLinnID = zones[xi.zone.MONARCH_LINN]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.MONARCH_LINN,
    battlefieldId    = xi.battlefield.id.BUGARD_IN_THE_CLOUDS,
    maxPlayers       = 18,
    levelCap         = 50,
    timeLimit        = utils.minutes(15),
    index            = 4,
    entryNpc         = 'SD_Entrance',
    exitNpcs         = { 'SD_BCNM_Exit_1', 'SD_BCNM_Exit_2', 'SD_BCNM_Exit_3' },
    requiredKeyItems = { xi.ki.MONARCH_BEARD, message = monarchLinnID.text.TORN_FROM_YOUR_HANDS },
    grantXP          = 2500,
})

content.groups =
{
    {
        mobs        = { 'Hotupuku' },
        allDeath    = utils.bind(content.handleAllMonstersDefeated, content),
    },
}

content.loot =
{
    {
        { itemId    = xi.item.NONE,               weight =  9500 }, -- Nothing
        { itemId    = xi.item.CLOUD_EVOKER,       weight =   500 }, -- Cloud Evoker
    },

    {
        quantity = 2,
        { itemId = xi.item.CHUNK_OF_ALUMINUM_ORE, weight = 10000 }, -- Chunk of Aluminum Ore
    },

    {
        { itemId = xi.item.NONE,                  weight =  7000 }, -- Nothing
        { itemId = xi.item.CHANTERS_STAFF,        weight =  1000 }, -- Chanter's Staff
        { itemId = xi.item.KORYUKAGEMITSU,        weight =  1000 }, -- Koryukagemitsu
        { itemId = xi.item.BUBOSO,                weight =  1000 }, -- Buboso
    },

    {
        { itemId = xi.item.NONE,                  weight =  6000 }, -- Nothing
        { itemId = xi.item.KSHAMA_RING_NO_2,      weight =  1000 }, -- Kshama Ring No.2
        { itemId = xi.item.KSHAMA_RING_NO_3,      weight =  1000 }, -- Kshama Ring No.3
        { itemId = xi.item.KSHAMA_RING_NO_4,      weight =  1000 }, -- Kshama Ring No.4
        { itemId = xi.item.KSHAMA_RING_NO_5,      weight =  1000 }, -- Kshama Ring No.5
    },
}

return content:register()
