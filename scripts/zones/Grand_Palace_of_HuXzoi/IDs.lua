-----------------------------------
-- Area: Grand_Palace_of_HuXzoi
-----------------------------------
zones = zones or {}

zones[xi.zone.GRAND_PALACE_OF_HUXZOI] =
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
        MEMBERS_LEVELS_ARE_RESTRICTED = 7028, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7095, -- Tallying conquest results...
        DOES_NOT_RESPOND              = 7259, -- The gate does not respond...
        PRESENCE_HAS_DRAWN            = 7375, -- Your presence has drawn unwanted attention!
        NOTHING_LEFT_TO_DO            = 7378, -- You have nothing left to do here.
        REQUEST_CONFIRMED             = 7380, -- Security portal access request confirmed. Commencing patrol routine. Stay on alert for intruder interference.
        PATROL_COMPLETED              = 7381, -- Patrol routine completed. Request transfer of final security portal access duty. Awaiting confirmation.
        DUTY_COMPLETE                 = 7382, -- Transfer of final security portal access duty complete.
        TRANSFER_OF_ACCESS_DUTY       = 7383, -- Transfer of access duty complete.
        RETURNING_TO_REGULAR_DUTIES   = 7384, -- Returning to regular duties.
        PORTAL_EAST                   = 7385, -- You hear a portal open to the east...
        PORTAL_WEST                   = 7386, -- You hear a portal open to the west...
        PORTAL_NORTH                  = 7387, -- You hear a portal open to the north...
        TIME_EXCEEDED                 = 7388, -- Patrol routine time restriction exceeded. Patrol aborted.
        PATROL_SUSPENDED              = 7389, -- Patrol suspended. Awaiting orders.
        RECOMMENCING_PATROL           = 7390, -- Recommencing patrol.
        RECENTLY_ACTIVATED            = 7391, -- The alcove has recently been activated...
        TIME_RESTRICTION              = 7392, -- Time restriction: <number> [minute/minutes] (Earth time)
        QUASILUMIN_MAP_QUEST_OFFSET   = 7393, -- Warning. Chamber of Eventide accessed by unauthorized personnel, 4789209-980 increments previous.
        IXAERN_MNK_QM                 = 7404, -- You hear something vaguely resembling a voice emanating from the depths of your soul. Bring me...aer...reccceptac...
        HOMEPOINT_SET                 = 7477, -- Home point set!
    },
    mob =
    {
        JAILER_OF_TEMPERANCE_PH = utils.slice(GetTableOfIDs('Eozdei_Still'), 1, 5), -- Entries 1-5 of the table (1-indexed, inclusive)
        IXGHRAH                 = GetFirstID('Ixghrah'),
        JAILER_OF_TEMPERANCE    = GetFirstID('Jailer_of_Temperance'),
        IXAERN_MNK              = GetFirstID('Ixaern_MNK'),
        EOGHRAH_BIRD            = utils.slice(GetTableOfIDs('Eoghrah'), 1, 38),
        EOGHRAH_SPIDER          = utils.slice(GetTableOfIDs('Eoghrah'), 39),
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
