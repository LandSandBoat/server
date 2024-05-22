-----------------------------------
-- Celery
-- Qu'Bia Arena BCNM60, Moon Orb
-- !additem 1130
-----------------------------------
local qubiaID = zones[xi.zone.QUBIA_ARENA]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.QUBIA_ARENA,
    battlefieldId    = xi.battlefield.id.CELERY,
    maxPlayers       = 3,
    levelCap         = 60,
    timeLimit        = utils.minutes(15),
    index            = 16,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.MOON_ORB, wearMessage = qubiaID.text.A_CRACK_HAS_FORMED, wornMessage = qubiaID.text.ORB_IS_CRACKED },

    experimental = true,
})

content:addEssentialMobs({
    'Annihilated_Anthony',
    'Shredded_Samson',
    'Mauled_Murdock',
    'Punctured_Percy'
})

-- All but the engaged mob despawns on engage, so they are not tracked
-- for the allDeath value.  Override allDeath with death, and trigger
-- win on a single defeated mob.
content.groups[1].death = function(battlefield, mob)
    content:handleAllMonstersDefeated(battlefield, mob)
end

content.loot =
{
    {
        { item = xi.item.LIBATION_ABJURATION, weight = 1000 }, -- libation_abjuration
    },

    {
        { item = xi.item.OBLATION_ABJURATION, weight = 1000 }, -- oblation_abjuration
    },

    {
        { item = xi.item.SQUARE_OF_RAINBOW_CLOTH, weight = 1000 }, -- square_of_rainbow_cloth
    },

    {
        quantity = 3,
        { item = xi.item.SQUARE_OF_SILK_CLOTH, weight = 1000 }, -- square_of_silk_cloth
    },

    {
        { item = xi.item.TELEPORT_RING_DEM, weight = 250 }, -- teleport_ring_dem
        { item = xi.item.TELEPORT_RING_MEA, weight = 250 }, -- teleport_ring_mea
        { item = xi.item.NURSEMAIDS_HARP,   weight = 250 }, -- nursemaids_harp
        { item = xi.item.TRAILERS_KUKRI,    weight = 250 }, -- trailers_kukri
    },

    {
        { item = xi.item.ELUSIVE_EARRING, weight = 250 }, -- elusive_earring
        { item = xi.item.KNIGHTLY_MANTLE, weight = 250 }, -- knightly_mantle
        { item = xi.item.HI_ETHER_TANK,   weight = 250 }, -- hi-ether_tank
        { item = xi.item.HI_POTION_TANK,  weight = 250 }, -- hi-potion_tank
    },

    {
        { item = xi.item.NONE,         weight = 950 }, -- nothing
        { item = xi.item.WALKURE_MASK, weight =  50 }, -- walkure_mask
    },

    {
        { item = xi.item.AQUAMARINE,       weight =  50 }, -- aquamarine
        { item = xi.item.CHRYSOBERYL,      weight =  50 }, -- chrysoberyl
        { item = xi.item.DARKSTEEL_INGOT,  weight = 100 }, -- darksteel_ingot
        { item = xi.item.EBONY_LOG,        weight =  50 }, -- ebony_log
        { item = xi.item.FLUORITE,         weight =  50 }, -- fluorite
        { item = xi.item.GOLD_INGOT,       weight =  50 }, -- gold_ingot
        { item = xi.item.HI_RERAISER,      weight =  50 }, -- hi-reraiser
        { item = xi.item.JADEITE,          weight =  50 }, -- jadeite
        { item = xi.item.MAHOGANY_LOG,     weight =  50 }, -- mahogany_log
        { item = xi.item.MOONSTONE,        weight =  50 }, -- moonstone
        { item = xi.item.MYTHRIL_INGOT,    weight =  50 }, -- mythril_ingot
        { item = xi.item.PAINITE,          weight =  50 }, -- painite
        { item = xi.item.RED_ROCK,         weight =  50 }, -- red_rock
        { item = xi.item.STEEL_INGOT,      weight =  50 }, -- steel_ingot
        { item = xi.item.SUNSTONE,         weight =  50 }, -- sunstone
        { item = xi.item.TRANSLUCENT_ROCK, weight =  50 }, -- translucent_rock
        { item = xi.item.WHITE_ROCK,       weight =  50 }, -- white_rock
        { item = xi.item.VILE_ELIXIR_P1,   weight =  50 }, -- vile_elixir_+1
        { item = xi.item.ZIRCON,           weight =  50 }, -- zircon
    },
}

return content:register()
