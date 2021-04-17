-----------------------------------
-- Area: Qufim_Island
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.QUFIM_ISLAND] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED        = 6383,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                  = 6389,  -- Obtained: <item>.
        GIL_OBTAINED                   = 6390,  -- Obtained <number> gil.
        KEYITEM_OBTAINED               = 6392,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                   = 6393,  -- Lost key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY        = 6403,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET          = 6418,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS            = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY        = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                   = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE                  = 7050,  -- Tallying conquest results...
        BEASTMEN_BANNER                = 7131,  -- There is a beastmen's banner.
        FISHING_MESSAGE_OFFSET         = 7209,  -- You can't fish here.
        THESE_WITHERED_FLOWERS         = 7329,  -- These withered flowers seem unable to bloom.
        NOW_THAT_NIGHT_HAS_FALLEN      = 7330,  -- Now that night has fallen, the flowers bloom with a strange glow.
        CONQUEST                       = 7378,  -- You've earned conquest points!
        AN_EMPTY_LIGHT_SWIRLS          = 7755,  -- An empty light swirls about the cave, eating away at the surroundings...
        GIGANTIC_FOOTPRINT             = 7839,  -- There is a gigantic footprint here.
        DYNA_NPC_DEFAULT_MESSAGE       = 7853,  -- You hear a mysterious, floating voice: Bring forth the <item>...
        YOU_CANNOT_ENTER_DYNAMIS       = 7865,  -- You cannot enter Dynamis - [Dummy/San d'Oria/Bastok/Windurst/Jeuno/Beaucedine/Xarcabard/Valkurm/Buburimu/Qufim/Tavnazia] for <number> [day/days] (Vana'diel time).
        PLAYERS_HAVE_NOT_REACHED_LEVEL = 7867,  -- Players who have not reached level <number> are prohibited from entering Dynamis.
        PLAYER_OBTAINS_ITEM            = 8063,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM          = 8064,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM       = 8065,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP           = 8066,  -- You already possess that temporary item.
        NO_COMBINATION                 = 8071,  -- You were unable to enter a combination.
        REGIME_REGISTERED              = 10347, -- New training regime registered!
        COMMON_SENSE_SURVIVAL          = 12672, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        HOMEPOINT_SET                  = 12714, -- Home point set!
    },
    mob =
    {
        SLIPPERY_SUCKER_PH =
        {
            [17293376] = 17293389,
            [17293377] = 17293389,
            [17293378] = 17293389,
            [17293380] = 17293389,
        },
        TRICKSTER_KINETIX_PH =
        {
            [17293533] = 17293537, -- -138.180 -20.928 228.793
            [17293534] = 17293537, -- -157.659 -25.501 235.862
            [17293535] = 17293537, -- -152.269 -20 243
            [17293536] = 17293537, -- -137.651 -23.507 231.528
        },
        OPHIOTAURUS = 17293666
    },
    npc =
    {
        CASKET_BASE   = 17293677,
        OVERSEER_BASE = 17293715, -- Pitoire_RK in npc_list
    },
}

return zones[xi.zone.QUFIM_ISLAND]
