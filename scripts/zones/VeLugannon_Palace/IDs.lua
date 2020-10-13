-----------------------------------
-- Area: VeLugannon_Palace
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.VELUGANNON_PALACE] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED  = 6382,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED            = 6388,  -- Obtained: <item>.
        GIL_OBTAINED             = 6389,  -- Obtained <number> gil.
        KEYITEM_OBTAINED         = 6391,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY  = 6402,  -- There is nothing out of the ordinary here.
        CONQUEST_BASE            = 7049,  -- Tallying conquest results...
        CHEST_UNLOCKED           = 7216,  -- You unlock the chest!
        EVIL_PRESENCE            = 7226,  -- You sense an evil presence lurking in the shadows...
        KNIFE_CHANGES_SHAPE      = 7233,  -- The <item> begins to change shape.
        NOTHING_HAPPENS          = 7234,  -- Nothing happens.
        REGIME_REGISTERED        = 10159, -- New training regime registered!
        PLAYER_OBTAINS_ITEM      = 11211, -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM    = 11212, -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM = 11213, -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP     = 11214, -- You already possess that temporary item.
        NO_COMBINATION           = 11219, -- You were unable to enter a combination.
    },
    mob =
    {
        MIMIC            = 17502567,
        BRIGANDISH_BLADE = 17502568,
    },
    npc =
    {
        QM3             = 17502583,
        CASKET_BASE     = 17502585,
        Y_DOOR_OFFSET   = 17502608,
        B_DOOR_OFFSET   = 17502616,
        Y_LITH_OFFSET   = 17502624,
        B_LITH_OFFSET   = 17502634,
        TREASURE_COFFER = 17502699,
    },
}

return zones[tpz.zone.VELUGANNON_PALACE]
