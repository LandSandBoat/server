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
        { item = xi.item.HIGH_QUALITY_COEURL_HIDE, weight = 1000 }, -- high-quality_coeurl_hide
    },

    {
        { item = xi.item.CHUNK_OF_ADAMAN_ORE, weight = 1000 }, -- chunk_of_adaman_ore
    },

    {
        { item = xi.item.HERMES_QUENCHER, weight = 1000 }, -- hermes_quencher
    },

    {
        { item = xi.item.ICARUS_WING, weight = 1000 }, -- icarus_wing
    },

    {
        { item = xi.item.GLEEMANS_BELT,  weight = 365 }, -- gleemans_belt
        { item = xi.item.PENITENTS_ROPE, weight = 635 }, -- penitents_rope
    },

    {
        { item = xi.item.TELEPORT_RING_MEA,   weight = 426 }, -- teleport_ring_mea
        { item = xi.item.TELEPORT_RING_YHOAT, weight = 574 }, -- teleport_ring_yhoat
    },

    {
        { item = xi.item.NONE,         weight = 848 }, -- nothing
        { item = xi.item.WALKURE_MASK, weight =  58 }, -- walkure_mask
        { item = xi.item.HI_RERAISER,  weight =  78 }, -- hi-reraiser
        { item = xi.item.EBONY_LOG,    weight =  16 }, -- ebony_log
    },

    {
        { item = xi.item.YELLOW_ROCK,      weight =  9 }, -- yellow_rock
        { item = xi.item.BLACK_ROCK,       weight =  9 }, -- black_rock
        { item = xi.item.AQUAMARINE,       weight = 16 }, -- aquamarine
        { item = xi.item.RED_ROCK,         weight = 16 }, -- red_rock
        { item = xi.item.BLUE_ROCK,        weight = 16 }, -- blue_rock
        { item = xi.item.PURPLE_ROCK,      weight = 16 }, -- purple_rock
        { item = xi.item.MAHOGANY_LOG,     weight = 33 }, -- mahogany_log
        { item = xi.item.CHRYSOBERYL,      weight = 33 }, -- chrysoberyl
        { item = xi.item.ZIRCON,           weight = 33 }, -- zircon
        { item = xi.item.STEEL_INGOT,      weight = 49 }, -- steel_ingot
        { item = xi.item.DARKSTEEL_INGOT,  weight = 49 }, -- darksteel_ingot
        { item = xi.item.TRANSLUCENT_ROCK, weight = 49 }, -- translucent_rock
        { item = xi.item.SUNSTONE,         weight = 49 }, -- sunstone
        { item = xi.item.MOONSTONE,        weight = 66 }, -- moonstone
        { item = xi.item.MYTHRIL_INGOT,    weight = 82 }, -- mythril_ingot
        { item = xi.item.FLUORITE,         weight = 82 }, -- fluorite
        { item = xi.item.GOLD_INGOT,       weight = 98 }, -- gold_ingot
        { item = xi.item.JADEITE,          weight = 98 }, -- jadeite
        { item = xi.item.PAINITE,          weight = 98 }, -- painite
        { item = xi.item.VILE_ELIXIR_P1,   weight = 99 }, -- vile_elixir_+1
    },
}

return content:register()
