-----------------------------------
-- Test Your Mite
-- Shrouded Maw ENM - Astral Covenant
-- !addkeyitem ASTRAL_COVENANT
-----------------------------------
local ID = zones[xi.zone.THE_SHROUDED_MAW]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.THE_SHROUDED_MAW,
    battlefieldId    = xi.battlefield.id.TEST_YOUR_MITE,
    maxPlayers       = 18,
    levelCap         = 40,
    timeLimit        = utils.minutes(30),
    index            = 1,
    entryNpc         = 'MC_Entrance',
    exitNpc          = 'Memento_Circle',
    requiredKeyItems = { xi.keyItem.ASTRAL_COVENANT, message = ID.text.ASTRAL_DISINTEGRATES },
    grantXP          = 3000,
})

content:addEssentialMobs({ 'Pasuk' })

content.loot =
{
    {
        { itemId = xi.item.NONE,              weight = 9750 }, -- Nothing
        { itemId = xi.item.CLOUD_EVOKER,      weight =  250 }, -- Cloud Evoker
    },

    {
        { itemId = xi.item.NONE,              weight = 5000 }, -- Nothing
        { itemId = xi.item.GEIST_EARRING,     weight = 2500 }, -- Geist Earring
        { itemId = xi.item.QUICK_BELT,        weight = 2500 }, -- Quick Belt
    },

    {
        { itemId = xi.item.NONE,              weight = 3500 }, -- Nothing
        { itemId = xi.item.CROSSBOWMANS_RING, weight = 2000 }, -- Crossbowman's Ring
        { itemId = xi.item.WOODSMAN_RING,     weight = 1500 }, -- Woodsman Ring
        { itemId = xi.item.ETHER_RING,        weight = 3000 }, -- Ether Ring
    },
}

return content:register()
