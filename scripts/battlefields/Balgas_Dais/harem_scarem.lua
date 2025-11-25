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
        { itemId = xi.item.SLICE_OF_DHALMEL_MEAT,  weight = 1000 },
    },

    {
        { itemId = xi.item.NONE,                   weight = 250 },
        { itemId = xi.item.BEATERS_MANTLE,         weight = 250 },
        { itemId = xi.item.ESQUIRES_MANTLE,        weight = 250 },
        { itemId = xi.item.HEALERS_MANTLE,         weight = 250 },
    },

    {
        { itemId = xi.item.NONE,                   weight = 250 },
        { itemId = xi.item.WIZARDS_SHIELD,         weight = 250 },
        { itemId = xi.item.TRIMMERS_ASPIS,         weight = 250 },
        { itemId = xi.item.WYVERN_TARGE,           weight = 250 },
    },

    {
        { itemId = xi.item.NONE,                   weight = 800 },
        { itemId = xi.item.CHUNK_OF_IRON_ORE,      weight =  20 },
        { itemId = xi.item.CHUNK_OF_SILVER_ORE,    weight =  20 },
        { itemId = xi.item.CHUNK_OF_MYTHRIL_ORE,   weight =  20 },
        { itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE, weight =  20 },
        { itemId = xi.item.IRON_INGOT,             weight =  20 },
        { itemId = xi.item.STEEL_INGOT,            weight =  20 },
        { itemId = xi.item.SILVER_INGOT,           weight =  20 },
        { itemId = xi.item.MYTHRIL_INGOT,          weight =  20 },
        { itemId = xi.item.CHESTNUT_LOG,           weight =  20 },
        { itemId = xi.item.ELM_LOG,                weight =  20 },
    },

    {
        { itemId = xi.item.NONE,                   weight = 500 },
        { itemId = xi.item.SCROLL_OF_ERASE,        weight = 71 },
        { itemId = xi.item.SCROLL_OF_DISPEL,       weight = 71 },
        { itemId = xi.item.SCROLL_OF_MAGIC_FINALE, weight = 143 },
        { itemId = xi.item.SCROLL_OF_UTSUSEMI_NI,  weight = 72 },
        { itemId = xi.item.SCROLL_OF_REGEN,        weight = 143 },
    },

    {
        { itemId = xi.item.SQUARE_OF_VELVET_CLOTH, weight = 333 },
        { itemId = xi.item.SQUARE_OF_LINEN_CLOTH,  weight = 333 },
        { itemId = xi.item.SQUARE_OF_WOOL_CLOTH,   weight = 334 },
    },

    {
        { itemId = xi.item.MANNEQUIN_HANDS,        weight = 1000 },
    },

    {
        { itemId = xi.item.NONE,                   weight = 950 },
        { itemId = xi.item.MANNEQUIN_HEAD,         weight =  50 },
    },
}

return content:register()
