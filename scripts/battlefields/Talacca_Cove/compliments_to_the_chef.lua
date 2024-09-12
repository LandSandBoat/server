-----------------------------------
-- Compliments to the Chef
-- Talacca Cove, Secret Imperial Order
-- !addkeyitem SECRET_IMPERIAL_ORDER
-----------------------------------
local ID = zones[xi.zone.TALACCA_COVE]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.TALACCA_COVE,
    battlefieldId    = xi.battlefield.id.COMPLIMENTS_TO_THE_CHEF,
    maxPlayers       = 6,
    levelCap         = 75,
    timeLimit        = utils.minutes(30),
    index            = 1,
    entryNpc         = '_1l0',
    exitNpcs         = { '_1l1', '_1l2', '_1l3' },
    requiredKeyItems = { xi.ki.SECRET_IMPERIAL_ORDER, message = ID.text.IMPERIAL_ORDER_BREAKS },
})

content:addEssentialMobs({ 'Angler_Orobon' })

content.loot =
{
    {
        { item = xi.item.GIL, weight = xi.loot.weight.NORMAL, amount = 12000 },
    },

    {
        { item = xi.item.CHARISMA_POTION, weight = xi.loot.weight.NORMAL },
        { item = xi.item.ICARUS_WING, weight = xi.loot.weight.NORMAL },
        { item = xi.item.INTELLIGENCE_POTION, weight = xi.loot.weight.NORMAL },
        { item = xi.item.MIND_POTION, weight = xi.loot.weight.NORMAL },
    },

    {
        { item = xi.item.BOTTLE_OF_SIEGLINDE_PUTTY, weight = xi.loot.weight.NORMAL },
        { item = xi.item.BRASS_TANK, weight = xi.loot.weight.NORMAL },
        { item = xi.item.MERROW_SCALE, weight = xi.loot.weight.NORMAL },
        { item = xi.item.AHRIMAN_WING, weight = xi.loot.weight.NORMAL },
    },

    {
        { item = xi.item.SCROLL_OF_ERASE, weight = xi.loot.weight.HIGH },
        { item = xi.item.SCROLL_OF_PROTECTRA_IV, weight = xi.loot.weight.HIGH },
        { item = xi.item.SCROLL_OF_BLIZZARD_IV, weight = xi.loot.weight.NORMAL },
        { item = xi.item.SCROLL_OF_DISPEL, weight = xi.loot.weight.NORMAL },
        { item = xi.item.SCROLL_OF_PROTECT_IV, weight = xi.loot.weight.NORMAL },
        { item = xi.item.SCROLL_OF_QUAKE, weight = xi.loot.weight.NORMAL },
        { item = xi.item.SCROLL_OF_RERAISE_III, weight = xi.loot.weight.NORMAL },
        { item = xi.item.SCROLL_OF_WATER_IV, weight = xi.loot.weight.NORMAL },
    },

    {
        { item = xi.item.CHOCOBO_EGG_SOMEWHAT_WARM, weight = xi.loot.weight.NORMAL },
    },

    {
        { item = xi.item.CHUNK_OF_OROBON_MEAT, weight = xi.loot.weight.NORMAL },
    },

    {
        { item = xi.item.NONE, weight = xi.loot.weight.EXTREMELY_HIGH },
        { item = xi.item.PIECE_OF_HABU_SKIN, weight = xi.loot.weight.NORMAL },
        { item = xi.item.SQUARE_OF_RAINBOW_CLOTH, weight = xi.loot.weight.NORMAL },
        { item = xi.item.BUFFALO_HORN, weight = xi.loot.weight.LOW },
        { item = xi.item.SQUARE_OF_WAMOURA_CLOTH, weight = xi.loot.weight.LOW },
        { item = xi.item.SQUARE_OF_RED_GRASS_CLOTH, weight = xi.loot.weight.VERY_LOW },
        { item = xi.item.SQUARE_OF_KARAKUL_CLOTH, weight = xi.loot.weight.VERY_LOW },
        { item = xi.item.SQUARE_OF_RAXA, weight = xi.loot.weight.VERY_LOW },
        { item = xi.item.POT_OF_URUSHI, weight = xi.loot.weight.VERY_LOW },
    },

    {
        { item = xi.item.NONE, weight = xi.loot.weight.EXTREMELY_HIGH },
        { item = xi.item.BITTER_CORSET, weight = xi.loot.weight.VERY_LOW },
        { item = xi.item.KAWAHORI_KABUTO, weight = xi.loot.weight.VERY_LOW },
        { item = xi.item.REQUIEM_FLUTE, weight = xi.loot.weight.VERY_LOW },
        { item = xi.item.TENSION_SPRING_II, weight = xi.loot.weight.EXTREMELY_LOW },
        { item = xi.item.ACCELERATOR_II, weight = xi.loot.weight.EXTREMELY_LOW },
        { item = xi.item.ARMOR_PLATE_II, weight = xi.loot.weight.EXTREMELY_LOW },
        { item = xi.item.AUTO_REPAIR_KIT_II, weight = xi.loot.weight.EXTREMELY_LOW },
        { item = xi.item.MANA_TANK_II, weight = xi.loot.weight.EXTREMELY_LOW },
        { item = xi.item.STABILIZER_II, weight = xi.loot.weight.EXTREMELY_LOW },
    },

    {
        { item = xi.item.BEHEMOTH_HORN, weight = xi.loot.weight.NORMAL },
        { item = xi.item.DRAGON_TALON, weight = xi.loot.weight.NORMAL },
        { item = xi.item.CHUNK_OF_KHROMA_ORE, weight = xi.loot.weight.NORMAL },
        { item = xi.item.CHUNK_OF_LUMINIUM_ORE, weight = xi.loot.weight.NORMAL },
    },
}

return content:register()
