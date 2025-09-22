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
        { itemId = xi.item.LIBATION_ABJURATION, weight = 1000 }, -- libation_abjuration
    },

    {
        { itemId = xi.item.OBLATION_ABJURATION, weight = 1000 }, -- oblation_abjuration
    },

    {
        { itemId = xi.item.SQUARE_OF_RAINBOW_CLOTH, weight = 1000 }, -- square_of_rainbow_cloth
    },

    {
        quantity = 3,
        { itemId = xi.item.SQUARE_OF_SILK_CLOTH, weight = 1000 }, -- square_of_silk_cloth
    },

    {
        { itemId = xi.item.TELEPORT_RING_DEM, weight = 250 }, -- teleport_ring_dem
        { itemId = xi.item.TELEPORT_RING_MEA, weight = 250 }, -- teleport_ring_mea
        { itemId = xi.item.NURSEMAIDS_HARP,   weight = 250 }, -- nursemaids_harp
        { itemId = xi.item.TRAILERS_KUKRI,    weight = 250 }, -- trailers_kukri
    },

    {
        { itemId = xi.item.ELUSIVE_EARRING, weight = 250 }, -- elusive_earring
        { itemId = xi.item.KNIGHTLY_MANTLE, weight = 250 }, -- knightly_mantle
        { itemId = xi.item.HI_ETHER_TANK,   weight = 250 }, -- hi-ether_tank
        { itemId = xi.item.HI_POTION_TANK,  weight = 250 }, -- hi-potion_tank
    },

    {
        { itemId = xi.item.NONE,         weight = 950 }, -- nothing
        { itemId = xi.item.WALKURE_MASK, weight =  50 }, -- walkure_mask
    },

    {
        { itemId = xi.item.AQUAMARINE,       weight =  50 }, -- aquamarine
        { itemId = xi.item.CHRYSOBERYL,      weight =  50 }, -- chrysoberyl
        { itemId = xi.item.DARKSTEEL_INGOT,  weight = 100 }, -- darksteel_ingot
        { itemId = xi.item.EBONY_LOG,        weight =  50 }, -- ebony_log
        { itemId = xi.item.FLUORITE,         weight =  50 }, -- fluorite
        { itemId = xi.item.GOLD_INGOT,       weight =  50 }, -- gold_ingot
        { itemId = xi.item.HI_RERAISER,      weight =  50 }, -- hi-reraiser
        { itemId = xi.item.JADEITE,          weight =  50 }, -- jadeite
        { itemId = xi.item.MAHOGANY_LOG,     weight =  50 }, -- mahogany_log
        { itemId = xi.item.MOONSTONE,        weight =  50 }, -- moonstone
        { itemId = xi.item.MYTHRIL_INGOT,    weight =  50 }, -- mythril_ingot
        { itemId = xi.item.PAINITE,          weight =  50 }, -- painite
        { itemId = xi.item.RED_ROCK,         weight =  50 }, -- red_rock
        { itemId = xi.item.STEEL_INGOT,      weight =  50 }, -- steel_ingot
        { itemId = xi.item.SUNSTONE,         weight =  50 }, -- sunstone
        { itemId = xi.item.TRANSLUCENT_ROCK, weight =  50 }, -- translucent_rock
        { itemId = xi.item.WHITE_ROCK,       weight =  50 }, -- white_rock
        { itemId = xi.item.VILE_ELIXIR_P1,   weight =  50 }, -- vile_elixir_+1
        { itemId = xi.item.ZIRCON,           weight =  50 }, -- zircon
    },
}

return content:register()
