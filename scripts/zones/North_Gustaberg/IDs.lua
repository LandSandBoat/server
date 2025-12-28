-----------------------------------
-- Area: North_Gustaberg
-----------------------------------
zones = zones or {}

zones[xi.zone.NORTH_GUSTABERG] =
{
    text =
    {
        CONQUEST_BASE                 = 0,     -- Tallying conquest results...
        NOTHING_HAPPENS               = 300,   -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED_TWICE = 6565,  -- You cannot obtain any more.
        ITEM_CANNOT_BE_OBTAINED       = 6566,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE    = 6570,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 6572,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6573,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6575,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6576,  -- Lost key item: <keyitem>.
        ITEMS_OBTAINED                = 6581,  -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY       = 6586,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6601,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7183,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7184,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7185,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7205,  -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7249,  -- You can't fish here.
        DIG_THROW_AWAY                = 7262,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                  = 7264,  -- You dig and you dig, but find nothing.
        FOUND_ITEM_WITH_EASE          = 7339,  -- It appears your chocobo found this item with ease.
        SENSE_EVIL_PRESENCE           = 7352,  -- You sense an evil presence...
        SPARKLING_LIGHT               = 7393,  -- The ground is sparkling with a strange light.
        SHINING_OBJECT_SLIPS_AWAY     = 7457,  -- The shining object slips through your fingers and is washed further down the stream.
        REACH_WATER_FROM_HERE         = 7464,  -- You can reach the water from here.
        CONQUEST                      = 7500,  -- You've earned conquest points!
        ITEMS_ITEMS_LA_LA             = 7852,  -- You can hear a strange voice... Items, items, la la la la la
        GOBLIN_SLIPPED_AWAY           = 7858,  -- The Goblin slipped away when you were not looking...
        GARRISON_BASE                 = 7868,  -- Hm? What is this? %? How do I know this is not some [San d'Orian/Bastokan/Windurstian] trick?
        PLAYER_OBTAINS_ITEM           = 8083,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 8084,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 8085,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 8086,  -- You already possess that temporary item.
        NO_COMBINATION                = 8091,  -- You were unable to enter a combination.
        VOIDWALKER_DESPAWN            = 8122,  -- The monster fades before your eyes, a look of disappointment on its face.
        TIME_ELAPSED                  = 8198,  -- Time elapsed: <number> [hour/hours] (Vana'diel time) <number> [minute/minutes] and <number> [second/seconds] (Earth time)
        REGIME_REGISTERED             = 10414, -- New training regime registered!
        VOIDWALKER_NO_MOB             = 11533, -- The <keyitem> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR        = 11534, -- The <keyitem> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT           = 11535, -- The <keyitem> resonates [feebly/softly/solidly/strongly/very strongly/furiously], sending a radiant beam of light lancing towards a spot roughly <number> [yalm/yalms] [east/southeast/south/southwest/west/northwest/north/northeast] of here.
        VOIDWALKER_SPAWN_MOB          = 11536, -- A monster materializes out of nowhere!
        VOIDWALKER_UPGRADE_KI_1       = 11538, -- The <keyitem> takes on a slightly deeper hue and becomes <keyitem>!
        VOIDWALKER_UPGRADE_KI_2       = 11539, -- The <keyitem> takes on a deeper, richer hue and becomes <keyitem>!
        VOIDWALKER_BREAK_KI           = 11540, -- The <keyitem> shatters into tiny fragments.
        VOIDWALKER_OBTAIN_KI          = 11541, -- Obtained key item: <keyitem>!
        COMMON_SENSE_SURVIVAL         = 12487, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        STINGING_SOPHIE     = GetTableOfIDs('Stinging_Sophie'), -- 2 NMs
        MAIGHDEAN_UAINE     = GetFirstID('Maighdean_Uaine'), -- TODO: PH Audit, 2 NMs
        GAMBILOX_WANDERLING = GetFirstID('Gambilox_Wanderling'),

        VOIDWALKER =
        {
            [xi.keyItem.CLEAR_ABYSSITE] =
            {
                17211881, -- Globster
                17211880, -- Globster
                17211879, -- Globster
                17211878, -- Globster
                17211877, -- Ground Guzzler
                17211876, -- Ground Guzzler
                17211875, -- Ground Guzzler
                17211874, -- Ground Guzzler
            },

            [xi.keyItem.COLORFUL_ABYSSITE] =
            {
                17211873, -- Lamprey Lord
                17211872,  -- Shoggoth
            },

            [xi.keyItem.ORANGE_ABYSSITE] =
            {
                17211865  -- Blobdingnag
            },

            [xi.keyItem.BLACK_ABYSSITE] =
            {
                17211864  -- Yilbegan
            }
        }
    },

    pet =
    {
        [17211865] = -- Blobdingnag
        {
            17211871, -- Septic Boils
            17211870, -- Septic Boils
            17211869, -- Septic Boils
            17211868, -- Septic Boils
            17211867, -- Septic Boils
            17211866, -- Septic Boils
        },
    },

    npc =
    {
        OVERSEER_BASE = GetFirstID('Ennigreaud_RK'),
    },
}

return zones[xi.zone.NORTH_GUSTABERG]
