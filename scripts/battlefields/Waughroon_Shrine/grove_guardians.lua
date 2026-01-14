-----------------------------------
-- Grove Guardians
-- Waughroon Shrine BCNM30, Sky Orb
-- !additem 1552
-----------------------------------
local waughroonID = zones[xi.zone.WAUGHROON_SHRINE]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.WAUGHROON_SHRINE,
    battlefieldId    = xi.battlefield.id.GROVE_GUARDIANS,
    maxPlayers       = 6,
    levelCap         = 30,
    timeLimit        = utils.minutes(30),
    index            = 11,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.SKY_ORB, wearMessage = waughroonID.text.A_CRACK_HAS_FORMED, wornMessage = waughroonID.text.ORB_IS_CRACKED },
})

content:addEssentialMobs({ 'Metsanneitsyt', 'Metsanhaltija' })

content.loot =
{
    {
        { itemId = xi.item.GIL,                    weight = 10000, amount = 4000 },
    },

    {
        { itemId = xi.item.BAG_OF_HERB_SEEDS,      weight =  3333 },
        { itemId = xi.item.BAG_OF_VEGETABLE_SEEDS, weight =  3333 },
        { itemId = xi.item.BAG_OF_GRAIN_SEEDS,     weight =  3334 },
    },

    {
        { itemId = xi.item.NONE,                   weight =  2500 },
        { itemId = xi.item.WRESTLERS_MANTLE,       weight =  2500 },
        { itemId = xi.item.MAGICIANS_MANTLE,       weight =  2500 },
        { itemId = xi.item.PILFERERS_MANTLE,       weight =  2500 },
    },

    {
        { itemId = xi.item.NONE,                   weight =  2500 },
        { itemId = xi.item.HEALERS_SHIELD,         weight =  2500 },
        { itemId = xi.item.GENIN_ASPIS,            weight =  2500 },
        { itemId = xi.item.KILLER_TARGE,           weight =  2500 },
    },

    {
        { itemId = xi.item.NONE,                   weight =  8000 },
        { itemId = xi.item.CHUNK_OF_IRON_ORE,      weight =   200 },
        { itemId = xi.item.CHUNK_OF_SILVER_ORE,    weight =   200 },
        { itemId = xi.item.CHUNK_OF_MYTHRIL_ORE,   weight =   200 },
        { itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE, weight =   200 },
        { itemId = xi.item.IRON_INGOT,             weight =   200 },
        { itemId = xi.item.STEEL_INGOT,            weight =   200 },
        { itemId = xi.item.SILVER_INGOT,           weight =   200 },
        { itemId = xi.item.MYTHRIL_INGOT,          weight =   200 },
        { itemId = xi.item.CHESTNUT_LOG,           weight =   200 },
        { itemId = xi.item.ELM_LOG,                weight =   200 },
    },

    {
        { itemId = xi.item.NONE,                   weight =  5000 },
        { itemId = xi.item.BAG_OF_HERB_SEEDS,      weight =  1666 },
        { itemId = xi.item.BAG_OF_VEGETABLE_SEEDS, weight =  1666 },
        { itemId = xi.item.BAG_OF_GRAIN_SEEDS,     weight =  1667 },
    },

    {
        { itemId = xi.item.HORN_QUIVER,            weight =  2500 },
        { itemId = xi.item.SCORPION_QUIVER,        weight =  2500 },
        { itemId = xi.item.SCROLL_OF_MAGIC_FINALE, weight =  2000 },
        { itemId = xi.item.SCROLL_OF_DISPEL,       weight =  1000 },
        { itemId = xi.item.SCROLL_OF_UTSUSEMI_NI,  weight =  1000 },
        { itemId = xi.item.SCROLL_OF_ERASE,        weight =  1000 },
    },

    {
        { itemId = xi.item.MANNEQUIN_BODY,         weight = 10000 },
    },

    {
        { itemId = xi.item.NONE,                   weight =  9500 },
        { itemId = xi.item.MANNEQUIN_HANDS,        weight =   500 },
    },
}

return content:register()
