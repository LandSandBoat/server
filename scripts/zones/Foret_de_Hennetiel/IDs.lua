-----------------------------------
-- Area: Foret_de_Hennetiel
-----------------------------------
zones = zones or {}

zones[xi.zone.FORET_DE_HENNETIEL] =
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
        BAYLD_OBTAINED                = 7008, -- You have obtained <number> bayld!
        YOU_HAVE_LEARNED              = 7016, -- You have learned <keyitem>!
        MEMBERS_LEVELS_ARE_RESTRICTED = 7024, -- Your party is unable to participate because certain members' levels are restricted.
        STARTED_TO_LEARN_BOAT         = 7529, -- You have started to learn a bit about how to operate your boat.
        FIGURED_OUT_BOAT              = 7530, -- You have figured out how to properly use the boat! Report your progress to Choubollet.
        WAYPOINT_ATTUNED              = 7688, -- Your <keyitem> has been attuned to a geomagnetic fount[/ at the frontier station/ at Frontier Bivouac #1/ at Frontier Bivouac #2/ at Frontier Bivouac #3/ at Frontier Bivouac #4]!
        EXPENDED_KINETIC_UNITS        = 7699, -- You have expended <number> kinetic unit[/s] and will be transported to another locale.
        INSUFFICIENT_UNITS            = 7700, -- Your stock of kinetic units is insufficient.
        REACHED_KINETIC_UNIT_LIMIT    = 7701, -- You have reached your limit of kinetic units and cannot charge your artifact any further.
        CANNOT_RECEIVE_KINETIC        = 7702, -- There is no response. You apparently cannot receive kinetic units from this item.
        ARTIFACT_HAS_BEEN_CHARGED     = 7703, -- Your artifact has been charged with <number> kinetic unit[/s]. Your current stock of kinetic units totals <number>.
        ARTIFACT_TERMINAL_VOLUME      = 7704, -- Your artifact has been charged to its terminal volume of kinetic units.
        SURPLUS_LOST_TO_AETHER        = 7705, -- A surplus of <number> kinetic unit[/s] has been lost to the aether.
        LEARNS_SPELL                  = 7942, -- <name> learns <spell>!
        UNCANNY_SENSATION             = 7944, -- You are assaulted by an uncanny sensation.
        HOMEPOINT_SET                 = 8016, -- Home point set!
    },
    mob =
    {
        REIVE_MOB_OFFSET = GetFirstID('Broadleaf_Palm'),
    },
    npc =
    {
        REIVE_COLLISION_OFFSET = GetFirstID('_7a0'),
    },
}

return zones[xi.zone.FORET_DE_HENNETIEL]
