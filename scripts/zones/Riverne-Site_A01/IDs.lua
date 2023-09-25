-----------------------------------
-- Area: Riverne-Site_A01
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.RIVERNE_SITE_A01] =
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
        A_GLOWING_MIST                = 7255, -- A glowing mist of ever-changing proportions floats before you...
        PARTY_MEMBERS_HAVE_FALLEN     = 7569, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7576, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        SD_VERY_SMALL                 = 7599, -- The spatial displacement is very small. If you only had some item that could make it bigger...
        SD_HAS_GROWN                  = 7600, -- The spatial displacement has grown.
        SPACE_SEEMS_DISTORTED         = 7601, -- The space around you seems oddly distorted and disrupted.
        MONUMENT                      = 7608, -- Something has been engraved on this stone, but the message is too difficult to make out.
        TRUNK                         = 7666, -- Closely examining the trunk reveals a tiny keyhole. You would need a tiny key to open it.
        INSECT_WINGS                  = 7732, -- There are tiny insect wings scattered all around here.
        HOMEPOINT_SET                 = 7736, -- Home point set!
        UNITY_WANTED_BATTLE_INTERACT  = 7794, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
    },
    mob =
    {
        AIATAR_PH =
        {
            [16900305] = 16900306,
        },
        ZIRYU =
        {
            16900315,
            16900316,
            16900317,
            16900318,
        },
        HELIODROMOS =
        {
            16900110,
            16900111,
            16900112,
        },
        HELIODROMOS_PH_OFFSET    = 16900107,
        HELIODROMOS_OFFSET       = 16900110,
        CARMINE_DOBSONFLY_OFFSET = 16900230,
        SHIELDTRAP               = 16900320,
        ARCANE_PHANTASM          = 16900319,
    },
    npc =
    {
        DISPLACEMENT_OFFSET = 16900334,
        SPATIAL_OURYU       = 16900358,
        STONE_MONUMENT      = 16900374,
    },
}

return zones[xi.zone.RIVERNE_SITE_A01]
