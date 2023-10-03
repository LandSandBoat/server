-----------------------------------
-- Area: Sealions_Den
-----------------------------------
zones = zones or {}

zones[xi.zone.SEALIONS_DEN] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        IRON_GATE_LOCKED              = 7097, -- A solid iron gate. It is tightly locked...
        PARTY_MEMBERS_HAVE_FALLEN     = 7410, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7417, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        CONQUEST_BASE                 = 7432, -- Tallying conquest results...
        TENZEN_MSG_OFFSET             = 7923, -- You will fall to my blade!
        MAKKI_CHEBUKKI_OFFSET         = 7927, -- Samurai Sky Pirate Power!
        KUKKI_CHEBUKKI_OFFSET         = 7932, -- What? Nooo!
        CHERUKIKI_OFFSET              = 7938, -- We're doomed!
    },
    mob =
    {
        ONE_TO_BE_FEARED_OFFSET = 16908289,
        OMEGA_OFFSET = 16908294,
        WARRIORS_PATH_OFFSET    = 16908310,
    },
    npc =
    {
        AIRSHIP_DOOR_OFFSET = 16908420,
    },
    aWarriorsPath =
    {
        TENZEN_ID         = 16908310,
        MAKKI_SHAKKI_ID   = 16908311,
        KUKKI_CHEBUKKI_ID = 16908312,
        CHERUKKI_ID       = 16908313,
    },
}

return zones[xi.zone.SEALIONS_DEN]
