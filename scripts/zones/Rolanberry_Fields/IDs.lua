-----------------------------------
-- Area: Rolanberry_Fields
-----------------------------------
zones = zones or {}

zones[xi.zone.ROLANBERRY_FIELDS] =
{
    text =
    {
        NOTHING_HAPPENS               = 141,   -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6406,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6412,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6413,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6415,  -- Obtained key item: <keyitem>.
        NOT_ENOUGH_GIL                = 6417,  -- You do not have enough gil.
        FELLOW_MESSAGE_OFFSET         = 6441,  -- I'm ready. I suppose.
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
        SIGN                          = 7416,  -- North: Grand Duchy of Jeuno, Sauromugue Champaign South: Pashhow Marshlands
        TIME_ELAPSED                  = 7473,  -- Time Elapsed: / [hour/hours] (Vanadiel Time) / [minute/minutes] and [second/seconds] (Earth time)
        PLAYER_OBTAINS_ITEM           = 7597,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 7598,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 7599,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 7600,  -- You already possess that temporary item.
        NO_COMBINATION                = 7605,  -- You were unable to enter a combination.
        VOIDWALKER_DESPAWN            = 7636,  -- The monster fades before your eyes, a look of disappointment on its face.
        UNITY_WANTED_BATTLE_INTERACT  = 7667,  -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        REGIME_REGISTERED             = 9783,  -- New training regime registered!
        VOIDWALKER_NO_MOB             = 10956, -- The <keyitem> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR        = 10957, -- The <keyitem> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT           = 10958, -- The <keyitem> resonates [feebly/softly/solidly/strongly/very strongly/furiously], sending a radiant beam of light lancing towards a spot roughly <number> [yalm/yalms] [east/southeast/south/southwest/west/northwest/north/northeast] of here.
        VOIDWALKER_SPAWN_MOB          = 10959, -- A monster materializes out of nowhere!
        VOIDWALKER_UPGRADE_KI_1       = 10961, -- The <keyitem> takes on a slightly deeper hue and becomes <keyitem>!
        VOIDWALKER_UPGRADE_KI_2       = 10962, -- The <keyitem> takes on a deeper, richer hue and becomes <keyitem>!
        VOIDWALKER_BREAK_KI           = 10963, -- The <keyitem> shatters into tiny fragments.
        VOIDWALKER_OBTAIN_KI          = 10964, -- Obtained key item: <keyitem>!
        AWAIT_YOUR_CHALLENGE          = 12183, -- We await your challenge, traveler.
        LACK_LEGION_POINTS            = 12220, -- It would seem that you lack the necessary amount of Legion points.
        LEARNS_SPELL                  = 12268, -- <name> learns <spell>!
        UNCANNY_SENSATION             = 12270, -- You are assaulted by an uncanny sensation.
        COMMON_SENSE_SURVIVAL         = 12277, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },

    mob =
    {
        BLACK_TRIPLE_STARS = GetTableOfIDs('Black_Triple_Stars'), -- 2 NMs
        DROOLING_DAISY     = GetFirstID('Drooling_Daisy'),
        ELDRITCH_EDGE      = GetFirstID('Eldritch_Edge'),
        SILK_CATERPILLAR   = GetFirstID('Silk_Caterpillar'),
        SIMURGH            = GetFirstID('Simurgh'),
        CHUGLIX_BERRYPAWS  = GetFirstID('Chuglix_Berrypaws'),

        VOIDWALKER =
        {
            [xi.keyItem.CLEAR_ABYSSITE] =
            {
                17228261,  -- Lacus
                17228260,  -- Thunor
                17228259, -- Beorht
                17228258, -- Pruina
                17228257,  -- Puretos
                17228256,  -- Eorthe
                17228255, -- Deorc
                17228254, -- Aither
            },

            [xi.keyItem.COLORFUL_ABYSSITE] =
            {
                17228253, -- Skuld
                17228252, -- Urd
            },

            [xi.keyItem.YELLOW_ABYSSITE] =
            {
                17228251, -- Verthandi
            },

            [xi.keyItem.BLACK_ABYSSITE] =
            {
                17228250, -- Yilbegan
            }
        }
    },

    npc =
    {
    },
}

return zones[xi.zone.ROLANBERRY_FIELDS]
