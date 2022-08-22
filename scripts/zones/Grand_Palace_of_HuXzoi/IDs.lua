-----------------------------------
-- Area: Grand_Palace_of_HuXzoi
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.GRAND_PALACE_OF_HUXZOI] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6390, -- Obtained: <item>.
        GIL_OBTAINED            = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6393, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS     = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE           = 7079, -- Tallying conquest results...
        DOES_NOT_RESPOND        = 7243, -- The gate does not respond...
        DUTY_COMPLETE           = 7366, -- Transfer of final security portal access duty complete.
        PORTAL_EAST             = 7369, -- You hear a portal open to the east...
        PORTAL_WEST             = 7370, -- You hear a portal open to the west...
        PORTAL_NORTH            = 7371, -- You hear a portal open to the north...
        TIME_EXCEEDED           = 7372, -- Patrol routine time restriction exceeded. Patrol aborted.
        RECOMMENCING_PATROL     = 7374, -- Recommencing patrol.
        HOMEPOINT_SET           = 7461, -- Home point set!
    },
    quasilumin_text =
    {
        [16916897] = 7369,
        [16916898] = 7370,
        [16916899] = 7371,
        [16916900] = 7372,
        [16916901] = 7373,
        [16916902] = 7374,
        [16916903] = 7375,
        [16916904] = 7376,
        [16916905] = 7377,
        [16916906] = 7378,
    },
    mob =
    {
        JAILER_OF_TEMPERANCE_PH =
        {
            16916489, -- -420 -1 757
            16916508, --  -43 -1 460
            16916525, -- -260 -1.5 43
            16916541, -- -580 -1.5 43
            16916560, -- -797 -1.5 460
        },
        IXGHRAH                 = 16916813,
        JAILER_OF_TEMPERANCE    = 16916814,
        IXAERN_MNK              = 16916815,
    },
    npc =
    {
        QM_IXAERN_MNK     = 16916819,
        QUASILUMIN_OFFSET = 16916897,
    },
}

return zones[xi.zone.GRAND_PALACE_OF_HUXZOI]
