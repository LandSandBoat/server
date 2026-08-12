-----------------------------------
-- Area: Foret_de_Hennetiel
-----------------------------------
zones = zones or {}

zones[xi.zone.FORET_DE_HENNETIEL] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6387, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6395, -- Obtained: <item>.
        GIL_OBTAINED                  = 6396, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6398, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7006, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7007, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7008, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        BAYLD_OBTAINED                = 7012, -- You have obtained <number> bayld!
        YOU_HAVE_LEARNED              = 7020, -- You have learned <keyitem>!
        MEMBERS_LEVELS_ARE_RESTRICTED = 7028, -- Your party is unable to participate because certain members' levels are restricted.
        STARTED_TO_LEARN_BOAT         = 7535, -- You have started to learn a bit about how to operate your boat.
        FIGURED_OUT_BOAT              = 7536, -- You have figured out how to properly use the boat! Report your progress to Choubollet.
        WAYPOINT_ATTUNED              = 7694, -- Your <keyitem> has been attuned to a geomagnetic fount[/ at the frontier station/ at Frontier Bivouac #1/ at Frontier Bivouac #2/ at Frontier Bivouac #3/ at Frontier Bivouac #4]!
        EXPENDED_KINETIC_UNITS        = 7705, -- You have expended <number> kinetic unit[/s] and will be transported to another locale.
        INSUFFICIENT_UNITS            = 7706, -- Your stock of kinetic units is insufficient.
        REACHED_KINETIC_UNIT_LIMIT    = 7707, -- You have reached your limit of kinetic units and cannot charge your artifact any further.
        CANNOT_RECEIVE_KINETIC        = 7708, -- There is no response. You apparently cannot receive kinetic units from this item.
        ARTIFACT_HAS_BEEN_CHARGED     = 7709, -- Your artifact has been charged with <number> kinetic unit[/s]. Your current stock of kinetic units totals <number>.
        ARTIFACT_TERMINAL_VOLUME      = 7710, -- Your artifact has been charged to its terminal volume of kinetic units.
        SURPLUS_LOST_TO_AETHER        = 7711, -- A surplus of <number> kinetic unit[/s] has been lost to the aether.
        LEARNS_SPELL                  = 7948, -- <name> learns <spell>!
        UNCANNY_SENSATION             = 7950, -- You are assaulted by an uncanny sensation.
        RIVER_UNSUITABLE_FOR_SWIMMING = 7959, -- This river is not suitable for swimming.
        HOMEPOINT_SET                 = 8022, -- Home point set!
    },
    mob =
    {
        REIVE_MOB_OFFSET = GetFirstID('Broadleaf_Palm'),
    },
    npc =
    {
        CASTOFF_POINT_OFFSET   = GetFirstID('Castoff_Point_0'),
        REIVE_COLLISION_OFFSET = GetFirstID('_7a0'),
    },
}

return zones[xi.zone.FORET_DE_HENNETIEL]
