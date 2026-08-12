-----------------------------------
-- Area: Oldton_Movalpolos
-----------------------------------
zones = zones or {}

zones[xi.zone.OLDTON_MOVALPOLOS] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6387, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6395, -- Obtained: <item>.
        GIL_OBTAINED                  = 6396, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6398, -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6399, -- Lost key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET         = 6424, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7006, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7007, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7008, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7028, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7073, -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET        = 7592, -- You can't fish here.
        MINING_IS_POSSIBLE_HERE       = 7724, -- Mining is possible here if you have <item>.
        NO_FIRES_NO_BOMBS             = 7731, -- This place being for garbage. No fires. No bombs.
        KILLING_BOMBS                 = 7736, -- Killing bombs. Bringing <item>.
        REFUSES_TO_GIVE_ANOTHER       = 7744, -- When Brakobrik realizes that you already possess the item he is trying to give you, he refuses to give you another one.
        RAKOROK_DIALOGUE              = 7748, -- Nsy pipul. Gattohre! I bisynw!
        ALTANA_DIE                    = 7750, -- Aaaltaaanaaa... Diiieee!!!
        WAS_TAKEN_FROM_YOU            = 7762, -- The <keyitem> was taken from you...
        MONSTER_APPEARED              = 7763, -- A monster has appeared!
        CHEST_UNLOCKED                = 7772, -- You unlock the chest!
        COMMON_SENSE_SURVIVAL         = 8130, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
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
