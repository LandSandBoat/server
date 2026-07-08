-----------------------------------
-- Area: Sealions_Den
-----------------------------------
zones = zones or {}

zones[xi.zone.SEALIONS_DEN] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6386, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6394, -- Obtained: <item>.
        GIL_OBTAINED                  = 6395, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6397, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7005, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7006, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7007, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7027, -- Your party is unable to participate because certain members' levels are restricted.
        TIME_IN_THE_BATTLEFIELD_IS_UP = 7077, -- Your time in the battlefield is up! Now exiting...
        PARTY_MEMBERS_ARE_ENGAGED     = 7092, -- The battlefield where your party members are engaged in combat is locked. Access is denied.
        IRON_GATE_LOCKED              = 7109, -- A solid iron gate. It is tightly locked...
        MEMBERS_OF_YOUR_PARTY         = 7383, -- Currently, # members of your party (including yourself) have clearance to enter the battlefield.
        MEMBERS_OF_YOUR_ALLIANCE      = 7384, -- Currently, # members of your alliance (including yourself) have clearance to enter the battlefield.
        TIME_LIMIT_FOR_THIS_BATTLE_IS = 7386, -- The time limit for this battle is <number> minutes.
        PARTY_MEMBERS_HAVE_FALLEN     = 7422, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7429, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        CONQUEST_BASE                 = 7445, -- Tallying conquest results...
        ENTERING_THE_BATTLEFIELD_FOR  = 7608, -- Entering the battlefield for [One to Be Feared/The Warrior's Path/★The Warrior's Path/★One to Be Feared]!
        COSMIC_ELUCIDATION            = 7904, -- You are overwhelmed by Tenzen's Cosmic Elucidation!
        TENZEN_MSG_OFFSET             = 7936, -- You will fall to my blade!
        MAKKI_CHEBUKKI_OFFSET         = 7940, -- Samurai Sky Pirate Power!
        KUKKI_CHEBUKKI_OFFSET         = 7945, -- What? Nooo!
        CHERUKIKI_OFFSET              = 7951, -- We're doomed!
    },
    mob =
    {
        CHERUKIKI      = GetFirstID('Cherukiki'),
        KUKKI_CHEBUKKI = GetFirstID('Kukki-Chebukki'),
        MAKKI_CHEBUKKI = GetFirstID('Makki-Chebukki'),
        MAMMET_22_ZETA = GetFirstID('Mammet-22_Zeta'),
        TENZEN         = GetFirstID('Tenzen'),
    },
    npc =
    {
        AIRSHIP_DOOR_OFFSET = GetFirstID('Airship_Door'),
    },
}

return zones[xi.zone.SEALIONS_DEN]
