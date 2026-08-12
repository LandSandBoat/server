-----------------------------------
-- Area: Ceizak Battlegrounds (261)
-----------------------------------
zones = zones or {}

zones[xi.zone.CEIZAK_BATTLEGROUNDS] =
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
        MEMBERS_LEVELS_ARE_RESTRICTED = 7028, -- Your party is unable to participate because certain members' levels are restricted.
        WAYPOINT_ATTUNED              = 7605, -- Your <keyitem> has been attuned to a geomagnetic fount[/ at the frontier station/ at Frontier Bivouac #1/ at Frontier Bivouac #2/ at Frontier Bivouac #3]!
        EXPENDED_KINETIC_UNITS        = 7620, -- You have expended <number> kinetic unit[/s] and will be transported to another locale.
        INSUFFICIENT_UNITS            = 7621, -- Your stock of kinetic units is insufficient.
        REACHED_KINETIC_UNIT_LIMIT    = 7622, -- You have reached your limit of kinetic units and cannot charge your artifact any further.
        CANNOT_RECEIVE_KINETIC        = 7623, -- There is no response. You apparently cannot receive kinetic units from this item.
        ARTIFACT_HAS_BEEN_CHARGED     = 7624, -- Your artifact has been charged with <number> kinetic unit[/s]. Your current stock of kinetic units totals <number>.
        ARTIFACT_TERMINAL_VOLUME      = 7625, -- Your artifact has been charged to its terminal volume of kinetic units.
        SURPLUS_LOST_TO_AETHER        = 7626, -- A surplus of <number> kinetic unit[/s] has been lost to the aether.
        HOMEPOINT_SET                 = 7808, -- Home point set!
        MONSTER_APPEAR                = 8031, -- A monster appears!
        SPRING_STEP                   = 8039, -- The spring has returned to your step.
        LEARNS_SPELL                  = 8051, -- <name> learns <spell>!
        UNCANNY_SENSATION             = 8053, -- You are assaulted by an uncanny sensation.
        ENERGIES_COURSE               = 8054, -- The arcane energies begin to course within your veins.
        MYSTICAL_WARMTH               = 8055, -- You feel a mystical warmth welling up inside you!
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
