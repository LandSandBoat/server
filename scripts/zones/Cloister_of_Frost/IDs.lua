-----------------------------------
-- Area: Cloister_of_Frost
-----------------------------------
zones = zones or {}

zones[xi.zone.CLOISTER_OF_FROST] =
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
        CONQUEST_BASE                    = 7067, -- Tallying conquest results...
        YOU_CANNOT_ENTER_THE_BATTLEFIELD = 7228, -- You cannot enter the battlefield at present. Please wait a little longer.
        TIME_IN_THE_BATTLEFIELD_IS_UP    = 7231, -- Your time in the battlefield is up! Now exiting...
        PARTY_MEMBERS_ARE_ENGAGED        = 7246, -- The battlefield where your party members are engaged in combat is locked. Access is denied.
        PROTOCRYSTAL                     = 7252, -- It is a giant crystal.
        MEMBERS_OF_YOUR_PARTY            = 7537, -- Currently, # members of your party (including yourself) have clearance to enter the battlefield.
        MEMBERS_OF_YOUR_ALLIANCE         = 7538, -- Currently, # members of your alliance (including yourself) have clearance to enter the battlefield.
        TIME_LIMIT_FOR_THIS_BATTLE_IS    = 7540, -- The time limit for this battle is <number> minutes.
        PARTY_MEMBERS_HAVE_FALLEN        = 7576, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED        = 7583, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        SHIVA_UNLOCKED                   = 7586, -- You are now able to summon [Ifrit/Titan/Leviathan/Garuda/Shiva/Ramuh].
        ENTERING_THE_BATTLEFIELD_FOR     = 7674, -- Entering the battlefield for [Trial by Ice/Class Reunion/Trial-Size Trial by Ice/Waking the Beast/Sugar-coated Directive/Trial by Ice]!
        CANNOT_REMOVE_FRAG               = 7682, -- It is an oddly shaped stone monument. A shining stone is embedded in it, but cannot be removed...
        ALREADY_OBTAINED_FRAG            = 7683, -- You have already obtained this monument's <keyitem>. Try searching for another.
        ALREADY_HAVE_ALL_FRAGS           = 7684, -- You have obtained all of the fragments. You must hurry to the ruins of the ancient shrine!
        FOUND_ALL_FRAGS                  = 7685, -- You have obtained <keyitem>! You now have all 8 fragments of light!
        ZILART_MONUMENT                  = 7686, -- It is an ancient Zilart monument.
        ATTACH_SEAL                      = 7785, -- <player> attaches <item> to the protocrystal.
        POWER_STYMIES                    = 7786, -- An unseen power stymies your efforts to attach <item> to the protocrystal.
    },
    mob =
    {
        DRYAD             = GetFirstID('Dryad'),
        SHIVA_PRIME_ASA   = GetFirstID('Shiva_Prime_ASA')
    },
    npc =
    {
    },
}

return zones[xi.zone.CLOISTER_OF_FROST]
