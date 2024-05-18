-----------------------------------
-- Area: Fort_Karugo-Narugo_[S]
-----------------------------------
zones = zones or {}

zones[xi.zone.FORT_KARUGO_NARUGO_S] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6404, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        SPONDULIX_SHOP_DIALOG         = 7219, -- Spondulix comes all the way from Boodlix's Emporium to help Tarutaru and Mithra. I can help you, too! You have gil, no?
        CAMPAIGN_RESULTS_TALLIED      = 7601, -- Campaign results tallied.
        LOGGING_IS_POSSIBLE_HERE      = 7686, -- Logging is possible here if you have <item>.
        ITEM_DELIVERY_DIALOG          = 8125, -- Deliveries! We're open for business!
        COMMON_SENSE_SURVIVAL         = 9204, -- It appears that you have arrived at a new survival guide provided by the Servicemen's Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        RATATOSKR                = GetFirstID('Ratatoskr'),
        KIRTIMUKHA               = GetFirstID('Kirtimukha'),
        DEMOISELLE_DESOLEE       = GetFirstID('Demoiselle_Desolee'),
        TIGRESS_STRIKES_WAR_LYNX = GetFirstID('War_Lynx'),
    },
    npc =
    {
        CAMPAIGN_NPC_OFFSET = GetFirstID('Caulaise_RK'), -- San, Bas, Win, Flag +4, CA
        INDESCRIPT_MARKINGS = GetFirstID('Indescript_Markings'),
        LOGGING             = GetTableOfIDs('Logging_Point'),
    },
}

return zones[xi.zone.FORT_KARUGO_NARUGO_S]
