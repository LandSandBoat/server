-----------------------------------
-- Area: Selbina
-----------------------------------
zones = zones or {}

zones[xi.zone.SELBINA] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL           = 6395, -- You do not have enough gil.
        CARRIED_OVER_POINTS           = 6429, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 6430, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 6431, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 6451, -- Your party is unable to participate because certain members' levels are restricted.
        HOMEPOINT_SET                 = 6491, -- Home point set!
        FISHING_MESSAGE_OFFSET        = 6566, -- You can't fish here.
        NOMAD_MOOGLE_DIALOG           = 6666, -- I'm a traveling moogle, kupo. I help adventurers in the Outlands access items they have stored in a Mog House elsewhere, kupo.
        SUBJOB_UNLOCKED               = 6869, -- You can now designate a support job.
        DONT_HAVE_ENOUGH_GIL          = 6892, -- You don't have enough gil.
        FERRY_ARRIVING                = 7018, -- Attention, passengers! The ship to Mhaura is here and ready to board!
        FERRY_DEPARTING               = 7020, -- All aboard!
        HERMINIA_SHOP_DIALOG          = 7043, -- Hello there. What can I do for you?
        TORAPIONT_SHOP_DIALOG         = 7044, -- Arm yourself before you step outside.
        DOHDJUMA_SHOP_DIALOG          = 7045, -- I'm Dohdjuma, and I sell all kinds of things.
        CLOTHCRAFT_SHOP_DIALOG        = 7046, -- Welcome to the Weavers' Guild salesroom.
        FISHING_SHOP_DIALOG           = 7047, -- Welcome to the Fishermen's Guild salesroom.
        QUELPIA_SHOP_DIALOG           = 7048, -- In need of otherworldly protection?
        CHUTARMIRE_SHOP_DIALOG        = 7049, -- I have items for those who delve in the black arts!
        FALGIMA_SHOP_DIALOG           = 7050, -- In the market for spells, hexes, and incantations? Well, you've come to the right place!
        CONQUEST_BASE                 = 7114, -- Tallying conquest results...
        ABELARD_DIALOG                = 7374, -- I'm Abelard, mayor of this village.
        WENZEL_DELIVERY_DIALOG        = 7597, -- My independent survey confirms the town entrance as the preferred location from which adventurers send parcels.
        BORIS_DELIVERY_DIALOG         = 7598, -- My independent survey confirms the inn as the preferred location from which adventurers send parcels.
        RETRIEVE_DIALOG_ID            = 7758, -- You retrieve <item> from the porter moogle's care.
    },
    mob =
    {
    },
    npc =
    {
        EXPLORER_MOOGLE = 17793131,
    },
}

return zones[xi.zone.SELBINA]
