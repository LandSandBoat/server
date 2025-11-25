-----------------------------------
-- Area: Sacrarium
-----------------------------------
zones = zones or {}

zones[xi.zone.SACRARIUM] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6385, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6391, -- Obtained: <item>.
        GIL_OBTAINED                  = 6392, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6394, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6405, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS           = 7002, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7003, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7004, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7024, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7068, -- Tallying conquest results...
        LARGE_KEYHOLE_DESCRIPTION     = 7234, -- The gate is securely closed with two locks. This keyhole is engraved with a sealion insignia.
        SMALL_KEYHOLE_DESCRIPTION     = 7235, -- The gate is securely closed with two locks. This keyhole is engraved with a coral insignia.
        KEYHOLE_DAMAGED               = 7236, -- The keyhole is damaged.  The gate cannot be opened from this side.
        CANNOT_OPEN_SIDE              = 7237, -- The gate cannot be opened from this side.
        CANNOT_TRADE_NOW              = 7238, -- You cannot trade right now.
        STURDY_GATE                   = 7239, -- A sturdy iron gate. It is secured with two locks--a main lock and a sublock.
        CORAL_KEY_BREAKS              = 7243, -- The <item> breaks!
        EVIL_PRESENCE                 = 7277, -- You sense an evil presence!
        DRAWER_OPEN                   = 7278, -- You open the drawer.
        DRAWER_EMPTY                  = 7279, -- There is nothing inside.
        DRAWER_SHUT                   = 7280, -- The drawer is jammed shut.
        CHEST_UNLOCKED                = 7369, -- You unlock the chest!
        MUSTY_OLD_MANUSCRIPTS         = 7377, -- There is nothing here but a handful of musty old manuscripts.
        START_GET_GOOSEBUMPS          = 7379, -- You start to get goosebumps.
        HEART_RACING                  = 7380, -- Your heart is racing.
        LEAVE_QUICKLY_AS_POSSIBLE     = 7381, -- Your common sense tells you to leave as quickly as possible.
        NOTHING_HAPPENS               = 7384, -- Nothing happens.
        COMMON_SENSE_SURVIVAL         = 7388, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        SWIFT_BELT_NM_OFFSET    = GetFirstID('Balor'),
        OLD_PROFESSOR_MARISELLE = GetFirstID('Old_Professor_Mariselle'),
        ELEL                    = GetFirstID('Elel'),
    },
    npc =
    {
        LABYRINTH_OFFSET      = GetFirstID('_0sb'),
        QM_MARISELLE_OFFSET   = GetFirstID('qm_prof_0'),
        QM_TAVNAZIAN_COOKBOOK = GetFirstID('qm_tavnazian_cookbook'),
        SMALL_KEYHOLE         = GetFirstID('Small_Keyhole'),
        STALE_DRAFT_OFFSET    = GetFirstID('Stale_Draft'),
        TREASURE_CHEST        = GetFirstID('Treasure_Chest'),
    },
}

return zones[xi.zone.SACRARIUM]
