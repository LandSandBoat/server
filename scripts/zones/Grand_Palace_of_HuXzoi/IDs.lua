-----------------------------------
-- Area: Grand_Palace_of_HuXzoi
-----------------------------------
zones = zones or {}

zones[xi.zone.GRAND_PALACE_OF_HUXZOI] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7082, -- Tallying conquest results...
        DOES_NOT_RESPOND              = 7246, -- The gate does not respond...
        REQUEST_CONFIRMED             = 7367, -- Security portal access request confirmed. Commencing patrol routine. Stay on alert for intruder interference.
        PATROL_COMPLETED              = 7368, -- Patrol routine completed. Request transfer of final security portal access duty. Awaiting confirmation.
        DUTY_COMPLETE                 = 7369, -- Transfer of final security portal access duty complete.
        TRANSFER_OF_ACCESS_DUTY       = 7370, -- Transfer of access duty complete.
        RETURNING_TO_REGULAR_DUTIES   = 7371, -- Returning to regular duties.
        PORTAL_EAST                   = 7372, -- You hear a portal open to the east...
        PORTAL_WEST                   = 7373, -- You hear a portal open to the west...
        PORTAL_NORTH                  = 7374, -- You hear a portal open to the north...
        TIME_EXCEEDED                 = 7375, -- Patrol routine time restriction exceeded. Patrol aborted.
        PATROL_SUSPENDED              = 7376, -- Patrol suspended. Awaiting orders.
        RECOMMENCING_PATROL           = 7377, -- Recommencing patrol.
        RECENTLY_ACTIVATED            = 7378, -- The alcove has recently been activated...
        TIME_RESTRICTION              = 7379, -- Time restriction: <number> [minute/minutes] (Earth time)
        QUASILUMIN_MAP_QUEST_OFFSET   = 7380, -- Warning. Chamber of Eventide accessed by unauthorized personnel, 4789209-980 increments previous.
        HOMEPOINT_SET                 = 7464, -- Home point set!
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
        QM_IXAERN_MNK        = 16916819,
        QUASILUMIN_OFFSET    = 16916897,
        ESCORT_1_DOOR_OFFSET = 16916867,
        ESCORT_2_DOOR_OFFSET = 16916870,
        ESCORT_3_DOOR_OFFSET = 16916875,
        ESCORT_4_DOOR_OFFSET = 16916880,
        CERMET_ALCOVE_OFFSET = 16916927,
    },
}

return zones[xi.zone.GRAND_PALACE_OF_HUXZOI]
