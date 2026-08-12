-----------------------------------
-- Area: Cloister_of_Gales
-----------------------------------
zones = zones or {}

zones[xi.zone.CLOISTER_OF_GALES] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED          = 6387, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                    = 6395, -- Obtained: <item>.
        GIL_OBTAINED                     = 6396, -- Obtained <number> gil.
        KEYITEM_OBTAINED                 = 6398, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS              = 7006, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY          = 7007, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                     = 7008, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED    = 7028, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                    = 7073, -- Tallying conquest results...
        YOU_CANNOT_ENTER_THE_BATTLEFIELD = 7234, -- You cannot enter the battlefield at present. Please wait a little longer.
        PROTOCRYSTAL                     = 7258, -- It is a giant crystal.
        MEMBERS_OF_YOUR_PARTY            = 7543, -- Currently, # members of your party (including yourself) have clearance to enter the battlefield.
        MEMBERS_OF_YOUR_ALLIANCE         = 7544, -- Currently, # members of your alliance (including yourself) have clearance to enter the battlefield.
        TIME_LIMIT_FOR_THIS_BATTLE_IS    = 7546, -- The time limit for this battle is <number> minutes.
        PARTY_MEMBERS_HAVE_FALLEN        = 7582, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED        = 7589, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        GARUDA_UNLOCKED                  = 7592, -- You are now able to summon [Ifrit/Titan/Leviathan/Garuda/Shiva/Ramuh].
        ENTERING_THE_BATTLEFIELD_FOR     = 7680, -- Entering the battlefield for [Trial by Wind/Carbuncle Debacle/Trial-Size Trial by Wind/Waking the Beast/Sugar-coated Directive/★Trial by Wind]!
        ATTACH_SEAL                      = 7776, -- <player> attaches <item> to the protocrystal.
        POWER_STYMIES                    = 7777, -- An unseen power stymies your efforts to attach <item> to the protocrystal.
    },
    mob =
    {
        GARUDA_PRIME_ASA   = GetFirstID('Garuda_Prime_ASA'),
        OGMIOS             = GetFirstID('Ogmios'),
    },
    npc =
    {
    },
}

return zones[xi.zone.CLOISTER_OF_GALES]
