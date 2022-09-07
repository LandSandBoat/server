-----------------------------------
-- Area: Bearclaw_Pinnacle
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.BEARCLAW_PINNACLE] =
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
        PARTY_MEMBERS_HAVE_FALLEN     = 7407, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7414, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        ZEPHYR_RIPS                   = 7422, -- The <item> rips!
        CONQUEST_BASE                 = 7429, -- Tallying conquest results...
        BLOWN_AWAY                    = 7615, -- The explosion has blown you out of the area!
        BEGINS_TO_MELT                = 7672, -- The Snoll Tzar has begun to melt!
        LARGE_STEAM                   = 7673, -- The Snoll Tzar is emitting a large amount of steam.
        SHOOK_SALT                    = 7674, -- The Snoll Tzar shakes off the salt!
    },
    mob =
    {
        SNOLL_TZAR_OFFSET = 16801793,
    },
    npc =
    {
        ENTRANCE_OFFSET = 16801888,
    },
}

return zones[xi.zone.BEARCLAW_PINNACLE]
