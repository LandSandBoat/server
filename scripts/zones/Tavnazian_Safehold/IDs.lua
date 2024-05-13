-----------------------------------
-- Area: Tavnazian_Safehold
-----------------------------------
zones = zones or {}

zones[xi.zone.TAVNAZIAN_SAFEHOLD] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED        = 6384,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                  = 6390,  -- Obtained: <item>.
        GIL_OBTAINED                   = 6391,  -- Obtained <number> gil.
        KEYITEM_OBTAINED               = 6393,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY        = 6404,  -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS            = 6429,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY        = 6430,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                   = 6431,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED  = 6451,  -- Your party is unable to participate because certain members' levels are restricted.
        YOU_LEARNED_TRUST              = 6453,  -- You learned Trust: <name>!
        CONQUEST_BASE                  = 6551,  -- Tallying conquest results...
        REGIME_CANCELED                = 6717,  -- Current training regime canceled.
        HUNT_ACCEPTED                  = 6735,  -- Hunt accepted!
        USE_SCYLDS                     = 6736,  -- You use <number> [scyld/scylds]. Scyld balance: <number>.
        HUNT_RECORDED                  = 6747,  -- You record your hunt.
        OBTAIN_SCYLDS                  = 6749,  -- You obtain <number> [scyld/scylds]! Current balance: <number> [scyld/scylds].
        HUNT_CANCELED                  = 6753,  -- Hunt canceled.
        FISHING_MESSAGE_OFFSET         = 10272, -- You can't fish here.
        NOMAD_MOOGLE_DIALOG            = 10904, -- I'm a traveling moogle, kupo. I help adventurers in the Outlands access items they have stored in a Mog House elsewhere, kupo.
        NILEROUCHE_SHOP_DIALOG         = 10912, -- Hello, traveler! Please have a look at these fine Tavnazian-built products!
        MAZUROOOZURO_SHOP_DIALOG       = 10913, -- Hidely-howdy-ho! I'll sell you what I've got if you fork over enough dough!
        KOMALATA_SHOP_DIALOG           = 10914, -- Do you need any Tavnazian produce? We don't have much, but find a fine cook and your problems will be solved!
        CAIPHIMONRIDE_SHOP_DIALOG      = 10917, -- Welcome! Thanks to the supplies from Jeuno, I've been able to fix some of the weapons I had in storage!
        MELLEUPAUX_SHOP_DIALOG         = 10919, -- Hello! With the arrival of supplies from Jeuno, we are now able to sell some of the items we had stored in these warehouses.
        MISSEULIEU_SHOP_DIALOG         = 10921, -- Greetings, adventurer! I've been given authorization to begin the sale of the old Tavnazian armor we had in storage!
        MIGRAN_SHOP_DIALOG             = 10923, -- Please, [sir/ma'am]. Even with the aid from Jeuno, I still have trouble feeding my six children...
        ITEM_DELIVERY_DIALOG           = 10930, -- I can send your items to anywhere in Vana'diel!
        HOMEPOINT_SET                  = 10933, -- Home point set!
        DOOR_IS_LOCKED_TIGHT           = 11030, -- The door is locked tight.
        YOU_CANNOT_ENTER_DYNAMIS       = 11843, -- You cannot enter Dynamis - [Dummy/San d'Oria/Bastok/Windurst/Jeuno/Beaucedine/Xarcabard/Valkurm/Buburimu/Qufim/Tavnazia] for <number> [day/days] (Vana'diel time).
        PLAYERS_HAVE_NOT_REACHED_LEVEL = 11845, -- Players who have not reached level <number> are prohibited from entering Dynamis.
        DYNA_NPC_DEFAULT_MESSAGE       = 11967, -- There is a strange symbol drawn here. A haunting chill sweeps through you as you gaze upon it...
        RETRIEVE_DIALOG_ID             = 12268, -- You retrieve <item> from the porter moogle's care.
        COMMON_SENSE_SURVIVAL          = 13342, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
    },
    npc =
    {
        QM_IN_SEARCH_OF_TRUTH_BASE = GetFirstID('qm_in_search_of_truth'),
    },
}

return zones[xi.zone.TAVNAZIAN_SAFEHOLD]
