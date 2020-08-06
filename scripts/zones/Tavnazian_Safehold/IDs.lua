-----------------------------------
-- Area: Tavnazian_Safehold
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.TAVNAZIAN_SAFEHOLD] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED        = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                  = 6388, -- Obtained: <item>.
        GIL_OBTAINED                   = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED               = 6391, -- Obtained key item: <keyitem>.
        CONQUEST_BASE                  = 6536, -- Tallying conquest results...
        REGIME_CANCELED                = 6702, -- Current training regime canceled.
        HUNT_ACCEPTED                  = 6720, -- Hunt accepted!
        USE_SCYLDS                     = 6721, -- You use <number> [scyld/scylds]. Scyld balance: <number>.
        HUNT_RECORDED                  = 6732, -- You record your hunt.
        OBTAIN_SCYLDS                  = 6734, -- You obtain <number> [scyld/scylds]! Current balance: <number> [scyld/scylds].
        HUNT_CANCELED                  = 6738, -- Hunt canceled.
        FISHING_MESSAGE_OFFSET         = 10257, -- You can't fish here.
        NOMAD_MOOGLE_DIALOG            = 10889, -- I'm a traveling moogle, kupo. I help adventurers in the Outlands access items they have stored in a Mog House elsewhere, kupo.
        NILEROUCHE_SHOP_DIALOG         = 10897, -- Hello, traveler! Please have a look at these fine Tavnazian-built products!
        MAZUROOOZURO_SHOP_DIALOG       = 10898, -- Hidely-howdy-ho! I'll sell you what I've got if you fork over enough dough!
        KOMALATA_SHOP_DIALOG           = 10899, -- Do you need any Tavnazian produce? We don't have much, but find a fine cook and your problems will be solved!
        CAIPHIMONRIDE_SHOP_DIALOG      = 10902, -- Welcome! Thanks to the supplies from Jeuno, I've been able to fix some of the weapons I had in storage!
        MELLEUPAUX_SHOP_DIALOG         = 10904, -- Hello! With the arrival of supplies from Jeuno, we are now able to sell some of the items we had stored in these warehouses.
        MISSEULIEU_SHOP_DIALOG         = 10906, -- Greetings, adventurer! I've been given authorization to begin the sale of the old Tavnazian armor we had in storage!
        MIGRAN_SHOP_DIALOG             = 10908, -- Please, [sir/ma'am]. Even with the aid from Jeuno, I still have trouble feeding my six children...
        ITEM_DELIVERY_DIALOG           = 10915, -- I can send your items to anywhere in Vana'diel!
        HOMEPOINT_SET                  = 10918, -- Home point set!
        YOU_CANNOT_ENTER_DYNAMIS       = 11828, -- You cannot enter Dynamis - [Dummy/San d'Oria/Bastok/Windurst/Jeuno/Beaucedine/Xarcabard/Valkurm/Buburimu/Qufim/Tavnazia] for <number> [day/days] (Vana'diel time).
        DYNA_NPC_DEFAULT_MESSAGE       = 11829, -- You hear a mysterious, floating voice: The guiding aura has not yet faded... Bring forth the <item>.
        PLAYERS_HAVE_NOT_REACHED_LEVEL = 11830, -- Players who have not reached level <number> are prohibited from entering Dynamis.
        RETRIEVE_DIALOG_ID             = 12253, -- You retrieve <item> from the porter moogle's care.
        COMMON_SENSE_SURVIVAL          = 13327, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[tpz.zone.TAVNAZIAN_SAFEHOLD]
