-----------------------------------
-- Shadows of the Mind
-- Jade Sepulcher, Confidential Imperial Order
-- !addkeyitem SECRET_IMPERIAL_ORDER
-----------------------------------
local ID = zones[xi.zone.JADE_SEPULCHER]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.JADE_SEPULCHER,
    battlefieldId    = xi.battlefield.id.SHADOWS_OF_THE_MIND,
    maxPlayers       = 6,
    levelCap         = 75,
    timeLimit        = utils.minutes(30),
    index            = 1,
    entryNpc         = '_1v0',
    exitNpcs         = { '_1v1', '_1v2', '_1v3' },
    requiredKeyItems = { xi.ki.SECRET_IMPERIAL_ORDER, message = ID.text.IMPERIAL_ORDER_BREAKS },
})

content.groups = {
    {
        mobs      = { 'Phantom_Puk' },
        allDeath  = utils.bind(content.handleAllMonstersDefeated, content),
    },

    {
        mobs      = { 'Phantom_Puk_Clone' },
        spawned  = false,
    },
}

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
        { item = xi.item.PUK_WING, weight = xi.loot.weight.NORMAL },
    },

    {
        { item = xi.item.NONE, weight = xi.loot.weight.EXTREMELY_HIGH },
        { item = xi.item.COMPANY_FLEURET, weight = xi.loot.weight.LOW },
        { item = xi.item.MAGNET_KNIFE, weight = xi.loot.weight.LOW },
        { item = xi.item.SACRIFICE_TORQUE, weight = xi.loot.weight.LOW },
        { item = xi.item.TOURNAMENT_LANCE, weight = xi.loot.weight.LOW },
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
        { item = xi.item.BEHEMOTH_HORN, weight = xi.loot.weight.NORMAL },
        { item = xi.item.DRAGON_TALON, weight = xi.loot.weight.NORMAL },
        { item = xi.item.CHUNK_OF_KHROMA_ORE, weight = xi.loot.weight.NORMAL },
        { item = xi.item.CHUNK_OF_LUMINIUM_ORE, weight = xi.loot.weight.NORMAL },
    },
}

return content:register()
