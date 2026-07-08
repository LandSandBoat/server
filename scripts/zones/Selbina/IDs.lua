-----------------------------------
-- Area: Selbina
-----------------------------------
zones = zones or {}

zones[xi.zone.SELBINA] =
{
    text =
    {
        ASSIST_CHANNEL                = 6380, -- You will be able to use the Assist Channel until #/#/# at #:# (JST).
        ITEM_CANNOT_BE_OBTAINED       = 6386, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6394, -- Obtained: <item>.
        GIL_OBTAINED                  = 6395, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6397, -- Obtained key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL           = 6399, -- You do not have enough gil.
        CARRIED_OVER_POINTS           = 6433, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 6434, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 6435, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 6455, -- Your party is unable to participate because certain members' levels are restricted.
        HOMEPOINT_SET                 = 6502, -- Home point set!
        FISHING_MESSAGE_OFFSET        = 6577, -- You can't fish here.
        NOMAD_MOOGLE_DIALOG           = 6678, -- I'm a traveling moogle, kupo. I help adventurers in the Outlands access items they have stored in a Mog House elsewhere, kupo.
        SUBJOB_UNLOCKED               = 6881, -- You can now designate a support job.
        DONT_HAVE_ENOUGH_GIL          = 6904, -- You don't have enough gil.
        FERRY_ARRIVING                = 7030, -- Attention, passengers! The ship to Mhaura is here and ready to board!
        FERRY_DEPARTING               = 7032, -- All aboard!
        HERMINIA_SHOP_DIALOG          = 7055, -- Hello there. What can I do for you?
        TORAPIONT_SHOP_DIALOG         = 7056, -- Arm yourself before you step outside.
        DOHDJUMA_SHOP_DIALOG          = 7057, -- I'm Dohdjuma, and I sell all kinds of things.
        CLOTHCRAFT_SHOP_DIALOG        = 7058, -- Welcome to the Weavers' Guild salesroom.
        FISHING_SHOP_DIALOG           = 7059, -- Welcome to the Fishermen's Guild salesroom.
        QUELPIA_SHOP_DIALOG           = 7060, -- In need of otherworldly protection?
        CHUTARMIRE_SHOP_DIALOG        = 7061, -- I have items for those who delve in the black arts!
        FALGIMA_SHOP_DIALOG           = 7062, -- In the market for spells, hexes, and incantations? Well, you've come to the right place!
        CONQUEST_BASE                 = 7126, -- Tallying conquest results...
        ABELARD_DIALOG                = 7386, -- I'm Abelard, mayor of this village.
        WENZEL_DELIVERY_DIALOG        = 7609, -- My independent survey confirms the town entrance as the preferred location from which adventurers send parcels.
        BORIS_DELIVERY_DIALOG         = 7610, -- My independent survey confirms the inn as the preferred location from which adventurers send parcels.
        INSUFFICIENT_GIL              = 7643, -- You don't seem to have enough gil...
        RETRIEVE_DIALOG_ID            = 7770, -- You retrieve <item> from the porter moogle's care.
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
