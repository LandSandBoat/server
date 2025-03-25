-----------------------------------
-- Area: Bostaunieux_Oubliette
-----------------------------------
zones = zones or {}

zones[xi.zone.BOSTAUNIEUX_OUBLIETTE] =
{
    text =
    {
        CONQUEST_BASE                 = 0,     -- Tallying conquest results...
        ITEM_CANNOT_BE_OBTAINED       = 6544,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6550,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6551,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6553,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6564,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6579,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7161,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7162,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7163,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7183,  -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7227,  -- You can't fish here.
        CHUMIA_DIALOG                 = 7327,  -- Welcome to Bostaunieux Oubliette...
        SEEMS_LOCKED                  = 7329,  -- It seems to be locked.
        SPIRAL_HELL_LEARNED           = 7436,  -- You have learned the weapon skill Spiral Hell!
        SENSE_OMINOUS_PRESENCE        = 7437,  -- You sense an ominous presence...
        ITEMS_ITEMS_LA_LA             = 7440,  -- You can hear a strange voice... Items, items, la la la la la
        GOBLIN_SLIPPED_AWAY           = 7446,  -- The Goblin slipped away when you were not looking...
        REGIME_REGISTERED             = 9551,  -- New training regime registered!
        PLAYER_OBTAINS_ITEM           = 10603, -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 10604, -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 10605, -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 10606, -- You already possess that temporary item.
        NO_COMBINATION                = 10611, -- You were unable to enter a combination.
        LEARNS_SPELL                  = 10635, -- <name> learns <spell>!
        UNCANNY_SENSATION             = 10637, -- You are assaulted by an uncanny sensation.
        COMMON_SENSE_SURVIVAL         = 10644, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        UNITY_WANTED_BATTLE_INTERACT  = 10708, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
    },
    mob =
    {
        ARIOCH                  = GetFirstID('Arioch'),
        BLOODSUCKER             = GetTableOfIDs('Bloodsucker')[42],
        BODACH                  = GetFirstID('Bodach'),
        DREXERION_THE_CONDEMNED = GetFirstID('Drexerion_the_Condemned'),
        MANES                   = GetFirstID('Manes'),
        PHANDURON_THE_CONDEMNED = GetFirstID('Phanduron_the_Condemned'),
        SEWER_SYRUP             = GetFirstID('Sewer_Syrup'),
        SHII                    = GetFirstID('Shii'),
    },
    npc =
    {
    },
}

return zones[xi.zone.BOSTAUNIEUX_OUBLIETTE]
