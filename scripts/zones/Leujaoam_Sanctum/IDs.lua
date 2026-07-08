-----------------------------------
-- Area: Leujaoam_Sanctum
-----------------------------------
zones = zones or {}

zones[xi.zone.LEUJAOAM_SANCTUM] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6386, -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE    = 6390, -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 6394, -- Obtained: <item>.
        GIL_OBTAINED                  = 6395, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6397, -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6398, -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL           = 6399, -- You do not have enough gil.
        ITEMS_OBTAINED                = 6403, -- You obtain <number> <item>!
        CARRIED_OVER_POINTS           = 7005, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7006, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7007, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7027, -- Your party is unable to participate because certain members' levels are restricted.
        PLAYER_OBTAINS_ITEM           = 7331, -- <name> obtains <item>!
        ASSAULT_START_OFFSET          = 7466, -- Max MP Down removed for <name>.
        TIME_TO_COMPLETE              = 7527, -- You have <number> [minute/minutes] (Earth time) to complete this mission.
        MISSION_FAILED                = 7528, -- The mission has failed. Leaving area.
        RUNE_UNLOCKED_POS             = 7529, -- Mission objective completed. Unlocking Rune of Release ([A/B/C/D/E/F/G/H/I/J/K/L/M/N/O/P/Q/R/S/T/U/V/W/X/Y/Z]-<number>).
        ASSAULT_POINTS_OBTAINED       = 7531, -- You gain <number> [Assault point/Assault points]!
        TIME_REMAINING_MINUTES        = 7532, -- Time remaining: <number> [minute/minutes] (Earth time).
        TIME_REMAINING_SECONDS        = 7533, -- Time remaining: <number> [second/seconds] (Earth time).
        PARTY_FALLEN                  = 7535, -- All party members have fallen in battle. Mission failure in <number> [minute/minutes].
    },

    mob =
    {
        LEUJAOAM_WORM = GetFirstID('Leujaoam_Worm'),
        QIQIRN_MINER  = GetFirstID('Qiqirn_Miner'),
    },

    npc =
    {
        ANCIENT_LOCKBOX = GetFirstID('Ancient_Lockbox'),
        RUNE_OF_RELEASE = GetFirstID('Rune_of_Release'),
        MINING_POINTS   = GetFirstID('Mining_Point'),
        MULWAHAH        = GetFirstID('Mulwahah'),
    }
}

return zones[xi.zone.LEUJAOAM_SANCTUM]
