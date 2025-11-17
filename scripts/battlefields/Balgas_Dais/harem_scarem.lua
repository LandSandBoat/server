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
        { itemId = xi.item.GIL,                    weight = 1000, amount = 4000 },
    },

    {
        quantity = 2,
        { itemId = xi.item.NONE,                   weight =  250 },
        { itemId = xi.item.GIANT_FEMUR,            weight =  250 },
        { itemId = xi.item.SLICE_OF_DHALMEL_MEAT,  weight =  250 },
        { itemId = xi.item.DHALMEL_HIDE,           weight =  250 },
    },

    {
        { itemId = xi.item.NONE,                   weight = 250 },
        { itemId = xi.item.MERCENARY_MANTLE,       weight = 188 },
        { itemId = xi.item.BEATERS_MANTLE,         weight = 187 },
        { itemId = xi.item.ESQUIRES_MANTLE,        weight = 187 },
        { itemId = xi.item.HEALERS_MANTLE,         weight = 188 },
    },

    {
        { itemId = xi.item.NONE,                   weight = 250 },
        { itemId = xi.item.WIZARDS_SHIELD,         weight = 250 },
        { itemId = xi.item.TRIMMERS_ASPIS,         weight = 250 },
        { itemId = xi.item.WYVERN_TARGE,           weight = 250 },
    },

    {
        { itemId = xi.item.NONE,                   weight = 500 },
        { itemId = xi.item.SCROLL_OF_ERASE,        weight = 100 },
        { itemId = xi.item.SCROLL_OF_DISPEL,       weight = 100 },
        { itemId = xi.item.SCROLL_OF_MAGIC_FINALE, weight = 100 },
        { itemId = xi.item.SCROLL_OF_UTSUSEMI_NI,  weight = 100 },
        { itemId = xi.item.SCROLL_OF_REGEN,        weight = 100 },
    },

    {
        { itemId = xi.item.NONE,                   weight = 250 },
        { itemId = xi.item.SQUARE_OF_VELVET_CLOTH, weight = 250 },
        { itemId = xi.item.SQUARE_OF_LINEN_CLOTH,  weight = 250 },
        { itemId = xi.item.SQUARE_OF_WOOL_CLOTH,   weight = 250 },
    },

    {
        { itemId = xi.item.NONE,                   weight = 800 },
        { itemId = xi.item.SARDONYX,               weight =  25 },
        { itemId = xi.item.AMBER_STONE,            weight =  25 },
        { itemId = xi.item.LAPIS_LAZULI,           weight =  25 },
        { itemId = xi.item.TOURMALINE,             weight =  25 },
        { itemId = xi.item.CLEAR_TOPAZ,            weight =  25 },
        { itemId = xi.item.AMETHYST,               weight =  25 },
        { itemId = xi.item.LIGHT_OPAL,             weight =  25 },
        { itemId = xi.item.ONYX,                   weight =  25 },
    },

    {
        { itemId = xi.item.NONE,                   weight = 950 },
        { itemId = xi.item.MANNEQUIN_HEAD,         weight =  50 },
    },

    {
        { itemId = xi.item.MANNEQUIN_HANDS,        weight = 1000 },
    },
}

return content:register()
