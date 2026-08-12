-----------------------------------
-- Area: PsoXja
-----------------------------------
zones = zones or {}

zones[xi.zone.PSOXJA] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6387, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6395, -- Obtained: <item>.
        GIL_OBTAINED                  = 6396, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6398, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6409, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS           = 7006, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7007, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7008, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7028, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7095, -- Tallying conquest results...
        REGION_POINTS_SANDORIA        = 7160, -- San d'Oria's region points have increased!
        DEVICE_IN_OPERATION           = 7254, -- The device appears to be in operation...
        DOOR_LOCKED                   = 7257, -- The door is locked.
        ARCH_GLOW_BLUE                = 7258, -- The arch above the door is glowing blue...
        ARCH_GLOW_GREEN               = 7259, -- The arch above the door is glowing green...
        CANNOT_OPEN_SIDE              = 7262, -- The door cannot be opened from this side.
        TRAP_ACTIVATES                = 7264, -- <name> examines the door. A trap connected to it has been activated!
        TRAP_FAILS                    = 7265, -- <name> examines the door. The trap connected to it fails to activate.
        DISCOVER_DISARM_FAIL          = 7266, -- <name> discovers a trap connected to the door, but fails to disarm it!
        DISCOVER_DISARM_SUCCESS       = 7267, -- <name> discovers a trap connected to the door and succeeds in disarming it!
        TRAP_ACTIVATED                = 7269, -- <name> examines the stone compartment. A trap connected to it has been activated!
        CHEST_UNLOCKED                = 7487, -- You unlock the chest!
        BROKEN_KNIFE                  = 7495, -- A broken knife blade can be seen among the rubble...
        HOMEPOINT_SET                 = 7500, -- Home point set!
    },
    mob =
    {
        GYRE_CARLIN             = GetFirstID('Gyre-Carlin'),
        GARGOYLE_OFFSET         = GetFirstID('Gargoyle'),
        NUNYUNUWI               = GetFirstID('Nunyunuwi'),
        GOLDEN_TONGUED_CULBERRY = GetFirstID('Golden-Tongued_Culberry'),
    },
    npc =
    {
        STONE_DOOR_OFFSET       = GetFirstID('_090'),
        TREASURE_CHEST          = GetTableOfIDs('Treasure_Chest')[7],
    },
}

return zones[xi.zone.PSOXJA]
