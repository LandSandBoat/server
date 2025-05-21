-----------------------------------
-- Area: Alzadaal_Undersea_Ruins
-----------------------------------
zones = zones or {}

zones[xi.zone.ALZADAAL_UNDERSEA_RUINS] =
{
    text =
    {
        NOTHING_HAPPENS               = 119,  -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6385, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6391, -- Obtained: <item>.
        GIL_OBTAINED                  = 6392, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6394, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6405, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS           = 7002, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7003, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7004, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7024, -- Your party is unable to participate because certain members' levels are restricted.
        STAGING_GATE_CLOSER           = 7228, -- You must move closer.
        STAGING_GATE_INTERACT         = 7229, -- This gate guards an area under Imperial control.
        STAGING_GATE_NYZUL            = 7235, -- Nyzul Isle Staging Point.
        CANNOT_LEAVE                  = 7239, -- You cannot leave this area while in the possession of <keyitem>.
        RESPONSE                      = 7248, -- There is no response...
        DEVICE_MALFUNCTIONING         = 7264, -- The device appears to be malfunctioning...
        COMMENCING_TRANSPORT          = 7457, -- Commencing transport to [Leujaoam Sanctum/the Mamool Ja Training Grounds/Lebros Cavern/Periqia/Ilrusi Atoll/Nyzul Isle/The Ashu Talif/Zhayolm Remnants/Arrapago Remnants/Bhaflau Remnants/Silver Sea Remnants]!
        CANNOT_ENTER                  = 7460, -- You cannot enter at this time. Please wait a while before trying again.
        AREA_FULL                     = 7461, -- This area is fully occupied. You were unable to enter.
        MEMBER_NO_REQS                = 7465, -- Not all of your party members meet the requirements for this objective. Unable to enter area.
        MEMBER_TOO_FAR                = 7469, -- One or more party members are too far away from the entrance. Unable to enter area.
        MEMBER_IMBUED_ITEM            = 7470, -- One or more party members are carrying imbued items. Unable to enter area.
        IMBUED_ITEM                   = 7471, -- You are carrying imbued items. Unable to enter area.
        MYTHIC_REQUIRED               = 7473, -- You do not have the appropriate mythic weapon equipped. Unable to enter area.
        HEADY_FRAGRANCE               = 7747, -- The heady fragrance of wine pervades the air...
        GLITTERING_FRAGMENTS          = 7748, -- Minute glittering fragments are scattered all over...
        SLIMY_TOUCH                   = 7766, -- The ground here is slimy to the touch...
        DRAWS_NEAR                    = 7777, -- Something draws near!
        UNITY_WANTED_BATTLE_INTERACT  = 7942, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
    },
    mob =
    {
        NEPIONIC_SOULFLAYER     = GetFirstID('Nepionic_Soulflayer'),
        COOKIEDUSTER_LIPIROON   = GetFirstID('Cookieduster_Lipiroon'),
        OB                      = GetFirstID('Ob'),
        CHEESE_HOARDER_GIGIROON = GetFirstID('Cheese_Hoarder_Gigiroon'),
        ARMED_GEARS             = GetFirstID('Armed_Gears'),
        WULGARU                 = GetFirstID('Wulgaru'),

    },
    npc =
    {
        RUNIC_PORTAL_OFFSET = GetFirstID('Runic_Portal'), -- North portal
        NEPIONIC_QM         = GetFirstID('blank_transformations'),
    },
}

return zones[xi.zone.ALZADAAL_UNDERSEA_RUINS]
