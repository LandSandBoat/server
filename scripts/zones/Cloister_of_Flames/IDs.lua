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
        ITEM_CANNOT_BE_OBTAINED          = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                    = 6390, -- Obtained: <item>.
        GIL_OBTAINED                     = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED                 = 6393, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS              = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY          = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                     = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE                    = 7057, -- Tallying conquest results...
        YOU_CANNOT_ENTER_THE_BATTLEFIELD = 7218, -- You cannot enter the battlefield at present. Please wait a little longer.
        PROTOCRYSTAL                     = 7242, -- It is a giant crystal.
        PARTY_MEMBERS_HAVE_FALLEN        = 7562, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED        = 7569, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        IFRIT_UNLOCKED                   = 7576, -- You are now able to summon [Ifrit/Titan/Leviathan/Garuda/Shiva/Ramuh].
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[xi.zone.CLOISTER_OF_FLAMES]
