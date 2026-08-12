-----------------------------------
-- Area: Alzadaal_Undersea_Ruins
-----------------------------------
zones = zones or {}

zones[xi.zone.ALZADAAL_UNDERSEA_RUINS] =
{
    text =
    {
        NOTHING_HAPPENS               = 119,  -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6387, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6395, -- Obtained: <item>.
        GIL_OBTAINED                  = 6396, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6398, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6409, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS           = 7006, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7007, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7008, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7028, -- Your party is unable to participate because certain members' levels are restricted.
        CHEST_WONT_OPEN               = 7072, -- It won't open.
        STAGING_GATE_CLOSER           = 7233, -- You must move closer.
        STAGING_GATE_INTERACT         = 7234, -- This gate guards an area under Imperial control.
        STAGING_GATE_NYZUL            = 7240, -- Nyzul Isle Staging Point.
        CANNOT_LEAVE                  = 7244, -- You cannot leave this area while in the possession of <keyitem>.
        RESPONSE                      = 7253, -- There is no response...
        DEVICE_MALFUNCTIONING         = 7269, -- The device appears to be malfunctioning...
        COMMENCING_TRANSPORT          = 7462, -- Commencing transport to [Leujaoam Sanctum/the Mamool Ja Training Grounds/Lebros Cavern/Periqia/Ilrusi Atoll/Nyzul Isle/The Ashu Talif/Zhayolm Remnants/Arrapago Remnants/Bhaflau Remnants/Silver Sea Remnants]!
        CANNOT_ENTER                  = 7465, -- You cannot enter at this time. Please wait a while before trying again.
        AREA_FULL                     = 7466, -- This area is fully occupied. You were unable to enter.
        MEMBER_NO_REQS                = 7470, -- Not all of your party members meet the requirements for this objective. Unable to enter area.
        MEMBER_TOO_FAR                = 7474, -- One or more party members are too far away from the entrance. Unable to enter area.
        MEMBER_IMBUED_ITEM            = 7475, -- One or more party members are carrying imbued items. Unable to enter area.
        IMBUED_ITEM                   = 7476, -- You are carrying imbued items. Unable to enter area.
        MYTHIC_REQUIRED               = 7478, -- You do not have the appropriate mythic weapon equipped. Unable to enter area.
        HEADY_FRAGRANCE               = 7752, -- The heady fragrance of wine pervades the air...
        GLITTERING_FRAGMENTS          = 7753, -- Minute glittering fragments are scattered all over...
        SLIMY_TOUCH                   = 7771, -- The ground here is slimy to the touch...
        DRAWS_NEAR                    = 7782, -- Something draws near!
        UNITY_WANTED_BATTLE_INTERACT  = 7947, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
    },
    mob =
    {
        ALEXANDER               = GetFirstID('Alexander'),
        ARMED_GEARS             = GetFirstID('Armed_Gears'),
        CHEESE_HOARDER_GIGIROON = GetFirstID('Cheese_Hoarder_Gigiroon'),
        COOKIEDUSTER_LIPIROON   = GetFirstID('Cookieduster_Lipiroon'),
        NEPIONIC_SOULFLAYER     = GetFirstID('Nepionic_Soulflayer'),
        OB                      = GetFirstID('Ob'),
        WULGARU                 = GetFirstID('Wulgaru'),
    },
    npc =
    {
        NEPIONIC_QM              = GetFirstID('blank_transformations'),
        RUNIC_PORTAL_OFFSET      = GetFirstID('Runic_Portal'), -- North portal
        STRANGE_HAPPENINGS_CHEST = GetFirstID('Treasure_Chest'),
    },
}

return zones[xi.zone.ALZADAAL_UNDERSEA_RUINS]
