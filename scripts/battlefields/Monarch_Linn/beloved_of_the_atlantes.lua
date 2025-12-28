-----------------------------------
-- Beloved of the Atlantes
-- Level 50 ENM
-- !addkeyitem MONARCH_BEARD
-----------------------------------
local monarchLinnID = zones[xi.zone.MONARCH_LINN]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.MONARCH_LINN,
    battlefieldId    = xi.battlefield.id.BELOVED_OF_THE_ATLANTES,
    maxPlayers       = 18,
    levelCap         = 50,
    timeLimit        = utils.minutes(30),
    index            = 5,
    entryNpc         = 'SD_Entrance',
    exitNpcs         = { 'SD_BCNM_Exit_1', 'SD_BCNM_Exit_2', 'SD_BCNM_Exit_3' },
    requiredKeyItems = { xi.ki.MONARCH_BEARD, message = monarchLinnID.text.TORN_FROM_YOUR_HANDS },
    grantXP          = 2500,
})

content.groups =
{
    {
        mobs      = { 'Watch_Hippogryph' },
        allDeath  = utils.bind(content.handleAllMonstersDefeated, content),
    },

    {
        mobs      = { 'Guard_Hippogryph' },
        spawned  = false,
    },
}

content.loot =
{
    {
        quantity = 4,
        { itemId = xi.item.CHUNK_OF_ALUMINUM_ORE, weight = 1000 }, -- Chunk of Aluminum Ore
    },

    {
        { itemId = xi.item.NONE,              weight = 950 }, -- Nothing
        { itemId = xi.item.CLOUD_EVOKER,      weight =  50 }, -- Cloud Evoker
    },

    {
        { itemId = xi.item.NONE,              weight = 600 }, -- Nothing
        { itemId = xi.item.CHANTERS_STAFF,    weight = 100 }, -- Chanter's Staff
        { itemId = xi.item.KORYUKAGEMITSU,    weight = 100 }, -- Koryukagemitsu
        { itemId = xi.item.BUBOSO,            weight = 100 }, -- Buboso
        { itemId = xi.item.RAISE_ROD,         weight = 100 }, -- Raise Rod
    },

    {
        { itemId = xi.item.NONE,              weight = 300 }, -- Nothing
        { itemId = xi.item.KSHAMA_RING_NO_2,  weight = 100 }, -- Kshama Ring No.2
        { itemId = xi.item.KSHAMA_RING_NO_3,  weight = 100 }, -- Kshama Ring No.3
        { itemId = xi.item.KSHAMA_RING_NO_4,  weight = 100 }, -- Kshama Ring No.4
        { itemId = xi.item.KSHAMA_RING_NO_5,  weight = 100 }, -- Kshama Ring No.5
        { itemId = xi.item.KSHAMA_RING_NO_6,  weight = 100 }, -- Kshama Ring No.6
        { itemId = xi.item.KSHAMA_RING_NO_8,  weight = 100 }, -- Kshama Ring No.8
        { itemId = xi.item.KSHAMA_RING_NO_9,  weight = 100 }, -- Kshama Ring No.9
    },
}

return content:register()
