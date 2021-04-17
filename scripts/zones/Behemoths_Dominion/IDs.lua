-----------------------------------
-- Area: Behemoths_Dominion
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.BEHEMOTHS_DOMINION] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED  = 6383,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED            = 6389,  -- Obtained: <item>.
        GIL_OBTAINED             = 6390,  -- Obtained <number> gil.
        KEYITEM_OBTAINED         = 6392,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY  = 6403,  -- There is nothing out of the ordinary here.
        SENSE_OF_FOREBODING      = 6404,  -- You are suddenly overcome with a sense of foreboding...
        IRREPRESSIBLE_MIGHT      = 6407,  -- An aura of irrepressible might threatens to overwhelm you...
        FELLOW_MESSAGE_OFFSET    = 6418,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS      = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY  = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER             = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE            = 7050,  -- Tallying conquest results...
        SOMETHING_BETTER         = 7316,  -- Don't you have something better to do right now?
        CANNOT_REMOVE_FRAG       = 7319,  -- It is an oddly shaped stone monument. A shining stone is embedded in it, but cannot be removed...
        ALREADY_OBTAINED_FRAG    = 7320,  -- You have already obtained this monument's <keyitem>. Try searching for another.
        FOUND_ALL_FRAGS          = 7322,  -- You have obtained <keyitem>! You now have all 8 fragments of light!
        ZILART_MONUMENT          = 7323,  -- It is an ancient Zilart monument.
        PLAYER_OBTAINS_ITEM      = 7344,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM    = 7345,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM = 7346,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP     = 7347,  -- You already possess that temporary item.
        NO_COMBINATION           = 7352,  -- You were unable to enter a combination.
        REGIME_REGISTERED        = 9530,  -- New training regime registered!
        COMMON_SENSE_SURVIVAL    = 11528, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        BEHEMOTH                = 17297440,
        KING_BEHEMOTH           = 17297441,
        TALEKEEPERS_GIFT_OFFSET = 17297446,
        ANCIENT_WEAPON          = 17297449,
        LEGENDARY_WEAPON        = 17297450,
    },
    npc =
    {
        BEHEMOTH_QM      = 17297459,
        CASKET_BASE      = 17297460,
        CERMET_HEADSTONE = 17297493,
    },
}

return zones[xi.zone.BEHEMOTHS_DOMINION]
