-----------------------------------
-- Wild Wild Whiskers
-- Balga's Dais BCNM60, Moon Orb
-- !additem 1130
-----------------------------------
local balgasID = zones[xi.zone.BALGAS_DAIS]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.BALGAS_DAIS,
    battlefieldId    = xi.battlefield.id.WILD_WILD_WHISKERS,
    maxPlayers       = 3,
    levelCap         = 60,
    timeLimit        = utils.minutes(15),
    index            = 14,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.MOON_ORB, wearMessage = balgasID.text.A_CRACK_HAS_FORMED, wornMessage = balgasID.text.ORB_IS_CRACKED },
})

content:addEssentialMobs({ 'Macan_Gadangan' })

content.loot =
{
    {
        quantity = 3,
        { itemId = xi.item.HIGH_QUALITY_COEURL_HIDE, weight = 1000 }, -- high-quality_coeurl_hide
    },

    {
        { itemId = xi.item.CHUNK_OF_ADAMAN_ORE, weight = 1000 }, -- chunk_of_adaman_ore
    },

    {
        { itemId = xi.item.HERMES_QUENCHER, weight = 1000 }, -- hermes_quencher
    },

    {
        { itemId = xi.item.ICARUS_WING, weight = 1000 }, -- icarus_wing
    },

    {
        { itemId = xi.item.GLEEMANS_BELT,  weight = 365 }, -- gleemans_belt
        { itemId = xi.item.PENITENTS_ROPE, weight = 635 }, -- penitents_rope
    },

    {
        { itemId = xi.item.TELEPORT_RING_MEA,   weight = 426 }, -- teleport_ring_mea
        { itemId = xi.item.TELEPORT_RING_YHOAT, weight = 574 }, -- teleport_ring_yhoat
    },

    {
        { itemId = xi.item.NONE,         weight = 848 }, -- nothing
        { itemId = xi.item.WALKURE_MASK, weight =  58 }, -- walkure_mask
        { itemId = xi.item.HI_RERAISER,  weight =  78 }, -- hi-reraiser
        { itemId = xi.item.EBONY_LOG,    weight =  16 }, -- ebony_log
    },

    {
        { itemId = xi.item.YELLOW_ROCK,      weight =  9 }, -- yellow_rock
        { itemId = xi.item.BLACK_ROCK,       weight =  9 }, -- black_rock
        { itemId = xi.item.AQUAMARINE,       weight = 16 }, -- aquamarine
        { itemId = xi.item.RED_ROCK,         weight = 16 }, -- red_rock
        { itemId = xi.item.BLUE_ROCK,        weight = 16 }, -- blue_rock
        { itemId = xi.item.PURPLE_ROCK,      weight = 16 }, -- purple_rock
        { itemId = xi.item.MAHOGANY_LOG,     weight = 33 }, -- mahogany_log
        { itemId = xi.item.CHRYSOBERYL,      weight = 33 }, -- chrysoberyl
        { itemId = xi.item.ZIRCON,           weight = 33 }, -- zircon
        { itemId = xi.item.STEEL_INGOT,      weight = 49 }, -- steel_ingot
        { itemId = xi.item.DARKSTEEL_INGOT,  weight = 49 }, -- darksteel_ingot
        { itemId = xi.item.TRANSLUCENT_ROCK, weight = 49 }, -- translucent_rock
        { itemId = xi.item.SUNSTONE,         weight = 49 }, -- sunstone
        { itemId = xi.item.MOONSTONE,        weight = 66 }, -- moonstone
        { itemId = xi.item.MYTHRIL_INGOT,    weight = 82 }, -- mythril_ingot
        { itemId = xi.item.FLUORITE,         weight = 82 }, -- fluorite
        { itemId = xi.item.GOLD_INGOT,       weight = 98 }, -- gold_ingot
        { itemId = xi.item.JADEITE,          weight = 98 }, -- jadeite
        { itemId = xi.item.PAINITE,          weight = 98 }, -- painite
        { itemId = xi.item.VILE_ELIXIR_P1,   weight = 99 }, -- vile_elixir_+1
    },
}

return content:register()
