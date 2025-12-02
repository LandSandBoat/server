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
        { itemId = xi.item.GOLEM_SHARD, weight = 1000 },
    },

    {
        { itemId = xi.item.SLAB_OF_GRANITE, weight = 1000 },
    },

    {
        { itemId = xi.item.LIBATION_ABJURATION, weight = 500 },
        { itemId = xi.item.OBLATION_ABJURATION, weight = 500 },
    },

    {
        { itemId = xi.item.NONE,             weight = 875 },
        { itemId = xi.item.SCROLL_OF_FREEZE, weight = 125 },
    },

    {
        { itemId = xi.item.NONE,           weight = 200 },
        { itemId = xi.item.OPTICAL_NEEDLE, weight = 200 },
        { itemId = xi.item.KAKANPU,        weight = 200 },
        { itemId = xi.item.MANTRA_COIN,    weight = 200 },
        { itemId = xi.item.NAZAR_BONJUK,   weight = 200 },
    },

    {
        { itemId = xi.item.NONE,                 weight = 100 },
        { itemId = xi.item.CHUNK_OF_MYTHRIL_ORE, weight = 300 },
        { itemId = xi.item.GOLD_INGOT,           weight = 300 },
        { itemId = xi.item.PLATINUM_INGOT,       weight = 300 },
    },
}

return content:register()
