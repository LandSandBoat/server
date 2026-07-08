-----------------------------------
-- Area: Temple_of_Uggalepih
-----------------------------------
zones = zones or {}

zones[xi.zone.TEMPLE_OF_UGGALEPIH] =
{
    text =
    {
        NOTHING_HAPPENS               = 119,   -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6386,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6394,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6395,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6397,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6408,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6423,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7005,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7006,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7007,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7027,  -- Your party is unable to participate because certain members' levels are restricted.
        UNABLE_TO_PROGRESS_MISSION    = 7051,  -- You are unable to make further progress in Rhapsodies of Vana'diel due to an event occurring in the [Chains of Promathia/Treasures of Aht Urhgan/Wings of the Goddess/Seekers of Adoulin/Rise of the Zilart] missions.
        CONQUEST_BASE                 = 7072,  -- Tallying conquest results...
        REGION_POINTS_SANDORIA        = 7137,  -- San d'Oria's region points have increased!
        FISHING_MESSAGE_OFFSET        = 7231,  -- You can't fish here.
        CHEST_UNLOCKED                = 7340,  -- You unlock the chest!
        NO_REASON_TO_INVESTIGATE      = 7348,  -- There is no reason to investigate further.
        THE_BOX_IS_LOCKED             = 7349,  -- The box is locked.
        PAINTBRUSH_OFFSET             = 7352,  -- When the <keyitem> projects the deepest, darkest corner of your soul onto the blank canvas...only then will the doors to rancor open.
        FALLS_FROM_THE_BOOK           = 7362,  -- <item> falls from the book!
        THE_DOOR_IS_LOCKED            = 7376,  -- The door is locked. You might be able to open it with <item>.
        PROTECTED_BY_UNKNOWN_FORCE    = 7377,  -- The door is protected by some unknown force.
        YOUR_KEY_BREAKS               = 7379,  -- Your <item> breaks!
        FRAME_FOR_A_PAINTING          = 7383,  -- This is a frame for a painting.
        STILL_HANGS_ON_THE_WALL       = 7395,  -- The <keyitem> still hangs on the wall.
        DOOR_LOCKED                   = 7397,  -- The door is locked.
        HATE_RESET                    = 7450,  -- The built-up hate has been cleansed...!
        DOOR_SHUT                     = 7452,  -- The door is firmly shut.
        NO_HATE                       = 7453,  -- You have no built-up hate to cleanse.
        NOTHING_I_CANT_CUT            = 7457,  -- Nothing... Nothing... Nothing I can't cut... Nothing...
        YOU_CANNOT_OPEN_THIS_DOOR     = 7463,  -- You cannot open this door.
        OFFERING                      = 7464,  -- This platform looks a place for an offering.
        SOMETHING_IS_WRITTEN          = 7465,  -- Something is written here, but you cannot make out the words.
        SLIGHTLY_QUIVERS              = 7466,  -- The <keyitem> slightly quivers, but there is no sign of Lightbringer here.
        BEGINS_TO_QUIVER              = 7467,  -- The <keyitem> begins to quiver!
        SOME_SORT_OF_CEREMONY         = 7469,  -- Some sort of ceremony was performed here...
        NM_OFFSET                     = 7519,  -- It looks like some sort of device. A thin thread leads down to the floor...
        IT_IS_A_BEEHIVE               = 7523,  -- It is a beehive...
        BITS_OF_VEGETABLE             = 7524,  -- Bits of vegetable matter are strewn around. They appear to have been gnawed on by insects...
        SENSE_OMINOUS_PRESENCE        = 7526,  -- You sense an ominous presence...
        PLAYER_OBTAINS_ITEM           = 8461,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 8462,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 8463,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 8464,  -- You already possess that temporary item.
        NO_COMBINATION                = 8469,  -- You were unable to enter a combination.
        REGIME_REGISTERED             = 10547, -- New training regime registered!
        COMMON_SENSE_SURVIVAL         = 11607, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        UNITY_WANTED_BATTLE_INTERACT  = 11671, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
    },
    mob =
    {
        BERYL_FOOTED_MOLBERRY    = GetFirstID('Beryl-footed_Molberry'),
        CLEUVARION_M_RESOAIX     = GetFirstID('Cleuvarion_M_Resoaix'),
        COOK_OFFSET              = GetFirstID('Cook_Solberry'),
        CRIMSON_TOOTHED_PAWBERRY = GetFirstID('Crimson-toothed_Pawberry'),
        DEATH_FROM_ABOVE         = GetFirstID('Death_from_Above'),
        FLAUROS                  = GetFirstID('Flauros'),
        HABETROT                 = GetFirstID('Habetrot'),
        MIMIC                    = GetFirstID('Mimic'),
        NIO_A                    = GetFirstID('Nio-A'),
        NIO_HUM                  = GetFirstID('Nio-Hum'),
        ROMPAULION_S_CITALLE     = GetFirstID('Rompaulion_S_Citalle'),
        SACRIFICIAL_GOBLET       = GetFirstID('Sacrificial_Goblet'),
        SOZU_ROGBERRY            = GetFirstID('Sozu_Rogberry'),
        SOZU_SARBERRY            = GetFirstID('Sozu_Sarberry'),
        SOZU_TERBERRY            = GetFirstID('Sozu_Terberry'),
        TROMPE_LOEIL             = GetFirstID('Trompe_LOeil'),
        TEMPLE_GUARDIAN          = GetFirstID('Temple_Guardian'),
        TONBERRY_KINQ            = GetFirstID('Tonberry_Kinq'),
        YALLERY_BROWN            = GetFirstID('Yallery_Brown')
    },
    npc =
    {
        BOOK_OFFSET          = GetFirstID('Worn_Book'),
        CHEF_NONBERRY        = GetFirstID('Chef_Nonberry'),
        DOOR_TO_RANCOR       = GetFirstID('_mfb'),
        PLONGEUR_MONBERRY    = GetFirstID('Plongeur_Monberry'),
        TEMPLE_GUARDIAN_DOOR = GetFirstID('_mf1'),
        TREASURE_COFFER      = GetFirstID('Treasure_Coffer')
    },
}

return zones[xi.zone.TEMPLE_OF_UGGALEPIH]
