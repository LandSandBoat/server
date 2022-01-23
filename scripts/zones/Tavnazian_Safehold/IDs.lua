-----------------------------------
-- Area: Tavnazian_Safehold
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.TAVNAZIAN_SAFEHOLD] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED        = 6383,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                  = 6389,  -- Obtained: <item>.
        GIL_OBTAINED                   = 6390,  -- Obtained <number> gil.
        KEYITEM_OBTAINED               = 6392,  -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS            = 6428,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY        = 6429,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                   = 6430,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        YOU_LEARNED_TRUST              = 6452,  -- You learned Trust: <name>!
        CONQUEST_BASE                  = 6543,  -- Tallying conquest results...
        REGIME_CANCELED                = 6709,  -- Current training regime canceled.
        HUNT_ACCEPTED                  = 6727,  -- Hunt accepted!
        USE_SCYLDS                     = 6728,  -- You use <number> [scyld/scylds]. Scyld balance: <number>.
        HUNT_RECORDED                  = 6739,  -- You record your hunt.
        OBTAIN_SCYLDS                  = 6741,  -- You obtain <number> [scyld/scylds]! Current balance: <number> [scyld/scylds].
        HUNT_CANCELED                  = 6745,  -- Hunt canceled.
        FISHING_MESSAGE_OFFSET         = 10264, -- You can't fish here.
        NOMAD_MOOGLE_DIALOG            = 10896, -- I'm a traveling moogle, kupo. I help adventurers in the Outlands access items they have stored in a Mog House elsewhere, kupo.
        NILEROUCHE_SHOP_DIALOG         = 10904, -- Hello, traveler! Please have a look at these fine Tavnazian-built products!
        MAZUROOOZURO_SHOP_DIALOG       = 10905, -- Hidely-howdy-ho! I'll sell you what I've got if you fork over enough dough!
        KOMALATA_SHOP_DIALOG           = 10906, -- Do you need any Tavnazian produce? We don't have much, but find a fine cook and your problems will be solved!
        CAIPHIMONRIDE_SHOP_DIALOG      = 10909, -- Welcome! Thanks to the supplies from Jeuno, I've been able to fix some of the weapons I had in storage!
        MELLEUPAUX_SHOP_DIALOG         = 10911, -- Hello! With the arrival of supplies from Jeuno, we are now able to sell some of the items we had stored in these warehouses.
        MISSEULIEU_SHOP_DIALOG         = 10913, -- Greetings, adventurer! I've been given authorization to begin the sale of the old Tavnazian armor we had in storage!
        MIGRAN_SHOP_DIALOG             = 10915, -- Please, [sir/ma'am]. Even with the aid from Jeuno, I still have trouble feeding my six children...
        ITEM_DELIVERY_DIALOG           = 10922, -- I can send your items to anywhere in Vana'diel!
        HOMEPOINT_SET                  = 10925, -- Home point set!
        YOU_CANNOT_ENTER_DYNAMIS       = 11835, -- You cannot enter Dynamis - [Dummy/San d'Oria/Bastok/Windurst/Jeuno/Beaucedine/Xarcabard/Valkurm/Buburimu/Qufim/Tavnazia] for <number> [day/days] (Vana'diel time).
        PLAYERS_HAVE_NOT_REACHED_LEVEL = 11837, -- Players who have not reached level <number> are prohibited from entering Dynamis.
        DYNA_NPC_DEFAULT_MESSAGE       = 11959, -- There is a strange symbol drawn here. A haunting chill sweeps through you as you gaze upon it...
        RETRIEVE_DIALOG_ID             = 12260, -- You retrieve <item> from the porter moogle's care.
        COMMON_SENSE_SURVIVAL          = 13334, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
    },
    npc =
    {
        QM_IN_SEARCH_OF_TRUTH_BASE = 16883860,
    },
}

return zones[xi.zone.TAVNAZIAN_SAFEHOLD]
