-----------------------------------
-- Area: Valley_of_Sorrows
-----------------------------------
zones = zones or {}

zones[xi.zone.VALLEY_OF_SORROWS] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6386,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE    = 6390,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 6394,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6395,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6397,  -- Obtained key item: <keyitem>.
        ITEMS_OBTAINED                = 6403,  -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY       = 6408,  -- There is nothing out of the ordinary here.
        AURA_THREATENS                = 6412,  -- An aura of irrepressible might threatens to overwhelm you...
        FELLOW_MESSAGE_OFFSET         = 6423,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7005,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7006,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7007,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7027,  -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7072,  -- Tallying conquest results...
        SOMETHING_BURRIED             = 7332,  -- It looks like something was buried here.
        PLAYER_OBTAINS_ITEM           = 7522,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 7523,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 7524,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 7525,  -- You already possess that temporary item.
        NO_COMBINATION                = 7530,  -- You were unable to enter a combination.
        UNITY_WANTED_BATTLE_INTERACT  = 7592,  -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        REGIME_REGISTERED             = 9708,  -- New training regime registered!
        COMMON_SENSE_SURVIVAL         = 10827, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        ADAMANTOISE   = GetFirstID('Adamantoise'),
        ASPIDOCHELONE = GetFirstID('Aspidochelone'),
    },
    npc =
    {
        ADAMANTOISE_QM = GetFirstID('qm0'),
    },
}

return zones[xi.zone.VALLEY_OF_SORROWS]
