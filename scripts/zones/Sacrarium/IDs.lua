-----------------------------------
-- Area: Sacrarium
-----------------------------------
zones = zones or {}

zones[xi.zone.SACRARIUM] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6386, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6394, -- Obtained: <item>.
        GIL_OBTAINED                  = 6395, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6397, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6408, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS           = 7005, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7006, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7007, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7027, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7072, -- Tallying conquest results...
        CANNOT_BE_OPENED              = 7235, -- The door cannot be opened...
        LARGE_KEYHOLE_DESCRIPTION     = 7238, -- The gate is securely closed with two locks. This keyhole is engraved with a sealion insignia.
        SMALL_KEYHOLE_DESCRIPTION     = 7239, -- The gate is securely closed with two locks. This keyhole is engraved with a coral insignia.
        KEYHOLE_DAMAGED               = 7240, -- The keyhole is damaged. The gate cannot be opened from this side.
        CANNOT_OPEN_SIDE              = 7241, -- The gate cannot be opened from this side.
        CANNOT_TRADE_NOW              = 7242, -- You cannot trade right now.
        STURDY_GATE                   = 7243, -- A sturdy iron gate. It is secured with two locks--a main lock and a sublock.
        CORAL_KEY_BREAKS              = 7247, -- The <item> breaks!
        EVIL_PRESENCE                 = 7281, -- You sense an evil presence!
        DRAWER_OPEN                   = 7282, -- You open the drawer.
        DRAWER_EMPTY                  = 7283, -- There is nothing inside.
        DRAWER_SHUT                   = 7284, -- The drawer is jammed shut.
        CHEST_UNLOCKED                = 7373, -- You unlock the chest!
        MUSTY_OLD_MANUSCRIPTS         = 7381, -- There is nothing here but a handful of musty old manuscripts.
        START_GET_GOOSEBUMPS          = 7383, -- You start to get goosebumps.
        HEART_RACING                  = 7384, -- Your heart is racing.
        LEAVE_QUICKLY_AS_POSSIBLE     = 7385, -- Your common sense tells you to leave as quickly as possible.
        NOTHING_HAPPENS               = 7388, -- Nothing happens.
        COMMON_SENSE_SURVIVAL         = 7392, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        ELEL                    = GetFirstID('Elel'),
        FOMOR_BARD              = GetTableOfIDs('Fomor_Bard'),
        FOMOR_BLACK_MAGE        = GetTableOfIDs('Fomor_Black_Mage'),
        FOMOR_DARK_KNIGHT       = GetTableOfIDs('Fomor_Dark_Knight'),
        FOMOR_DRAGOON           = GetTableOfIDs('Fomor_Dragoon'),
        FOMOR_MONK              = GetTableOfIDs('Fomor_Monk'),
        FOMOR_NINJA             = GetTableOfIDs('Fomor_Ninja'),
        FOMOR_RANGER            = GetTableOfIDs('Fomor_Ranger'),
        FOMOR_RED_MAGE          = GetTableOfIDs('Fomor_Red_Mage'),
        FOMOR_SAMURAI           = GetTableOfIDs('Fomor_Samurai'),
        FOMOR_WARRIOR           = GetTableOfIDs('Fomor_Warrior'),
        OLD_PROFESSOR_MARISELLE = GetFirstID('Old_Professor_Mariselle'),
        SWIFT_BELT_NM_OFFSET    = GetFirstID('Balor'),
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
