-----------------------------------
-- Area: Alzadaal_Undersea_Ruins
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[ xi.zone.ALZADAAL_UNDERSEA_RUINS] =
{
    text =
    {
        NOTHING_HAPPENS         = 119, -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED = 6383, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6389, -- Obtained: <item>.
        GIL_OBTAINED            = 6390, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6392, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS     = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MOVE_CLOSER             = 7210, -- You must move closer.
        IMPERIAL_CONTROL        = 7211, -- This gate guards an area under Imperial control.
        STAGING_POINT_NYZUL     = 7217, -- Nyzul Isle Staging Point.
        CANNOT_LEAVE            = 7221, -- You cannot leave this area while in the possession of <keyitem>.
        RESPONSE                = 7230, -- There is no response...
        DEVICE_MALFUNCTIONING   = 7246, -- The device appears to be malfunctioning...
        NOTHING_OUT_OF_ORDINARY = 7426, -- There is nothing out of the ordinary here.
        CANNOT_ENTER            = 7442, -- You cannot enter at this time. Please wait a while before trying again.
        AREA_FULL               = 7443, -- This area is fully occupied. You were unable to enter.
        MEMBER_NO_REQS          = 7447, -- Not all of your party members meet the requirements for this objective. Unable to enter area.
        MEMBER_TOO_FAR          = 7451, -- One or more party members are too far away from the entrance. Unable to enter area.
        MEMBER_IMBUED_ITEM      = 7452, -- One or more party members are carrying imbued items. Unable to enter area.
        IMBUED_ITEM             = 7453, -- You are carrying imbued items. Unable to enter area.
        MYTHIC_REQUIRED         = 7455, -- You do not have the appropriate mythic weapon equipped. Unable to enter area.
        HEADY_FRAGRANCE         = 7729, -- The heady fragrance of wine pervades the air...
        SLIMY_TOUCH             = 7748, -- The ground here is slimy to the touch...
        DRAWS_NEAR              = 7759, -- Something draws near!
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
        RUNIC_PORTAL_NORTH      = 17072236,
        RUNIC_PORTAL_SOUTH      = 17072237,
        NEPIONIC_QM             = 17072271,
    },
}

return zones[ xi.zone.ALZADAAL_UNDERSEA_RUINS]
