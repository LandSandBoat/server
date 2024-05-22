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
        { item = xi.item.SLICE_OF_LAND_CRAB_MEAT, weight = 1000 }, -- slice_of_land_crab_meat
    },

    {
        { item = xi.item.MANNEQUIN_BODY, weight = 1000 }, -- mannequin_body
    },

    {
        { item = xi.item.NONE,       weight = 334 }, -- nothing
        { item = xi.item.CRAB_SHELL, weight = 666 }, -- crab_shell
    },

    {
        { item = xi.item.BEETLE_QUIVER,         weight = 444 }, -- beetle_quiver
        { item = xi.item.JUG_OF_FISH_OIL_BROTH, weight = 556 }, -- jug_of_fish_oil_broth
    },

    {
        { item = xi.item.NONE,         weight = 450 }, -- nothing
        { item = xi.item.BRASS_INGOT,  weight = 100 }, -- brass_ingot
        { item = xi.item.BRONZE_SHEET, weight = 150 }, -- bronze_sheet
        { item = xi.item.BRONZE_INGOT, weight = 300 }, -- bronze_ingot
    },

    {
        { item = xi.item.NONE,              weight = 300 }, -- nothing
        { item = xi.item.MYTHRIL_BEASTCOIN, weight = 500 }, -- mythril_beastcoin
        { item = xi.item.MANNEQUIN_HANDS,   weight = 100 }, -- mannequin_hands
        { item = xi.item.MANNEQUIN_HEAD,    weight = 100 }, -- mannequin_head
    },

    {
        { item = xi.item.NONE,            weight = 200 }, -- nothing
        { item = xi.item.PLATOON_CESTI,   weight = 100 }, -- platoon_cesti
        { item = xi.item.PLATOON_DAGGER,  weight = 100 }, -- platoon_dagger
        { item = xi.item.PLATOON_AXE,     weight = 100 }, -- platoon_axe
        { item = xi.item.PLATOON_BOW,     weight = 100 }, -- platoon_bow
        { item = xi.item.PLATOON_LANCE,   weight = 100 }, -- platoon_lance
        { item = xi.item.PLATOON_SWORD,   weight = 100 }, -- platoon_sword
        { item = xi.item.PLATOON_MACE,    weight = 100 }, -- platoon_mace
        { item = xi.item.PLATOON_ZAGHNAL, weight = 100 }, -- platoon_zaghnal
    },
}

return content:register()
