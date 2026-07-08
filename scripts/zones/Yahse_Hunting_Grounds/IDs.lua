-----------------------------------
-- Area: Yahse_Hunting_Grounds
-----------------------------------
zones = zones or {}

zones[xi.zone.YAHSE_HUNTING_GROUNDS] =
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
        MEMBERS_LEVELS_ARE_RESTRICTED = 7027, -- Your party is unable to participate because certain members' levels are restricted.
        WAYPOINT_ATTUNED              = 7624, -- Your <keyitem> has been attuned to a geomagnetic fount[/ at the frontier station/ at Frontier Bivouac #1/ at Frontier Bivouac #2/ at Frontier Bivouac #3]!
        EXPENDED_KINETIC_UNITS        = 7639, -- You have expended <number> kinetic unit[/s] and will be transported to another locale.
        INSUFFICIENT_UNITS            = 7640, -- Your stock of kinetic units is insufficient.
        REACHED_KINETIC_UNIT_LIMIT    = 7641, -- You have reached your limit of kinetic units and cannot charge your artifact any further.
        CANNOT_RECEIVE_KINETIC        = 7642, -- There is no response. You apparently cannot receive kinetic units from this item.
        ARTIFACT_HAS_BEEN_CHARGED     = 7643, -- Your artifact has been charged with <number> kinetic unit[/s]. Your current stock of kinetic units totals <number>.
        ARTIFACT_TERMINAL_VOLUME      = 7644, -- Your artifact has been charged to its terminal volume of kinetic units.
        SURPLUS_LOST_TO_AETHER        = 7645, -- A surplus of <number> kinetic unit[/s] has been lost to the aether.
        LEARNS_SPELL                  = 7880, -- <name> learns <spell>!
        UNCANNY_SENSATION             = 7882, -- You are assaulted by an uncanny sensation.
        ENERGIES_COURSE               = 7883, -- The arcane energies begin to course within your veins.
        MYSTICAL_WARMTH               = 7884, -- You feel a mystical warmth welling up inside you!
        RIVER_UNSUITABLE_FOR_SWIMMING = 7891, -- This river is not suitable for swimming.
    },
    mob =
    {
        REIVE_MOB_OFFSET = GetFirstID('Knotted_Root'),
    },
    npc =
    {
        CASTOFF_POINT_OFFSET   = GetFirstID('Castoff_Point'),
        REIVE_COLLISION_OFFSET = GetFirstID('_780'),
    },
}

return zones[xi.zone.YAHSE_HUNTING_GROUNDS]
