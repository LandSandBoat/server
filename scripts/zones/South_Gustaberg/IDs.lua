-----------------------------------
-- Area: South_Gustaberg
-----------------------------------
zones = zones or {}

zones[xi.zone.SOUTH_GUSTABERG] =
{
    text =
    {
        NOTHING_HAPPENS               = 141,  -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6408, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6416, -- Obtained: <item>.
        GIL_OBTAINED                  = 6417, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6419, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6430, -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6445, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7027, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7028, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7029, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7049, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7094, -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET        = 7253, -- You can't fish here.
        DIG_THROW_AWAY                = 7266, -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                  = 7268, -- You dig and you dig, but find nothing.
        FOUND_ITEM_WITH_EASE          = 7343, -- It appears your chocobo found this item with ease.
        MONSTER_TRACKS                = 7424, -- You see monster tracks on the ground.
        MONSTER_TRACKS_FRESH          = 7425, -- You see fresh monster tracks on the ground.
        FIRE_GOOD                     = 7428, -- The fire seems to be good enough for cooking.
        FIRE_PUT                      = 7429, -- You put <item> in the fire.
        FIRE_TAKE                     = 7430, -- You take <item> out of the fire.
        FIRE_LONGER                   = 7431, -- It may take a little while more to cook the <item>.
        MEAT_ALREADY_PUT              = 7432, -- The <item> is already in the fire.
        ITEMS_ITEMS_LA_LA             = 7531, -- You can hear a strange voice... Items, items, la la la la la
        GOBLIN_SLIPPED_AWAY           = 7537, -- The Goblin slipped away when you were not looking...
        PLAYER_OBTAINS_ITEM           = 7551, -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 7552, -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 7553, -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 7554, -- You already possess that temporary item.
        NO_COMBINATION                = 7559, -- You were unable to enter a combination.
        UNITY_WANTED_BATTLE_INTERACT  = 7621, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        TIME_ELAPSED                  = 7703, -- Time elapsed: <number> [hour/hours] (Vana'diel time) <number> [minute/minutes] and <number> [second/seconds] (Earth time)
        REGIME_REGISTERED             = 9921, -- New training regime registered!
    },
    mob =
    {
        CARNERO       = GetTableOfIDs('Carnero'),
        LEAPING_LIZZY = GetTableOfIDs('Leaping_Lizzy'),
        BUBBLY_BERNIE = GetFirstID('Bubbly_Bernie'),
    },
    npc =
    {
    },
}

return zones[xi.zone.SOUTH_GUSTABERG]
