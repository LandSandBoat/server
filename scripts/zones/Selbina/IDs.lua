-----------------------------------
-- Area: Selbina
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.SELBINA] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6388, -- Obtained: <item>.
        GIL_OBTAINED            = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6391, -- Obtained key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL     = 6393, -- You do not have enough gil.
        CARRIED_OVER_POINTS     = 6427, -- You have carried over <number> points.
        LOGIN_CAMPAIGN_UNDERWAY = 6428, -- The <month> ≺year≻ Login Campaign is currently underway!
        LOGIN_NUMBER            = 6429, -- In celebration of your most recent login no. <number>...
        HOMEPOINT_SET           = 6479, -- Home point set!
        FISHING_MESSAGE_OFFSET  = 6554, -- You can't fish here.
        NOMAD_MOOGLE_DIALOG     = 6654, -- I'm a traveling moogle, kupo. I help adventurers in the Outlands access items they have stored in a Mog House elsewhere, kupo.
        SUBJOB_UNLOCKED         = 6857, -- You can now designate a support job.
        HERMINIA_SHOP_DIALOG    = 7031, -- Hello there. What can I do for you?
        TORAPIONT_SHOP_DIALOG   = 7032, -- Arm yourself before you step outside.
        DOHDJUMA_SHOP_DIALOG    = 7033, -- I'm Dohdjuma, and I sell all kinds of things.
        CLOTHCRAFT_SHOP_DIALOG  = 7034, -- Welcome to the Weavers' Guild salesroom.
        FISHING_SHOP_DIALOG     = 7035, -- Welcome to the Fishermen's Guild salesroom.
        QUELPIA_SHOP_DIALOG     = 7036, -- In need of otherworldly protection?
        CHUTARMIRE_SHOP_DIALOG  = 7037, -- I have items for those who delve in the black arts!
        FALGIMA_SHOP_DIALOG     = 7038, -- In the market for spells, hexes, and incantations? Well, you've come to the right place!
        CONQUEST_BASE           = 7102, -- Tallying conquest results...
        WENZEL_DELIVERY_DIALOG  = 7585, -- My independent survey confirms the town entrance as the preferred location from which adventurers send parcels.
        BORIS_DELIVERY_DIALOG   = 7586, -- My independent survey confirms the inn as the preferred location from which adventurers send parcels.
        RETRIEVE_DIALOG_ID      = 7746, -- You retrieve <item> from the porter moogle's care.
    },
    mob =
    {
    },
    npc =
    {
        EXPLORER_MOOGLE = 17793131,
    },
}

return zones[tpz.zone.SELBINA]
