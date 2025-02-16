-----------------------------------
-- Area: Tahrongi_Canyon
-----------------------------------
zones = zones or {}

zones[xi.zone.TAHRONGI_CANYON] =
{
    text =
    {
        CONQUEST_BASE                 = 0,     -- Tallying conquest results...
        ITEM_CANNOT_BE_OBTAINED       = 6565,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6571,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6572,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6574,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6585,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6600,  -- I'm ready. I suppose.
        CRUOR_TOTAL                   = 7169,  -- Obtained <number> cruor. (Total: <number>)
        CARRIED_OVER_POINTS           = 7182,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7183,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7184,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7204,  -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7246,  -- You can't fish here.
        DIG_THROW_AWAY                = 7259,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                  = 7261,  -- You dig and you dig, but find nothing.
        AMK_DIGGING_OFFSET            = 7327,  -- You spot some familiar footprints. You are convinced that your moogle friend has been digging in the immediate vicinity.
        FOUND_ITEM_WITH_EASE          = 7336,  -- It appears your chocobo found this item with ease.
        ALREADY_OBTAINED_TELE         = 7346,  -- You already possess the gate crystal for this telepoint.
        TELEPOINT_DISAPPEARED         = 7347,  -- The telepoint has disappeared...
        SIGN_1                        = 7421,  -- North: Meriphataud Mountains Northeast: Crag of Mea South: East Sarutabaruta
        SIGN_3                        = 7422,  -- North: Meriphataud Mountains East: Crag of Mea South: East Sarutabaruta
        SIGN_5                        = 7423,  -- North: Meriphataud Mountains East: Buburimu Peninsula South: East Sarutabaruta
        SIGN_7                        = 7424,  -- East: Buburimu Peninsula West: East Sarutabaruta
        BUD_BREAKS_OFF                = 7425,  -- The bud breaks off. You obtain <item>.
        POISONOUS_LOOKING_BUDS        = 7426,  -- The flowers have poisonous-looking buds.
        CANT_TAKE_ANY_MORE            = 7427,  -- You can't take any more.
        MINING_IS_POSSIBLE_HERE       = 7448,  -- Mining is possible here if you have <item>.
        TELEPOINT_HAS_BEEN_SHATTERED  = 7522,  -- The telepoint has been shattered into a thousand pieces...
        SPROUT_LOOKS_WITHERED         = 7565,  -- There is something sprouting from the ground here. It looks a little withered.
        REPULSIVE_CREATURE_EMERGES    = 7566,  -- A repulsive creature emerges from the ground!
        SPROUT_DOES_NOT_NEED_WATER    = 7567,  -- The sprout does not need any more water now.
        NOTHING_HAPPENS               = 7568,  -- Nothing happens.
        SPROUT_LOOKING_BETTER         = 7569,  -- The sprout is looking better.
        PLAYER_OBTAINS_ITEM           = 7574,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 7575,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 7576,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 7577,  -- You already possess that temporary item.
        NO_COMBINATION                = 7582,  -- You were unable to enter a combination.
        VOIDWALKER_DESPAWN            = 7613,  -- The monster fades before your eyes, a look of disappointment on its face.
        UNITY_WANTED_BATTLE_INTERACT  = 7644,  -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        TIME_ELAPSED                  = 7722,  -- Time Elapsed: / [hour/hours] (Vanadiel Time) / [minute/minutes] and [second/seconds] (Earth time)
        REGIME_REGISTERED             = 9834,  -- New training regime registered!
        VOIDWALKER_NO_MOB             = 11007, -- The <keyitem> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR        = 11008, -- The <keyitem> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT           = 11009, -- The <keyitem> resonates [feebly/softly/solidly/strongly/very strongly/furiously], sending a radiant beam of light lancing towards a spot roughly <number> [yalm/yalms] [east/southeast/south/southwest/west/northwest/north/northeast] of here.
        VOIDWALKER_SPAWN_MOB          = 11010, -- A monster materializes out of nowhere!
        VOIDWALKER_UPGRADE_KI_1       = 11012, -- The <keyitem> takes on a slightly deeper hue and becomes <keyitem>!
        VOIDWALKER_UPGRADE_KI_2       = 11013, -- The <keyitem> takes on a deeper, richer hue and becomes <keyitem>!
        VOIDWALKER_BREAK_KI           = 11014, -- The <keyitem> shatters into tiny fragments.
        VOIDWALKER_OBTAIN_KI          = 11015, -- Obtained key item: <keyitem>!
        LEARNS_SPELL                  = 11942, -- <name> learns <spell>!
        UNCANNY_SENSATION             = 11944, -- You are assaulted by an uncanny sensation.
        COMMON_SENSE_SURVIVAL         = 11951, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        SERPOPARD_ISHTAR = GetTableOfIDs('Serpopard_Ishtar'),
        HERBAGE_HUNTER   = GetFirstID('Herbage_Hunter'),
        HABROK           = GetFirstID('Habrok'),
        YARA_MA_YHA_WHO  = GetFirstID('Yara_Ma_Yha_Who'),

        VOIDWALKER =
        {
            [xi.keyItem.CLEAR_ABYSSITE] =
            {
                17256918, -- Prickly Sheep
                17256917, -- Prickly Sheep
                17256916, -- Prickly Sheep
                17256915, -- Prickly Sheep
                17256914,  -- Void Hare
                17256913,  -- Void Hare
                17256912,  -- Void Hare
                17256911,  -- Void Hare
            },

            [xi.keyItem.COLORFUL_ABYSSITE] =
            {
                17256910, -- Chesma
                17256909, -- Tammuz
            },

            [xi.keyItem.GREY_ABYSSITE] =
            {
                17256908, -- Dawon
            },

            [xi.keyItem.BLACK_ABYSSITE] =
            {
                17256907, -- Yilbegan
            }
        }
    },

    npc =
    {
        SIGNPOST_OFFSET = GetFirstID('Signpost'),
        EXCAVATION      = GetTableOfIDs('Excavation_Point'),
    },
}

return zones[xi.zone.TAHRONGI_CANYON]
