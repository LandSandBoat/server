-----------------------------------
-- Area: Zeruhn_Mines
-----------------------------------
zones = zones or {}

zones[xi.zone.ZERUHN_MINES] =
{
    text =
    {
        CONQUEST_BASE                 = 0,     -- Tallying conquest results...
        ITEM_CANNOT_BE_OBTAINED       = 6543,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6549,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6550,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6552,  -- Obtained key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET         = 6578,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7160,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7161,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7162,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7182,  -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7219,  -- You can't fish here.
        MAKARIM_DIALOG_I              = 7326,  -- Be careful on your way out. Remember, you should give my report to Naji, one of the Mythril Musketeers on post at the President's Office.
        ZELMAN_CANT_RUN_AROUND        = 7351,  -- I can't run around doing everything she tells me to--I have my dignity to uphold!
        MINING_IS_POSSIBLE_HERE       = 7358,  -- Mining is possible here if you have <item>.
        PLAYER_OBTAINS_ITEM           = 7415,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 7416,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 7417,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 7418,  -- You already possess that temporary item.
        NO_COMBINATION                = 7423,  -- You were unable to enter a combination.
        REGIME_REGISTERED             = 9501,  -- New training regime registered!
        COMMON_SENSE_SURVIVAL         = 10549, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
    },
    npc =
    {
        MINING = GetTableOfIDs('Mining_Point'),
    },
}

return zones[xi.zone.ZERUHN_MINES]
