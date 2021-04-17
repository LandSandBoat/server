-----------------------------------
-- Area: Lufaise_Meadows
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.LUFAISE_MEADOWS] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED     = 6383, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED               = 6389, -- Obtained: <item>.
        GIL_OBTAINED                = 6390, -- Obtained <number> gil.
        KEYITEM_OBTAINED            = 6392, -- Obtained key item: <keyitem>.
        KEYITEM_LOST                = 6393, -- Lost key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY     = 6403, -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET       = 6418, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS         = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY     = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE               = 7050, -- Tallying conquest results...
        CONQUEST                    = 7218, -- You've earned conquest points!
        FISHING_MESSAGE_OFFSET      = 7552, -- You can't fish here.
        KI_STOLEN                   = 7681, -- The <keyitem> has been stolen!
        LOGGING_IS_POSSIBLE_HERE    = 7729, -- Logging is possible here if you have <item>.
        SURVEY_THE_SURROUNDINGS     = 7736, -- You survey the surroundings but see nothing out of the ordinary.
        MURDEROUS_PRESENCE          = 7737, -- Wait, you sense a murderous presence...!
        YOU_CAN_SEE_FOR_MALMS       = 7738, -- You can see for malms in every direction.
        SPINE_CHILLING_PRESENCE     = 7740, -- You sense a spine-chilling presence!
        COMMON_SENSE_SURVIVAL       = 8735, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        PADFOOT               =
        {
            16875552, -- !pos -43.689 0.487 -328.028
            16875578, -- !pos 260.445 -1.761 -27.862
            16875615, -- !pos 412.447 -0.057 -200.161
            16875703, -- !pos -378.950 -15.742 144.215
            16875748, -- !pos -141.523 -15.529 91.709
        },
        MEGALOBUGARD_PH       =
        {
            [16875720] = 16875741, -- -137.168 -15.390 91.016
        },
        LESHY_OFFSET          = 16875754,
        COLORFUL_LESHY        = 16875762,
        SPLINTERSPINE_GRUKJUK = 16875774,
        KURREA                = 16875778,
        AMALTHEIA             = 16875779,
    },
    npc =
    {
        OVERSEER_BASE = 16875865, -- Jemmoquel_RK in npc_list
        LOGGING       =
        {
            16875883,
            16875884,
            16875885,
            16875886,
            16875887,
            16875888,
        },
    },
}

return zones[xi.zone.LUFAISE_MEADOWS]
