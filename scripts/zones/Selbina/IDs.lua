-----------------------------------
-- Area: Selbina
-----------------------------------
zones = zones or {}

zones[xi.zone.SELBINA] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6385, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6391, -- Obtained: <item>.
        GIL_OBTAINED                  = 6392, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6394, -- Obtained key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL           = 6396, -- You do not have enough gil.
        CARRIED_OVER_POINTS           = 6430, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 6431, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 6432, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 6452, -- Your party is unable to participate because certain members' levels are restricted.
        HOMEPOINT_SET                 = 6498, -- Home point set!
        FISHING_MESSAGE_OFFSET        = 6573, -- You can't fish here.
        NOMAD_MOOGLE_DIALOG           = 6673, -- I'm a traveling moogle, kupo. I help adventurers in the Outlands access items they have stored in a Mog House elsewhere, kupo.
        SUBJOB_UNLOCKED               = 6876, -- You can now designate a support job.
        DONT_HAVE_ENOUGH_GIL          = 6899, -- You don't have enough gil.
        FERRY_ARRIVING                = 7025, -- Attention, passengers! The ship to Mhaura is here and ready to board!
        FERRY_DEPARTING               = 7027, -- All aboard!
        HERMINIA_SHOP_DIALOG          = 7050, -- Hello there. What can I do for you?
        TORAPIONT_SHOP_DIALOG         = 7051, -- Arm yourself before you step outside.
        DOHDJUMA_SHOP_DIALOG          = 7052, -- I'm Dohdjuma, and I sell all kinds of things.
        CLOTHCRAFT_SHOP_DIALOG        = 7053, -- Welcome to the Weavers' Guild salesroom.
        FISHING_SHOP_DIALOG           = 7054, -- Welcome to the Fishermen's Guild salesroom.
        QUELPIA_SHOP_DIALOG           = 7055, -- In need of otherworldly protection?
        CHUTARMIRE_SHOP_DIALOG        = 7056, -- I have items for those who delve in the black arts!
        FALGIMA_SHOP_DIALOG           = 7057, -- In the market for spells, hexes, and incantations? Well, you've come to the right place!
        CONQUEST_BASE                 = 7121, -- Tallying conquest results...
        ABELARD_DIALOG                = 7381, -- I'm Abelard, mayor of this village.
        WENZEL_DELIVERY_DIALOG        = 7604, -- My independent survey confirms the town entrance as the preferred location from which adventurers send parcels.
        BORIS_DELIVERY_DIALOG         = 7605, -- My independent survey confirms the inn as the preferred location from which adventurers send parcels.
        INSUFFICIENT_GIL              = 7638, -- You don't seem to have enough gil...
        RETRIEVE_DIALOG_ID            = 7765, -- You retrieve <item> from the porter moogle's care.
    },
    mob =
    {
    },
    npc =
    {
        EXPLORER_MOOGLE = GetFirstID('Explorer_Moogle'),
    },
}

return zones[xi.zone.SELBINA]
