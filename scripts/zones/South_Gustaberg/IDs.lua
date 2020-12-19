-----------------------------------
-- Area: South_Gustaberg
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.SOUTH_GUSTABERG] =
{
    text =
    {
        NOTHING_HAPPENS          = 141,  -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED  = 6404, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED            = 6410, -- Obtained: <item>.
        GIL_OBTAINED             = 6411, -- Obtained <number> gil.
        KEYITEM_OBTAINED         = 6413, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY  = 6424, -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET    = 6439, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS      = 7021, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY  = 7022, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER             = 7023, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE            = 7071, -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET   = 7230, -- You can't fish here.
        DIG_THROW_AWAY           = 7243, -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING             = 7245, -- You dig and you dig, but find nothing.
        MONSTER_TRACKS           = 7400, -- You see monster tracks on the ground.
        MONSTER_TRACKS_FRESH     = 7401, -- You see fresh monster tracks on the ground.
        FIRE_GOOD                = 7404, -- The fire seems to be good enough for cooking.
        FIRE_PUT                 = 7405, -- You put <item> in the fire.
        FIRE_TAKE                = 7406, -- You take <item> out of the fire.
        FIRE_LONGER              = 7407, -- It may take a little while more to cook the <item>.
        MEAT_ALREADY_PUT         = 7408, -- The <item> is already in the fire.
        ITEMS_ITEMS_LA_LA        = 7523, -- You can hear a strange voice... Items, items, la la la la la
        GOBLIN_SLIPPED_AWAY      = 7529, -- The Goblin slipped away when you were not looking...
        PLAYER_OBTAINS_ITEM      = 7543, -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM    = 7544, -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM = 7545, -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP     = 7546, -- You already possess that temporary item.
        NO_COMBINATION           = 7551, -- You were unable to enter a combination.
        REGIME_REGISTERED        = 9911, -- New training regime registered!
    },
    mob =
    {
        CARNERO_PH       =
        {
            [17215638] = 17215626, -- 277.891 -39.854 -413.354
            [17215611] = 17215626, -- 186.081 -39.990 -367.942
            [17215612] = 17215626, -- 164.245 -39.900 -347.878
            [17215624] = 17215626, -- 160.304 -39.990 -460.400
            [17215625] = 17215626, -- 201.021 -39.904 -500.721
            [17215646] = 17215626, -- 275.135 -39.977 -477.840
            [17215645] = 17215626, -- 274.561 -39.972 -476.762
            [17215648] = 17215626, -- 213.010 -59.983 -442.766
            [17215649] = 17215626, -- 211.745 -59.938 -441.313
        },
        LEAPING_LIZZY_PH =
        {
            [17215867] = 17215868, -- -275.441 20.451 -347.294
            [17215887] = 17215888, -- -322.871 30.052 -401.184
        },
        BUBBLY_BERNIE    = 17215494,
    },
    npc =
    {
        CASKET_BASE = 17216139,
    },
}

return zones[tpz.zone.SOUTH_GUSTABERG]
