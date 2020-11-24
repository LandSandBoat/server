-----------------------------------
-- Area: West_Ronfaure
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.WEST_RONFAURE] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED  = 6404,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED            = 6410,  -- Obtained: <item>.
        GIL_OBTAINED             = 6411,  -- Obtained <number> gil.
        KEYITEM_OBTAINED         = 6413,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST             = 6414,  -- Lost key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET    = 6439,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS      = 7021, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY  = 7022, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER             = 7023, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE            = 7071,  -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET   = 7230,  -- You can't fish here.
        DIG_THROW_AWAY           = 7243,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING             = 7245,  -- You dig and you dig, but find nothing.
        GACHEMAGE_DIALOG         = 7331,  -- Orcish scouts lurk in the shadows. Consider yourself warned!
        COLMAIE_DIALOG           = 7331,  -- Orcish scouts lurk in the shadows. Consider yourself warned!
        ADALEFONT_DIALOG         = 7332,  -- If you sense danger, just flee into the city. I'll not endanger myself on your account!
        LAILLERA_DIALOG          = 7333,  -- I mustn't chat while on duty. Sorry.
        PICKPOCKET_GACHEMAGE     = 7334,  -- A pickpocket? Now that you mention it, I did see a woman flee the city. She ran west.
        PICKPOCKET_ADALEFONT     = 7335,  -- What, someone picked your pocket? And you call yourself an adventurer!
        AAVELEON_HEALED          = 7339,  -- My wounds are healed, thanks to you!
        PALCOMONDAU_REPORT       = 7377,  -- Scout reporting! All is quiet on the road to Ghelsba!
        PALCOMONDAU_DIALOG       = 7378,  -- Let me be! I must patrol the road to Ghelsba.
        ZOVRIACE_REPORT          = 7380,  -- Scout reporting! All is quiet on the roads to La Theine!
        ZOVRIACE_DIALOG          = 7382,  -- Let me be! I return to Southgate with word on La Theine.
        DISMAYED_CUSTOMER        = 7408,  -- You find some worthless scraps of paper.
        CONQUEST                 = 7530,  -- You've earned conquest points!
        PLAYER_OBTAINS_ITEM      = 8048,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM    = 8049,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM = 8050,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP     = 8051,  -- You already possess that temporary item.
        NO_COMBINATION           = 8056,  -- You were unable to enter a combination.
        REGIME_REGISTERED        = 10421, -- New training regime registered!
        COMMON_SENSE_SURVIVAL    = 12422, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        FUNGUS_BEETLE_PH      =
        {
            [17187046] = 17187047, -- -133.001 -20.636 -141.110
            [17187115] = 17187047, -- -287.202 -20.826 -199.075
            [17187114] = 17187047, -- -295.626 -21.389 -192.191
        },
        JAGGEDY_EARED_JACK_PH =
        {
            [17187110] = 17187111, -- -262.780 -22.384 -253.873
            [17187109] = 17187111, -- -267.389 -21.669 -252.720
            [17187108] = 17187111, -- -273.558 -19.943 -284.081
            [17187042] = 17187111, -- -248.681 -21.336 -163.987
            [17187154] = 17187111, -- -329.892 -9.702 -313.713
            [17187152] = 17187111, -- -278.421 -11.691 -351.425
            [17187132] = 17187111, -- -204.492 -20.754 -324.770
        },
        MARAUDER_DVOGZOG      = 17187273,
    },
    npc =
    {
        CASKET_BASE     = 17187467,
        SIGNPOST_OFFSET = 17187505,
        OVERSEER_BASE   = 17187525,
    },
}

return zones[tpz.zone.WEST_RONFAURE]
