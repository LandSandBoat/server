-----------------------------------
-- Area: Ceizak Battlegrounds (261)
-----------------------------------
zones = zones or {}

zones[xi.zone.CEIZAK_BATTLEGROUNDS] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6394, -- Lost key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        WAYPOINT_ATTUNED              = 7598, -- Your <keyitem> has been attuned to a geomagnetic fount[/ at the frontier station/ at Frontier Bivouac #1/ at Frontier Bivouac #2/ at Frontier Bivouac #3]!
        EXPENDED_KINETIC_UNITS        = 7613, -- You have expended <number> kinetic unit[/s] and will be transported to another locale.
        INSUFFICIENT_UNITS            = 7614, -- Your stock of kinetic units is insufficient.
        REACHED_KINETIC_UNIT_LIMIT    = 7615, -- You have reached your limit of kinetic units and cannot charge your artifact any further.
        CANNOT_RECEIVE_KINETIC        = 7616, -- There is no response. You apparently cannot receive kinetic units from this item.
        ARTIFACT_HAS_BEEN_CHARGED     = 7617, -- Your artifact has been charged with <number> kinetic unit[/s]. Your current stock of kinetic units totals <number>.
        ARTIFACT_TERMINAL_VOLUME      = 7618, -- Your artifact has been charged to its terminal volume of kinetic units.
        SURPLUS_LOST_TO_AETHER        = 7619, -- A surplus of <number> kinetic unit[/s] has been lost to the aether.
        HOMEPOINT_SET                 = 7801, -- Home point set!
        MONSTER_APPEAR                = 8024, -- A monster appears!
        SPRING_STEP                   = 8032, -- The spring has returned to your step.
        LEARNS_SPELL                  = 8044, -- <name> learns <spell>!
        UNCANNY_SENSATION             = 8046, -- You are assaulted by an uncanny sensation.
        ENERGIES_COURSE               = 8047, -- The arcane energies begin to course within your veins.
        MYSTICAL_WARMTH               = 8048, -- You feel a mystical warmth welling up inside you!
    },
    mob =
    {
        UNFETTERED_TWITHERYM    = GetFirstID('Unfettered_Twitherym'),
        SUPERNAL_CHAPULI        = GetFirstID('Supernal_Chapuli'),
        TRANSCENDENT_SCORPION   = GetFirstID('Transcendent_Scorpion'),
        MASTOP                  = GetFirstID('Mastop'),
        TAXET                   = GetFirstID('Taxet'),
        REIVE_MOB_OFFSET        = GetFirstID('Knotted_Root'),
    },
    npc =
    {
        REIVE_COLLISION_OFFSET = GetFirstID('_790'),
    },
}

return zones[xi.zone.CEIZAK_BATTLEGROUNDS]
