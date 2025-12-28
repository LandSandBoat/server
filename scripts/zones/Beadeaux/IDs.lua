-----------------------------------
-- Area: Beadeaux
-----------------------------------
zones = zones or {}

zones[xi.zone.BEADEAUX] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED            = 6385, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                      = 6391, -- Obtained: <item>.
        GIL_OBTAINED                       = 6392, -- Obtained <number> gil.
        KEYITEM_OBTAINED                   = 6394, -- Obtained key item: <keyitem>.
        NOT_ENOUGH_GIL                     = 6396, -- You do not have enough gil.
        ITEMS_OBTAINED                     = 6400, -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY            = 6405, -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET              = 6420, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS                = 7002, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY            = 7003, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                       = 7004, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED      = 7024, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                      = 7068, -- Tallying conquest results...
        LOCKED_DOOR_QUADAV_HAS_KEY         = 7231, -- It is locked tight, but has what looks like a keyhole. Maybe one of the Quadav here has the key.
        FEEL_COLD                          = 7353, -- You feel cold...
        FEEL_NUMB                          = 7354, -- You feel extremely numb...
        TOO_HEAVY                          = 7355, -- Your body feels almost too heavy to move...
        LIGHT_HEADED                       = 7356, -- You feel a little light-headed...but only briefly.
        NORMAL_AGAIN                       = 7357, -- You feel normal again.
        YOU_CAN_NOW_BECOME_A_DARK_KNIGHT   = 7368, -- You can now become a dark knight!
        FOUL_SMELLING_SOIL_IS_SPILLING_OUT = 7369, -- Foul-smelling soil is spilling out.
        CHEST_UNLOCKED                     = 7379, -- You unlock the chest!
        HUURR                              = 7775, -- Hu-urr...!
        TAKEN_FROM_YOU                     = 7777, -- The <keyitem> is taken from you!
        QUADAV_ARE_ATTACKING               = 7778, -- The Quadav are attacking!
        LEARNS_SPELL                       = 7797, -- <name> learns <spell>!
        UNCANNY_SENSATION                  = 7799, -- You are assaulted by an uncanny sensation.
        COMMON_SENSE_SURVIVAL              = 7806, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
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
