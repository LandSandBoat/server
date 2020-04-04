-----------------------------------
-- Area: Chateau_dOraguille
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.CHATEAU_DORAGUILLE] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6590, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6596, -- Obtained: <item>.
        GIL_OBTAINED            = 6597, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6599, -- Obtained key item: <keyitem>.
        KEYITEM_LOST            = 6600, -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL     = 6601, -- You do not have enough gil.
        YOU_LEARNED_TRUST       = 6659, -- You learned Trust: <name>!
        HALVER_OFFSET           = 6793, -- The princess is always speaking of your deeds for the Kingdom. Everyone here is counting on you, <name>.
        CONQUEST_BASE           = 6879, -- Tallying conquest results...
        TOMBSTONE               = 7172, -- Here lies the beloved Queen Leaute. May Her Majesty's soul find Paradise.
        SAVAGE_BLADE_LEARNED    = 7940, -- You have learned the weapon skill Savage Blade!
        CELEBRATORY_GOODS       = 8452, -- An assortment of celebratory goods is available for purchase.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[tpz.zone.CHATEAU_DORAGUILLE]
