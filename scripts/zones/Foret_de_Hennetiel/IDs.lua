-----------------------------------
-- Area: Foret_de_Hennetiel
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.FORET_DE_HENNETIEL] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6390, -- Obtained: <item>.
        GIL_OBTAINED            = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6393, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS     = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        BAYLD_OBTAINED          = 7008, -- You have obtained <number> bayld!
        YOU_HAVE_LEARNED        = 7015, -- You have learned <keyitem>!
        STARTED_TO_LEARN_BOAT   = 7518, -- You have started to learn a bit about how to operate your boat.
        FIGURED_OUT_BOAT        = 7519, -- You have figured out how to properly use the boat! Report your progress to Choubollet.
        HOMEPOINT_SET           = 8002, -- Home point set!
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[xi.zone.FORET_DE_HENNETIEL]
