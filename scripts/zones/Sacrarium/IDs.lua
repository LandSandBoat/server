-----------------------------------
-- Area: Sacrarium
-----------------------------------
zones = zones or {}

zones[xi.zone.SACRARIUM] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6404, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7064, -- Tallying conquest results...
        LARGE_KEYHOLE_DESCRIPTION     = 7230, -- The gate is securely closed with two locks. This keyhole is engraved with a sealion insignia.
        SMALL_KEYHOLE_DESCRIPTION     = 7231, -- The gate is securely closed with two locks. This keyhole is engraved with a coral insignia.
        KEYHOLE_DAMAGED               = 7232, -- The keyhole is damaged.  The gate cannot be opened from this side.
        CANNOT_OPEN_SIDE              = 7233, -- The gate cannot be opened from this side.
        CANNOT_TRADE_NOW              = 7234, -- You cannot trade right now.
        STURDY_GATE                   = 7235, -- A sturdy iron gate. It is secured with two locks--a main lock and a sublock.
        CORAL_KEY_BREAKS              = 7239, -- The <item> breaks!
        EVIL_PRESENCE                 = 7273, -- You sense an evil presence!
        DRAWER_OPEN                   = 7274, -- You open the drawer.
        DRAWER_EMPTY                  = 7275, -- There is nothing inside.
        DRAWER_SHUT                   = 7276, -- The drawer is jammed shut.
        CHEST_UNLOCKED                = 7365, -- You unlock the chest!
        START_GET_GOOSEBUMPS          = 7375, -- You start to get goosebumps.
        HEART_RACING                  = 7376, -- Your heart is racing.
        LEAVE_QUICKLY_AS_POSSIBLE     = 7377, -- Your common sense tells you to leave as quickly as possible.
        NOTHING_HAPPENS               = 7380, -- Nothing happens.
        COMMON_SENSE_SURVIVAL         = 7384, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        SWIFT_BELT_NM_OFFSET    = GetFirstID('Balor'),
        OLD_PROFESSOR_MARISELLE = GetFirstID('Old_Professor_Mariselle'),
        ELEL                    = GetFirstID('Elel'),
    },
    npc =
    {
        STALE_DRAFT_OFFSET  = GetFirstID('Stale_Draft'),
        LABYRINTH_OFFSET    = GetFirstID('_0sb'),
        SMALL_KEYHOLE       = GetFirstID('Small_Keyhole'),
        QM_MARISELLE_OFFSET = GetFirstID('qm_prof_0'),
        TREASURE_CHEST      = GetFirstID('Treasure_Chest'),
    },
}

return zones[xi.zone.SACRARIUM]
