-----------------------------------
-- Area: Sauromugue_Champaign
-----------------------------------
zones = zones or {}

zones[xi.zone.SAUROMUGUE_CHAMPAIGN] =
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
        CARRIED_OVER_POINTS           = 7023,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7024,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7025,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7045,  -- Your party is unable to participate because certain members' levels are restricted.
        UNABLE_TO_PROGRESS            = 7069,  -- ou are unable to make further progress in Rhapsodies of Vana'diel due to an event occurring in the [Chains of Promathia/Treasures of Aht Urhgan/Wings of the Goddess/Seekers of Adoulin/Rise of the Zilart] missions.
        CONQUEST_BASE                 = 7087,  -- Tallying conquest results...
        MANY_TIGER_BONES              = 7246,  -- There are many tiger bones here...
        OLD_SABERTOOTH_DIALOG_I       = 7252,  -- You hear the distant roar of a tiger. It sounds as if the beast is approaching slowly...
        OLD_SABERTOOTH_DIALOG_II      = 7253,  -- The sound of the tiger's footsteps is growing louder.
        FISHING_MESSAGE_OFFSET        = 7254,  -- You can't fish here.
        DIG_THROW_AWAY                = 7267,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                  = 7269,  -- You dig and you dig, but find nothing.
        FOUND_ITEM_WITH_EASE          = 7344,  -- It appears your chocobo found this item with ease.
        THF_AF_MOB                    = 7431,  -- Something has come down from the tower!
        THF_AF_WALL_OFFSET            = 7450,  -- It is impossible to climb this wall with your bare hands.
        PLAYER_OBTAINS_ITEM           = 7513,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 7514,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 7515,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 7516,  -- You already possess that temporary item.
        NO_COMBINATION                = 7521,  -- You were unable to enter a combination.
        VOIDWALKER_DESPAWN            = 7552,  -- The monster fades before your eyes, a look of disappointment on its face.
        UNITY_WANTED_BATTLE_INTERACT  = 7583,  -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        TIME_ELAPSED                  = 7665,  -- Time Elapsed: / [hour/hours] (Vanadiel Time) / [minute/minutes] and [second/seconds] (Earth time)
        REGIME_REGISTERED             = 9822,  -- New training regime registered!
        VOIDWALKER_NO_MOB             = 10995, -- The <keyitem> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR        = 10996, -- The <keyitem> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT           = 10997, -- The <keyitem> resonates [feebly/softly/solidly/strongly/very strongly/furiously], sending a radiant beam of light lancing towards a spot roughly <number> [yalm/yalms] [east/southeast/south/southwest/west/northwest/north/northeast] of here.
        VOIDWALKER_SPAWN_MOB          = 10998, -- A monster materializes out of nowhere!
        VOIDWALKER_UPGRADE_KI_1       = 11000, -- The <keyitem> takes on a slightly deeper hue and becomes <keyitem>!
        VOIDWALKER_UPGRADE_KI_2       = 11001, -- The <keyitem> takes on a deeper, richer hue and becomes <keyitem>!
        VOIDWALKER_BREAK_KI           = 11002, -- The <keyitem> shatters into tiny fragments.
        VOIDWALKER_OBTAIN_KI          = 11003, -- Obtained key item: <keyitem>!
        LEARNS_SPELL                  = 12503, -- <name> learns <spell>!
        UNCANNY_SENSATION             = 12505, -- You are assaulted by an uncanny sensation.
        COMMON_SENSE_SURVIVAL         = 12512, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        DEADLY_DODO        = GetFirstID('Deadly_Dodo'),
        BLIGHTING_BRAND    = GetFirstID('Blighting_Brand'),
        BASHE              = GetFirstID('Bashe'),
        OLD_SABERTOOTH     = GetFirstID('Old_Sabertooth'),
        ROC                = GetFirstID('Roc'),
        CLIMBPIX_HIGHRISE  = GetFirstID('Climbpix_Highrise'),
        DRIBBLIX_GREASEMAW = GetFirstID('Dribblix_Greasemaw'),

        VOIDWALKER =
        {
            [xi.keyItem.CLEAR_ABYSSITE] =
            {
                17269126,  -- Lacus
                17269125,  -- Thunor
                17269124, -- Beorht
                17269123, -- Pruina
                17269122,  -- Puretos
                17269121,  -- Eorthe
                17269120, -- Deorc
                17269119, -- Aither
            },

            [xi.keyItem.COLORFUL_ABYSSITE] =
            {
                17269118, -- Skuld
                17269117, -- Urd
            },

            [xi.keyItem.YELLOW_ABYSSITE] =
            {
                17269116, -- Verthandi
            },

            [xi.keyItem.BLACK_ABYSSITE] =
            {
                17269115, -- Yilbegan
            }
        }
    },

    npc =
    {
        QM2 = GetFirstID('qm2'), -- THF AF2
    },
}

return zones[xi.zone.SAUROMUGUE_CHAMPAIGN]
