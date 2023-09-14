-----------------------------------
-- Area: Riverne-Site_B01
-----------------------------------
zones = zones or {}

zones[xi.zone.RIVERNE_SITE_B01] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6404, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7060, -- Tallying conquest results...
        PARTY_MEMBERS_HAVE_FALLEN     = 7569, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7576, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        SD_VERY_SMALL                 = 7597, -- The spatial displacement is very small. If you only had some item that could make it bigger...
        SD_HAS_GROWN                  = 7598, -- The spatial displacement has grown.
        SPACE_SEEMS_DISTORTED         = 7599, -- The space around you seems oddly distorted and disrupted.
        MONUMENT                      = 7605, -- Something has been engraved on this stone, but the message is too difficult to make out.
        GROUND_GIVING_HEAT            = 7607, -- The ground here is giving off heat.
        BAHAMUT_TAUNT                 = 7675, -- Children of Vana'diel, what do you think to accomplish by fighting for your lives? You know your efforts are futile, yet still you resist...
        HOMEPOINT_SET                 = 7711, -- Home point set!
        UNITY_WANTED_BATTLE_INTERACT  = 7769, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
    },
    mob =
    {
        IMDUGUD_PH       =
        {
            [16896101] = 16896107, -- 650.770 20.052 676.513
            [16896102] = 16896107, -- 643.308 20.049 652.354
            [16896103] = 16896107, -- 669.574 19.215 623.129
            [16896104] = 16896107, -- 691.504 21.296 583.884
            [16896105] = 16896107, -- 687.199 21.161 582.560
            [16896106] = 16896107, -- 666.737 20.012 652.352
        },
        UNSTABLE_CLUSTER = 16896155,
    },
    npc =
    {
        DISPLACEMENT_OFFSET = 16896183,
    },
}

return zones[xi.zone.RIVERNE_SITE_B01]
