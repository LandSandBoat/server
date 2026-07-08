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
    requiredKeyItems = { xi.ki.ASTRAL_COVENANT, message = ID.text.ASTRAL_DISINTEGRATES },
    grantXP          = 3000,
})

content:addEssentialMobs({ 'Pasuk' })

content.loot =
{
    {
        { itemId = xi.item.NONE,              weight = 950 }, -- Nothing
        { itemId = xi.item.CLOUD_EVOKER,      weight =  50 }, -- Cloud Evoker
    },

    {
        { itemId = xi.item.NONE,              weight = 500 }, -- Nothing
        { itemId = xi.item.GEIST_EARRING,     weight = 250 }, -- Geist Earring
        { itemId = xi.item.QUICK_BELT,        weight = 250 }, -- Quick Belt
    },

    {
        { itemId = xi.item.NONE,              weight = 350 }, -- Nothing
        { itemId = xi.item.CROSSBOWMANS_RING, weight = 200 }, -- Crossbowman's Ring
        { itemId = xi.item.WOODSMAN_RING,     weight = 150 }, -- Woodsman Ring
        { itemId = xi.item.ETHER_RING,        weight = 300 }, -- Ether Ring
    },
}

return content:register()
