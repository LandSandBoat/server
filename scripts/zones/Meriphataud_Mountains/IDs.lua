-----------------------------------
-- Area: Meriphataud_Mountains
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.MERIPHATAUD_MOUNTAINS] =
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
        FISHING_MESSAGE_OFFSET   = 7231,  -- You can't fish here.
        DIG_THROW_AWAY           = 7244,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING             = 7246,  -- You dig and you dig, but find nothing.
        NOTHING_FOUND            = 7489,  -- You find nothing.
        CONQUEST                 = 7901,  -- You've earned conquest points!
        ITEMS_ITEMS_LA_LA        = 8293,  -- You can hear a strange voice... Items, items, la la la la la
        GOBLIN_SLIPPED_AWAY      = 8299,  -- The Goblin slipped away when you were not looking...
        PLAYER_OBTAINS_ITEM      = 8356,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM    = 8357,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM = 8358,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP     = 8359,  -- You already possess that temporary item.
        NO_COMBINATION           = 8364,  -- You were unable to enter a combination.
        REGIME_REGISTERED        = 10604, -- New training regime registered!
        COMMON_SENSE_SURVIVAL    = 12633, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        NAA_ZEKU_THE_UNWAITING_PH =
        {
            [17264763] = 17264768,
        },
        PATRIPATAN_PH       =
        {
            [17264967] = 17264972, -- 551.767, -32.570, 590.205
            [17264968] = 17264972, -- 646.199, -24.483, 644.477
            [17264969] = 17264972, -- 535.318, -32.179, 602.055
        },
        DAGGERCLAW_DRACOS_PH =
        {
            [17264815] = 17264818, -- 583.725 -15.652 -388.159
        },
        WARAXE_BEAK         = 17264828,
        COO_KEJA_THE_UNSEEN = 17264946,
    },
    npc =
    {
        CASKET_BASE   = 17265218,
        OVERSEER_BASE = 17265270, -- Chegourt_RK in npc_list
    },
}

return zones[tpz.zone.MERIPHATAUD_MOUNTAINS]
