-----------------------------------
-- Area: Riverne-Site_A01
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[ xi.zone.RIVERNE_SITE_A01] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6383, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6389, -- Obtained: <item>.
        GIL_OBTAINED            = 6390, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6392, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY = 6403, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS     = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE           = 7050, -- Tallying conquest results...
        SD_VERY_SMALL           = 7588, -- The spatial displacement is very small. If you only had some item that could make it bigger...
        SD_HAS_GROWN            = 7589, -- The spatial displacement has grown.
        SPACE_SEEMS_DISTORTED   = 7590, -- The space around you seems oddly distorted and disrupted.
        MONUMENT                = 7597, -- Something has been engraved on this stone, but the message is too difficult to make out.
        HOMEPOINT_SET           = 7725, -- Home point set!
    },
    mob =
    {
        HELIODROMOS_PH_OFFSET    = 16900107,
        HELIODROMOS_OFFSET       = 16900110,
        CARMINE_DOBSONFLY_OFFSET = 16900230,
    },
    npc =
    {
        DISPLACEMENT_OFFSET = 16900334,
    },
}

return zones[ xi.zone.RIVERNE_SITE_A01]
