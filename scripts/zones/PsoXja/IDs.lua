-----------------------------------
-- Area: PsoXja
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.PSOXJA] =
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
        CONQUEST_BASE           = 7072, -- Tallying conquest results...
        DEVICE_IN_OPERATION     = 7231, -- The device appears to be in operation...
        DOOR_LOCKED             = 7234, -- The door is locked.
        ARCH_GLOW_BLUE          = 7235, -- The arch above the door is glowing blue...
        ARCH_GLOW_GREEN         = 7236, -- The arch above the door is glowing green...
        CANNOT_OPEN_SIDE        = 7239, -- The door cannot be opened from this side.
        TRAP_FAILS              = 7242, -- <name> examines the door. The trap connected to it fails to activate.
        DISCOVER_DISARM_FAIL    = 7243, -- <name> discovers a trap connected to the door, but fails to disarm it!
        DISCOVER_DISARM_SUCCESS = 7244, -- <name> discovers a trap connected to the door and succeeds in disarming it!
        TRAP_ACTIVATED          = 7246, -- <name> examines the stone compartment. A trap connected to it has been activated!
        CHEST_UNLOCKED          = 7464, -- You unlock the chest!
        BROKEN_KNIFE            = 7472, -- A broken knife blade can be seen among the rubble...
        HOMEPOINT_SET           = 7477, -- Home point set!
    },
    mob =
    {
        GYRE_CARLIN_PH =
        {
            [16814330] = 16814331,
        },
        GARGOYLE_OFFSET         = 16814081,
        NUNYUNUWI               = 16814361,
        GOLDEN_TONGUED_CULBERRY = 16814432,
    },
    npc =
    {
        STONE_DOOR_OFFSET          = 16814445, -- _090 in npc_list
        TREASURE_CHEST             = 16814557,
    },
}

return zones[xi.zone.PSOXJA]
