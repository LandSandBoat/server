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
        CONQUEST_BASE                      = 7060, -- Tallying conquest results...
        LOCKED_DOOR_QUADAV_HAS_KEY         = 7223, -- It is locked tight, but has what looks like a keyhole. Maybe one of the Quadav here has the key.
        FEEL_COLD                          = 7345, -- You feel cold...
        FEEL_NUMB                          = 7346, -- You feel extremely numb...
        TOO_HEAVY                          = 7347, -- Your body feels almost too heavy to move...
        LIGHT_HEADED                       = 7348, -- You feel a little light-headed...but only briefly.
        NORMAL_AGAIN                       = 7349, -- You feel normal again.
        YOU_CAN_NOW_BECOME_A_DARK_KNIGHT   = 7360, -- You can now become a dark knight!
        FOUL_SMELLING_SOIL_IS_SPILLING_OUT = 7361, -- Foul-smelling soil is spilling out.
        CHEST_UNLOCKED                     = 7371, -- You unlock the chest!
        LEARNS_SPELL                       = 7789, -- <name> learns <spell>!
        UNCANNY_SENSATION                  = 7791, -- You are assaulted by an uncanny sensation.
        COMMON_SENSE_SURVIVAL              = 7798, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        MIMIC                  = GetFirstID("Mimic"),
        BI_GHO_HEADTAKER_PH    =
        {
            [GetFirstID("BiGho_Headtaker") - 1] = GetFirstID("BiGho_Headtaker"), -- -98.611 0.498 71.212
        },
        DA_DHA_HUNDREDMASK_PH  =
        {
            [GetFirstID("DaDha_Hundredmask") - 1] = GetFirstID("DaDha_Hundredmask"), -- -71.480 0.490 -62.882
        },
        GE_DHA_EVILEYE_PH      =
        {
            [GetFirstID("GeDha_Evileye") - 3] = GetFirstID("GeDha_Evileye"), -- -242.709 0.5 -188.01
        },
        ZO_KHU_BLACKCLOUD_PH   =
        {
            [GetFirstID("ZoKhu_Blackcloud") - 2] = GetFirstID("ZoKhu_Blackcloud"), -- -294.223 -3.504 -206.657
        },
        GA_BHU_UNVANQUISHED_PH =
        {
            [GetFirstID("GaBhu_Unvanquished") - 1] = GetFirstID("GaBhu_Unvanquished"), -- 139.642 -2.445 161.557
        },
    },
    npc =
    {
        QM1             = GetFirstID("qm1"),
        TREASURE_CHEST  = GetFirstID("Treasure_Chest"),
        TREASURE_COFFER = GetFirstID("Treasure_Coffer"),
        AFFLICTOR_BASE  = GetFirstID("The_Afflictor"),
    },
}

return zones[xi.zone.BEADEAUX]
