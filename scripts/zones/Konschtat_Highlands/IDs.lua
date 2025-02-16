-----------------------------------
-- Area: Konschtat_Highlands
-----------------------------------
zones = zones or {}

zones[xi.zone.KONSCHTAT_HIGHLANDS] =
{
    text =
    {
        NOTHING_HAPPENS               = 119,   -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6384,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6391,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6404,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6419,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7001,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023,  -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7065,  -- Tallying conquest results...
        ALREADY_OBTAINED_TELE         = 7224,  -- You already possess the gate crystal for this telepoint.
        DIG_THROW_AWAY                = 7241,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                  = 7243,  -- You dig and you dig, but find nothing.
        AMK_DIGGING_OFFSET            = 7309,  -- You spot some familiar footprints. You are convinced that your moogle friend has been digging in the immediate vicinity.
        FOUND_ITEM_WITH_EASE          = 7318,  -- It appears your chocobo found this item with ease.
        SIGNPOST3                     = 7399,  -- North: Valkurm Dunes South: North Gustaberg East: Gusgen Mines, Pashhow Marshlands
        SIGNPOST2                     = 7400,  -- North: Pashhow Marshlands West: Valkurm Dunes, North Gustaberg Southeast: Gusgen Mines
        SIGNPOST_DIALOG_1             = 7401,  -- North: Valkurm Dunes South: To Gustaberg
        SIGNPOST_DIALOG_2             = 7402,  -- You see something stuck behind the signpost.
        SOMETHING_BURIED_HERE         = 7403,  -- Something has been buried here.
        BLACKENED_SPOT_ON_GROUND      = 7452,  -- There is a blackened spot on the ground...
        BLACKENED_SHOULD_PLACE        = 7453,  -- This is the blackened spot you were told about. You should place <item> here.
        PLACE_BLACKENED_SPOT          = 7454,  -- You place <item> on the blackened spot.
        BLACKENED_NOTHING_HAPPENS     = 7455,  -- You place <item> on the blackened spot, but nothing happens.
        BLACKENED_MUST_BE_CLOSER      = 7456,  -- You have to be closer to place anything on the blackened spot.
        NOT_THE_TIME_FOR_THAT         = 7465,  -- This is not the time for that!
        TELEPOINT_HAS_BEEN_SHATTERED  = 7492,  -- The telepoint has been shattered into a thousand pieces...
        TIME_ELAPSED                  = 7548,  -- Time Elapsed: / [hour/hours] (Vanadiel Time) / [minute/minutes] and [second/seconds] (Earth time)
        MEMORIES_SEALED_OFF           = 7605,  -- A portion of your memories has been sealed off.
        PLAYER_OBTAINS_ITEM           = 7610,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 7611,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 7612,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 7613,  -- You already possess that temporary item.
        NO_COMBINATION                = 7618,  -- You were unable to enter a combination.
        VOIDWALKER_DESPAWN            = 7649,  -- The monster fades before your eyes, a look of disappointment on its face.
        UNITY_WANTED_BATTLE_INTERACT  = 7680,  -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        REGIME_REGISTERED             = 9796,  -- New training regime registered!
        VOIDWALKER_NO_MOB             = 10969, -- The <keyitem> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR        = 10970, -- The <keyitem> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT           = 10971, -- The <keyitem> resonates [feebly/softly/solidly/strongly/very strongly/furiously], sending a radiant beam of light lancing towards a spot roughly <number> [yalm/yalms] [east/southeast/south/southwest/west/northwest/north/northeast] of here.
        VOIDWALKER_SPAWN_MOB          = 10972, -- A monster materializes out of nowhere!
        VOIDWALKER_UPGRADE_KI_1       = 10974, -- The <keyitem> takes on a slightly deeper hue and becomes <keyitem>!
        VOIDWALKER_UPGRADE_KI_2       = 10975, -- The <keyitem> takes on a deeper, richer hue and becomes <keyitem>!
        VOIDWALKER_BREAK_KI           = 10976, -- The <keyitem> shatters into tiny fragments.
        VOIDWALKER_OBTAIN_KI          = 10977, -- Obtained key item: <keyitem>!
        LEARNS_SPELL                  = 11913, -- <name> learns <spell>!
        UNCANNY_SENSATION             = 11915, -- You are assaulted by an uncanny sensation.
        COMMON_SENSE_SURVIVAL         = 11922, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        STRAY_MARY     = GetTableOfIDs('Stray_Mary'), -- 2 NMs
        RAMPAGING_RAM  = GetFirstID('Rampaging_Ram'),
        STEELFLEECE    = GetFirstID('Steelfleece_Baldarich'),
        TREMMOR_RAM    = GetTableOfIDs('Tremor_Ram'), -- Used for Steelface pop
        FORGER         = GetFirstID('Forger'),
        HATY           = GetFirstID('Haty'),
        BENDIGEIT_VRAN = GetFirstID('Bendigeit_Vran'),

        VOIDWALKER =
        {
            [xi.keyItem.CLEAR_ABYSSITE] =
            {
                17220019, -- Prickly Sheep
                17220018, -- Prickly Sheep
                17220017, -- Prickly Sheep
                17220016, -- Prickly Sheep
                17220015,  -- Void Hare
                17220014,  -- Void Hare
                17220013,  -- Void Hare
                17220012,  -- Void Hare
            },

            [xi.keyItem.COLORFUL_ABYSSITE] =
            {
                17220011,  -- Chesma
                17220010, -- Tammuz
            },

            [xi.keyItem.GREY_ABYSSITE] =
            {
                17220009, -- Dawon
            },

            [xi.keyItem.BLACK_ABYSSITE] =
            {
                17220008, -- Yilbegan
            }
        }
    },

    npc =
    {
    },
}

return zones[xi.zone.KONSCHTAT_HIGHLANDS]
