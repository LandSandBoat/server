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
        { itemid = xi.item.BAG_OF_TREE_CUTTINGS, droprate = 1000 }, -- bag_of_tree_cuttings
    },

    {
        { itemid = xi.item.CLUMP_OF_BOYAHDA_MOSS, droprate = 1000 }, -- clump_of_boyahda_moss
    },

    {
        { itemid = xi.item.SCROLL_OF_QUAKE,          droprate = 100 }, -- scroll_of_quake
        { itemid = xi.item.PIECE_OF_WISTERIA_LUMBER, droprate = 100 }, -- piece_of_wisteria_lumber
        { itemid = xi.item.MAHOGANY_LOG,             droprate = 100 }, -- mahogany_log
        { itemid = xi.item.EBONY_LOG,                droprate = 100 }, -- ebony_log
        { itemid = xi.item.SCROLL_OF_FREEZE,         droprate = 100 }, -- scroll_of_freeze
        { itemid = xi.item.DARKSTEEL_INGOT,          droprate = 100 }, -- darksteel_ingot
        { itemid = xi.item.SCROLL_OF_RAISE_II,       droprate = 100 }, -- scroll_of_raise_ii
        { itemid = xi.item.PETRIFIED_LOG,            droprate = 100 }, -- petrified_log
        { itemid = xi.item.GOLD_INGOT,               droprate = 100 }, -- gold_ingot
        { itemid = xi.item.CORAL_FRAGMENT,           droprate = 100 }, -- coral_fragment
    },

    {
        { itemid = xi.item.SHOCK_MASK,              droprate = 62 }, -- shock_mask
        { itemid = xi.item.SUPER_RIBBON,            droprate = 62 }, -- super_ribbon
        { itemid = xi.item.RIVAL_RIBBON,            droprate = 62 }, -- rival_ribbon
        { itemid = xi.item.IVORY_MITTS,             droprate = 62 }, -- ivory_mitts
        { itemid = xi.item.SPIKED_FINGER_GAUNTLETS, droprate = 70 }, -- spiked_finger_gauntlets
        { itemid = xi.item.SLY_GAUNTLETS,           droprate = 62 }, -- sly_gauntlets
        { itemid = xi.item.RUSH_GLOVES,             droprate = 62 }, -- rush_gloves
        { itemid = xi.item.MANA_CIRCLET,            droprate = 62 }, -- mana_circlet
        { itemid = xi.item.HATEFUL_COLLAR,          droprate = 62 }, -- hateful_collar
        { itemid = xi.item.ESOTERIC_MANTLE,         droprate = 62 }, -- esoteric_mantle
        { itemid = xi.item.TEMPLARS_MANTLE,         droprate = 62 }, -- templars_mantle
        { itemid = xi.item.HEAVY_MANTLE,            droprate = 62 }, -- heavy_mantle
        { itemid = xi.item.INTELLECT_TORQUE,        droprate = 62 }, -- intellect_torque
        { itemid = xi.item.STORM_GORGET,            droprate = 62 }, -- storm_gorget
        { itemid = xi.item.BENIGN_NECKLACE,         droprate = 62 }, -- benign_necklace
        { itemid = xi.item.SNIPERS_MANTLE,          droprate = 62 }, -- snipers_mantle
    },
}

return content:register()
