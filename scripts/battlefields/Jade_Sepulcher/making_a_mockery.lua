-----------------------------------
-- Making a Mockery
-- Jade Sepulcher, Confidential Imperial Order
-- !addkeyitem CONFIDENTIAL_IMPERIAL_ORDER
-----------------------------------
local ID = zones[xi.zone.JADE_SEPULCHER]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.JADE_SEPULCHER,
    battlefieldId    = xi.battlefield.id.MAKING_A_MOCKERY,
    maxPlayers       = 6,
    levelCap         = 60,
    timeLimit        = utils.minutes(30),
    index            = 0,
    entryNpc         = '_1v0',
    exitNpcs         = { '_1v1', '_1v2', '_1v3' },
    requiredKeyItems = { xi.ki.CONFIDENTIAL_IMPERIAL_ORDER, message = ID.text.ORDER_BREAKS },
})

content:addEssentialMobs({ 'Mocking_Colibri' })

content.loot =
{
    {
        { item = xi.item.AGILITY_POTION, weight = xi.loot.weight.NORMAL },
        { item = xi.item.VITALITY_POTION, weight = xi.loot.weight.NORMAL },
        { item = xi.item.STRENGTH_POTION, weight = xi.loot.weight.NORMAL },
        { item = xi.item.DEXTERITY_POTION, weight = xi.loot.weight.NORMAL },
    },

    {
        { item = xi.item.SQUARE_OF_POLYFLAN, weight = xi.loot.weight.HIGH },
        { item = xi.item.BUNDLE_OF_HOMUNCULUS_NERVES, weight = xi.loot.weight.NORMAL },
        { item = xi.item.GLASS_SHEET, weight = xi.loot.weight.LOW },
        { item = xi.item.PETRIFIED_LOG, weight = xi.loot.weight.LOW },
    },

    {
        { item = xi.item.SCROLL_OF_AERO_IV, weight = xi.loot.weight.NORMAL },
        { item = xi.item.SCROLL_OF_MAIDENS_VIRELAI, weight = xi.loot.weight.NORMAL },
        { item = xi.item.SCROLL_OF_CARNAGE_ELEGY, weight = xi.loot.weight.NORMAL },
        { item = xi.item.SCROLL_OF_FLARE, weight = xi.loot.weight.NORMAL },
        { item = xi.item.SCROLL_OF_FLOOD, weight = xi.loot.weight.NORMAL },
        { item = xi.item.SCROLL_OF_TORNADO, weight = xi.loot.weight.NORMAL },
        { item = xi.item.DARK_SPIRIT_PACT, weight = xi.loot.weight.NORMAL },
        { item = xi.item.LIGHT_SPIRIT_PACT, weight = xi.loot.weight.NORMAL },
        { item = xi.item.LOUDSPEAKER_II, weight = xi.loot.weight.VERY_LOW },
        { item = xi.item.ACCELERATOR_II, weight = xi.loot.weight.VERY_LOW },
        { item = xi.item.STABILIZER_II, weight = xi.loot.weight.VERY_LOW },
    },

    {
        { item = xi.item.CHOCOBO_EGG_A_LITTLE_WARM, weight = xi.loot.weight.NORMAL },
    },

    {
        { item = xi.item.COLIBRI_FEATHER, weight = xi.loot.weight.NORMAL },
    },

    {
        { item = xi.item.NONE, weight = xi.loot.weight.EXTREMELY_HIGH },
        { item = xi.item.CHUNK_OF_DARKSTEEL_ORE, weight = xi.loot.weight.NORMAL },
        { item = xi.item.DEMON_HORN, weight = xi.loot.weight.NORMAL },
        { item = xi.item.IYO_SCALE, weight = xi.loot.weight.LOW },
        { item = xi.item.SQUARE_OF_MOBLINWEAVE, weight = xi.loot.weight.LOW },
        { item = xi.item.ALUMINUM_SHEET, weight = xi.loot.weight.VERY_LOW },
        { item = xi.item.MYTHRIL_COIL, weight = xi.loot.weight.VERY_LOW },
    },

    {
        { item = xi.item.NONE, weight = xi.loot.weight.EXTREMELY_HIGH },
        { item = xi.item.IMMORTALS_CAPE, weight = xi.loot.weight.LOW },
        { item = xi.item.DEADEYE_GLOVES, weight = xi.loot.weight.LOW },
        { item = xi.item.LEECH_SCIMITAR, weight = xi.loot.weight.LOW },
        { item = xi.item.PIRATES_EARRING, weight = xi.loot.weight.LOW },
    },

    {
        { item = xi.item.CHUNK_OF_PLATINUM_ORE, weight = xi.loot.weight.VERY_HIGH },
        { item = xi.item.CHUNK_OF_DARKSTEEL_ORE, weight = xi.loot.weight.VERY_HIGH },
        { item = xi.item.CHUNK_OF_ADAMAN_ORE, weight = xi.loot.weight.NORMAL },
        { item = xi.item.CHUNK_OF_ORICHALCUM_ORE, weight = xi.loot.weight.LOW },
        { item = xi.item.DEMON_HORN, weight = xi.loot.weight.LOW },
    },
}

return content:register()
