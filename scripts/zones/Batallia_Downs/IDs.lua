-----------------------------------
-- Area: Batallia_Downs
-----------------------------------
zones = zones or {}

zones[xi.zone.BATALLIA_DOWNS] =
{
    text =
    {
        NOTHING_HAPPENS               = 141,   -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6406,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6412,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6413,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6415,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6426,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6441,  -- I'm ready. I suppose.
        REPORT_TO_CAIT_SITH           = 7014,  -- You have obtained all of Lilisette's memory fragments. Make haste and report to Cait Sith.
        CARRIED_OVER_POINTS           = 7023,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7024,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7025,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7045,  -- Your party is unable to participate because certain members' levels are restricted.
        UNABLE_TO_PROGRESS            = 7069,  -- ou are unable to make further progress in Rhapsodies of Vana'diel due to an event occurring in the [Chains of Promathia/Treasures of Aht Urhgan/Wings of the Goddess/Seekers of Adoulin/Rise of the Zilart] missions.
        CONQUEST_BASE                 = 7087,  -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET        = 7246,  -- You can't fish here.
        DIG_THROW_AWAY                = 7259,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                  = 7261,  -- You dig and you dig, but find nothing.
        FOUND_ITEM_WITH_EASE          = 7336,  -- It appears your chocobo found this item with ease.
        SPARKLING_LIGHT               = 7355,  -- The ground is sparkling with a strange light.
        SENSE_SOMETHING_LURKING       = 7445,  -- You sense something lurking close by!
        NO_GRASS_GROWING_HERE         = 7494,  -- There is no grass growing here...
        YOU_ARE_BEING_ATTACKED        = 7631,  -- You are being attacked!
        YOU_FIND_NOTHING              = 7634,  -- You find nothing.
        TIME_ELAPSED                  = 7696,  -- Time Elapsed: / [hour/hours] (Vanadiel Time) / [minute/minutes] and [second/seconds] (Earth time)
        PLAYER_OBTAINS_ITEM           = 7706,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 7707,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 7708,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 7709,  -- You already possess that temporary item.
        NO_COMBINATION                = 7714,  -- You were unable to enter a combination.
        VOIDWALKER_DESPAWN            = 7745,  -- The monster fades before your eyes, a look of disappointment on its face.
        UNITY_WANTED_BATTLE_INTERACT  = 7776,  -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        REGIME_REGISTERED             = 9992,  -- New training regime registered!
        FRAGMENT_FAR_TOO_SMALL        = 11330, -- You obtain <keyitem>. However, it is far too small to house an adequate amount of energy. Alone, it serves no purpose.
        FRAGMENTS_MELD                = 11331, -- The tiny fragments of Lilisette's memory meld together to form <keyitem>!
        SEE_WEATHERED_GRAVESTONE      = 11332, -- You see a weathered gravestone.
        VOIDWALKER_NO_MOB             = 11333, -- The <keyitem> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR        = 11334, -- The <keyitem> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT           = 11335, -- The <keyitem> resonates [feebly/softly/solidly/strongly/very strongly/furiously], sending a radiant beam of light lancing towards a spot roughly <number> [yalm/yalms] [east/southeast/south/southwest/west/northwest/north/northeast] of here.
        VOIDWALKER_SPAWN_MOB          = 11336, -- A monster materializes out of nowhere!
        VOIDWALKER_UPGRADE_KI_1       = 11338, -- The <keyitem> takes on a slightly deeper hue and becomes <keyitem>!
        VOIDWALKER_UPGRADE_KI_2       = 11339, -- The <keyitem> takes on a deeper, richer hue and becomes <keyitem>!
        VOIDWALKER_BREAK_KI           = 11340, -- The <keyitem> shatters into tiny fragments.
        VOIDWALKER_OBTAIN_KI          = 11341, -- Obtained key item: <keyitem>!
        LEARNS_SPELL                  = 12841, -- <name> learns <spell>!
        UNCANNY_SENSATION             = 12843, -- You are assaulted by an uncanny sensation.
        COMMON_SENSE_SURVIVAL         = 12850, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        RAPTOR_OVERCOME_MUNCHIES      = 13003, -- The raptor has overcome the munchies! (<number>/<number>)
        RAPTOR_SECOND_WIND            = 13004, -- The raptor has gained a second wind!
        MEET_SYRILLIA                 = 13005, -- Meet up with Syrillia.
        RAPTOR_SPEEDS_OFF             = 13006, -- The raptor speeds off into the sunset...
    },
    mob =
    {
        AHTU              = GetFirstID('Ahtu'),
        BADSHAH_OFFSET    = GetFirstID('Badshah'),
        PRANKSTER_MAVERIX = GetFirstID('Prankster_Maverix'),
        STURMTIGER        = GetFirstID('Sturmtiger'),
        SUPARNA           = GetFirstID('Suparna'),
        SUPARNA_FLEDGLING = GetFirstID('Suparna_Fledgling'),
        TOTTERING_TOBY    = GetFirstID('Tottering_Toby'),
        VEGNIX_GREENTHUMB = GetFirstID('Vegnix_Greenthumb'),

        VOIDWALKER =
        {
            [xi.keyItem.CLEAR_ABYSSITE] =
            {
                17207722,  -- Lacus
                17207721,  -- Thunor
                17207720, -- Beorht
                17207719, -- Pruina
                17207718,  -- Puretos
                17207717,  -- Eorthe
                17207716, -- Deorc
                17207715, -- Aither
            },

            [xi.keyItem.COLORFUL_ABYSSITE] =
            {
                17207714, -- Skuld
                17207713  -- Urd
            },

            [xi.keyItem.YELLOW_ABYSSITE] =
            {
                17207712  -- Verthandi
            },

            [xi.keyItem.BLACK_ABYSSITE] =
            {
                17207711  -- Yilbegan
            }
        }
    },

    npc =
    {
        BLUE_BEAM_BASE   = GetFirstID('NPC[2a4]'),
        RAPTOR_FOOD_BASE = GetFirstID('Raptors_Food_0'),
        SYRILLIA         = GetFirstID('Syrillia'),
    },
}

return zones[xi.zone.BATALLIA_DOWNS]
