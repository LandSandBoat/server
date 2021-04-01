-----------------------------------
-- Area: Chateau_dOraguille
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[ xi.zone.CHATEAU_DORAGUILLE] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6591, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6597, -- Obtained: <item>.
        GIL_OBTAINED            = 6598, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6600, -- Obtained key item: <keyitem>.
        KEYITEM_LOST            = 6601, -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL     = 6602, -- You do not have enough gil.
        CARRIED_OVER_POINTS     = 6636, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 6637, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 6638, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        YOU_LEARNED_TRUST       = 6660, -- You learned Trust: <name>!
        HALVER_OFFSET           = 6794, -- The princess is always speaking of your deeds for the Kingdom. Everyone here is counting on you, <name>.
        LIGHTBRINGER_EXTRA      = 6837, -- Lightbringer has been found! This is the happiest day in my tenure as monarlais!
        CONQUEST_BASE           = 6880, -- Tallying conquest results...
        TOMBSTONE               = 7173, -- Here lies the beloved Queen Leaute. May Her Majesty's soul find Paradise.
        HEIR_TO_LIGHT_EXTRA     = 7791, -- <name>! I never doubted your ability on the front line. We are truly in your debt. Proceed to the Audience Chamber. His Highness awaits!
        SAVAGE_BLADE_LEARNED    = 7941, -- You have learned the weapon skill Savage Blade!
        CELEBRATORY_GOODS       = 8453, -- An assortment of celebratory goods is available for purchase.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[ xi.zone.CHATEAU_DORAGUILLE]
