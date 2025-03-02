-----------------------------------
-- Area: Carpenters_Landing
-----------------------------------
zones = zones or {}

zones[xi.zone.CARPENTERS_LANDING] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE    = 6388, -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        ITEMS_OBTAINED                = 6399, -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY       = 6404, -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6419, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7067, -- Tallying conquest results...
        YOU_WISH_TO_KNOW_MISTALLE     = 7242, -- You wish to know of the Knights Mistalle?
        SQUASH_ANOTHER_WORM           = 7243, -- You're just like everyone else! A maggot looking for a scandal! Well, it's time for me to squash another worm!
        BEGONE_TRESPASSER             = 7262, -- Begone, trespasser! This land belongs to the Knights Mi- This land belongs to Count Teulomme!
        CRYPTONBERRY_FALLEN_TREE      = 7264, -- A tree has fallen here...
        CRYPTONBERRY_EXECUTOR_POP     = 7265, -- You feel a wave of hatred wash over you!
        FISHING_MESSAGE_OFFSET        = 7288, -- You can't fish here.
        LOGGING_IS_POSSIBLE_HERE      = 7405, -- Logging is possible here if you have <item>.
        BEUGUNGEL_SHOP_DIALOG         = 7437, -- Hello, [sir/ma'am]! I'm selling goods direct from the Carpenters' Guild.
        STENCH_OF_DECAY               = 7487, -- You are overwhelmed by the putrid stench of decay!
        CRYPTONBERRY_EXECUTOR_DIE     = 7489, -- ...Cleave our foesss with barren hate.
        CRYPTONBERRY_ASSASSIN_2HR     = 7490, -- ..Take up thy lanternsss. The truth we shall illuminate.
        CRYPTONBERRY_EXECUTOR_2HR     = 7491, -- Through this we ssseek our just reward...
        POLISH_MUSHROOM_SPORE         = 7492, -- You polish the <keyitem> with the glowing mushroom spores!
        MYCOPHILE_MUSHROOM            = 7508, -- There is a rotten mushroom here. There are 3 openings in its cap.
        HERCULES_TREE_NOTHING_YET     = 7510, -- There is nothing here yet. Check again in the morning.
        UNITY_WANTED_BATTLE_INTERACT  = 7553, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        COMMON_SENSE_SURVIVAL         = 7575, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        ORCTRAP               = GetFirstID('Orctrap'),
        TEMPEST_TIGON         = GetFirstID('Tempest_Tigon'),
        OVERGROWN_IVY         = GetFirstID('Overgrown_Ivy'),
        CRYPTONBERRY_EXECUTOR = GetFirstID('Cryptonberry_Executor'),
        MYCOPHILE             = GetFirstID('Mycophile'),
        HERCULES_BEETLE       = GetFirstID('Hercules_Beetle'),
        PARA                  = GetFirstID('Para'),
    },
    npc =
    {
        HERCULES_BEETLE_TREES = GetTableOfIDs('qm_hercules_beetle'),
        LOGGING               = GetTableOfIDs('Logging_Point'),
    },
}

return zones[xi.zone.CARPENTERS_LANDING]
