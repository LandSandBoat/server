-----------------------------------
-- Area: Alzadaal_Undersea_Ruins
-----------------------------------
zones = zones or {}

zones[xi.zone.ALZADAAL_UNDERSEA_RUINS] =
{
    text =
    {
        NOTHING_HAPPENS               = 119,  -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6404, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        STAGING_GATE_CLOSER           = 7220, -- You must move closer.
        STAGING_GATE_INTERACT         = 7221, -- This gate guards an area under Imperial control.
        STAGING_GATE_NYZUL            = 7227, -- Nyzul Isle Staging Point.
        CANNOT_LEAVE                  = 7231, -- You cannot leave this area while in the possession of <keyitem>.
        RESPONSE                      = 7240, -- There is no response...
        DEVICE_MALFUNCTIONING         = 7256, -- The device appears to be malfunctioning...
        COMMENCING_TRANSPORT          = 7449, -- Commencing transport to [Leujaoam Sanctum/the Mamool Ja Training Grounds/Lebros Cavern/Periqia/Ilrusi Atoll/Nyzul Isle/The Ashu Talif/Zhayolm Remnants/Arrapago Remnants/Bhaflau Remnants/Silver Sea Remnants]!
        CANNOT_ENTER                  = 7452, -- You cannot enter at this time. Please wait a while before trying again.
        AREA_FULL                     = 7453, -- This area is fully occupied. You were unable to enter.
        MEMBER_NO_REQS                = 7457, -- Not all of your party members meet the requirements for this objective. Unable to enter area.
        MEMBER_TOO_FAR                = 7461, -- One or more party members are too far away from the entrance. Unable to enter area.
        MEMBER_IMBUED_ITEM            = 7462, -- One or more party members are carrying imbued items. Unable to enter area.
        IMBUED_ITEM                   = 7463, -- You are carrying imbued items. Unable to enter area.
        MYTHIC_REQUIRED               = 7465, -- You do not have the appropriate mythic weapon equipped. Unable to enter area.
        HEADY_FRAGRANCE               = 7739, -- The heady fragrance of wine pervades the air...
        GLITTERING_FRAGMENTS          = 7740, -- Minute glittering fragments are scattered all over...
        SLIMY_TOUCH                   = 7758, -- The ground here is slimy to the touch...
        DRAWS_NEAR                    = 7769, -- Something draws near!
        UNITY_WANTED_BATTLE_INTERACT  = 7934, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
    },
    mob =
    {
        NEPIONIC_SOULFLAYER     = 17072129,
        COOKIEDUSTER_LIPIROON_PH =
        {
            [17072142] = 17072150,
            [17072144] = 17072150,
        },
        OB                      = 17072171,
        CHEESE_HOARDER_GIGIROON = 17072172,
        ARMED_GEARS             = 17072178,
        WULGARU                 = 17072179,

    },
    npc =
    {
        RUNIC_PORTAL_NORTH      = 17072331,
        RUNIC_PORTAL_SOUTH      = 17072332,
        NEPIONIC_QM             = 17072366, -- blank_transformations in DB
    },
}

return zones[xi.zone.ALZADAAL_UNDERSEA_RUINS]
