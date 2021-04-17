-----------------------------------
-- Area: Pashhow_Marshlands
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.PASHHOW_MARSHLANDS] =
{
    text =
    {
        NOTHING_HAPPENS          = 141,   -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED  = 6405,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED            = 6411,  -- Obtained: <item>.
        GIL_OBTAINED             = 6412,  -- Obtained <number> gil.
        KEYITEM_OBTAINED         = 6414,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST             = 6415,  -- Lost key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY  = 6425,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET    = 6440,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS      = 7022, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY  = 7023, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER             = 7024, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE            = 7072,  -- Tallying conquest results...
        BEASTMEN_BANNER          = 7153,  -- There is a beastmen's banner.
        FISHING_MESSAGE_OFFSET   = 7231,  -- You can't fish here.
        DIG_THROW_AWAY           = 7244,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING             = 7246,  -- You dig and you dig, but find nothing.
        CONQUEST                 = 7920,  -- You've earned conquest points!
        PLAYER_OBTAINS_ITEM      = 8476,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM    = 8477,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM = 8478,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP     = 8479,  -- You already possess that temporary item.
        NO_COMBINATION           = 8484,  -- You were unable to enter a combination.
        REGIME_REGISTERED        = 10725, -- New training regime registered!
        COMMON_SENSE_SURVIVAL    = 12836, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
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
        CASKET_BASE   = 17224274,
        OVERSEER_BASE = 17224325, -- Mesachedeau_RK in npc_list
    },
}

return zones[xi.zone.PASHHOW_MARSHLANDS]
