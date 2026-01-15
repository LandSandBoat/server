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
})

content:addEssentialMobs({ 'The_Waughroon_Kid' })

content.loot =
{

    {
        { itemId = xi.item.GIL,                      weight = 10000, amount = 8000 },
    },

    {
        quantity = 2,
        { itemId = xi.item.BAG_OF_TREE_CUTTINGS,     weight = 10000 },
    },

    {
        { itemId = xi.item.NONE,                     weight =  5000 },
        { itemId = xi.item.BAG_OF_TREE_CUTTINGS,     weight =  5000 },
    },

    {
        { itemId = xi.item.CLUMP_OF_BOYAHDA_MOSS,    weight = 10000 },
    },

    {
        quantity = 2,
        { itemId = xi.item.MANA_CIRCLET,             weight =   620 },
        { itemId = xi.item.RIVAL_RIBBON,             weight =   620 },
        { itemId = xi.item.SHOCK_MASK,               weight =   620 },
        { itemId = xi.item.SUPER_RIBBON,             weight =   620 },
        { itemId = xi.item.IVORY_MITTS,              weight =   620 },
        { itemId = xi.item.RUSH_GLOVES,              weight =   620 },
        { itemId = xi.item.SLY_GAUNTLETS,            weight =   620 },
        { itemId = xi.item.SPIKED_FINGER_GAUNTLETS,  weight =   620 },
        { itemId = xi.item.ESOTERIC_MANTLE,          weight =   620 },
        { itemId = xi.item.HEAVY_MANTLE,             weight =   620 },
        { itemId = xi.item.SNIPERS_MANTLE,           weight =   620 },
        { itemId = xi.item.TEMPLARS_MANTLE,          weight =   620 },
        { itemId = xi.item.BENIGN_NECKLACE,          weight =   620 },
        { itemId = xi.item.HATEFUL_COLLAR,           weight =   620 },
        { itemId = xi.item.INTELLECT_TORQUE,         weight =   620 },
        { itemId = xi.item.STORM_GORGET,             weight =   620 },
    },

    {
        { itemId = xi.item.SCROLL_OF_QUAKE,          weight =   620 },
        { itemId = xi.item.SCROLL_OF_FREEZE,         weight =   620 },
        { itemId = xi.item.SCROLL_OF_RAISE_II,       weight =   620 },
        { itemId = xi.item.SCROLL_OF_REGEN_III,      weight =   620 },
        { itemId = xi.item.PIECE_OF_WISTERIA_LUMBER, weight =   620 },
        { itemId = xi.item.MAHOGANY_LOG,             weight =   620 },
        { itemId = xi.item.EBONY_LOG,                weight =   620 },
        { itemId = xi.item.PETRIFIED_LOG,            weight =   620 },
        { itemId = xi.item.DARKSTEEL_INGOT,          weight =   620 },
        { itemId = xi.item.GOLD_INGOT,               weight =   620 },
        { itemId = xi.item.MYTHRIL_INGOT,            weight =   620 },
        { itemId = xi.item.HANDFUL_OF_WYVERN_SCALES, weight =   620 },
        { itemId = xi.item.RAM_HORN,                 weight =   620 },
        { itemId = xi.item.WYVERN_SKIN,              weight =   620 },
        { itemId = xi.item.RAM_SKIN,                 weight =   620 },
        { itemId = xi.item.CORAL_FRAGMENT,           weight =   620 },
    }
}

return content:register()
