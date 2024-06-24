-----------------------------------
-- Area: Oldton_Movalpolos
-----------------------------------
zones = zones or {}

zones[xi.zone.OLDTON_MOVALPOLOS] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6394, -- Lost key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET         = 6419, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7064, -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET        = 7583, -- You can't fish here.
        MINING_IS_POSSIBLE_HERE       = 7714, -- Mining is possible here if you have <item>.
        RAKOROK_DIALOGUE              = 7738, -- Nsy pipul. Gattohre! I bisynw!
        ALTANA_DIE                    = 7740, -- Aaaltaaanaaa... Diiieee!!!
        WAS_TAKEN_FROM_YOU            = 7752, -- The <keyitem> was taken from you...
        MONSTER_APPEARED              = 7753, -- A monster has appeared!
        CHEST_UNLOCKED                = 7762, -- You unlock the chest!
        COMMON_SENSE_SURVIVAL         = 8120, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
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
