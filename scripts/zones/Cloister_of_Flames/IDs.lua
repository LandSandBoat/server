-----------------------------------
-- Area: Cloister_of_Flames
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
        LOGIN_CAMPAIGN_UNDERWAY          = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                     = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED    = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                    = 7064, -- Tallying conquest results...
        YOU_CANNOT_ENTER_THE_BATTLEFIELD = 7225, -- You cannot enter the battlefield at present. Please wait a little longer.
        TIME_IN_THE_BATTLEFIELD_IS_UP    = 7228, -- Your time in the battlefield is up! Now exiting...
        PARTY_MEMBERS_ARE_ENGAGED        = 7243, -- The battlefield where your party members are engaged in combat is locked. Access is denied.
        PROTOCRYSTAL                     = 7249, -- It is a giant crystal.
        MEMBERS_OF_YOUR_PARTY            = 7534, -- Currently, # members of your party (including yourself) have clearance to enter the battlefield.
        MEMBERS_OF_YOUR_ALLIANCE         = 7535, -- Currently, # members of your alliance (including yourself) have clearance to enter the battlefield.
        TIME_LIMIT_FOR_THIS_BATTLE_IS    = 7537, -- The time limit for this battle is <number> minutes.
        PARTY_MEMBERS_HAVE_FALLEN        = 7573, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED        = 7580, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        IFRIT_UNLOCKED                   = 7583, -- You are now able to summon [Ifrit/Titan/Leviathan/Garuda/Shiva/Ramuh].
        ENTERING_THE_BATTLEFIELD_FOR     = 7671, -- Entering the battlefield for [Trial by Fire/Trial-Size Trial by Fire/Waking the Beast/Sugar-coated Directive/Trial by Fire]!
        ATTACH_SEAL                      = 7730, -- <player> attaches <item> to the protocrystal.
        POWER_STYMIES                    = 7731, -- An unseen power stymies your efforts to attach <item> to the protocrystal.
    },
    mob =
    {
        IFRIT_PRIME     = GetFirstID('Ifrit_Prime_Trial'),
        IFRIT_PRIME_ASA = GetFirstID('Ifrit_Prime_ASA'),
    },
    npc =
    {
    },
}

return zones[xi.zone.CLOISTER_OF_FLAMES]
