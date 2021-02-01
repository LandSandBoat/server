-----------------------------------
-- Area: Jugner_Forest
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.JUGNER_FOREST] =
{
    text =
    {
        NOTHING_HAPPENS          = 141,   -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED  = 6405,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED            = 6411,  -- Obtained: <item>.
        GIL_OBTAINED             = 6412,  -- Obtained <number> gil.
        KEYITEM_OBTAINED         = 6414,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST             = 6415,  -- Lost key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET    = 6440,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS      = 7022, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY  = 7023, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER             = 7024, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE            = 7072,  -- Tallying conquest results...
        BEASTMEN_BANNER          = 7153,  -- There is a beastmen's banner.
        FISHING_MESSAGE_OFFSET   = 7705,  -- You can't fish here.
        DIG_THROW_AWAY           = 7718,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING             = 7720,  -- You dig and you dig, but find nothing.
        LOGGING_IS_POSSIBLE_HERE = 7898,  -- Logging is possible here if you have <item>.
        CONQUEST                 = 8049,  -- You've earned conquest points!
        PLAYER_OBTAINS_ITEM      = 8658,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM    = 8659,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM = 8660,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP     = 8661,  -- You already possess that temporary item.
        NO_COMBINATION           = 8666,  -- You were unable to enter a combination.
        REGIME_REGISTERED        = 10871, -- New training regime registered!
        COMMON_SENSE_SURVIVAL    = 13100, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        PANZER_PERCIVAL_PH =
        {
            [17203581] = 17203585, -- 535.504 -1.517 152.171 (southeast)
            [17203637] = 17203642, -- 239.541 -0.365 559.722 (northwest)
        },
        SUPPLESPINE_MUJWUJ_PH =
        {
            [17203437] = 17203475,
        },
        FRADUBIO_PH =
        {
            [17203447] = 17203448,
        },
        KING_ARTHRO = 17203216,
        FRAELISSA   = 17203447,
    },
    npc =
    {
        CASKET_BASE   = 17203785,
        OVERSEER_BASE = 17203847, -- Chaplion_RK in npc_list
        LOGGING =
        {
            17203863,
            17203864,
            17203865,
            17203866,
            17203867,
            17203868,
        },
    },
}

return zones[tpz.zone.JUGNER_FOREST]
