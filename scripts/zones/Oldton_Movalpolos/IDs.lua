-----------------------------------
-- Area: Oldton_Movalpolos
-----------------------------------
zones = zones or {}

zones[xi.zone.OLDTON_MOVALPOLOS] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6385, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6391, -- Obtained: <item>.
        GIL_OBTAINED                  = 6392, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6394, -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6395, -- Lost key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET         = 6420, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7002, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7003, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7004, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7024, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7068, -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET        = 7587, -- You can't fish here.
        MINING_IS_POSSIBLE_HERE       = 7718, -- Mining is possible here if you have <item>.
        RAKOROK_DIALOGUE              = 7742, -- Nsy pipul. Gattohre! I bisynw!
        ALTANA_DIE                    = 7744, -- Aaaltaaanaaa... Diiieee!!!
        WAS_TAKEN_FROM_YOU            = 7756, -- The <keyitem> was taken from you...
        MONSTER_APPEARED              = 7757, -- A monster has appeared!
        CHEST_UNLOCKED                = 7766, -- You unlock the chest!
        COMMON_SENSE_SURVIVAL         = 8124, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        BUGALLUG          = GetFirstID('Bugallug'),
        BUGBEAR_STRONGMAN = GetTableOfIDs('Bugbear_Strongman'),
        GOBLIN_WOLFMAN    = GetFirstID('Goblin_Wolfman'),
    },
    npc =
    {
        SCRAWLED_WRITING = GetFirstID('Scrawled_Writing'),
        OVERSEER_BASE    = GetFirstID('Conquest_Banner'),
        TREASURE_CHEST   = GetFirstID('Treasure_Chest'),
        MINING           = GetTableOfIDs('Mining_Point'),
    },
}

return zones[xi.zone.OLDTON_MOVALPOLOS]
