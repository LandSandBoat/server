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
        IRON_GATE_LOCKED              = 7101, -- A solid iron gate. It is tightly locked...
        PARTY_MEMBERS_HAVE_FALLEN     = 7414, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7421, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        CONQUEST_BASE                 = 7437, -- Tallying conquest results...
        TENZEN_MSG_OFFSET             = 7928, -- You will fall to my blade!
        MAKKI_CHEBUKKI_OFFSET         = 7932, -- Samurai Sky Pirate Power!
        KUKKI_CHEBUKKI_OFFSET         = 7937, -- What? Nooo!
        CHERUKIKI_OFFSET              = 7943, -- We're doomed!
    },
    mob =
    {
        ONE_TO_BE_FEARED_OFFSET = GetFirstID('Mammet-22_Zeta'),
        OMEGA_OFFSET            = GetFirstID('Omega'),
        WARRIORS_PATH_OFFSET    = GetFirstID('Tenzen'),
    },
    npc =
    {
        AIRSHIP_DOOR_OFFSET = GetFirstID('Airship_Door'),
    },
}

return zones[xi.zone.SEALIONS_DEN]
