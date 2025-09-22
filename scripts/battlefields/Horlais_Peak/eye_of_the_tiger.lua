-----------------------------------
-- Eye of the Tiger
-- Horlais Peak BCNM50, Comet Orb
-- !additem 1177
-----------------------------------
local horlaisID = zones[xi.zone.HORLAIS_PEAK]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.HORLAIS_PEAK,
    battlefieldId    = xi.battlefield.id.EYE_OF_THE_TIGER,
    maxPlayers       = 3,
    levelCap         = 50,
    timeLimit        = utils.minutes(15),
    index            = 13,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.COMET_ORB, wearMessage = horlaisID.text.A_CRACK_HAS_FORMED, wornMessage = horlaisID.text.ORB_IS_CRACKED },
})

content:addEssentialMobs({ 'Gerjis' })

content.loot =
{
    {
        quantity = 2,
        { itemId = xi.item.BLACK_TIGER_FANG, weight = 1000 }, -- black_tiger_fang
    },

    {
        { itemId = xi.item.NONE,     weight = 700 }, -- nothing
        { itemId = xi.item.NUE_FANG, weight = 300 }, -- nue_fang
    },

    {
        { itemId = xi.item.NONE,                    weight = 125 }, -- nothing
        { itemId = xi.item.IVORY_MITTS,             weight = 125 }, -- ivory_mitts
        { itemId = xi.item.SUPER_RIBBON,            weight = 125 }, -- super_ribbon
        { itemId = xi.item.MANA_CIRCLET,            weight = 125 }, -- mana_circlet
        { itemId = xi.item.RIVAL_RIBBON,            weight = 125 }, -- rival_ribbon
        { itemId = xi.item.SLY_GAUNTLETS,           weight = 125 }, -- sly_gauntlets
        { itemId = xi.item.SHOCK_MASK,              weight = 125 }, -- shock_mask
        { itemId = xi.item.SPIKED_FINGER_GAUNTLETS, weight = 125 }, -- spiked_finger_gauntlets
    },

    {
        { itemId = xi.item.INTELLECT_TORQUE, weight = 125 }, -- intellect_torque
        { itemId = xi.item.ESOTERIC_MANTLE,  weight = 125 }, -- esoteric_mantle
        { itemId = xi.item.TEMPLARS_MANTLE,  weight = 125 }, -- templars_mantle
        { itemId = xi.item.SNIPERS_MANTLE,   weight = 125 }, -- snipers_mantle
        { itemId = xi.item.HATEFUL_COLLAR,   weight = 125 }, -- hateful_collar
        { itemId = xi.item.STORM_GORGET,     weight = 125 }, -- storm_gorget
        { itemId = xi.item.HEAVY_MANTLE,     weight = 125 }, -- heavy_mantle
        { itemId = xi.item.BENIGN_NECKLACE,  weight = 125 }, -- benign_necklace
    },

    {
        { itemId = xi.item.NONE,           weight = 125 }, -- nothing
        { itemId = xi.item.GOLD_INGOT,     weight = 125 }, -- gold_ingot
        { itemId = xi.item.RAM_HORN,       weight = 125 }, -- ram_horn
        { itemId = xi.item.WYVERN_SKIN,    weight = 125 }, -- wyvern_skin
        { itemId = xi.item.EBONY_LOG,      weight = 125 }, -- ebony_log
        { itemId = xi.item.MYTHRIL_INGOT,  weight = 125 }, -- mythril_ingot
        { itemId = xi.item.RAM_SKIN,       weight = 125 }, -- ram_skin
        { itemId = xi.item.CORAL_FRAGMENT, weight = 125 }, -- coral_fragment
    },

    {
        { itemId = xi.item.NONE,                  weight = 400 }, -- nothing
        { itemId = xi.item.SLICE_OF_BUFFALO_MEAT, weight = 200 }, -- slice_of_buffalo_meat
        { itemId = xi.item.SLICE_OF_DRAGON_MEAT,  weight = 200 }, -- slice_of_dragon_meat
        { itemId = xi.item.SLICE_OF_COEURL_MEAT,  weight = 200 }, -- slice_of_coeurl_meat
    },

    {
        { itemId = xi.item.NONE,               weight = 625 }, -- nothing
        { itemId = xi.item.SCROLL_OF_FREEZE,   weight = 125 }, -- scroll_of_freeze
        { itemId = xi.item.SCROLL_OF_RAISE_II, weight = 125 }, -- scroll_of_raise_ii
        { itemId = xi.item.SCROLL_OF_QUAKE,    weight = 125 }, -- scroll_of_quake
    },
}

return content:register()
