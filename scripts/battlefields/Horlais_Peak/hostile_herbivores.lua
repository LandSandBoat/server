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
        { itemId = xi.item.NONE,         weight = 50 }, -- Nothing
        { itemId = xi.item.OCEAN_BELT,   weight = 95 }, -- Ocean Belt
        { itemId = xi.item.JUNGLE_BELT,  weight = 95 }, -- Jungle Belt
        { itemId = xi.item.STEPPE_BELT,  weight = 95 }, -- Steppe Belt
        { itemId = xi.item.DESERT_BELT,  weight = 95 }, -- Desert Belt
        { itemId = xi.item.FOREST_BELT,  weight = 95 }, -- Forest Belt
        { itemId = xi.item.OCEAN_STONE,  weight = 95 }, -- Ocean Stone
        { itemId = xi.item.JUNGLE_STONE, weight = 95 }, -- Jungle Stone
        { itemId = xi.item.STEPPE_STONE, weight = 95 }, -- Steppe Stone
        { itemId = xi.item.DESERT_STONE, weight = 95 }, -- Desert Stone
        { itemId = xi.item.FOREST_STONE, weight = 95 }, -- Forest Stone
    },

    {
        { itemId = xi.item.GUARDIANS_RING, weight = 64 }, -- Guardians Ring
        { itemId = xi.item.KAMPFER_RING,   weight = 65 }, -- Kampfer Ring
        { itemId = xi.item.CONJURERS_RING, weight = 65 }, -- Conjurers Ring
        { itemId = xi.item.SHINOBI_RING,   weight = 65 }, -- Shinobi Ring
        { itemId = xi.item.SLAYERS_RING,   weight = 65 }, -- Slayers Ring
        { itemId = xi.item.SORCERERS_RING, weight = 65 }, -- Sorcerers Ring
        { itemId = xi.item.SOLDIERS_RING,  weight = 64 }, -- Soldiers Ring
        { itemId = xi.item.TAMERS_RING,    weight = 65 }, -- Tamers Ring
        { itemId = xi.item.TRACKERS_RING,  weight = 64 }, -- Trackers Ring
        { itemId = xi.item.DRAKE_RING,     weight = 65 }, -- Drake Ring
        { itemId = xi.item.FENCERS_RING,   weight = 65 }, -- Fencers Ring
        { itemId = xi.item.MINSTRELS_RING, weight = 65 }, -- Minstrels Ring
        { itemId = xi.item.MEDICINE_RING,  weight = 64 }, -- Medicine Ring
        { itemId = xi.item.ROGUES_RING,    weight = 65 }, -- Rogues Ring
        { itemId = xi.item.RONIN_RING,     weight = 64 }, -- Ronin Ring
        { itemId = xi.item.PLATINUM_RING,  weight = 30 }, -- Platinum Ring
    },

    {
        quantity = 2,
        { itemId = xi.item.NONE,                weight = 100 }, -- Nothing
        { itemId = xi.item.SCROLL_OF_QUAKE,     weight = 176 }, -- Scroll Of Quake
        { itemId = xi.item.LIGHT_SPIRIT_PACT,   weight =  10 }, -- Light Spirit Pact
        { itemId = xi.item.SCROLL_OF_FREEZE,    weight = 176 }, -- Scroll Of Freeze
        { itemId = xi.item.SCROLL_OF_REGEN_III, weight = 176 }, -- Scroll Of Regen Iii
        { itemId = xi.item.RERAISER,            weight =  60 }, -- Reraiser
        { itemId = xi.item.VILE_ELIXIR,         weight =  60 }, -- Vile Elixir
        { itemId = xi.item.SCROLL_OF_RAISE_II,  weight = 176 }, -- Scroll Of Raise Ii
    },

    {
        quantity = 2,
        { itemId = xi.item.RAM_HORN,                 weight =  59 }, -- Ram Horn
        { itemId = xi.item.MAHOGANY_LOG,             weight =  59 }, -- Mahogany Log
        { itemId = xi.item.MYTHRIL_INGOT,            weight = 200 }, -- Mythril Ingot
        { itemId = xi.item.MANTICORE_HIDE,           weight =  59 }, -- Manticore Hide
        { itemId = xi.item.HANDFUL_OF_WYVERN_SCALES, weight =  90 }, -- Handful Of Wyvern Scales
        { itemId = xi.item.WYVERN_SKIN,              weight =  90 }, -- Wyvern Skin
        { itemId = xi.item.PETRIFIED_LOG,            weight = 176 }, -- Petrified Log
        { itemId = xi.item.DARKSTEEL_INGOT,          weight =  59 }, -- Darksteel Ingot
        { itemId = xi.item.RAM_SKIN,                 weight =  59 }, -- Ram Skin
        { itemId = xi.item.PLATINUM_INGOT,           weight =  90 }, -- Platinum Ingot
    },
}

return content:register()
