-----------------------------------
-- Area: Zeruhn_Mines
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.ZERUHN_MINES] =
{
    text =
    {
        CONQUEST_BASE            = 0,     -- Tallying conquest results...
        ITEM_CANNOT_BE_OBTAINED  = 6541,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED            = 6547,  -- Obtained: <item>.
        GIL_OBTAINED             = 6548,  -- Obtained <number> gil.
        KEYITEM_OBTAINED         = 6550,  -- Obtained key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET    = 6576,  -- I'm ready. I suppose.
        FISHING_MESSAGE_OFFSET   = 7208,  -- You can't fish here.
        MAKARIM_DIALOG_I         = 7315,  -- Be careful on your way out. Remember, you should give my report to Naji, one of the Mythril Musketeers on post at the President's Office.
        ZELMAN_CANT_RUN_AROUND   = 7340,  -- I can't run around doing everything she tells me to--I have my dignity to uphold!
        MINING_IS_POSSIBLE_HERE  = 7347,  -- Mining is possible here if you have <item>.
        PLAYER_OBTAINS_ITEM      = 7404,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM    = 7405,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM = 7406,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP     = 7407,  -- You already possess that temporary item.
        NO_COMBINATION           = 7412,  -- You were unable to enter a combination.
        REGIME_REGISTERED        = 9490,  -- New training regime registered!
        COMMON_SENSE_SURVIVAL    = 10538, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
    },
    npc =
    {
        CASKET_BASE = 17481791,
        MINING      =
        {
            17481840,
            17481841,
            17481842,
            17481843,
            17481844,
            17481845,
        },
    },
}

return zones[tpz.zone.ZERUHN_MINES]
