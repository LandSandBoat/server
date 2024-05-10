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
        CONQUEST_BASE                 = 7083, -- Tallying conquest results...
        DOES_NOT_RESPOND              = 7247, -- The gate does not respond...
        REQUEST_CONFIRMED             = 7368, -- Security portal access request confirmed. Commencing patrol routine. Stay on alert for intruder interference.
        PATROL_COMPLETED              = 7369, -- Patrol routine completed. Request transfer of final security portal access duty. Awaiting confirmation.
        DUTY_COMPLETE                 = 7370, -- Transfer of final security portal access duty complete.
        TRANSFER_OF_ACCESS_DUTY       = 7371, -- Transfer of access duty complete.
        RETURNING_TO_REGULAR_DUTIES   = 7372, -- Returning to regular duties.
        PORTAL_EAST                   = 7373, -- You hear a portal open to the east...
        PORTAL_WEST                   = 7374, -- You hear a portal open to the west...
        PORTAL_NORTH                  = 7375, -- You hear a portal open to the north...
        TIME_EXCEEDED                 = 7376, -- Patrol routine time restriction exceeded. Patrol aborted.
        PATROL_SUSPENDED              = 7377, -- Patrol suspended. Awaiting orders.
        RECOMMENCING_PATROL           = 7378, -- Recommencing patrol.
        RECENTLY_ACTIVATED            = 7379, -- The alcove has recently been activated...
        TIME_RESTRICTION              = 7380, -- Time restriction: <number> [minute/minutes] (Earth time)
        QUASILUMIN_MAP_QUEST_OFFSET   = 7381, -- Warning. Chamber of Eventide accessed by unauthorized personnel, 4789209-980 increments previous.
        HOMEPOINT_SET                 = 7465, -- Home point set!
    },
    mob =
    {
        JAILER_OF_TEMPERANCE_PH = GetTableOfIDs('Eozdei_Still', 5), -- Get the first 5 in the zone
        IXGHRAH                 = GetFirstID('Ixghrah'),
        JAILER_OF_TEMPERANCE    = GetFirstID('Jailer_of_Temperance'),
        IXAERN_MNK              = GetFirstID('Ixaern_MNK'),
    },
    npc =
    {
        QM_IXAERN_MNK        = GetFirstID('qm_ixaern_mnk'),
        QUASILUMIN_OFFSET    = GetFirstID('Quasilumin'),
        ESCORT_1_DOOR_OFFSET = GetFirstID('_0y6'),
        ESCORT_2_DOOR_OFFSET = GetFirstID('_iyn'),
        ESCORT_3_DOOR_OFFSET = GetFirstID('_iyk'),
        ESCORT_4_DOOR_OFFSET = GetFirstID('_iyd'),
        CERMET_ALCOVE_OFFSET = GetFirstID('Cermet_Alcove'),
    },
}

return zones[xi.zone.GRAND_PALACE_OF_HUXZOI]
