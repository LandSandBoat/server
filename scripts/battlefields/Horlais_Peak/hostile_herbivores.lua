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
        { item = xi.item.NONE,         weight = 50 }, -- Nothing
        { item = xi.item.OCEAN_BELT,   weight = 95 }, -- Ocean Belt
        { item = xi.item.JUNGLE_BELT,  weight = 95 }, -- Jungle Belt
        { item = xi.item.STEPPE_BELT,  weight = 95 }, -- Steppe Belt
        { item = xi.item.DESERT_BELT,  weight = 95 }, -- Desert Belt
        { item = xi.item.FOREST_BELT,  weight = 95 }, -- Forest Belt
        { item = xi.item.OCEAN_STONE,  weight = 95 }, -- Ocean Stone
        { item = xi.item.JUNGLE_STONE, weight = 95 }, -- Jungle Stone
        { item = xi.item.STEPPE_STONE, weight = 95 }, -- Steppe Stone
        { item = xi.item.DESERT_STONE, weight = 95 }, -- Desert Stone
        { item = xi.item.FOREST_STONE, weight = 95 }, -- Forest Stone
    },

    {
        { item = xi.item.GUARDIANS_RING, weight = 64 }, -- Guardians Ring
        { item = xi.item.KAMPFER_RING,   weight = 65 }, -- Kampfer Ring
        { item = xi.item.CONJURERS_RING, weight = 65 }, -- Conjurers Ring
        { item = xi.item.SHINOBI_RING,   weight = 65 }, -- Shinobi Ring
        { item = xi.item.SLAYERS_RING,   weight = 65 }, -- Slayers Ring
        { item = xi.item.SORCERERS_RING, weight = 65 }, -- Sorcerers Ring
        { item = xi.item.SOLDIERS_RING,  weight = 64 }, -- Soldiers Ring
        { item = xi.item.TAMERS_RING,    weight = 65 }, -- Tamers Ring
        { item = xi.item.TRACKERS_RING,  weight = 64 }, -- Trackers Ring
        { item = xi.item.DRAKE_RING,     weight = 65 }, -- Drake Ring
        { item = xi.item.FENCERS_RING,   weight = 65 }, -- Fencers Ring
        { item = xi.item.MINSTRELS_RING, weight = 65 }, -- Minstrels Ring
        { item = xi.item.MEDICINE_RING,  weight = 64 }, -- Medicine Ring
        { item = xi.item.ROGUES_RING,    weight = 65 }, -- Rogues Ring
        { item = xi.item.RONIN_RING,     weight = 64 }, -- Ronin Ring
        { item = xi.item.PLATINUM_RING,  weight = 30 }, -- Platinum Ring
    },

    {
        quantity = 2,
        { item = xi.item.NONE,                weight = 100 }, -- Nothing
        { item = xi.item.SCROLL_OF_QUAKE,     weight = 176 }, -- Scroll Of Quake
        { item = xi.item.LIGHT_SPIRIT_PACT,   weight =  10 }, -- Light Spirit Pact
        { item = xi.item.SCROLL_OF_FREEZE,    weight = 176 }, -- Scroll Of Freeze
        { item = xi.item.SCROLL_OF_REGEN_III, weight = 176 }, -- Scroll Of Regen Iii
        { item = xi.item.RERAISER,            weight =  60 }, -- Reraiser
        { item = xi.item.VILE_ELIXIR,         weight =  60 }, -- Vile Elixir
        { item = xi.item.SCROLL_OF_RAISE_II,  weight = 176 }, -- Scroll Of Raise Ii
    },

    {
        quantity = 2,
        { item = xi.item.RAM_HORN,                 weight =  59 }, -- Ram Horn
        { item = xi.item.MAHOGANY_LOG,             weight =  59 }, -- Mahogany Log
        { item = xi.item.MYTHRIL_INGOT,            weight = 200 }, -- Mythril Ingot
        { item = xi.item.MANTICORE_HIDE,           weight =  59 }, -- Manticore Hide
        { item = xi.item.HANDFUL_OF_WYVERN_SCALES, weight =  90 }, -- Handful Of Wyvern Scales
        { item = xi.item.WYVERN_SKIN,              weight =  90 }, -- Wyvern Skin
        { item = xi.item.PETRIFIED_LOG,            weight = 176 }, -- Petrified Log
        { item = xi.item.DARKSTEEL_INGOT,          weight =  59 }, -- Darksteel Ingot
        { item = xi.item.RAM_SKIN,                 weight =  59 }, -- Ram Skin
        { item = xi.item.PLATINUM_INGOT,           weight =  90 }, -- Platinum Ingot
    },
}

return content:register()
