-----------------------------------
-- Area: Marjami_Ravine
-----------------------------------
zones = zones or {}

zones[xi.zone.MARJAMI_RAVINE] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6387, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6395, -- Obtained: <item>.
        GIL_OBTAINED                  = 6396, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6398, -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6399, -- Lost key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6409, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS           = 7006, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7007, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7008, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        BAYLD_OBTAINED                = 7012, -- You have obtained <number> bayld!
        YOU_HAVE_LEARNED              = 7020, -- You have learned <keyitem>!
        MEMBERS_LEVELS_ARE_RESTRICTED = 7028, -- Your party is unable to participate because certain members' levels are restricted.
        WAYPOINT_ATTUNED              = 7711, -- Your <keyitem> has been attuned to a geomagnetic fount[/ at the frontier station/ at Frontier Bivouac #1/ at Frontier Bivouac #2/ at Frontier Bivouac #3/ at Frontier Bivouac #4]!
        EXPENDED_KINETIC_UNITS        = 7722, -- You have expended <number> kinetic unit[/s] and will be transported to another locale.
        INSUFFICIENT_UNITS            = 7723, -- Your stock of kinetic units is insufficient.
        REACHED_KINETIC_UNIT_LIMIT    = 7724, -- You have reached your limit of kinetic units and cannot charge your artifact any further.
        CANNOT_RECEIVE_KINETIC        = 7725, -- There is no response. You apparently cannot receive kinetic units from this item.
        ARTIFACT_HAS_BEEN_CHARGED     = 7726, -- Your artifact has been charged with <number> kinetic unit[/s]. Your current stock of kinetic units totals <number>.
        ARTIFACT_TERMINAL_VOLUME      = 7727, -- Your artifact has been charged to its terminal volume of kinetic units.
        SURPLUS_LOST_TO_AETHER        = 7728, -- A surplus of <number> kinetic unit[/s] has been lost to the aether.
        LEATHER_SCRAPS_STREWN         = 7750, -- Leather scraps are strewn about the ground.
        SHARP_THORNS_PROTRUDE         = 7869, -- Sharp thorns protrude from the surface.
        HOMEPOINT_SET                 = 7893, -- Home point set!
        LEARNS_SPELL                  = 8194, -- <name> learns <spell>!
        UNCANNY_SENSATION             = 8196, -- You are assaulted by an uncanny sensation.
    },
    mob =
    {
        REIVE_MOB_OFFSET = GetFirstID('Monolithic_Boulder'),
    },
    npc =
    {
        REIVE_COLLISION_OFFSET = GetFirstID('_7e0'),
        SCALABLE_AREA_OFFSET   = GetFirstID('Scalable_Area_0'),
    },
}

return zones[xi.zone.MARJAMI_RAVINE]
