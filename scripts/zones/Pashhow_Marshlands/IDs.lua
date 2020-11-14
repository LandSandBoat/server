-----------------------------------
-- Area: Pashhow_Marshlands
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.PASHHOW_MARSHLANDS] =
{
    text =
    {
        NOTHING_HAPPENS          = 141,   -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED  = 6404,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED            = 6410,  -- Obtained: <item>.
        GIL_OBTAINED             = 6411,  -- Obtained <number> gil.
        KEYITEM_OBTAINED         = 6413,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST             = 6414,  -- Lost key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY  = 6424,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET    = 6439,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS      = 7021, -- You have carried over <number> points.
        LOGIN_CAMPAIGN_UNDERWAY  = 7022, -- The <month> ≺year≻ Login Campaign is currently underway!
        LOGIN_NUMBER             = 7023, -- In celebration of your most recent login no. <number>...
        CONQUEST_BASE            = 7071,  -- Tallying conquest results...
        BEASTMEN_BANNER          = 7152,  -- There is a beastmen's banner.
        FISHING_MESSAGE_OFFSET   = 7230,  -- You can't fish here.
        DIG_THROW_AWAY           = 7243,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING             = 7245,  -- You dig and you dig, but find nothing.
        PLAYER_OBTAINS_ITEM      = 8457,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM    = 8458,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM = 8459,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP     = 8460,  -- You already possess that temporary item.
        NO_COMBINATION           = 8465,  -- You were unable to enter a combination.
        CONQUEST                 = 7919,  -- You've earned conquest points!
        REGIME_REGISTERED        = 10706, -- New training regime registered!
        COMMON_SENSE_SURVIVAL    = 12817, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        NI_ZHO_BLADEBENDER_PH =
        {
            [17223740] = 17223797, -- -429.953 24.5 -305.450
            [17223789] = 17223797, -- 11.309 23.904 -337.923
        },
        JOLLY_GREEN_PH        =
        {
            [17223888] = 17223889, -- 184.993 24.499 -41.790
        },
        BLOODPOOL_VORAX_PH    =
        {
            [17224014] = 17224019, -- -351.884 24.014 513.531
        },
        BOWHO_WARMONGER       = 17224104,
    },
    npc =
    {
        CASKET_BASE   = 17224275,
        OVERSEER_BASE = 17224326,
    },
}

return zones[tpz.zone.PASHHOW_MARSHLANDS]
