-----------------------------------
-- Area: Beadeaux
-----------------------------------
zones = zones or {}

zones[xi.zone.BEADEAUX] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED            = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                      = 6390, -- Obtained: <item>.
        GIL_OBTAINED                       = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED                   = 6393, -- Obtained key item: <keyitem>.
        NOT_ENOUGH_GIL                     = 6395, -- You do not have enough gil.
        ITEMS_OBTAINED                     = 6399, -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY            = 6404, -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET              = 6419, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS                = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY            = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                       = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED      = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                      = 7061, -- Tallying conquest results...
        LOCKED_DOOR_QUADAV_HAS_KEY         = 7224, -- It is locked tight, but has what looks like a keyhole. Maybe one of the Quadav here has the key.
        FEEL_COLD                          = 7346, -- You feel cold...
        FEEL_NUMB                          = 7347, -- You feel extremely numb...
        TOO_HEAVY                          = 7348, -- Your body feels almost too heavy to move...
        LIGHT_HEADED                       = 7349, -- You feel a little light-headed...but only briefly.
        NORMAL_AGAIN                       = 7350, -- You feel normal again.
        YOU_CAN_NOW_BECOME_A_DARK_KNIGHT   = 7361, -- You can now become a dark knight!
        FOUL_SMELLING_SOIL_IS_SPILLING_OUT = 7362, -- Foul-smelling soil is spilling out.
        CHEST_UNLOCKED                     = 7372, -- You unlock the chest!
        LEARNS_SPELL                       = 7790, -- <name> learns <spell>!
        UNCANNY_SENSATION                  = 7792, -- You are assaulted by an uncanny sensation.
        COMMON_SENSE_SURVIVAL              = 7799, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        MIMIC                  = 17379783,
        BI_GHO_HEADTAKER_PH    =
        {
            [17379350] = 17379351, -- -98.611 0.498 71.212
        },
        DA_DHA_HUNDREDMASK_PH  =
        {
            [17379426] = 17379427, -- -71.480 0.490 -62.882
        },
        GE_DHA_EVILEYE_PH      =
        {
            [17379447] = 17379450, -- -242.709 0.5 -188.01
        },
        ZO_KHU_BLACKCLOUD_PH   =
        {
            [17379562] = 17379564, -- -294.223 -3.504 -206.657
        },
        GA_BHU_UNVANQUISHED_PH =
        {
            [17379625] = 17379626, -- 139.642 -2.445 161.557
        },
    },
    npc =
    {
        QM1             = 17379800,
        TREASURE_CHEST  = 17379842,
        TREASURE_COFFER = 17379843,
        AFFLICTOR_BASE  = 17379801,
    },
}

return zones[xi.zone.BEADEAUX]
