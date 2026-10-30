-----------------------------------
-- Area: Leujaoam_Sanctum
-----------------------------------
zones = zones or {}

zones[xi.zone.LEUJAOAM_SANCTUM] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6387, -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE    = 6391, -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 6395, -- Obtained: <item>.
        GIL_OBTAINED                  = 6396, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6398, -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6399, -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL           = 6400, -- You do not have enough gil.
        ITEMS_OBTAINED                = 6404, -- You obtain <number> <item>!
        CARRIED_OVER_POINTS           = 7006, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7007, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7008, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7028, -- Your party is unable to participate because certain members' levels are restricted.
        OBTAIN_PICKAXE                = 7331, -- Obtained temporary item: a pickaxe!
        PLAYER_OBTAINS_ITEM           = 7332, -- <name> obtains <item>!
        ASSAULT_START_OFFSET          = 7467, -- Max MP Down removed for <name>.
        TIME_TO_COMPLETE              = 7528, -- You have <number> [minute/minutes] (Earth time) to complete this mission.
        MISSION_FAILED                = 7529, -- The mission has failed. Leaving area.
        RUNE_UNLOCKED_POS             = 7530, -- Mission objective completed. Unlocking Rune of Release ([A/B/C/D/E/F/G/H/I/J/K/L/M/N/O/P/Q/R/S/T/U/V/W/X/Y/Z]-<number>).
        ASSAULT_POINTS_OBTAINED       = 7532, -- You gain <number> [Assault point/Assault points]!
        TIME_REMAINING_MINUTES        = 7533, -- Time remaining: <number> [minute/minutes] (Earth time).
        TIME_REMAINING_SECONDS        = 7534, -- Time remaining: <number> [second/seconds] (Earth time).
        PARTY_FALLEN                  = 7536, -- All party members have fallen in battle. Mission failure in <number> [minute/minutes].
        FIND_NOTHING                  = 7545, -- You find nothing.
        OBTAIN_PEBBLE                 = 7546, -- You obtain a pebble.
        OBTAIN_ORICHALCUM_ORE         = 7547, -- You obtain an Orichalcum ore.
        PICKAXE_BREAKS                = 7548, -- Your pickaxe breaks.
        NO_PICKAXE                    = 7549, -- Mining is possible here if you have a pickaxe.
        MOVE_CLOSER                   = 7550, -- You must move closer to the target (mining point).
        CANT_MINE_RIGHT_NOW           = 7551, -- You can't mine here right now (worm is up).
        YOU_FOUND_SOME                = 7553, -- You found some? Let's take a look then...
        AMAZING_LOOK_AT_IT            = 7554, -- Amazing! Look at it shine! This is definitely a chunk of orichalcum ore.
        THE_RUMORS_WERE_TRUE          = 7555, -- The rumors were true! Excellent work!
        ALREADY_HAVE_PICKAXE          = 7556, -- You only get as many pickaxes as you need. Now, get moving!
        BRING_ORICHALCUM_ORE_BACK     = 7557, -- If you come across a chunk of orichalcum ore, bring it directly back to me.
    },

    mob =
    {
        LEUJAOAM_WORM = GetFirstID('Leujaoam_Worm'),
        MINERAL_EATER = GetFirstID('Mineral_Eater'),
        QIQIRN_MINER  = GetFirstID('Qiqirn_Miner'),
    },

    npc =
    {
        ANCIENT_LOCKBOX = GetFirstID('Ancient_Lockbox'),
        RUNE_OF_RELEASE = GetFirstID('Rune_of_Release'),
        MINING_POINTS   = GetFirstID('Mining_Point'),
        MULWAHAH        = GetFirstID('Mulwahah'),
        _1xo            = GetFirstID('_1xo'),
    }
}

return zones[xi.zone.LEUJAOAM_SANCTUM]
