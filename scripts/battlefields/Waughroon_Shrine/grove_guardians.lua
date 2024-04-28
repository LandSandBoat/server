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
        { item = xi.item.MANNEQUIN_BODY, weight = 1000 }, -- mannequin_body
    },

    {
        { item = xi.item.NONE,            weight = 800 }, -- nothing
        { item = xi.item.MANNEQUIN_HANDS, weight = 200 }, -- mannequin_hands
    },

    {
        { item = xi.item.NONE,             weight = 250 }, -- nothing
        { item = xi.item.WRESTLERS_MANTLE, weight = 250 }, -- wrestlers_mantle
        { item = xi.item.MAGICIANS_MANTLE, weight = 250 }, -- magicians_mantle
        { item = xi.item.PILFERERS_MANTLE, weight = 250 }, -- pilferers_mantle
    },

    {
        { item = xi.item.NONE,           weight = 200 }, -- nothing
        { item = xi.item.HEALERS_SHIELD, weight = 200 }, -- healers_shield
        { item = xi.item.GENIN_ASPIS,    weight = 200 }, -- genin_aspis
        { item = xi.item.KILLER_TARGE,   weight = 200 }, -- killer_targe
        { item = xi.item.STAFF_BELT,     weight = 200 }, -- staff_belt
    },

    {
        { item = xi.item.NONE,                   weight = 250 }, -- nothing
        { item = xi.item.BAG_OF_HERB_SEEDS,      weight = 250 }, -- bag_of_herb_seeds
        { item = xi.item.BAG_OF_VEGETABLE_SEEDS, weight = 250 }, -- bag_of_vegetable_seeds
        { item = xi.item.BAG_OF_GRAIN_SEEDS,     weight = 250 }, -- bag_of_grain_seeds
    },

    {
        { item = xi.item.NONE,                   weight = 500 }, -- nothing
        { item = xi.item.SCROLL_OF_DISPEL,       weight = 125 }, -- scroll_of_dispel
        { item = xi.item.SCROLL_OF_UTSUSEMI_NI,  weight = 125 }, -- scroll_of_utsusemi_ni
        { item = xi.item.SCROLL_OF_MAGIC_FINALE, weight = 125 }, -- scroll_of_magic_finale
        { item = xi.item.SCROLL_OF_ERASE,        weight = 125 }, -- scroll_of_erase
    },

    {
        { item = xi.item.NONE,            weight = 800 }, -- nothing
        { item = xi.item.SCORPION_QUIVER, weight = 200 }, -- scorpion_quiver
    },
}

return content:register()
