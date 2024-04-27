-----------------------------------
-- Under Observation
-- Horlais Peak BCNM40, Star Orb
-- !additem 1131
-----------------------------------
local horlaisID = zones[xi.zone.HORLAIS_PEAK]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.HORLAIS_PEAK,
    battlefieldId    = xi.battlefield.id.UNDER_OBSERVATION,
    maxPlayers       = 3,
    levelCap         = 40,
    timeLimit        = utils.minutes(15),
    index            = 12,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.STAR_ORB, wearMessage = horlaisID.text.A_CRACK_HAS_FORMED, wornMessage = horlaisID.text.ORB_IS_CRACKED },
})

content:addEssentialMobs({ 'Sobbing_Eyes', 'Compound_Eyes' })

content.loot =
{
    {
        { item = xi.item.NONE,          weight = 910 }, -- Nothing
        { item = xi.item.PEACOCK_CHARM, weight =  90 }, -- Peacock Charm
    },

    {
        { item = xi.item.NONE,          weight = 467 }, -- Nothing
        { item = xi.item.BEHOURD_LANCE, weight =  48 }, -- Behourd Lance
        { item = xi.item.MUTILATOR,     weight =  61 }, -- Mutilator
        { item = xi.item.RAIFU,         weight =  46 }, -- Raifu
        { item = xi.item.TILT_BELT,     weight = 302 }, -- Tilt Belt
        { item = xi.item.TOURNEY_PATAS, weight =  76 }, -- Tourney Patas
    },

    {
        { item = xi.item.NONE,                  weight = 413 }, -- Nothing
        { item = xi.item.BUZZARD_TUCK,          weight =  42 }, -- Buzzard Tuck
        { item = xi.item.DE_SAINTRES_AXE,       weight =  77 }, -- De Saintres Axe
        { item = xi.item.GRUDGE_SWORD,          weight =  73 }, -- Grudge Sword
        { item = xi.item.MANTRA_BELT,           weight = 258 }, -- Mantra Belt
        { item = xi.item.SCROLL_OF_REFRESH,     weight =  68 }, -- Scroll Of Refresh
        { item = xi.item.SCROLL_OF_UTSUSEMI_NI, weight =  55 }, -- Scroll Of Utsusemi Ni
        { item = xi.item.SCROLL_OF_ICE_SPIKES,  weight =  14 }, -- Scroll Of Ice Spikes
    },

    {
        { item = xi.item.SCROLL_OF_ICE_SPIKES,  weight = 114 }, -- Scroll Of Ice Spikes
        { item = xi.item.SCROLL_OF_REFRESH,     weight = 174 }, -- Scroll Of Refresh
        { item = xi.item.SCROLL_OF_UTSUSEMI_NI, weight = 138 }, -- Scroll Of Utsusemi Ni
        { item = xi.item.RED_ROCK,              weight =  16 }, -- Red Rock
        { item = xi.item.BLUE_ROCK,             weight =  17 }, -- Blue Rock
        { item = xi.item.YELLOW_ROCK,           weight =  17 }, -- Yellow Rock
        { item = xi.item.GREEN_ROCK,            weight =  18 }, -- Green Rock
        { item = xi.item.TRANSLUCENT_ROCK,      weight =  17 }, -- Translucent Rock
        { item = xi.item.PURPLE_ROCK,           weight =  16 }, -- Purple Rock
        { item = xi.item.BLACK_ROCK,            weight =  18 }, -- Black Rock
        { item = xi.item.WHITE_ROCK,            weight =  16 }, -- White Rock
        { item = xi.item.MYTHRIL_BEASTCOIN,     weight = 102 }, -- Mythril Beastcoin
        { item = xi.item.GOLD_BEASTCOIN,        weight = 120 }, -- Gold Beastcoin
        { item = xi.item.OAK_LOG,               weight =  22 }, -- Oak Log
        { item = xi.item.AMETRINE,              weight =  18 }, -- Ametrine
        { item = xi.item.BLACK_PEARL,           weight =  18 }, -- Black Pearl
        { item = xi.item.GARNET,                weight =  20 }, -- Garnet
        { item = xi.item.GOSHENITE,             weight =  19 }, -- Goshenite
        { item = xi.item.PEARL,                 weight =  21 }, -- Pearl
        { item = xi.item.PERIDOT,               weight =  35 }, -- Peridot
        { item = xi.item.SPHENE,                weight =  17 }, -- Sphene
        { item = xi.item.TURQUOISE,             weight =  23 }, -- Turquoise
        { item = xi.item.RERAISER,              weight =  21 }, -- Reraiser
        { item = xi.item.VILE_ELIXIR,           weight =  16 }, -- Vile Elixir
    },

    {
        { item = xi.item.FIRE_SPIRIT_PACT,     weight = 116 }, -- Fire Spirit Pact
        { item = xi.item.SCROLL_OF_ABSORB_STR, weight = 113 }, -- Scroll Of Absorb-str
        { item = xi.item.SCROLL_OF_ERASE,      weight = 137 }, -- Scroll Of Erase
        { item = xi.item.SCROLL_OF_ICE_SPIKES, weight =  67 }, -- Scroll Of Ice Spikes
        { item = xi.item.SCROLL_OF_PHALANX,    weight =  99 }, -- Scroll Of Phalanx
        { item = xi.item.AMETRINE,             weight =  58 }, -- Ametrine
        { item = xi.item.BLACK_PEARL,          weight =  52 }, -- Black Pearl
        { item = xi.item.GARNET,               weight =  51 }, -- Garnet
        { item = xi.item.GOSHENITE,            weight =  65 }, -- Goshenite
        { item = xi.item.PEARL,                weight =  61 }, -- Pearl
        { item = xi.item.PERIDOT,              weight =  63 }, -- Peridot
        { item = xi.item.SPHENE,               weight =  55 }, -- Sphene
        { item = xi.item.TURQUOISE,            weight =  62 }, -- Turquoise
    },

    {
        { item = xi.item.HECTEYES_EYE, weight = 1000 }, -- Hecteyes Eye
    },

    {
        { item = xi.item.VIAL_OF_MERCURY, weight = 1000 }, -- Vial Of Mercury
    },
}

return content:register()
