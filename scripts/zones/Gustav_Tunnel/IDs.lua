-----------------------------------
-- Area: Gustav Tunnel (212)
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.GUSTAV_TUNNEL] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED  = 6382,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED            = 6388,  -- Obtained: <item>.
        GIL_OBTAINED             = 6389,  -- Obtained <number> gil.
        KEYITEM_OBTAINED         = 6391,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY  = 6402,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET    = 6417,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS      = 6999, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY  = 7000, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER             = 7001, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        GEOMAGNETRON_ATTUNED     = 7010,  -- Your <keyitem> has been attuned to a geomagnetic fount in the corresponding locale.
        CONQUEST_BASE            = 7049,  -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET   = 7208,  -- You can't fish here.
        SENSE_OMINOUS_PRESENCE   = 7310,  -- You sense an ominous presence...
        REGIME_REGISTERED        = 9578,  -- New training regime registered!
        COMMON_SENSE_SURVIVAL    = 10662, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        PLAYER_OBTAINS_ITEM      = 10630, -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM    = 10631, -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM = 10632, -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP     = 10633, -- You already possess that temporary item.
        NO_COMBINATION           = 10638, -- You were unable to enter a combination.
    },
    mob =
    {
        GOBLINSAVIOR_HERONOX_PH   =
        {
            [17645592] = 17645609, -- 153.000 -10.000 -53.000
            [17645605] = 17645609, -- 152.325 -10.702 -77.007
            [17645604] = 17645609, -- 165.558 -10.647 -68.537
        },
        WYVERNPOACHER_DRACHLOX_PH =
        {
            [17645633] = 17645640, -- -100.000 1.000 -44.000
            [17645634] = 17645640, -- -101.000 1.000 -29.000
            [17645644] = 17645640, -- -165.598 0.218 -21.966
            [17645643] = 17645640, -- -150.673 -0.067 -20.914
        },
        BAOBHAN_SITH_PH           =
        {
            [17645717] = 17645719, -- 171.000 9.194 55.000
            [17645718] = 17645719, -- 187.000 9.000 105.000
        },
        TAXIM_PH                  =
        {
            [17645731] = 17645742, -- -172.941 -1.220 55.577
            [17645738] = 17645742, -- -137.334 -0.108 48.105
            [17645744] = 17645742, -- -125.000 0.635 59.000
            [17645739] = 17645742, -- -118.000 -0.515 79.000
        },
        UNGUR_PH                  =
        {
            [17645764] = 17645755, -- -242.000 -0.577 120.000
            [17645792] = 17645755, -- -88.000 0.735 190.000
            [17645784] = 17645755, -- -123.856 0.239 223.303
            [17645758] = 17645755, -- -277.000 -10.000 -34.000
            [17645754] = 17645755, -- -316.000 -9.000 3.000
        },
        AMIKIRI_PH                =
        {
            [17645763] = 17645774, -- -245.000 -0.045 146.000
            [17645768] = 17645774, -- -228.872 -0.264 144.689
            [17645772] = 17645774, -- -209.552 -0.257 161.728
        },
        BUNE                      = 17645578,
        GIGAPLASM                 = 17645794,
        BARONIAL_BAT              = 17645809,
    },
    npc =
    {
        CASKET_BASE = 17645851,
    },
}

return zones[tpz.zone.GUSTAV_TUNNEL]
