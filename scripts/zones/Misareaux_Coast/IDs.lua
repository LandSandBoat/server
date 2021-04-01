-----------------------------------
-- Area: Misareaux_Coast
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[ xi.zone.MISAREAUX_COAST] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED  = 6383, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED            = 6389, -- Obtained: <item>.
        GIL_OBTAINED             = 6390, -- Obtained <number> gil.
        KEYITEM_OBTAINED         = 6392, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY  = 6403, -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET    = 6418, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS      = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY  = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER             = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        FISHING_MESSAGE_OFFSET   = 7072, -- You can't fish here.
        CONQUEST_BASE            = 7172, -- Tallying conquest results...
        DOOR_CLOSED              = 7348, -- The door is locked tight.
        LOGGING_IS_POSSIBLE_HERE = 7602, -- Logging is possible here if you have <item>.
        NOTHING_HERE_YET         = 7661, -- There is nothing here yet. Check again in the morning.
        ALREADY_BAITED           = 7662, -- The trap already contains <item>.
        APPEARS_TO_BE_TRAP       = 7663, -- There appears to be some kind of trap here. Bits of fish are lying around the area.
        DID_NOT_CATCH_ANYTHING   = 7664, -- You did not catch anything.
        PUT_IN_TRAP              = 7665, -- You put <item> in the trap.
        COMMON_SENSE_SURVIVAL    = 8636, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        HOMEPOINT_SET            = 8859, -- Home point set!
    },
    mob =
    {
        OKYUPETE_PH =
        {
            [16879839] = 16879847,
        },
        PM6_2_MOB_OFFSET = 16879893,
        BOGGELMANN       = 16879897,
        GRATION          = 16879899,
        ZIPHIUS          = 16879900,

    },
    npc =
    {
        LOGGING =
        {
            16879972,
            16879973,
            16879974,
            16879975,
            16879976,
            16879977,
        },
        ZIPHIUS_QM_BASE  = 16879919,
    },
}

return zones[ xi.zone.MISAREAUX_COAST]
