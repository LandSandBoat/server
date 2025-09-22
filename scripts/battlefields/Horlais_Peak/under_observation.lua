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
        { itemId = xi.item.NONE,          weight = 910 }, -- Nothing
        { itemId = xi.item.PEACOCK_CHARM, weight =  90 }, -- Peacock Charm
    },

    {
        { itemId = xi.item.NONE,          weight = 467 }, -- Nothing
        { itemId = xi.item.BEHOURD_LANCE, weight =  48 }, -- Behourd Lance
        { itemId = xi.item.MUTILATOR,     weight =  61 }, -- Mutilator
        { itemId = xi.item.RAIFU,         weight =  46 }, -- Raifu
        { itemId = xi.item.TILT_BELT,     weight = 302 }, -- Tilt Belt
        { itemId = xi.item.TOURNEY_PATAS, weight =  76 }, -- Tourney Patas
    },

    {
        { itemId = xi.item.NONE,                  weight = 413 }, -- Nothing
        { itemId = xi.item.BUZZARD_TUCK,          weight =  42 }, -- Buzzard Tuck
        { itemId = xi.item.DE_SAINTRES_AXE,       weight =  77 }, -- De Saintres Axe
        { itemId = xi.item.GRUDGE_SWORD,          weight =  73 }, -- Grudge Sword
        { itemId = xi.item.MANTRA_BELT,           weight = 258 }, -- Mantra Belt
        { itemId = xi.item.SCROLL_OF_REFRESH,     weight =  68 }, -- Scroll Of Refresh
        { itemId = xi.item.SCROLL_OF_UTSUSEMI_NI, weight =  55 }, -- Scroll Of Utsusemi Ni
        { itemId = xi.item.SCROLL_OF_ICE_SPIKES,  weight =  14 }, -- Scroll Of Ice Spikes
    },

    {
        { itemId = xi.item.SCROLL_OF_ICE_SPIKES,  weight = 114 }, -- Scroll Of Ice Spikes
        { itemId = xi.item.SCROLL_OF_REFRESH,     weight = 174 }, -- Scroll Of Refresh
        { itemId = xi.item.SCROLL_OF_UTSUSEMI_NI, weight = 138 }, -- Scroll Of Utsusemi Ni
        { itemId = xi.item.RED_ROCK,              weight =  16 }, -- Red Rock
        { itemId = xi.item.BLUE_ROCK,             weight =  17 }, -- Blue Rock
        { itemId = xi.item.YELLOW_ROCK,           weight =  17 }, -- Yellow Rock
        { itemId = xi.item.GREEN_ROCK,            weight =  18 }, -- Green Rock
        { itemId = xi.item.TRANSLUCENT_ROCK,      weight =  17 }, -- Translucent Rock
        { itemId = xi.item.PURPLE_ROCK,           weight =  16 }, -- Purple Rock
        { itemId = xi.item.BLACK_ROCK,            weight =  18 }, -- Black Rock
        { itemId = xi.item.WHITE_ROCK,            weight =  16 }, -- White Rock
        { itemId = xi.item.MYTHRIL_BEASTCOIN,     weight = 102 }, -- Mythril Beastcoin
        { itemId = xi.item.GOLD_BEASTCOIN,        weight = 120 }, -- Gold Beastcoin
        { itemId = xi.item.OAK_LOG,               weight =  22 }, -- Oak Log
        { itemId = xi.item.AMETRINE,              weight =  18 }, -- Ametrine
        { itemId = xi.item.BLACK_PEARL,           weight =  18 }, -- Black Pearl
        { itemId = xi.item.GARNET,                weight =  20 }, -- Garnet
        { itemId = xi.item.GOSHENITE,             weight =  19 }, -- Goshenite
        { itemId = xi.item.PEARL,                 weight =  21 }, -- Pearl
        { itemId = xi.item.PERIDOT,               weight =  35 }, -- Peridot
        { itemId = xi.item.SPHENE,                weight =  17 }, -- Sphene
        { itemId = xi.item.TURQUOISE,             weight =  23 }, -- Turquoise
        { itemId = xi.item.RERAISER,              weight =  21 }, -- Reraiser
        { itemId = xi.item.VILE_ELIXIR,           weight =  16 }, -- Vile Elixir
    },

    {
        { itemId = xi.item.FIRE_SPIRIT_PACT,     weight = 116 }, -- Fire Spirit Pact
        { itemId = xi.item.SCROLL_OF_ABSORB_STR, weight = 113 }, -- Scroll Of Absorb-str
        { itemId = xi.item.SCROLL_OF_ERASE,      weight = 137 }, -- Scroll Of Erase
        { itemId = xi.item.SCROLL_OF_ICE_SPIKES, weight =  67 }, -- Scroll Of Ice Spikes
        { itemId = xi.item.SCROLL_OF_PHALANX,    weight =  99 }, -- Scroll Of Phalanx
        { itemId = xi.item.AMETRINE,             weight =  58 }, -- Ametrine
        { itemId = xi.item.BLACK_PEARL,          weight =  52 }, -- Black Pearl
        { itemId = xi.item.GARNET,               weight =  51 }, -- Garnet
        { itemId = xi.item.GOSHENITE,            weight =  65 }, -- Goshenite
        { itemId = xi.item.PEARL,                weight =  61 }, -- Pearl
        { itemId = xi.item.PERIDOT,              weight =  63 }, -- Peridot
        { itemId = xi.item.SPHENE,               weight =  55 }, -- Sphene
        { itemId = xi.item.TURQUOISE,            weight =  62 }, -- Turquoise
    },

    {
        { itemId = xi.item.HECTEYES_EYE, weight = 1000 }, -- Hecteyes Eye
    },

    {
        { itemId = xi.item.VIAL_OF_MERCURY, weight = 1000 }, -- Vial Of Mercury
    },
}

return content:register()
