-----------------------------------
-- Area: Wajaom_Woodlands
-----------------------------------
zones = zones or {}

zones[xi.zone.WAJAOM_WOODLANDS] =
{
    text =
    {
        NOTHING_HAPPENS               = 119,  -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6385, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6391, -- Obtained: <item>.
        GIL_OBTAINED                  = 6392, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6394, -- Obtained key item: <keyitem>.
        WARHORSE_HOOFPRINT            = 6401, -- You find the hoofprint of a gigantic warhorse...
        ITEM_RETURNED                 = 6403, -- The <item> is returned to you.
        FELLOW_MESSAGE_OFFSET         = 6420, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7002, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7003, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7004, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7024, -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7064, -- You can't fish here.
        DIG_THROW_AWAY                = 7077, -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                  = 7079, -- You dig and you dig, but find nothing.
        FOUND_ITEM_WITH_EASE          = 7154, -- It appears your chocobo found this item with ease.
        PLACE_HYDROGAUGE              = 7357, -- You set the <item> in the glowing trench.
        ENIGMATIC_LIGHT               = 7358, -- The <item> is giving off an enigmatic light.
        LEYPOINT                      = 7413, -- An eerie red glow emanates from this stone platform. The surrounding air feels alive with energy...
        HARVESTING_IS_POSSIBLE_HERE   = 7421, -- Harvesting is possible here if you have <item>.
        WELLSPRING                    = 7466, -- The water in this spring is an unusual color...
        FORGIVE_I_WILL_NOT            = 7471, -- Forgive, I will not. My pet, you hurt!
        GIWAHB_WATCHTOWER_LOCKED      = 8003, -- The door is locked...
        INCREASED_STANDING            = 8004, -- Your Imperial Standing has increased!
        HEADY_FRAGRANCE               = 8508, -- The heady fragrance of wine pervades the air...
        BROKEN_SHARDS                 = 8510, -- Broken shards of insect wing are scattered all over...
        PAMAMA_PEELS                  = 8512, -- Piles of pamama peels litter the ground...
        DRAWS_NEAR                    = 8538, -- Something draws near!
        COMMON_SENSE_SURVIVAL         = 9656, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        UNITY_WANTED_BATTLE_INTERACT  = 9720, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
    },
    mob =
    {
        CHIGOES =
        {
            ['Marid'] = GetTableOfIDs('Chigoe', 5),
        },
        JADED_JODY             = GetFirstID('Jaded_Jody'),
        ZORAAL_JAS_PKUUCHA     = GetFirstID('Zoraal_Jas_Pkuucha'),
        PERCIPIENT_ZORAAL_JA   = GetFirstID('Percipient_Zoraal_Ja'),
        VULPANGUE              = GetFirstID('Vulpangue'),
        IRIZ_IMA               = GetFirstID('Iriz_Ima'),
        GOTOH_ZHA_THE_REDOLENT = GetFirstID('Gotoh_Zha_the_Redolent'),
        TINNIN                 = GetFirstID('Tinnin'),
    },
    npc =
    {
        HARVESTING = GetTableOfIDs('Harvesting_Point'),
        HOOFPRINT  = GetFirstID('Warhorse_Hoofprint'),
        WELLSPRING = GetFirstID('Mythralline_Wellspring')
    },
}

return zones[xi.zone.WAJAOM_WOODLANDS]
