-----------------------------------
-- Area: Carpenters_Landing
-----------------------------------
zones = zones or {}

zones[xi.zone.CARPENTERS_LANDING] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6386, -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE    = 6390, -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 6394, -- Obtained: <item>.
        GIL_OBTAINED                  = 6395, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6397, -- Obtained key item: <keyitem>.
        ITEMS_OBTAINED                = 6403, -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY       = 6408, -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6423, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7005, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7006, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7007, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7027, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7072, -- Tallying conquest results...
        YOU_WISH_TO_KNOW_MISTALLE     = 7247, -- You wish to know of the Knights Mistalle?
        SQUASH_ANOTHER_WORM           = 7248, -- You're just like everyone else! A maggot looking for a scandal! Well, it's time for me to squash another worm!
        BEGONE_TRESPASSER             = 7267, -- Begone, trespasser! This land belongs to the Knights Mi- This land belongs to Count Teulomme!
        CRYPTONBERRY_FALLEN_TREE      = 7269, -- A tree has fallen here...
        CRYPTONBERRY_EXECUTOR_POP     = 7270, -- You feel a wave of hatred wash over you!
        FISHING_MESSAGE_OFFSET        = 7293, -- You can't fish here.
        LOGGING_IS_POSSIBLE_HERE      = 7411, -- Logging is possible here if you have <item>.
        BEUGUNGEL_SHOP_DIALOG         = 7443, -- Hello, [sir/ma'am]! I'm selling goods direct from the Carpenters' Guild.
        TOO_POOR                      = 7449, -- I'm sorry, [sir/madame]. You don't have enough gil to purchase a ticket.
        BARGE_TICKET_REMAINING        = 7462, -- You use your %. (# trip[/s] remaining)
        BARGE_TICKET_USED             = 7463, -- You use up your %.
        BARGE_TICKET_ADDED            = 7464, -- # ticket[/s] [was/were] added to your %.
        STENCH_OF_DECAY               = 7493, -- You are overwhelmed by the putrid stench of decay!
        CRYPTONBERRY_EXECUTOR_DIE     = 7495, -- ...Cleave our foesss with barren hate.
        CRYPTONBERRY_ASSASSIN_2HR     = 7496, -- ..Take up thy lanternsss. The truth we shall illuminate.
        CRYPTONBERRY_EXECUTOR_2HR     = 7497, -- Through this we ssseek our just reward...
        POLISH_MUSHROOM_SPORE         = 7498, -- You polish the <keyitem> with the glowing mushroom spores!
        CATCH_HIS_BREATH              = 7499, -- Bullheaded Grosvez pauses to catch his breath.
        MYCOPHILE_MUSHROOM            = 7514, -- There is a rotten mushroom here. There are 3 openings in its cap.
        HERCULES_TREE_NOTHING_YET     = 7516, -- There is nothing here yet. Check again in the morning.
        UNITY_WANTED_BATTLE_INTERACT  = 7559, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        COMMON_SENSE_SURVIVAL         = 7581, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        BULLHEADED_GROSVEZ    = GetFirstID('Bullheaded_Grosvez'),
        CRYPTONBERRY_EXECUTOR = GetFirstID('Cryptonberry_Executor'),
        HERCULES_BEETLE       = GetFirstID('Hercules_Beetle'),
        MYCOPHILE             = GetFirstID('Mycophile'),
        ORCTRAP               = GetFirstID('Orctrap'),
        OVERGROWN_IVY         = GetFirstID('Overgrown_Ivy'),
        PARA                  = GetFirstID('Para'),
        TEMPEST_TIGON         = GetFirstID('Tempest_Tigon'),
    },
    npc =
    {
        HERCULES_BEETLE_TREES = GetTableOfIDs('qm_hercules_beetle'),
        LOGGING               = GetTableOfIDs('Logging_Point'),
    },
}

return zones[xi.zone.CARPENTERS_LANDING]
