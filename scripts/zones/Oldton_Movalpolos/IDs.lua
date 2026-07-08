-----------------------------------
-- Area: Oldton_Movalpolos
-----------------------------------
zones = zones or {}

zones[xi.zone.OLDTON_MOVALPOLOS] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6386, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6394, -- Obtained: <item>.
        GIL_OBTAINED                  = 6395, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6397, -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6398, -- Lost key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET         = 6423, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7005, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7006, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7007, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7027, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7072, -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET        = 7591, -- You can't fish here.
        MINING_IS_POSSIBLE_HERE       = 7723, -- Mining is possible here if you have <item>.
        NO_FIRES_NO_BOMBS             = 7730, -- This place being for garbage. No fires. No bombs.
        KILLING_BOMBS                 = 7735, -- Killing bombs. Bringing <item>.
        REFUSES_TO_GIVE_ANOTHER       = 7743, -- When Brakobrik realizes that you already possess the item he is trying to give you, he refuses to give you another one.
        RAKOROK_DIALOGUE              = 7747, -- Nsy pipul. Gattohre! I bisynw!
        ALTANA_DIE                    = 7749, -- Aaaltaaanaaa... Diiieee!!!
        WAS_TAKEN_FROM_YOU            = 7761, -- The <keyitem> was taken from you...
        MONSTER_APPEARED              = 7762, -- A monster has appeared!
        CHEST_UNLOCKED                = 7771, -- You unlock the chest!
        COMMON_SENSE_SURVIVAL         = 8129, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        BUGALLUG           = GetFirstID('Bugallug'),
        BUGBEAR_BONDMAN    = GetTableOfIDs('Bugbear_Bondman'),
        BUGBEAR_SERVINGMAN = GetTableOfIDs('Bugbear_Servingman'),
        BUGBEAR_STRONGMAN  = GetTableOfIDs('Bugbear_Strongman'),
        GOBLIN_FREELANCE   = GetTableOfIDs('Goblin_Freelance'),
        GOBLIN_WOLFMAN     = GetFirstID('Goblin_Wolfman'),
        GOBLIN_HAMMERMAN   = GetTableOfIDs('Goblin_Hammerman'),
        MOBLIN_CHAPMAN     = GetTableOfIDs('Moblin_Chapman'),
        MOBLIN_COALMAN     = GetTableOfIDs('Moblin_Coalman'),
        MOBLIN_GASMAN      = GetTableOfIDs('Moblin_Gasman'),
        MOBLIN_PIKEMAN     = GetTableOfIDs('Moblin_Pikeman'),
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
