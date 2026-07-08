-----------------------------------
-- Area: Mount_Zhayolm
-----------------------------------
zones = zones or {}

zones[xi.zone.MOUNT_ZHAYOLM] =
{
    text =
    {
        NOTHING_HAPPENS               = 119,  -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6386, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6394, -- Obtained: <item>.
        GIL_OBTAINED                  = 6395, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6397, -- Obtained key item: <keyitem>.
        WARHORSE_HOOFPRINT            = 6404, -- You find the hoofprint of a gigantic warhorse...
        FELLOW_MESSAGE_OFFSET         = 6423, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7005, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7006, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7007, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7027, -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7068, -- You can't fish here.
        STAGING_GATE_CLOSER           = 7329, -- You must move closer.
        STAGING_GATE_INTERACT         = 7330, -- This gate guards an area under Imperial control.
        STAGING_GATE_HALVUNG          = 7333, -- Halvung Staging Point.
        CANNOT_LEAVE                  = 7340, -- You cannot leave this area while in the possession of <keyitem>.
        RESPONSE                      = 7349, -- There is no response...
        YOU_HAVE_A_BADGE              = 7362, -- You have a %? Let me have a closer look at that...
        NOTHING_OUT_OF_ORDINARY       = 7385, -- There is nothing out of the ordinary here.
        LARGE_KEYHOLE_HERE            = 7386, -- There is a large keyhole here. It seems to be a very simple mechanism.
        FITS_LARGE_KEYHOLE            = 7387, -- Obtained key item: %. You think it may fit the large keyhole.
        INSERT_INTO_KEYHOLE           = 7388, -- You insert the % into the keyhole.
        HAND_OVER_TO_IMMORTAL         = 7436, -- You hand over the % to the Immortal.
        YOUR_IMPERIAL_STANDING        = 7437, -- Your Imperial Standing has increased!
        MINING_IS_POSSIBLE_HERE       = 7438, -- Mining is possible here if you have <item>.
        CANNOT_ENTER                  = 7497, -- You cannot enter at this time. Please wait a while before trying again.
        AREA_FULL                     = 7498, -- This area is fully occupied. You were unable to enter.
        MEMBER_NO_REQS                = 7502, -- Not all of your party members meet the requirements for this objective. Unable to enter area.
        MEMBER_TOO_FAR                = 7506, -- One or more party members are too far away from the entrance. Unable to enter area.
        DETACHED_PART                 = 7561, -- There is a detached part here...
        SHED_LEAVES                   = 7576, -- The ground is strewn with shed leaves...
        SICKLY_SWEET                  = 7581, -- A sickly sweet fragrance pervades the air...
        ACIDIC_ODOR                   = 7582, -- An acidic odor pervades the air...
        PUTRID_ODOR                   = 7583, -- A putrid odor threatens to overwhelm you...
        STIFLING_STENCH               = 7587, -- A stifling stench pervades the air...
        DRAWS_NEAR                    = 7603, -- Something draws near!
        ACID_EATEN_DOOR               = 7853, -- The door's coarse, discolored surface gives off a pungent chemical odor...
        HOMEPOINT_SET                 = 8752, -- Home point set!
        UNITY_WANTED_BATTLE_INTERACT  = 8810, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
    },
    mob =
    {
        APKALLU_NPC           = GetFirstID('Zhayolm_Apkallu'),
        WAMOURA_OFFSET        = GetTableOfIDs('Wamoura'),
        ENERGETIC_ERUCA       = GetFirstID('Energetic_Eruca'),
        IGNAMOTH              = GetFirstID('Ignamoth'),
        CERBERUS              = GetFirstID('Cerberus'),
        BRASS_BORER           = GetFirstID('Brass_Borer'),
        CLARET                = GetFirstID('Claret'),
        ANANTABOGA            = GetFirstID('Anantaboga'),
        KHROMASOUL_BHURBORLOR = GetFirstID('Khromasoul_Bhurborlor'),
        SARAMEYA              = GetFirstID('Sarameya'),
    },
    npc =
    {
        HOOFPRINT = GetFirstID('Warhorse_Hoofprint'),
        MINING    = GetTableOfIDs('Mining_Point'),
    },
}

return zones[xi.zone.MOUNT_ZHAYOLM]
