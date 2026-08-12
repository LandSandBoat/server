-----------------------------------
-- Area: Tavnazian_Safehold
-----------------------------------
zones = zones or {}

zones[xi.zone.TAVNAZIAN_SAFEHOLD] =
{
    text =
    {
        ASSIST_CHANNEL                 = 6380,  -- You will be able to use the Assist Channel until #/#/# at #:# (JST).
        ITEM_CANNOT_BE_OBTAINED        = 6387,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                  = 6395,  -- Obtained: <item>.
        GIL_OBTAINED                   = 6396,  -- Obtained <number> gil.
        KEYITEM_OBTAINED               = 6398,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY        = 6409,  -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS            = 6434,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY        = 6435,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                   = 6436,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED  = 6456,  -- Your party is unable to participate because certain members' levels are restricted.
        YOU_LEARNED_TRUST              = 6458,  -- You learned Trust: <name>!
        CONQUEST_BASE                  = 6560,  -- Tallying conquest results...
        REGIME_CANCELED                = 6726,  -- Current training regime canceled.
        HUNT_ACCEPTED                  = 6744,  -- Hunt accepted!
        USE_SCYLDS                     = 6745,  -- You use <number> [scyld/scylds]. Scyld balance: <number>.
        HUNT_RECORDED                  = 6756,  -- You record your hunt.
        OBTAIN_SCYLDS                  = 6758,  -- You obtain <number> [scyld/scylds]! Current balance: <number> [scyld/scylds].
        HUNT_CANCELED                  = 6762,  -- Hunt canceled.
        FISHING_MESSAGE_OFFSET         = 10281, -- You can't fish here.
        NOMAD_MOOGLE_DIALOG            = 10914, -- I'm a traveling moogle, kupo. I help adventurers in the Outlands access items they have stored in a Mog House elsewhere, kupo.
        NILEROUCHE_SHOP_DIALOG         = 10922, -- Hello, traveler! Please have a look at these fine Tavnazian-built products!
        MAZUROOOZURO_SHOP_DIALOG       = 10923, -- Hidely-howdy-ho! I'll sell you what I've got if you fork over enough dough!
        KOMALATA_SHOP_DIALOG           = 10924, -- Do you need any Tavnazian produce? We don't have much, but find a fine cook and your problems will be solved!
        CAIPHIMONRIDE_SHOP_DIALOG      = 10927, -- Welcome! Thanks to the supplies from Jeuno, I've been able to fix some of the weapons I had in storage!
        MELLEUPAUX_SHOP_DIALOG         = 10929, -- Hello! With the arrival of supplies from Jeuno, we are now able to sell some of the items we had stored in these warehouses.
        MISSEULIEU_SHOP_DIALOG         = 10931, -- Greetings, adventurer! I've been given authorization to begin the sale of the old Tavnazian armor we had in storage!
        MIGRAN_SHOP_DIALOG             = 10933, -- Please, [sir/ma'am]. Even with the aid from Jeuno, I still have trouble feeding my six children...
        COMPLETELY_BARE                = 10934, -- The safehold warehouses used to store a great amount of equipment and supplies. However, now the rooms are almost completely bare...
        LITTLE_TO_WATCH_OVER           = 10935, -- I have been assigned to watch over the supplies in these storage rooms, though there is little to watch over...
        CONTACT_WITH_THE_MAINLAND      = 10936, -- If we could only make contact with the mainland... Then, maybe, the day would come when these warehouses are filled with goods from all over Vana'diel.
        KEEP_INVENTORY                 = 10937, -- My job is to keep inventory of these items. However, I have to count really, really slow or I finish in ten minutes!
        LOTS_OF_STORAGE                = 10939, -- Little food... Little supplies... The one thing Tavnazia does have a lot of, though, is storage space! <Sigh>
        ITEM_DELIVERY_DIALOG           = 10940, -- I can send your items to anywhere in Vana'diel!
        HOMEPOINT_SET                  = 10943, -- Home point set!
        DOOR_IS_LOCKED_TIGHT           = 11040, -- The door is locked tight.
        CRUSE_ON_THE_GROUND            = 11769, -- There is a <keyitem> lying on the ground here! <player> obtains the <keyitem>!
        TRAIL_OF_WATER                 = 11770, -- There is a trail of water here. It is still fresh.
        YOU_CANNOT_ENTER_DYNAMIS       = 11853, -- You cannot enter Dynamis - [Dummy/San d'Oria/Bastok/Windurst/Jeuno/Beaucedine/Xarcabard/Valkurm/Buburimu/Qufim/Tavnazia] for <number> [day/days] (Vana'diel time).
        PLAYERS_HAVE_NOT_REACHED_LEVEL = 11855, -- Players who have not reached level <number> are prohibited from entering Dynamis.
        DYNA_NPC_DEFAULT_MESSAGE       = 11977, -- There is a strange symbol drawn here. A haunting chill sweeps through you as you gaze upon it...
        RETRIEVE_DIALOG_ID             = 12278, -- You retrieve <item> from the porter moogle's care.
        COMMON_SENSE_SURVIVAL          = 13352, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
    },
    npc =
    {
        QM1_IN_SEARCH_OF_TRUTH_BASE = GetFirstID('qm1_in_search_of_truth'),
        QM2_IN_SEARCH_OF_TRUTH_BASE = GetFirstID('qm2_in_search_of_truth'),
        QM3_IN_SEARCH_OF_TRUTH_BASE = GetFirstID('qm3_in_search_of_truth'),
        QM4_IN_SEARCH_OF_TRUTH_BASE = GetFirstID('qm4_in_search_of_truth'),
        QM5_IN_SEARCH_OF_TRUTH_BASE = GetFirstID('qm5_in_search_of_truth'),
    },
}

return zones[xi.zone.TAVNAZIAN_SAFEHOLD]
