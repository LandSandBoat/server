-----------------------------------
-- Tough Nut to Crack
-- Navukgo Execution Chamber, Confidential Imperial Order
-- !addkeyitem CONFIDENTIAL_IMPERIAL_ORDER
-----------------------------------
local ID = zones[xi.zone.NAVUKGO_EXECUTION_CHAMBER]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.NAVUKGO_EXECUTION_CHAMBER,
    battlefieldId    = xi.battlefield.id.TOUGH_NUT_TO_CRACK,
    maxPlayers       = 6,
    levelCap         = 60,
    timeLimit        = utils.minutes(30),
    index            = 0,
    entryNpc         = '_1s0',
    exitNpcs         = { '_1s1', '_1s2', '_1s3' },
    requiredKeyItems = { xi.ki.CONFIDENTIAL_IMPERIAL_ORDER, message = ID.text.IMPERIAL_ORDER_BREAKS },
})

content:addEssentialMobs({ 'Watch_Wamoura' })

content.loot =
{
    {
        { item = xi.item.GIL, weight = xi.loot.weight.NORMAL, amount = 8000 },
    },

    {
        { item = xi.item.AGILITY_POTION, weight = xi.loot.weight.NORMAL },
        { item = xi.item.VITALITY_POTION, weight = xi.loot.weight.NORMAL },
        { item = xi.item.STRENGTH_POTION, weight = xi.loot.weight.NORMAL },
        { item = xi.item.DEXTERITY_POTION, weight = xi.loot.weight.NORMAL },
    },

    {
        { item = xi.item.GLASS_SHEET, weight = xi.loot.weight.NORMAL },
        { item = xi.item.BUNDLE_OF_HOMUNCULUS_NERVES, weight = xi.loot.weight.NORMAL },
        { item = xi.item.SQUARE_OF_POLYFLAN, weight = xi.loot.weight.NORMAL },
    },

    {
        { item = xi.item.SCROLL_OF_MAIDENS_VIRELAI, weight = xi.loot.weight.HIGH },
        { item = xi.item.SCROLL_OF_CARNAGE_ELEGY, weight = xi.loot.weight.HIGH },
        { item = xi.item.SCROLL_OF_AERO_IV, weight = xi.loot.weight.NORMAL },
        { item = xi.item.SCROLL_OF_FLARE, weight = xi.loot.weight.NORMAL },
        { item = xi.item.SCROLL_OF_FLOOD, weight = xi.loot.weight.NORMAL },
        { item = xi.item.SCROLL_OF_TORNADO, weight = xi.loot.weight.NORMAL },
        { item = xi.item.DARK_SPIRIT_PACT, weight = xi.loot.weight.NORMAL },
        { item = xi.item.LIGHT_SPIRIT_PACT, weight = xi.loot.weight.NORMAL },
    },

    {
        { item = xi.item.CHOCOBO_EGG_A_LITTLE_WARM, weight = xi.loot.weight.NORMAL },
    },

    {
        { item = xi.item.WAMOURA_COCOON, weight = xi.loot.weight.NORMAL },
    },

    {
        { item = xi.item.NONE, weight = xi.loot.weight.EXTREMELY_HIGH },
        { item = xi.item.TEMPLAR_SABATONS, weight = xi.loot.weight.LOW },
        { item = xi.item.BUSKERS_CAPE, weight = xi.loot.weight.LOW },
        { item = xi.item.DOMINION_RING, weight = xi.loot.weight.LOW },
        { item = xi.item.IMMORTALS_EARRING, weight = xi.loot.weight.LOW },
    },

    {
        { item = xi.item.NONE, weight = xi.loot.weight.EXTREMELY_HIGH },
        { item = xi.item.CHUNK_OF_PLATINUM_ORE, weight = xi.loot.weight.NORMAL },
        { item = xi.item.CHUNK_OF_DARKSTEEL_ORE, weight = xi.loot.weight.NORMAL },
        { item = xi.item.CHUNK_OF_ADAMAN_ORE, weight = xi.loot.weight.NORMAL },
        { item = xi.item.CHUNK_OF_ORICHALCUM_ORE, weight = xi.loot.weight.NORMAL },
    },
}

return content:register()
