-----------------------------------
-- Area: East_Ronfaure
-----------------------------------
zones = zones or {}

zones[xi.zone.EAST_RONFAURE] =
{
    text =
    {
        NOTHING_HAPPENS               = 141,   -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6409,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6417,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6418,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6420,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6431,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6446,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7028,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7029,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7030,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7050,  -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7095,  -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET        = 7254,  -- You can't fish here.
        DIG_THROW_AWAY                = 7267,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                  = 7269,  -- You dig and you dig, but find nothing.
        FOUND_ITEM_WITH_EASE          = 7344,  -- It appears your chocobo found this item with ease.
        BEASTMEN_CACHE_OFFSET         = 7349,  -- You discover a cache of beastman resources and receive <number> conquest point[/s]!
        RAYOCHINDOT_DIALOG            = 7435,  -- If you are outmatched, run to the city as quickly as you can.
        CROTEILLARD_DIALOG            = 7436,  -- Sorry, no chatting while I'm on duty.
        ANDELAIN_DIALOG               = 7437,  -- My name is Andelain. As part of my devotions, I come here each day to pray.
        MAY_ONLY_EAT                  = 7438,  -- During this time, I may eat only three <item> a day for nourishment. No more, no less. And no other food may I eat.
        THANKS_TO_GODDESS             = 7439,  -- Thanks be to the Goddess in her benevolence!
        CANNOT_ACCEPT_ALMS            = 7440,  -- I am currently undergoing devotions, and as such, am not allowed to take alms from those on the road. I am sorry, but I cannot accept this.
        GATES_OF_PARADISE_OPEN        = 7441,  -- May the Gates of Paradise open to all...
        APPRECIATE_OFFER_DECLINE      = 7442,  -- I appreciate your offer, but I only need one <item>. Thank you for your kindness.
        THE_WATER_SPARKLES            = 7460,  -- The water sparkles in the light.
        CHEVAL_RIVER_WATER            = 7461,  -- You fill your waterskin with water from the river. You now have <item>.
        BLESSED_WATERSKIN             = 7480,  -- To get water, trade the waterskin you hold with the river.
        LOGGING_IS_POSSIBLE_HERE      = 7511,  -- Logging is possible here if you have <item>.
        PLAYER_OBTAINS_ITEM           = 7522,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 7523,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 7524,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 7525,  -- You already possess that temporary item.
        NO_COMBINATION                = 7530,  -- You were unable to enter a combination.
        VOIDWALKER_DESPAWN            = 7561,  -- The monster fades before your eyes, a look of disappointment on its face.
        UNITY_WANTED_BATTLE_INTERACT  = 7592,  -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        REGIME_REGISTERED             = 9892,  -- New training regime registered!
        VOIDWALKER_NO_MOB             = 11065, -- The <keyitem> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR        = 11066, -- The <keyitem> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT           = 11067, -- The <keyitem> resonates [feebly/softly/solidly/strongly/very strongly/furiously], sending a radiant beam of light lancing towards a spot roughly <number> [yalm/yalms] [east/southeast/south/southwest/west/northwest/north/northeast] of here.
        VOIDWALKER_SPAWN_MOB          = 11068, -- A monster materializes out of nowhere!
        VOIDWALKER_UPGRADE_KI_1       = 11070, -- The <keyitem> takes on a slightly deeper hue and becomes <keyitem>!
        VOIDWALKER_UPGRADE_KI_2       = 11071, -- The <keyitem> takes on a deeper, richer hue and becomes <keyitem>!
        VOIDWALKER_BREAK_KI           = 11072, -- The <keyitem> shatters into tiny fragments.
        VOIDWALKER_OBTAIN_KI          = 11073, -- Obtained key item: <keyitem>!
        LEARNS_SPELL                  = 11963, -- <name> learns <spell>!
        UNCANNY_SENSATION             = 11965, -- You are assaulted by an uncanny sensation.
    },

    mob =
    {
        BIGMOUTH_BILLY = GetFirstID('Bigmouth_Billy'),
        SWAMFISK       = GetTableOfIDs('Swamfisk'), -- 2 NMs

        VOIDWALKER =
        {
            [xi.keyItem.CLEAR_ABYSSITE] =
            {
                17191334, -- Sunderclaw
                17191333, -- Sunderclaw
                17191332, -- Sunderclaw
                17191331, -- Sunderclaw
                17191330,  -- Quagmire Pugil
                17191329,  -- Quagmire Pugil
                17191328,  -- Quagmire Pugil
                17191327,  -- Quagmire Pugil
            },

            [xi.keyItem.COLORFUL_ABYSSITE] =
            {
                17191326, -- Capricornus
                17191325  -- Yacumama
            },

            [xi.keyItem.BLUE_ABYSSITE] =
            {
                17191324  -- Krabkatoa
            },

            [xi.keyItem.BLACK_ABYSSITE] =
            {
                17191323  -- Yilbegan
            }
        }
    },

    npc =
    {
        LOGGING = GetTableOfIDs('Logging_Point'),
    },
}

return zones[xi.zone.EAST_RONFAURE]
