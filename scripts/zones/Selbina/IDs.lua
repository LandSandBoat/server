-----------------------------------
-- Area: Selbina
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.SELBINA] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6383, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6389, -- Obtained: <item>.
        GIL_OBTAINED            = 6390, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6392, -- Obtained key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL     = 6394, -- You do not have enough gil.
        CARRIED_OVER_POINTS     = 6428, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 6429, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 6430, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        HOMEPOINT_SET           = 6480, -- Home point set!
        FISHING_MESSAGE_OFFSET  = 6555, -- You can't fish here.
        NOMAD_MOOGLE_DIALOG     = 6655, -- I'm a traveling moogle, kupo. I help adventurers in the Outlands access items they have stored in a Mog House elsewhere, kupo.
        SUBJOB_UNLOCKED         = 6858, -- You can now designate a support job.
        HERMINIA_SHOP_DIALOG    = 7032, -- Hello there. What can I do for you?
        TORAPIONT_SHOP_DIALOG   = 7033, -- Arm yourself before you step outside.
        DOHDJUMA_SHOP_DIALOG    = 7034, -- I'm Dohdjuma, and I sell all kinds of things.
        CLOTHCRAFT_SHOP_DIALOG  = 7035, -- Welcome to the Weavers' Guild salesroom.
        FISHING_SHOP_DIALOG     = 7036, -- Welcome to the Fishermen's Guild salesroom.
        QUELPIA_SHOP_DIALOG     = 7037, -- In need of otherworldly protection?
        CHUTARMIRE_SHOP_DIALOG  = 7038, -- I have items for those who delve in the black arts!
        FALGIMA_SHOP_DIALOG     = 7039, -- In the market for spells, hexes, and incantations? Well, you've come to the right place!
        CONQUEST_BASE           = 7103, -- Tallying conquest results...
        ABELARD_DIALOG          = 7363, -- I'm Abelard, mayor of this village.
        WENZEL_DELIVERY_DIALOG  = 7586, -- My independent survey confirms the town entrance as the preferred location from which adventurers send parcels.
        BORIS_DELIVERY_DIALOG   = 7587, -- My independent survey confirms the inn as the preferred location from which adventurers send parcels.
        RETRIEVE_DIALOG_ID      = 7747, -- You retrieve <item> from the porter moogle's care.
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
