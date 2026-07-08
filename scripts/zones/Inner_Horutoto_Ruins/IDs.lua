-----------------------------------
-- Area: Inner Horutoto Ruins (192)
-----------------------------------
zones = zones or {}

zones[xi.zone.INNER_HORUTOTO_RUINS] =
{
    text =
    {
        PORTAL_SEALED_BY_3_MAGIC      = 8,     -- The Sealed Portal is sealed by three kinds of magic.
        PORTAL_NOT_OPEN_THAT_SIDE     = 9,     -- The Sealed Portal cannot be opened from this side.
        CONQUEST_BASE                 = 10,    -- Tallying conquest results...
        ITEM_CANNOT_BE_OBTAINED       = 6555,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6563,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6564,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6566,  -- Obtained key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET         = 6592,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7174,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7175,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7176,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        GEOMAGNETRON_ATTUNED          = 7185,  -- Your <keyitem> has been attuned to a geomagnetic fount in the corresponding locale.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7196,  -- Your party is unable to participate because certain members' levels are restricted.
        NOT_BROKEN_ORB                = 7257,  -- The Mana Orb in this receptacle is not broken.
        EXAMINED_RECEPTACLE           = 7258,  -- You have already examined this receptacle.
        DOOR_FIRMLY_CLOSED            = 7285,  -- The door is firmly closed.
        CAT_BURGLARS_HIDEOUT          = 7286,  -- It looks like that Cat Burglar's hideout lies behind this door! You were able to confirm <keyitem>!
        CHEST_UNLOCKED                = 7361,  -- You unlock the chest!
        PLAYER_OBTAINS_ITEM           = 7424,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 7425,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 7426,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 7427,  -- You already possess that temporary item.
        NO_COMBINATION                = 7432,  -- You were unable to enter a combination.
        REGIME_REGISTERED             = 9510,  -- New training regime registered!
        COMMON_SENSE_SURVIVAL         = 10558, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        SLENDLIX_SPINDLETHUMB = GetFirstID('Slendlix_Spindlethumb'),
        NOCUOUS_WEAPON        = GetFirstID('Nocuous_Weapon'),
        MAGICKED_BONES        = GetFirstID('Magicked_Bones'),
        --[[
            -2    Goblin Thug
            -1    Goblin Weaver
             0    Magicked Bones (with club)
            +1    Magicked Bones (with knife)
        ]]
    },
    npc =
    {
        PORTAL_CIRCLE_BASE = GetFirstID('_5cm'),
        TREASURE_CHEST     = GetFirstID('Treasure_Chest'),
    },
}

return zones[xi.zone.INNER_HORUTOTO_RUINS]
