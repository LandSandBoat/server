-----------------------------------
-- Harem Scarem
-- Balga's Dais BCNM30, Sky Orb
-- !additem 1552
-----------------------------------
local balgasID = zones[xi.zone.BALGAS_DAIS]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.BALGAS_DAIS,
    battlefieldId    = xi.battlefield.id.HAREM_SCAREM,
    maxPlayers       = 6,
    levelCap         = 30,
    timeLimit        = utils.minutes(30),
    index            = 10,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.SKY_ORB, wearMessage = balgasID.text.A_CRACK_HAS_FORMED, wornMessage = balgasID.text.ORB_IS_CRACKED },
})

content:addEssentialMobs({ 'Nenaunir', 'Nenaunirs_Wife' })

content.loot =
{
    {
        { itemId = xi.item.DHALMEL_HIDE, weight = 1000 }, -- dhalmel_hide
    },

    {
        { itemId = xi.item.NONE,        weight =  500 }, -- nothing
        { itemId = xi.item.GIANT_FEMUR, weight =  500 }, -- giant_femur
    },

    {
        { itemId = xi.item.NONE,                  weight = 500 }, -- nothing
        { itemId = xi.item.SLICE_OF_DHALMEL_MEAT, weight = 500 }, -- slice_of_dhalmel_meat
    },

    {
        { itemId = xi.item.NONE,             weight = 400 }, -- nothing
        { itemId = xi.item.MERCENARY_MANTLE, weight = 150 }, -- mercenary_mantle
        { itemId = xi.item.BEATERS_MANTLE,   weight = 150 }, -- beaters_mantle
        { itemId = xi.item.ESQUIRES_MANTLE,  weight = 150 }, -- esquires_mantle
        { itemId = xi.item.HEALERS_MANTLE,   weight = 150 }, -- healers_mantle
    },

    {
        { itemId = xi.item.NONE,           weight = 400 }, -- nothing
        { itemId = xi.item.WIZARDS_SHIELD, weight = 200 }, -- wizards_shield
        { itemId = xi.item.TRIMMERS_ASPIS, weight = 200 }, -- trimmers_aspis
        { itemId = xi.item.WYVERN_TARGE,   weight = 200 }, -- wyvern_targe
    },

    {
        { itemId = xi.item.NONE,                   weight = 200 }, -- nothing
        { itemId = xi.item.SCROLL_OF_ERASE,        weight = 200 }, -- scroll_of_erase
        { itemId = xi.item.SCROLL_OF_DISPEL,       weight = 200 }, -- scroll_of_dispel
        { itemId = xi.item.SCROLL_OF_MAGIC_FINALE, weight = 200 }, -- scroll_of_magic_finale
        { itemId = xi.item.SCROLL_OF_UTSUSEMI_NI,  weight = 200 }, -- scroll_of_utsusemi_ni
    },

    {
        { itemId = xi.item.NONE,                   weight = 250 }, -- nothing
        { itemId = xi.item.SQUARE_OF_VELVET_CLOTH, weight = 250 }, -- square_of_velvet_cloth
        { itemId = xi.item.SQUARE_OF_LINEN_CLOTH,  weight = 250 }, -- square_of_linen_cloth
        { itemId = xi.item.SQUARE_OF_WOOL_CLOTH,   weight = 250 }, -- square_of_wool_cloth
    },

    {
        { itemId = xi.item.NONE,            weight = 600 }, -- nothing
        { itemId = xi.item.MANNEQUIN_HEAD,  weight = 200 }, -- mannequin_head
        { itemId = xi.item.MANNEQUIN_HANDS, weight = 200 }, -- mannequin_hands
    },
}

return content:register()
