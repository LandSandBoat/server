-----------------------------------
-- The Final Bout
-- Waughroon Shrine BCNM50, Comet Orb
-- !additem 1177
-----------------------------------
local waughroonID = zones[xi.zone.WAUGHROON_SHRINE]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.WAUGHROON_SHRINE,
    battlefieldId    = xi.battlefield.id.FINAL_BOUT,
    maxPlayers       = 3,
    levelCap         = 50,
    timeLimit        = utils.minutes(3),
    index            = 14,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.COMET_ORB, wearMessage = waughroonID.text.A_CRACK_HAS_FORMED, wornMessage = waughroonID.text.ORB_IS_CRACKED },

    experimental = true,
})

content:addEssentialMobs({ 'The_Waughroon_Kid' })

content.loot =
{
    {
        quantity = 2,
        { itemId = xi.item.BAG_OF_TREE_CUTTINGS, weight = 1000 }, -- bag_of_tree_cuttings
    },

    {
        { itemId = xi.item.CLUMP_OF_BOYAHDA_MOSS, weight = 1000 }, -- clump_of_boyahda_moss
    },

    {
        { itemId = xi.item.SCROLL_OF_QUAKE,          weight = 100 }, -- scroll_of_quake
        { itemId = xi.item.PIECE_OF_WISTERIA_LUMBER, weight = 100 }, -- piece_of_wisteria_lumber
        { itemId = xi.item.MAHOGANY_LOG,             weight = 100 }, -- mahogany_log
        { itemId = xi.item.EBONY_LOG,                weight = 100 }, -- ebony_log
        { itemId = xi.item.SCROLL_OF_FREEZE,         weight = 100 }, -- scroll_of_freeze
        { itemId = xi.item.DARKSTEEL_INGOT,          weight = 100 }, -- darksteel_ingot
        { itemId = xi.item.SCROLL_OF_RAISE_II,       weight = 100 }, -- scroll_of_raise_ii
        { itemId = xi.item.PETRIFIED_LOG,            weight = 100 }, -- petrified_log
        { itemId = xi.item.GOLD_INGOT,               weight = 100 }, -- gold_ingot
        { itemId = xi.item.CORAL_FRAGMENT,           weight = 100 }, -- coral_fragment
    },

    {
        { itemId = xi.item.SHOCK_MASK,              weight = 62 }, -- shock_mask
        { itemId = xi.item.SUPER_RIBBON,            weight = 62 }, -- super_ribbon
        { itemId = xi.item.RIVAL_RIBBON,            weight = 62 }, -- rival_ribbon
        { itemId = xi.item.IVORY_MITTS,             weight = 62 }, -- ivory_mitts
        { itemId = xi.item.SPIKED_FINGER_GAUNTLETS, weight = 70 }, -- spiked_finger_gauntlets
        { itemId = xi.item.SLY_GAUNTLETS,           weight = 62 }, -- sly_gauntlets
        { itemId = xi.item.RUSH_GLOVES,             weight = 62 }, -- rush_gloves
        { itemId = xi.item.MANA_CIRCLET,            weight = 62 }, -- mana_circlet
        { itemId = xi.item.HATEFUL_COLLAR,          weight = 62 }, -- hateful_collar
        { itemId = xi.item.ESOTERIC_MANTLE,         weight = 62 }, -- esoteric_mantle
        { itemId = xi.item.TEMPLARS_MANTLE,         weight = 62 }, -- templars_mantle
        { itemId = xi.item.HEAVY_MANTLE,            weight = 62 }, -- heavy_mantle
        { itemId = xi.item.INTELLECT_TORQUE,        weight = 62 }, -- intellect_torque
        { itemId = xi.item.STORM_GORGET,            weight = 62 }, -- storm_gorget
        { itemId = xi.item.BENIGN_NECKLACE,         weight = 62 }, -- benign_necklace
        { itemId = xi.item.SNIPERS_MANTLE,          weight = 62 }, -- snipers_mantle
    },
}

return content:register()
