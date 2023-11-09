-----------------------------------
-- Area: PsoXja
-----------------------------------
zones = zones or {}

zones[xi.zone.PSOXJA] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6404, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7083, -- Tallying conquest results...
        DEVICE_IN_OPERATION           = 7242, -- The device appears to be in operation...
        DOOR_LOCKED                   = 7245, -- The door is locked.
        ARCH_GLOW_BLUE                = 7246, -- The arch above the door is glowing blue...
        ARCH_GLOW_GREEN               = 7247, -- The arch above the door is glowing green...
        CANNOT_OPEN_SIDE              = 7250, -- The door cannot be opened from this side.
        TRAP_ACTIVATES                = 7252, -- <name> examines the door. A trap connected to it has been activated!
        TRAP_FAILS                    = 7253, -- <name> examines the door. The trap connected to it fails to activate.
        DISCOVER_DISARM_FAIL          = 7254, -- <name> discovers a trap connected to the door, but fails to disarm it!
        DISCOVER_DISARM_SUCCESS       = 7255, -- <name> discovers a trap connected to the door and succeeds in disarming it!
        TRAP_ACTIVATED                = 7257, -- <name> examines the stone compartment. A trap connected to it has been activated!
        CHEST_UNLOCKED                = 7475, -- You unlock the chest!
        BROKEN_KNIFE                  = 7483, -- A broken knife blade can be seen among the rubble...
        HOMEPOINT_SET                 = 7488, -- Home point set!
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
