-----------------------------------
-- Area: Mount_Zhayolm
-----------------------------------
zones = zones or {}

zones[xi.zone.MOUNT_ZHAYOLM] =
{
    text =
    {
        NOTHING_HAPPENS               = 119,  -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6385, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6391, -- Obtained: <item>.
        GIL_OBTAINED                  = 6392, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6394, -- Obtained key item: <keyitem>.
        WARHORSE_HOOFPRINT            = 6401, -- You find the hoofprint of a gigantic warhorse...
        FELLOW_MESSAGE_OFFSET         = 6420, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7002, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7003, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7004, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7024, -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7064, -- You can't fish here.
        STAGING_GATE_CLOSER           = 7324, -- You must move closer.
        STAGING_GATE_INTERACT         = 7325, -- This gate guards an area under Imperial control.
        STAGING_GATE_HALVUNG          = 7328, -- Halvung Staging Point.
        CANNOT_LEAVE                  = 7335, -- You cannot leave this area while in the possession of <keyitem>.
        RESPONSE                      = 7344, -- There is no response...
        YOU_HAVE_A_BADGE              = 7357, -- You have a %? Let me have a closer look at that...
        HAND_OVER_TO_IMMORTAL         = 7431, -- You hand over the % to the Immortal.
        YOUR_IMPERIAL_STANDING        = 7432, -- Your Imperial Standing has increased!
        MINING_IS_POSSIBLE_HERE       = 7433, -- Mining is possible here if you have <item>.
        CANNOT_ENTER                  = 7492, -- You cannot enter at this time. Please wait a while before trying again.
        AREA_FULL                     = 7493, -- This area is fully occupied. You were unable to enter.
        MEMBER_NO_REQS                = 7497, -- Not all of your party members meet the requirements for this objective. Unable to enter area.
        MEMBER_TOO_FAR                = 7501, -- One or more party members are too far away from the entrance. Unable to enter area.
        SHED_LEAVES                   = 7566, -- The ground is strewn with shed leaves...
        SICKLY_SWEET                  = 7571, -- A sickly sweet fragrance pervades the air...
        ACIDIC_ODOR                   = 7572, -- An acidic odor pervades the air...
        PUTRID_ODOR                   = 7573, -- A putrid odor threatens to overwhelm you...
        STIFLING_STENCH               = 7577, -- A stifling stench pervades the air...
        DRAWS_NEAR                    = 7593, -- Something draws near!
        ACID_EATEN_DOOR               = 7842, -- The door's coarse, discolored surface gives off a pungent chemical odor...
        HOMEPOINT_SET                 = 8742, -- Home point set!
        UNITY_WANTED_BATTLE_INTERACT  = 8800, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
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
