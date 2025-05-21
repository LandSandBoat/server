-----------------------------------
-- Area: Sealions_Den
-----------------------------------
zones = zones or {}

zones[xi.zone.SEALIONS_DEN] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6385, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6391, -- Obtained: <item>.
        GIL_OBTAINED                  = 6392, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6394, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7002, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7003, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7004, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7024, -- Your party is unable to participate because certain members' levels are restricted.
        TIME_IN_THE_BATTLEFIELD_IS_UP = 7073, -- Your time in the battlefield is up! Now exiting...
        PARTY_MEMBERS_ARE_ENGAGED     = 7088, -- The battlefield where your party members are engaged in combat is locked. Access is denied.
        IRON_GATE_LOCKED              = 7105, -- A solid iron gate. It is tightly locked...
        MEMBERS_OF_YOUR_PARTY         = 7379, -- Currently, # members of your party (including yourself) have clearance to enter the battlefield.
        MEMBERS_OF_YOUR_ALLIANCE      = 7380, -- Currently, # members of your alliance (including yourself) have clearance to enter the battlefield.
        TIME_LIMIT_FOR_THIS_BATTLE_IS = 7382, -- The time limit for this battle is <number> minutes.
        PARTY_MEMBERS_HAVE_FALLEN     = 7418, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7425, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        CONQUEST_BASE                 = 7441, -- Tallying conquest results...
        ENTERING_THE_BATTLEFIELD_FOR  = 7604, -- Entering the battlefield for [One to Be Feared/The Warrior's Path/The Warrior's Path/One to Be Feared]!
        TENZEN_MSG_OFFSET             = 7932, -- You will fall to my blade!
        MAKKI_CHEBUKKI_OFFSET         = 7936, -- Samurai Sky Pirate Power!
        KUKKI_CHEBUKKI_OFFSET         = 7941, -- What? Nooo!
        CHERUKIKI_OFFSET              = 7947, -- We're doomed!
    },
    mob =
    {
        MAMMET_22_ZETA = GetFirstID('Mammet-22_Zeta'),
        TENZEN         = GetFirstID('Tenzen'),
    },
    npc =
    {
        AIRSHIP_DOOR_OFFSET = GetFirstID('Airship_Door'),
    },
}

return zones[xi.zone.SEALIONS_DEN]
