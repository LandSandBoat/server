-----------------------------------
-- Crustacean Conundrum
-- Waughroon Shrine BCNM20, Cloudy Orb
-- !additem 1551
-----------------------------------
local waughroonID = zones[xi.zone.WAUGHROON_SHRINE]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.WAUGHROON_SHRINE,
    battlefieldId    = xi.battlefield.id.CRUSTACEAN_CONUNDRUM,
    maxPlayers       = 3,
    levelCap         = 20,
    timeLimit        = utils.minutes(15),
    index            = 10,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.CLOUDY_ORB, wearMessage = waughroonID.text.A_CRACK_HAS_FORMED, wornMessage = waughroonID.text.ORB_IS_CRACKED },

    experimental = true,
})

content:addEssentialMobs({ 'Heavy_Metal_Crab', 'Metal_Crab' })

content.loot =
{
    {
        { itemId = xi.item.GIL,                     weight = 1000, amount = 1500 },
    },

    {
        quantity = 2,
        { itemId = xi.item.MYTHRIL_BEASTCOIN,       weight = 200 },
        { itemId = xi.item.BRONZE_SHEET,            weight = 100 },
        { itemId = xi.item.BRONZE_INGOT,            weight = 100 },
        { itemId = xi.item.PLATOON_CESTI,           weight =  75 },
        { itemId = xi.item.PLATOON_DAGGER,          weight =  75 },
        { itemId = xi.item.PLATOON_AXE,             weight =  75 },
        { itemId = xi.item.PLATOON_BOW,             weight =  75 },
        { itemId = xi.item.PLATOON_LANCE,           weight =  75 },
        { itemId = xi.item.PLATOON_SWORD,           weight =  75 },
        { itemId = xi.item.PLATOON_MACE,            weight =  75 },
        { itemId = xi.item.PLATOON_ZAGHNAL,         weight =  75 },
    },

    {
        { itemId = xi.item.SLICE_OF_LAND_CRAB_MEAT, weight = 1000 },
    },

    {
        { itemId = xi.item.NONE,                    weight = 500 },
        { itemId = xi.item.CRAB_SHELL,              weight = 500 },
    },

    {
        { itemId = xi.item.BEETLE_QUIVER,           weight = 500 },
        { itemId = xi.item.JUG_OF_FISH_OIL_BROTH,   weight = 500 },
    },

    {
        { itemId = xi.item.MANNEQUIN_BODY,          weight = 1000 },
    },

    {
        { itemId = xi.item.NONE,                    weight = 950 },
        { itemId = xi.item.MANNEQUIN_HANDS,         weight =  50 },
    },

}

return content:register()
