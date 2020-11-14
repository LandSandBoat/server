-----------------------------------
-- Area: Fort_Karugo-Narugo_[S]
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.FORT_KARUGO_NARUGO_S] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED  = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED            = 6388, -- Obtained: <item>.
        GIL_OBTAINED             = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED         = 6391, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY  = 6402, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS      = 6999, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY  = 7000, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER             = 7001, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        SPONDULIX_SHOP_DIALOG    = 7204, -- Spondulix comes all the way from Boodlix's Emporium to help Tarutaru and Mithra. I can help you, too! You have gil, no?
        LOGGING_IS_POSSIBLE_HERE = 7671, -- Logging is possible here if you have <item>.
        ITEM_DELIVERY_DIALOG     = 8110, -- Deliveries! We're open for business!
        COMMON_SENSE_SURVIVAL    = 9189, -- It appears that you have arrived at a new survival guide provided by the Servicemen's Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        RATATOSKR_PH =
        {
            [17170472] = 17170475,
        },
        KIRTIMUKHA_PH =
        {
            [17170491] = 17170499,
            [17170492] = 17170499,
            [17170493] = 17170499,
            [17170494] = 17170499,
            [17170495] = 17170499,
            [17170496] = 17170499,
            [17170498] = 17170499,
        },
        DEMOISELLE_DESOLEE_PH =
        {
            [17170577] = 17170569,
        },
        TIGRESS_STRIKES_WAR_LYNX = 17170645,
    },
    npc =
    {
        INDESCRIPT_MARKINGS = 17171272,
        LOGGING =
        {
            17171239,
            17171240,
            17171241,
            17171242,
            17171243,
            17171244,
        },
    },
}

return zones[tpz.zone.FORT_KARUGO_NARUGO_S]
