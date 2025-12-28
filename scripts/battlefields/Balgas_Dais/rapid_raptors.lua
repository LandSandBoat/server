-----------------------------------
-- Rapid Raptors
-- Balga's Dais BCNM50, Comet Orb
-- !additem 1177
-----------------------------------
local balgasID = zones[xi.zone.BALGAS_DAIS]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.BALGAS_DAIS,
    battlefieldId    = xi.battlefield.id.RAPID_RAPTORS,
    maxPlayers       = 3,
    levelCap         = 50,
    timeLimit        = utils.minutes(15),
    index            = 13,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.COMET_ORB, wearMessage = balgasID.text.A_CRACK_HAS_FORMED, wornMessage = balgasID.text.ORB_IS_CRACKED },
})

content:addEssentialMobs({ 'Dromiceiomimus' })

content.loot =
{
    {
        { itemId = xi.item.GIL,                      weight = 10000, amount = 15000 },
    },

    {
        quantity = 3,
        { itemId = xi.item.RAPTOR_SKIN,              weight = 10000 },
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
        quantity = 2,
        { itemId = xi.item.MAHOGANY_LOG,             weight =   400 },
        { itemId = xi.item.EBONY_LOG,                weight =   400 },
        { itemId = xi.item.PETRIFIED_LOG,            weight =   400 },
        { itemId = xi.item.CHUNK_OF_MYTHRIL_ORE,     weight =   400 },
        { itemId = xi.item.CHUNK_OF_GOLD_ORE,        weight =   400 },
        { itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE,   weight =   400 },
        { itemId = xi.item.CHUNK_OF_PLATINUM_ORE,    weight =   400 },
        { itemId = xi.item.MYTHRIL_INGOT,            weight =   400 },
        { itemId = xi.item.GOLD_INGOT,               weight =   400 },
        { itemId = xi.item.DARKSTEEL_INGOT,          weight =   400 },
        { itemId = xi.item.PLATINUM_INGOT,           weight =   400 },
        { itemId = xi.item.RAM_HORN,                 weight =   400 },
        { itemId = xi.item.CORAL_FRAGMENT,           weight =   400 },
        { itemId = xi.item.DEMON_HORN,               weight =   400 },
        { itemId = xi.item.HANDFUL_OF_WYVERN_SCALES, weight =   400 },
        { itemId = xi.item.RAM_SKIN,                 weight =   400 },
        { itemId = xi.item.MANTICORE_HIDE,           weight =   400 },
        { itemId = xi.item.WYVERN_SKIN,              weight =   400 },
        { itemId = xi.item.SCROLL_OF_FREEZE,         weight =   400 },
        { itemId = xi.item.SCROLL_OF_QUAKE,          weight =   400 },
        { itemId = xi.item.SCROLL_OF_RAISE_II,       weight =   400 },
        { itemId = xi.item.SCROLL_OF_REGEN_III,      weight =   400 },
        { itemId = xi.item.FIRE_SPIRIT_PACT,         weight =   400 },
        { itemId = xi.item.LIGHT_SPIRIT_PACT,        weight =   400 },
        { itemId = xi.item.RERAISER,                 weight =   200 },
        { itemId = xi.item.VILE_ELIXIR,              weight =   200 },
    },
}

return content:register()
