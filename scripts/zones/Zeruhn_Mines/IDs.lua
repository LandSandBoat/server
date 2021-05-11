-----------------------------------
-- Area: Zeruhn_Mines
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.ZERUHN_MINES] =
{
    text =
    {
        CONQUEST_BASE            = 0,     -- Tallying conquest results...
        ITEM_CANNOT_BE_OBTAINED  = 6542,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED            = 6548,  -- Obtained: <item>.
        GIL_OBTAINED             = 6549,  -- Obtained <number> gil.
        KEYITEM_OBTAINED         = 6551,  -- Obtained key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET    = 6577,  -- I'm ready. I suppose.
        FISHING_MESSAGE_OFFSET   = 7209,  -- You can't fish here.
        CARRIED_OVER_POINTS      = 7159, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY  = 7160, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER             = 7161, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MAKARIM_DIALOG_I         = 7316,  -- Be careful on your way out. Remember, you should give my report to Naji, one of the Mythril Musketeers on post at the President's Office.
        ZELMAN_CANT_RUN_AROUND   = 7341,  -- I can't run around doing everything she tells me to--I have my dignity to uphold!
        MINING_IS_POSSIBLE_HERE  = 7348,  -- Mining is possible here if you have <item>.
        PLAYER_OBTAINS_ITEM      = 7405,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM    = 7406,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM = 7407,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP     = 7408,  -- You already possess that temporary item.
        NO_COMBINATION           = 7413,  -- You were unable to enter a combination.
        REGIME_REGISTERED        = 9491,  -- New training regime registered!
        COMMON_SENSE_SURVIVAL    = 10539, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
    },
    npc =
    {
        CASKET_BASE = 17481795,
        MINING      =
        {
            17481844,
            17481845,
            17481846,
            17481847,
            17481848,
            17481849,
        },
    },
}

return zones[xi.zone.ZERUHN_MINES]
