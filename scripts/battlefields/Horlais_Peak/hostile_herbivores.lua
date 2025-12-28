-----------------------------------
-- Hostile Herbivores
-- Horlais Peak BCNM50, Comet Orb
-- !additem 1177
-----------------------------------
local horlaisID = zones[xi.zone.HORLAIS_PEAK]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.HORLAIS_PEAK,
    battlefieldId    = xi.battlefield.id.HOSTILE_HERBIVORES,
    maxPlayers       = 6,
    levelCap         = 50,
    timeLimit        = utils.minutes(30),
    index            = 4,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.COMET_ORB, wearMessage = horlaisID.text.A_CRACK_HAS_FORMED, wornMessage = horlaisID.text.ORB_IS_CRACKED },
})

content:addEssentialMobs({ 'Fighting_Sheep' })

content.loot =
{
    {
        { itemId = xi.item.OCEAN_BELT,               weight = 1000 },
        { itemId = xi.item.JUNGLE_BELT,              weight = 1000 },
        { itemId = xi.item.STEPPE_BELT,              weight = 1000 },
        { itemId = xi.item.DESERT_BELT,              weight = 1000 },
        { itemId = xi.item.FOREST_BELT,              weight = 1000 },
        { itemId = xi.item.OCEAN_STONE,              weight = 1000 },
        { itemId = xi.item.JUNGLE_STONE,             weight = 1000 },
        { itemId = xi.item.STEPPE_STONE,             weight = 1000 },
        { itemId = xi.item.DESERT_STONE,             weight = 1000 },
        { itemId = xi.item.FOREST_STONE,             weight = 1000 },
    },

    {
        { itemId = xi.item.GUARDIANS_RING,           weight =  625 },
        { itemId = xi.item.KAMPFER_RING,             weight =  625 },
        { itemId = xi.item.CONJURERS_RING,           weight =  625 },
        { itemId = xi.item.SHINOBI_RING,             weight =  625 },
        { itemId = xi.item.SLAYERS_RING,             weight =  625 },
        { itemId = xi.item.SORCERERS_RING,           weight =  625 },
        { itemId = xi.item.SOLDIERS_RING,            weight =  625 },
        { itemId = xi.item.TAMERS_RING,              weight =  625 },
        { itemId = xi.item.TRACKERS_RING,            weight =  625 },
        { itemId = xi.item.DRAKE_RING,               weight =  625 },
        { itemId = xi.item.FENCERS_RING,             weight =  625 },
        { itemId = xi.item.MINSTRELS_RING,           weight =  625 },
        { itemId = xi.item.MEDICINE_RING,            weight =  625 },
        { itemId = xi.item.ROGUES_RING,              weight =  625 },
        { itemId = xi.item.RONIN_RING,               weight =  625 },
        { itemId = xi.item.PLATINUM_RING,            weight =  625 },
    },

    {
        { itemId = xi.item.NONE,                     weight = 5000 },
        { itemId = xi.item.RERAISER,                 weight = 2500 },
        { itemId = xi.item.VILE_ELIXIR,              weight = 2500 },
    },

    {
        { itemId = xi.item.SCROLL_OF_QUAKE,          weight =  500 },
        { itemId = xi.item.SCROLL_OF_FREEZE,         weight =  500 },
        { itemId = xi.item.SCROLL_OF_RAISE_II,       weight =  500 },
        { itemId = xi.item.SCROLL_OF_REGEN_III,      weight =  500 },
        { itemId = xi.item.LIGHT_SPIRIT_PACT,        weight =  500 },
        { itemId = xi.item.MAHOGANY_LOG,             weight =  500 },
        { itemId = xi.item.EBONY_LOG,                weight =  500 },
        { itemId = xi.item.PETRIFIED_LOG,            weight =  500 },
        { itemId = xi.item.PIECE_OF_WISTERIA_LUMBER, weight =  500 },
        { itemId = xi.item.MYTHRIL_INGOT,            weight =  500 },
        { itemId = xi.item.GOLD_INGOT,               weight =  500 },
        { itemId = xi.item.DARKSTEEL_INGOT,          weight =  500 },
        { itemId = xi.item.PLATINUM_INGOT,           weight =  500 },
        { itemId = xi.item.RAM_SKIN,                 weight =  500 },
        { itemId = xi.item.MANTICORE_HIDE,           weight =  500 },
        { itemId = xi.item.WYVERN_SKIN,              weight =  500 },
        { itemId = xi.item.RAM_HORN,                 weight =  500 },
        { itemId = xi.item.DEMON_HORN,               weight =  500 },
        { itemId = xi.item.CORAL_FRAGMENT,           weight =  500 },
        { itemId = xi.item.HANDFUL_OF_WYVERN_SCALES, weight =  500 },
    },
}

return content:register()
