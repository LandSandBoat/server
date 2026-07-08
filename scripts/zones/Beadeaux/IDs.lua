-----------------------------------
-- Area: Beadeaux
-----------------------------------
zones = zones or {}

zones[xi.zone.BEADEAUX] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED            = 6386, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                      = 6394, -- Obtained: <item>.
        GIL_OBTAINED                       = 6395, -- Obtained <number> gil.
        KEYITEM_OBTAINED                   = 6397, -- Obtained key item: <keyitem>.
        NOT_ENOUGH_GIL                     = 6399, -- You do not have enough gil.
        ITEMS_OBTAINED                     = 6403, -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY            = 6408, -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET              = 6423, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS                = 7005, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY            = 7006, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                       = 7007, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED      = 7027, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                      = 7072, -- Tallying conquest results...
        REGION_POINTS_SANDORIA             = 7137, -- San d'Oria's region points have increased!
        LOCKED_DOOR_QUADAV_HAS_KEY         = 7235, -- It is locked tight, but has what looks like a keyhole. Maybe one of the Quadav here has the key.
        FEEL_COLD                          = 7357, -- You feel cold...
        FEEL_NUMB                          = 7358, -- You feel extremely numb...
        TOO_HEAVY                          = 7359, -- Your body feels almost too heavy to move...
        LIGHT_HEADED                       = 7360, -- You feel a little light-headed...but only briefly.
        NORMAL_AGAIN                       = 7361, -- You feel normal again.
        YOU_CAN_NOW_BECOME_A_DARK_KNIGHT   = 7372, -- You can now become a dark knight!
        FOUL_SMELLING_SOIL_IS_SPILLING_OUT = 7373, -- Foul-smelling soil is spilling out.
        CHEST_UNLOCKED                     = 7383, -- You unlock the chest!
        HUURR                              = 7779, -- Hu-urr...!
        TAKEN_FROM_YOU                     = 7781, -- The <keyitem> is taken from you!
        QUADAV_ARE_ATTACKING               = 7782, -- The Quadav are attacking!
        LEARNS_SPELL                       = 7801, -- <name> learns <spell>!
        UNCANNY_SENSATION                  = 7803, -- You are assaulted by an uncanny sensation.
        COMMON_SENSE_SURVIVAL              = 7810, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        BI_GHO_HEADTAKER    = GetFirstID('BiGho_Headtaker'),
        DA_DHA_HUNDREDMASK  = GetFirstID('DaDha_Hundredmask'),
        GA_BHU_UNVANQUISHED = GetFirstID('GaBhu_Unvanquished'),
        GE_DHA_EVILEYE      = GetFirstID('GeDha_Evileye'),
        MAGNES_QUADAV_NM    = GetFirstID('Magnes_Quadav_NM'),
        NICKEL_QUADAV_NM    = GetFirstID('Nickel_Quadav_NM'),
        MIMIC               = GetFirstID('Mimic'),
        ZO_KHU_BLACKCLOUD   = GetFirstID('ZoKhu_Blackcloud'),
    },
    npc =
    {
        AFFLICTOR_BASE  = GetFirstID('The_Afflictor'),
        TREASURE_CHEST  = GetFirstID('Treasure_Chest'),
        TREASURE_COFFER = GetFirstID('Treasure_Coffer'),
        QM1             = GetFirstID('qm1'),
    },
}

return zones[xi.zone.BEADEAUX]
