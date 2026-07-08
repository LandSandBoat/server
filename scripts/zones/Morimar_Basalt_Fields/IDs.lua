-----------------------------------
-- Area: Morimar_Basalt_Fields
-----------------------------------
zones = zones or {}

zones[xi.zone.MORIMAR_BASALT_FIELDS] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6386, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6394, -- Obtained: <item>.
        GIL_OBTAINED                  = 6395, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6397, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6408, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS           = 7005, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7006, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7007, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        BAYLD_OBTAINED                = 7011, -- You have obtained <number> bayld!
        YOU_HAVE_LEARNED              = 7019, -- You have learned <keyitem>!
        MEMBERS_LEVELS_ARE_RESTRICTED = 7027, -- Your party is unable to participate because certain members' levels are restricted.
        WAYPOINT_ATTUNED              = 7611, -- Your <keyitem> has been attuned to a geomagnetic fount[/ at the frontier station/ at Frontier Bivouac #1/ at Frontier Bivouac #2/ at Frontier Bivouac #3/ at Frontier Bivouac #4/ at Frontier Bivouac #5]!
        EXPENDED_KINETIC_UNITS        = 7620, -- You have expended <number> kinetic unit[/s] and will be transported to another locale.
        INSUFFICIENT_UNITS            = 7621, -- Your stock of kinetic units is insufficient.
        REACHED_KINETIC_UNIT_LIMIT    = 7622, -- You have reached your limit of kinetic units and cannot charge your artifact any further.
        CANNOT_RECEIVE_KINETIC        = 7623, -- There is no response. You apparently cannot receive kinetic units from this item.
        ARTIFACT_HAS_BEEN_CHARGED     = 7624, -- Your artifact has been charged with <number> kinetic unit[/s]. Your current stock of kinetic units totals <number>.
        ARTIFACT_TERMINAL_VOLUME      = 7625, -- Your artifact has been charged to its terminal volume of kinetic units.
        SURPLUS_LOST_TO_AETHER        = 7626, -- A surplus of <number> kinetic unit[/s] has been lost to the aether.
        LEARNS_SPELL                  = 7874, -- <name> learns <spell>!
        UNCANNY_SENSATION             = 7876, -- You are assaulted by an uncanny sensation.
        RIVER_UNSUITABLE_FOR_SWIMMING = 7885, -- This river is not suitable for swimming.
        SHARP_THORNS_PROTRUDE         = 8037, -- Sharp thorns protrude from the surface.
        HOMEPOINT_SET                 = 8190, -- Home point set!
    },
    mob =
    {
        REIVE_MOB_OFFSET = GetFirstID('Bedrock_Crag'),
    },
    npc =
    {
        CASTOFF_POINT_OFFSET   = GetFirstID('Castoff_Point'),
        REIVE_COLLISION_OFFSET = GetFirstID('_7d0'),
        SCALABLE_AREA_OFFSET   = GetFirstID('Scalable_Area'),
    },
}

return zones[xi.zone.MORIMAR_BASALT_FIELDS]
