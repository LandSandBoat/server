-----------------------------------
-- Shooting Fish
-- Horlais Peak BCNM20, Cloudy Orb
-- !additem 1551
-----------------------------------
local horlaisID = zones[xi.zone.HORLAIS_PEAK]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.HORLAIS_PEAK,
    battlefieldId    = xi.battlefield.id.SHOOTING_FISH,
    maxPlayers       = 3,
    levelCap         = 20,
    timeLimit        = utils.minutes(15),
    index            = 9,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.CLOUDY_ORB, wearMessage = horlaisID.text.A_CRACK_HAS_FORMED, wornMessage = horlaisID.text.ORB_IS_CRACKED },

    experimental = true,
})

content:addEssentialMobs({ 'Sniper_Pugil', 'Archer_Pugil' })

content.loot =
{
    {
        { item = xi.item.MANNEQUIN_HEAD, weight = 1000 }, -- mannequin_head
    },

    {
        { item = xi.item.SHALL_SHELL, weight = 1000 }, -- shall_shell
    },

    {
        { item = xi.item.MYTHRIL_BEASTCOIN, weight = 300 }, -- mythril_beastcoin
        { item = xi.item.BLACK_ROCK,        weight =  70 }, -- black_rock
        { item = xi.item.PURPLE_ROCK,       weight =  30 }, -- purple_rock
        { item = xi.item.WHITE_ROCK,        weight = 100 }, -- white_rock
        { item = xi.item.PLATOON_BOW,       weight = 100 }, -- platoon_bow
        { item = xi.item.PLATOON_MACE,      weight = 100 }, -- platoon_mace
        { item = xi.item.PLATOON_DISC,      weight = 150 }, -- platoon_disc
        { item = xi.item.PLATOON_GUN,       weight = 150 }, -- platoon_gun
    },

    {
        { item = xi.item.MYTHRIL_BEASTCOIN, weight = 310 }, -- mythril_beastcoin
        { item = xi.item.GREEN_ROCK,        weight =  50 }, -- green_rock
        { item = xi.item.YELLOW_ROCK,       weight =  40 }, -- yellow_rock
        { item = xi.item.BLUE_ROCK,         weight =  40 }, -- blue_rock
        { item = xi.item.RED_ROCK,          weight =  40 }, -- red_rock
        { item = xi.item.TRANSLUCENT_ROCK,  weight = 110 }, -- translucent_rock
        { item = xi.item.PLATOON_CESTI,     weight = 130 }, -- platoon_cesti
        { item = xi.item.PLATOON_CUTTER,    weight = 100 }, -- platoon_cutter
        { item = xi.item.PLATOON_SPATHA,    weight =  80 }, -- platoon_spatha
        { item = xi.item.PLATOON_ZAGHNAL,   weight = 100 }, -- platoon_zaghnal
    },

    {
        { item = xi.item.NONE,                    weight = 670 }, -- nothing
        { item = xi.item.HANDFUL_OF_PUGIL_SCALES, weight = 190 }, -- handful_of_pugil_scales
        { item = xi.item.SHALL_SHELL,             weight = 140 }, -- shall_shell
    },

    {
        { item = xi.item.NONE,           weight = 930 }, -- nothing
        { item = xi.item.MANNEQUIN_BODY, weight =  70 }, -- mannequin_body
    },

    {
        { item = xi.item.SCROLL_OF_BLAZE_SPIKES,  weight = 180 }, -- scroll_of_blaze_spikes
        { item = xi.item.SCROLL_OF_HORDE_LULLABY, weight = 510 }, -- scroll_of_horde_lullaby
        { item = xi.item.THUNDER_SPIRIT_PACT,     weight = 280 }, -- thunder_spirit_pact
        { item = xi.item.SCROLL_OF_WARP,          weight =  30 }, -- scroll_of_warp
    },
}

return content:register()
