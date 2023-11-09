-----------------------------------
-- Area: Cloister_of_Gales
-----------------------------------
zones = zones or {}

zones[xi.zone.CLOISTER_OF_GALES] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED          = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                    = 6390, -- Obtained: <item>.
        GIL_OBTAINED                     = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED                 = 6393, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS              = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY          = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                     = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED    = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                    = 7061, -- Tallying conquest results...
        YOU_CANNOT_ENTER_THE_BATTLEFIELD = 7222, -- You cannot enter the battlefield at present. Please wait a little longer.
        PROTOCRYSTAL                     = 7246, -- It is a giant crystal.
        PARTY_MEMBERS_HAVE_FALLEN        = 7570, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED        = 7577, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        GARUDA_UNLOCKED                  = 7580, -- You are now able to summon [Ifrit/Titan/Leviathan/Garuda/Shiva/Ramuh].
        ATTACH_SEAL                      = 7764, -- <player> attaches <item> to the protocrystal.
        POWER_STYMIES                    = 7765, -- An unseen power stymies your efforts to attach <item> to the protocrystal.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[xi.zone.CLOISTER_OF_GALES]
