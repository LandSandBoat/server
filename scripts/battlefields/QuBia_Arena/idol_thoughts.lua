-----------------------------------
-- Idol Thoughts
-- Qu'Bia Arena BCNM50, Comet Orb
-- !additem 1177
-----------------------------------
local qubiaID = zones[xi.zone.QUBIA_ARENA]
-----------------------------------

local content = Battlefield:new({
    zoneId        = xi.zone.QUBIA_ARENA,
    battlefieldId = xi.battlefield.id.IDOL_THOUGHTS,
    maxPlayers    = 6,
    levelCap      = 50,
    timeLimit     = utils.minutes(30),
    index         = 14,
    entryNpc      = 'BC_Entrance',
    exitNpc       = 'Burning_Circle',
    requiredItems = { xi.item.COMET_ORB, wearMessage = qubiaID.text.A_CRACK_HAS_FORMED, wornMessage = qubiaID.text.ORB_IS_CRACKED },
})

content:addEssentialMobs({ 'Fire_Golem', 'Water_Golem', 'Wind_Golem', 'Earth_Golem' })

content.loot =
{
    {
        { itemId = xi.item.GIL,                      weight = 10000, amount = 12000 },
    },

    {
        { itemId = xi.item.GOLEM_SHARD,              weight = 10000 },
    },

    {
        quantity = 2,
        { itemId = xi.item.CHUNK_OF_MYTHRIL_ORE,     weight = 10000 },
    },

    {
        { itemId = xi.item.LIBATION_ABJURATION,      weight =  5000 },
        { itemId = xi.item.OBLATION_ABJURATION,      weight =  5000 },
    },

    {
        { itemId = xi.item.OPTICAL_NEEDLE,           weight =  2500 },
        { itemId = xi.item.KAKANPU,                  weight =  2500 },
        { itemId = xi.item.MANTRA_COIN,              weight =  2500 },
        { itemId = xi.item.NAZAR_BONJUK,             weight =  2500 },
    },

    {
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
