-----------------------------------
-- Area: Cloister_of_Flames
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.CLOISTER_OF_FLAMES] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED          = 6383, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                    = 6389, -- Obtained: <item>.
        GIL_OBTAINED                     = 6390, -- Obtained <number> gil.
        KEYITEM_OBTAINED                 = 6392, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS              = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY          = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                     = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE                    = 7053, -- Tallying conquest results...
        YOU_CANNOT_ENTER_THE_BATTLEFIELD = 7214, -- You cannot enter the battlefield at present. Please wait a little longer.
        PROTOCRYSTAL                     = 7238, -- It is a giant crystal.
        IFRIT_UNLOCKED                   = 7572, -- You are now able to summon [Ifrit/Titan/Leviathan/Garuda/Shiva/Ramuh].
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[xi.zone.CLOISTER_OF_FLAMES]
