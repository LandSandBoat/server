-----------------------------------
-- Area: Empyreal_Paradox
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.EMPYREAL_PARADOX] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6388, -- Obtained: <item>.
        GIL_OBTAINED            = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6391, -- Obtained key item: <keyitem>.
        CONQUEST_BASE           = 7420, -- Tallying conquest results...
        PRISHE_TEXT             = 7685, -- You're about to learn how strong the will to live makes us!
        SELHTEUS_TEXT           = 7698, -- The...Emptiness... Is this...how it was meant...to be...?
        PROMATHIA_TEXT          = 7701, -- Give thyself to the apathy within...
        QM_TEXT                 = 7799, -- The air before you appears warped and distored...
    },
    mob =
    {
        PROMATHIA_OFFSET = 16924673,
    },
    npc =
    {
    },
}

return zones[tpz.zone.EMPYREAL_PARADOX]
