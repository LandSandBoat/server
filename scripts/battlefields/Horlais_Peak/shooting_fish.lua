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
        { itemId = xi.item.MANNEQUIN_HEAD, weight = 1000 }, -- mannequin_head
    },

    {
        { itemId = xi.item.SHALL_SHELL, weight = 1000 }, -- shall_shell
    },

    {
        { itemId = xi.item.MYTHRIL_BEASTCOIN, weight = 300 }, -- mythril_beastcoin
        { itemId = xi.item.BLACK_ROCK,        weight =  70 }, -- black_rock
        { itemId = xi.item.PURPLE_ROCK,       weight =  30 }, -- purple_rock
        { itemId = xi.item.WHITE_ROCK,        weight = 100 }, -- white_rock
        { itemId = xi.item.PLATOON_BOW,       weight = 100 }, -- platoon_bow
        { itemId = xi.item.PLATOON_MACE,      weight = 100 }, -- platoon_mace
        { itemId = xi.item.PLATOON_DISC,      weight = 150 }, -- platoon_disc
        { itemId = xi.item.PLATOON_GUN,       weight = 150 }, -- platoon_gun
    },

    {
        { itemId = xi.item.MYTHRIL_BEASTCOIN, weight = 310 }, -- mythril_beastcoin
        { itemId = xi.item.GREEN_ROCK,        weight =  50 }, -- green_rock
        { itemId = xi.item.YELLOW_ROCK,       weight =  40 }, -- yellow_rock
        { itemId = xi.item.BLUE_ROCK,         weight =  40 }, -- blue_rock
        { itemId = xi.item.RED_ROCK,          weight =  40 }, -- red_rock
        { itemId = xi.item.TRANSLUCENT_ROCK,  weight = 110 }, -- translucent_rock
        { itemId = xi.item.PLATOON_CESTI,     weight = 130 }, -- platoon_cesti
        { itemId = xi.item.PLATOON_CUTTER,    weight = 100 }, -- platoon_cutter
        { itemId = xi.item.PLATOON_SPATHA,    weight =  80 }, -- platoon_spatha
        { itemId = xi.item.PLATOON_ZAGHNAL,   weight = 100 }, -- platoon_zaghnal
    },

    {
        { itemId = xi.item.NONE,                    weight = 670 }, -- nothing
        { itemId = xi.item.HANDFUL_OF_PUGIL_SCALES, weight = 190 }, -- handful_of_pugil_scales
        { itemId = xi.item.SHALL_SHELL,             weight = 140 }, -- shall_shell
    },

    {
        { itemId = xi.item.NONE,           weight = 930 }, -- nothing
        { itemId = xi.item.MANNEQUIN_BODY, weight =  70 }, -- mannequin_body
    },

    {
        { itemId = xi.item.SCROLL_OF_BLAZE_SPIKES,  weight = 180 }, -- scroll_of_blaze_spikes
        { itemId = xi.item.SCROLL_OF_HORDE_LULLABY, weight = 510 }, -- scroll_of_horde_lullaby
        { itemId = xi.item.THUNDER_SPIRIT_PACT,     weight = 280 }, -- thunder_spirit_pact
        { itemId = xi.item.SCROLL_OF_WARP,          weight =  30 }, -- scroll_of_warp
    },
}

return content:register()
