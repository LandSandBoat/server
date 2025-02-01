
xi = xi or {}
xi.quest = xi.quest or {}

-----------------------------------
--
--  QUESTS ID
--
-----------------------------------

xi.quest.area =
{
    [xi.questLog.SANDORIA]    = 'sandoria',
    [xi.questLog.BASTOK]      = 'bastok',
    [xi.questLog.WINDURST]    = 'windurst',
    [xi.questLog.JEUNO]       = 'jeuno',
    [xi.questLog.OTHER_AREAS] = 'otherAreas',
    [xi.questLog.OUTLANDS]    = 'outlands',
    [xi.questLog.AHT_URHGAN]  = 'ahtUrhgan',
    [xi.questLog.CRYSTAL_WAR] = 'crystalWar',
    [xi.questLog.ABYSSEA]     = 'abyssea',
    [xi.questLog.ADOULIN]     = 'adoulin',
    [xi.questLog.COALITION]   = 'coalition',
}

xi.quest.id =
{
    -----------------------------------
    --  San d'Oria - 0
    -----------------------------------
    [xi.quest.area[xi.questLog.SANDORIA]] =
    {
        A_SENTRYS_PERIL                 = 0,  -- + Converted
        WATERS_OF_THE_CHEVAL            = 1,  -- + Converted
        ROSEL_THE_ARMORER               = 2,  -- + Converted
        THE_PICKPOCKET                  = 3,  -- + Converted
        FATHER_AND_SON                  = 4,  -- + Converted
        THE_SEAMSTRESS                  = 5,  -- + Converted
        THE_DISMAYED_CUSTOMER           = 6,  -- + Converted
        THE_TRADER_IN_THE_FOREST        = 7,  -- + Converted
        THE_SWEETEST_THINGS             = 8,  -- + Converted
        THE_VICASQUES_SERMON            = 9,  -- + Converted
        A_SQUIRES_TEST                  = 10, -- + Converted
        GRAVE_CONCERNS                  = 11, -- ± Converted
        THE_BRUGAIRE_CONSORTIUM         = 12, -- + Converted
        LIZARD_SKINS                    = 15, -- + Converted
        FLYERS_FOR_REGINE               = 16, -- +
        GATES_TO_PARADISE               = 18, -- +
        A_SQUIRES_TEST_II               = 19, -- + Converted
        TO_CURE_A_COUGH                 = 20, -- +
        TIGERS_TEETH                    = 23, -- ± Converted
        UNDYING_FLAMES                  = 26, -- +
        A_PURCHASE_OF_ARMS              = 27, -- +
        A_KNIGHTS_TEST                  = 29, -- + Converted
        THE_MEDICINE_WOMAN              = 30, -- +
        BLACK_TIGER_SKINS               = 31, -- + Converted
        GROWING_FLOWERS                 = 58, -- ± Converted
        TRIAL_BY_ICE                    = 59, -- +
        THE_GENERALS_SECRET             = 60, -- ± Converted
        THE_RUMOR                       = 61, -- ±
        HER_MAJESTYS_GARDEN             = 62, -- +
        INTRODUCTION_TO_TEAMWORK        = 63,
        INTERMEDIATE_TEAMWORK           = 64,
        ADVANCED_TEAMWORK               = 65,
        GRIMY_SIGNPOSTS                 = 66, -- +
        A_JOB_FOR_THE_CONSORTIUM        = 67,
        TROUBLE_AT_THE_SLUICE           = 68, -- +
        THE_MERCHANTS_BIDDING           = 69, -- ±
        UNEXPECTED_TREASURE             = 70,
        BLACKMAIL                       = 71, -- +
        THE_SETTING_SUN                 = 72, -- +
        DISTANT_LOYALTIES               = 74, -- ± Converted
        THE_RIVALRY                     = 75, -- ±
        THE_COMPETITION                 = 76, -- ±
        STARTING_A_FLAME                = 77, -- ±
        FEAR_OF_THE_DARK                = 78, -- +
        WARDING_VAMPIRES                = 79, -- +
        SLEEPLESS_NIGHTS                = 80, -- ±
        LUFETS_LAKE_SALT                = 81, -- ±
        HEALING_THE_LAND                = 82, -- ±
        SORCERY_OF_THE_NORTH            = 83, -- ±
        THE_CRIMSON_TRIAL               = 84, -- ± Converted
        ENVELOPED_IN_DARKNESS           = 85, -- ± Converted
        PEACE_FOR_THE_SPIRIT            = 86, -- ±
        MESSENGER_FROM_BEYOND           = 87, -- ±
        PRELUDE_OF_BLACK_AND_WHITE      = 88, -- ±
        PIEUJES_DECISION                = 89, -- +
        SHARPENING_THE_SWORD            = 90, -- ±
        A_BOYS_DREAM                    = 91, -- ±
        UNDER_OATH                      = 92,
        THE_HOLY_CREST                  = 93, -- +
        A_CRAFTSMANS_WORK               = 94, -- ±
        CHASING_QUOTAS                  = 95, -- +
        KNIGHT_STALKER                  = 96, -- +
        ECO_WARRIOR                     = 97,
        METHODS_CREATE_MADNESS          = 98, -- + Converted
        SOULS_IN_SHADOW                 = 99, -- + Converted
        A_TASTE_FOR_MEAT                = 100, -- + Converted
        EXIT_THE_GAMBLER                = 101, -- ±
        OLD_WOUNDS                      = 102, -- + Converted
        ESCORT_FOR_HIRE                 = 103,
        A_DISCERNING_EYE                = 104,
        A_TIMELY_VISIT                  = 105,
        FIT_FOR_A_PRINCE                = 106,
        TRIAL_SIZE_TRIAL_BY_ICE         = 107, -- +
        SIGNED_IN_BLOOD                 = 108, -- + Converted
        TEA_WITH_A_TONBERRY             = 109, -- + Converted
        SPICE_GALS                      = 110,
        OVER_THE_HILLS_AND_FAR_AWAY     = 112,
        LURE_OF_THE_WILDCAT             = 113, -- ±
        ATELLOUNES_LAMENT               = 114, -- + Converted
        THICK_SHELLS                    = 117, -- ±
        FOREST_FOR_THE_TREES            = 118,
        TRUST_SANDORIA                  = 119, -- ±
    },

    -----------------------------------
    --  Bastok - 1
    -----------------------------------
    [xi.quest.area[xi.questLog.BASTOK]] =
    {
        THE_SIRENS_TEAR                 = 0,  -- ± Converted
        BEAUTY_AND_THE_GALKA            = 1,  -- ± Converted
        WELCOME_TO_BASTOK               = 2,  -- + Converted
        GUEST_OF_HAUTEUR                = 3,  -- + Converted
        THE_QUADAVS_CURSE               = 4,  -- ± Converted
        OUT_OF_ONES_SHELL               = 5,  -- ± Converted
        HEARTS_OF_MYTHRIL               = 6,  -- ± Converted
        THE_ELEVENTHS_HOUR              = 7,  -- ± Converted
        SHADY_BUSINESS                  = 8,  -- ± Converted
        A_FOREMANS_BEST_FRIEND          = 9,  -- ± Converted
        BREAKING_STONES                 = 10, -- + Converted
        THE_COLD_LIGHT_OF_DAY           = 11, -- + Converted
        GOURMET                         = 12, -- ± Converted
        THE_ELVAAN_GOLDSMITH            = 13, -- ± Converted
        A_FLASH_IN_THE_PAN              = 14, -- ± Converted
        SMOKE_ON_THE_MOUNTAIN           = 15, -- ± Converted
        STAMP_HUNT                      = 16, -- + Converted
        FOREVER_TO_HOLD                 = 17, -- ± Converted
        TILL_DEATH_DO_US_PART           = 18, -- ± Converted
        FALLEN_COMRADES                 = 19, -- ± Converted
        RIVALS                          = 20, -- + Converted
        MOM_THE_ADVENTURER              = 21, -- + Converted
        THE_SIGNPOST_MARKS_THE_SPOT     = 22, -- + Converted
        PAST_PERFECT                    = 23, -- ± Converted
        STARDUST                        = 24, -- + Converted
        MEAN_MACHINE                    = 25, -- ± Converted
        CIDS_SECRET                     = 26, -- ± Converted
        THE_USUAL                       = 27, -- ± Converted
        BLADE_OF_DARKNESS               = 28, -- ± Converted
        FATHER_FIGURE                   = 29, -- ± Converted
        THE_RETURN_OF_THE_ADVENTURER    = 30, -- ± Converted
        DRACHENFALL                     = 31, -- + Converted
        VENGEFUL_WRATH                  = 32, -- ± Converted
        BEADEAUX_SMOG                   = 33, -- ± Converted
        THE_CURSE_COLLECTOR             = 34, -- + Converted
        FEAR_OF_FLYING                  = 35, -- + Converted
        THE_WISDOM_OF_ELDERS            = 36, -- ± Converted
        GROCERIES                       = 37, -- ± Converted
        THE_BARE_BONES                  = 38, -- ± Converted
        MINESWEEPER                     = 39, -- ± Converted
        THE_DARKSMITH                   = 40, -- ± Converted
        BUCKETS_OF_GOLD                 = 41, -- ± Converted
        THE_STARS_OF_IFRIT              = 42, -- ± Converted
        LOVE_AND_ICE                    = 43, -- ± Converted
        BRYGID_THE_STYLIST              = 44, -- ± Converted
        THE_GUSTABERG_TOUR              = 45,
        BITE_THE_DUST                   = 46, -- ± Converted
        BLADE_OF_DEATH                  = 47, -- + Converted
        SILENCE_OF_THE_RAMS             = 48, -- ± Converted
        ALTANAS_SORROW                  = 49, -- + Converted
        A_LADYS_HEART                   = 50, -- ± Converted
        GHOSTS_OF_THE_PAST              = 51, -- ± Converted
        THE_FIRST_MEETING               = 52, -- ± Converted
        TRUE_STRENGTH                   = 53, -- ± Converted
        THE_DOORMAN                     = 54, -- ± Converted
        THE_TALEKEEPERS_TRUTH           = 55, -- ± Converted
        THE_TALEKEEPERS_GIFT            = 56, -- ± Converted
        DARK_LEGACY                     = 57, -- ± Converted
        DARK_PUPPET                     = 58, -- ± Converted
        BLADE_OF_EVIL                   = 59, -- ± Converted
        AYAME_AND_KAEDE                 = 60, -- ± Converted
        TRIAL_BY_EARTH                  = 61, -- ± Converted
        A_TEST_OF_TRUE_LOVE             = 62, -- ± Converted
        LOVERS_IN_THE_DUSK              = 63, -- ± Converted
        WISH_UPON_A_STAR                = 64, -- ± Converted
        ECO_WARRIOR                     = 65, -- ±
        THE_WEIGHT_OF_YOUR_LIMITS       = 66, -- + Converted
        SHOOT_FIRST_ASK_QUESTIONS_LATER = 67, -- + Converted
        INHERITANCE                     = 68, -- + Converted
        THE_WALLS_OF_YOUR_MIND          = 69, -- + Converted
        ESCORT_FOR_HIRE                 = 70,
        A_DISCERNING_EYE                = 71,
        TRIAL_SIZE_TRIAL_BY_EARTH       = 72, -- + Converted
        FADED_PROMISES                  = 73, -- ± Converted
        BRYGID_THE_STYLIST_RETURNS      = 74, -- ± Converted
        OUT_OF_THE_DEPTHS               = 75,
        ALL_BY_MYSELF                   = 76,
        A_QUESTION_OF_FAITH             = 77,
        RETURN_OF_THE_DEPTHS            = 78,
        TEAK_ME_TO_THE_STARS            = 79, -- ± Converted
        HYPER_ACTIVE                    = 80,
        THE_NAMING_GAME                 = 81,
        CHIPS                           = 82,
        BAIT_AND_SWITCH                 = 83,
        LURE_OF_THE_WILDCAT             = 84, -- + Converted
        ACHIEVING_TRUE_POWER            = 85,
        TOO_MANY_CHEFS                  = 86, -- ±
        A_PROPER_BURIAL                 = 87,
        FULLY_MENTAL_ALCHEMIST          = 88,
        SYNERGUSTIC_PURSUITS            = 89,
        THE_WONDROUS_WHATCHAMACALLIT    = 90,
        SYNERGISTIC_SUPPORT             = 91,
        TRUST_BASTOK                    = 92, -- ± Converted
    },

    -----------------------------------
    --  Windurst - 2
    -----------------------------------
    [xi.quest.area[xi.questLog.WINDURST]] =
    {
        HAT_IN_HAND                     = 0,  -- +
        A_FEATHER_IN_ONES_CAP           = 1,  -- +
        A_CRISIS_IN_THE_MAKING          = 2,  -- +
        MAKING_AMENDS                   = 3,  -- +
        MAKING_THE_GRADE                = 4,  -- + Converted
        IN_A_PICKLE                     = 5,  -- +
        WONDERING_MINSTREL              = 6,  -- +
        A_POSE_BY_ANY_OTHER_NAME        = 7,  -- + Converted
        MAKING_AMENS                    = 8,  -- +
        THE_MOONLIT_PATH                = 9,  -- +
        STAR_STRUCK                     = 10, -- ± Converted
        BLAST_FROM_THE_PAST             = 11, -- + Converted
        A_SMUDGE_ON_ONES_RECORD         = 12, -- ± Converted
        CHASING_TALES                   = 13, -- + Converted
        FOOD_FOR_THOUGHT                = 14, -- + Converted
        OVERNIGHT_DELIVERY              = 15, -- + Converted
        WATER_WAY_TO_GO                 = 16, -- + Converted
        BLUE_RIBBON_BLUES               = 17, -- + Converted
        THE_ALL_NEW_C_3000              = 18, -- +
        THE_POSTMAN_ALWAYS_KOS_TWICE    = 19, -- +
        EARLY_BIRD_CATCHES_THE_BOOKWORM = 20, -- + Converted
        CATCH_IT_IF_YOU_CAN             = 21, -- +
        ALL_AT_SEA                      = 23,
        THE_ALL_NEW_C_2000              = 24, -- ±
        MIHGOS_AMIGO                    = 25, -- +
        ROCK_RACKETEER                  = 26, -- +
        CHOCOBILIOUS                    = 27, -- +
        TEACHERS_PET                    = 28, -- + Converted
        REAP_WHAT_YOU_SOW               = 29, -- +
        GLYPH_HANGER                    = 30, -- + Converted
        THE_FANGED_ONE                  = 31, -- +
        CURSES_FOILED_AGAIN_1           = 32, -- + Converted
        CURSES_FOILED_AGAIN_2           = 33, -- + Converted
        MANDRAGORA_MAD                  = 34, -- +
        TO_BEE_OR_NOT_TO_BEE            = 35, -- +
        TRUTH_JUSTICE_AND_THE_ONION_WAY = 36, -- + Converted
        MAKING_HEADLINES                = 37, -- +
        SCOOPED                         = 38,
        CREEPY_CRAWLIES                 = 39, -- +
        KNOW_ONES_ONIONS                = 40, -- + Converted
        INSPECTORS_GADGET               = 41, -- + Converted
        ONION_RINGS                     = 42, -- + Converted
        A_GREETING_CARDIAN              = 43, -- +
        LEGENDARY_PLAN_B                = 44, -- +
        IN_A_STEW                       = 45, -- +
        LET_SLEEPING_DOGS_LIE           = 46,
        CAN_CARDIANS_CRY                = 47, -- +
        WONDER_WANDS                    = 48, -- +
        HEAVEN_CENT                     = 49,
        SAY_IT_WITH_FLOWERS             = 50, -- +
        HOIST_THE_JELLY_ROGER           = 51, -- +
        SOMETHING_FISHY                 = 52, -- +
        TO_CATCH_A_FALLING_STAR         = 53, -- +
        PAYING_LIP_SERVICE              = 60, -- +
        THE_AMAZIN_SCORPIO              = 61, -- +
        TWINSTONE_BONDING               = 62, -- +
        CURSES_FOILED_A_GOLEM           = 63, -- + Converted
        ACTING_IN_GOOD_FAITH            = 64, -- ± Converted
        FLOWER_CHILD                    = 65, -- ± Converted
        THE_THREE_MAGI                  = 66, -- ±
        RECOLLECTIONS                   = 67, -- ±
        THE_ROOT_OF_THE_PROBLEM         = 68,
        THE_TENSHODO_SHOWDOWN           = 69, -- + Converted
        AS_THICK_AS_THIEVES             = 70, -- + Converted
        HITTING_THE_MARQUISATE          = 71, -- + Converted
        SIN_HUNTING                     = 72, -- +
        FIRE_AND_BRIMSTONE              = 73, -- +
        UNBRIDLED_PASSION               = 74, -- +
        I_CAN_HEAR_A_RAINBOW            = 75, -- +
        CRYING_OVER_ONIONS              = 76, -- + Converted
        WILD_CARD                       = 77, -- + Converted
        THE_PROMISE                     = 78, -- + Converted
        NOTHING_MATTERS                 = 79,
        TORAIMARAI_TURMOIL              = 80, -- + Converted
        THE_PUPPET_MASTER               = 81, -- + Converted
        CLASS_REUNION                   = 82, -- +
        CARBUNCLE_DEBACLE               = 83, -- +
        ECO_WARRIOR                     = 84, -- +
        FROM_SAPLINGS_GROW              = 85, -- + Converted
        ORASTERY_WOES                   = 86, -- + Converted
        BLOOD_AND_GLORY                 = 87, -- + Converted
        ESCORT_FOR_HIRE                 = 88,
        A_DISCERNING_EYE                = 89,
        TUNING_IN                       = 90,
        TUNING_OUT                      = 91,
        ONE_GOOD_DEED                   = 92,
        WAKING_DREAMS                   = 93, -- +
        LURE_OF_THE_WILDCAT             = 94, -- +
        BABBAN_NY_MHEILLEA              = 95,
        TRUST_WINDURST                  = 96, -- +
    },

    -----------------------------------
    --  Jeuno - 3
    -----------------------------------
    [xi.quest.area[xi.questLog.JEUNO]] =
    {
        CREST_OF_DAVOI                  = 0,  -- + Converted
        SAVE_MY_SISTER                  = 1,  -- + Converted
        A_CLOCK_MOST_DELICATE           = 2,  -- + Converted
        SAVE_THE_CLOCK_TOWER            = 3,  -- + Converted
        CHOCOBOS_WOUNDS                 = 4,  -- + Converted
        SAVE_MY_SON                     = 5,  -- + Converted
        A_CANDLELIGHT_VIGIL             = 6,  -- + Converted
        THE_WONDER_MAGIC_SET            = 7,  -- +
        THE_KIND_CARDIAN                = 8,  -- +
        YOUR_CRYSTAL_BALL               = 9,  -- +
        COLLECT_TARUT_CARDS             = 10, -- +
        THE_OLD_MONUMENT                = 11, -- + Converted
        A_MINSTREL_IN_DESPAIR           = 12, -- +
        RUBBISH_DAY                     = 13, -- +
        NEVER_TO_RETURN                 = 14, -- +
        COMMUNITY_SERVICE               = 15, -- +
        COOKS_PRIDE                     = 16, -- +
        TENSHODO_MEMBERSHIP             = 17, -- +
        THE_LOST_CARDIAN                = 18, -- +
        PATH_OF_THE_BEASTMASTER         = 19, -- + Converted
        PATH_OF_THE_BARD                = 20, -- +
        THE_CLOCKMASTER                 = 21, -- + Converted
        CANDLE_MAKING                   = 22, -- + Converted
        CHILDS_PLAY                     = 23, -- + Converted
        NORTHWARD                       = 24, -- + Converted
        THE_ANTIQUE_COLLECTOR           = 25, -- + Converted
        DEAL_WITH_TENSHODO              = 26, -- + Converted
        THE_GOBBIEBAG_PART_I            = 27, -- + Converted
        THE_GOBBIEBAG_PART_II           = 28, -- + Converted
        THE_GOBBIEBAG_PART_III          = 29, -- + Converted
        THE_GOBBIEBAG_PART_IV           = 30, -- + Converted
        MYSTERIES_OF_BEADEAUX_I         = 31, -- + Converted
        MYSTERIES_OF_BEADEAUX_II        = 32, -- + Converted
        MYSTERY_OF_FIRE                 = 33,
        MYSTERY_OF_WATER                = 34,
        MYSTERY_OF_EARTH                = 35,
        MYSTERY_OF_WIND                 = 36,
        MYSTERY_OF_ICE                  = 37,
        MYSTERY_OF_LIGHTNING            = 38,
        MYSTERY_OF_LIGHT                = 39,
        MYSTERY_OF_DARKNESS             = 40,
        FISTFUL_OF_FURY                 = 41, -- +
        THE_GOBLIN_TAILOR               = 42, -- +
        PRETTY_LITTLE_THINGS            = 43, -- ± Converted
        BORGHERTZS_WARRING_HANDS        = 44, -- +
        BORGHERTZS_STRIKING_HANDS       = 45, -- +
        BORGHERTZS_HEALING_HANDS        = 46, -- +
        BORGHERTZS_SORCEROUS_HANDS      = 47, -- +
        BORGHERTZS_VERMILLION_HANDS     = 48, -- +
        BORGHERTZS_SNEAKY_HANDS         = 49, -- +
        BORGHERTZS_STALWART_HANDS       = 50, -- +
        BORGHERTZS_SHADOWY_HANDS        = 51, -- +
        BORGHERTZS_WILD_HANDS           = 52, -- +
        BORGHERTZS_HARMONIOUS_HANDS     = 53, -- +
        BORGHERTZS_CHASING_HANDS        = 54, -- +
        BORGHERTZS_LOYAL_HANDS          = 55, -- +
        BORGHERTZS_LURKING_HANDS        = 56, -- +
        BORGHERTZS_DRAGON_HANDS         = 57, -- +
        BORGHERTZS_CALLING_HANDS        = 58, -- +
        AXE_THE_COMPETITION             = 59, -- + Converted
        WINGS_OF_GOLD                   = 60, -- ± Converted
        SCATTERED_INTO_SHADOW           = 61, -- ±
        A_NEW_DAWN                      = 62,
        PAINFUL_MEMORY                  = 63, -- +
        THE_REQUIEM                     = 64, -- +
        THE_CIRCLE_OF_TIME              = 65, -- +
        SEARCHING_FOR_THE_RIGHT_WORDS   = 66,
        BEAT_AROUND_THE_BUSHIN          = 67, -- +
        DUCAL_HOSPITALITY               = 68,
        IN_THE_MOOD_FOR_LOVE            = 69,
        EMPTY_MEMORIES                  = 70, -- + Converted
        HOOK_LINE_AND_SINKER            = 71, -- + Converted
        A_CHOCOBOS_TALE                 = 72, -- + Converted
        A_REPUTATION_IN_RUINS           = 73,
        THE_GOBBIEBAG_PART_V            = 74, -- + Converted
        THE_GOBBIEBAG_PART_VI           = 75, -- + Converted
        BEYOND_THE_SUN                  = 76, -- + Converted
        UNLISTED_QUALITIES              = 77,
        GIRL_IN_THE_LOOKING_GLASS       = 78,
        MIRROR_MIRROR                   = 79, -- +
        PAST_REFLECTIONS                = 80,
        BLIGHTED_GLOOM                  = 81,
        BLESSED_RADIANCE                = 82,
        MIRROR_IMAGES                   = 83,
        CHAMELEON_CAPERS                = 84,
        REGAINING_TRUST                 = 85,
        STORMS_OF_FATE                  = 86, -- + Converted
        MIXED_SIGNALS                   = 87,
        SHADOWS_OF_THE_DEPARTED         = 88, -- + Converted
        APOCALYPSE_NIGH                 = 89, -- + Converted
        LURE_OF_THE_WILDCAT             = 90, -- ±
        THE_ROAD_TO_AHT_URHGAN          = 91, -- + Converted
        CHOCOBO_ON_THE_LOOSE            = 92, -- + Converted
        THE_GOBBIEBAG_PART_VII          = 93, -- + Converted
        THE_GOBBIEBAG_PART_VIII         = 94, -- + Converted
        LAKESIDE_MINUET                 = 95, -- + Converted
        THE_UNFINISHED_WALTZ            = 96, -- ± Converted
        THE_ROAD_TO_DIVADOM             = 97, -- + Converted
        COMEBACK_QUEEN                  = 98, -- + Converted
        A_FURIOUS_FINALE                = 99,
        THE_MIRACULOUS_DALE             = 100,
        CLASH_OF_THE_COMRADES           = 101,
        UNLOCKING_A_MYTH_WARRIOR        = 102,
        UNLOCKING_A_MYTH_MONK           = 103,
        UNLOCKING_A_MYTH_WHITE_MAGE     = 104,
        UNLOCKING_A_MYTH_BLACK_MAGE     = 105,
        UNLOCKING_A_MYTH_RED_MAGE       = 106,
        UNLOCKING_A_MYTH_THIEF          = 107,
        UNLOCKING_A_MYTH_PALADIN        = 108,
        UNLOCKING_A_MYTH_DARK_KNIGHT    = 109,
        UNLOCKING_A_MYTH_BEASTMASTER    = 110,
        UNLOCKING_A_MYTH_BARD           = 111,
        UNLOCKING_A_MYTH_RANGER         = 112,
        UNLOCKING_A_MYTH_SAMURAI        = 113,
        UNLOCKING_A_MYTH_NINJA          = 114,
        UNLOCKING_A_MYTH_DRAGOON        = 115,
        UNLOCKING_A_MYTH_SUMMONER       = 116,
        UNLOCKING_A_MYTH_BLUE_MAGE      = 117,
        UNLOCKING_A_MYTH_CORSAIR        = 118,
        UNLOCKING_A_MYTH_PUPPETMASTER   = 119,
        UNLOCKING_A_MYTH_DANCER         = 120,
        UNLOCKING_A_MYTH_SCHOLAR        = 121,
        THE_GOBBIEBAG_PART_IX           = 123, -- + Converted
        THE_GOBBIEBAG_PART_X            = 124, -- + Converted

        IN_DEFIANT_CHALLENGE            = 128, -- + Converted
        ATOP_THE_HIGHEST_MOUNTAINS      = 129, -- + Converted
        WHENCE_BLOWS_THE_WIND           = 130, -- + Converted
        RIDING_ON_THE_CLOUDS            = 131, -- + Converted
        SHATTERING_STARS                = 132, -- + Converted
        NEW_WORLDS_AWAIT                = 133, -- + Converted
        EXPANDING_HORIZONS              = 134, -- + Converted
        BEYOND_THE_STARS                = 135, -- + Converted
        DORMANT_POWERS_DISLODGED        = 136, -- + Converted
        BEYOND_INFINITY                 = 137, -- + Converted

        A_TRIAL_IN_TANDEM               = 160,
        A_TRIAL_IN_TANDEM_REDUX         = 161,
        YET_ANOTHER_TRIAL_IN_TANDEM     = 162,
        A_QUATERNARY_TRIAL_IN_TANDEM    = 163,
        A_TRIAL_IN_TANDEM_REVISITED     = 164,
        ALL_IN_THE_CARDS                = 166,
        MARTIAL_MASTERY                 = 167, -- + Converted
        VW_OP_115_VALKURM_DUSTER        = 168,
        VW_OP_118_BUBURIMU_SQUALL       = 169,
        PRELUDE_TO_PUISSANCE            = 170, -- + Converted

        FULL_SPEED_AHEAD                = 179, -- +
    },

    -----------------------------------
    --  Other Areas - 4
    -----------------------------------
    [xi.quest.area[xi.questLog.OTHER_AREAS]] =
    {
        RYCHARDE_THE_CHEF               = 0,  -- + Converted
        WAY_OF_THE_COOK                 = 1,  -- + Converted
        UNENDING_CHASE                  = 2,  -- + Converted
        HIS_NAME_IS_VALGEIR             = 3,  -- + Converted
        EXPERTISE                       = 4,  -- + Converted
        THE_CLUE                        = 5,  -- + Converted
        THE_BASICS                      = 6,  -- + Converted
        ORLANDOS_ANTIQUES               = 7,  -- +
        THE_SAND_CHARM                  = 8,  -- + Converted
        A_POTTERS_PREFERENCE            = 9,  -- +
        THE_OLD_LADY                    = 10, -- +
        FISHERMANS_HEART                = 11,
        DONATE_TO_RECYCLING             = 16, -- +
        UNDER_THE_SEA                   = 17, -- +
        ONLY_THE_BEST                   = 18, -- +
        AN_EXPLORERS_FOOTSTEPS          = 19, -- +
        CARGO                           = 20, -- +
        THE_GIFT                        = 21, -- + Converted
        THE_REAL_GIFT                   = 22, -- + Converted
        THE_RESCUE                      = 23, -- +
        ELDER_MEMORIES                  = 24, -- +
        TEST_MY_METTLE                  = 25, -- + Converted
        INSIDE_THE_BELLY                = 26, -- + Converted
        TRIAL_BY_LIGHTNING              = 27, -- ±
        TRIAL_SIZE_TRIAL_BY_LIGHTNING   = 28, -- +
        ITS_RAINING_MANNEQUINS          = 29, -- + Converted
        RECYCLING_RODS                  = 30,
        PICTURE_PERFECT                 = 31,
        WAKING_THE_BEAST                = 32,
        SURVIVAL_OF_THE_WISEST          = 33,
        MONSTROSITY                     = 34, -- + Converted
        A_HARD_DAYS_KNIGHT              = 64, -- + Converted
        X_MARKS_THE_SPOT                = 65,
        A_BITTER_PAST                   = 66,
        THE_CALL_OF_THE_SEA             = 67,
        PARADISE_SALVATION_AND_MAPS     = 68,
        GO_GO_GOBMUFFIN                 = 69,
        THE_BIG_ONE                     = 70,
        FLY_HIGH                        = 71, -- ±
        UNFORGIVEN                      = 72,
        SECRETS_OF_OVENS_LOST           = 73,
        PETALS_FOR_PARELBRIAUX          = 74,
        ELDERLY_PURSUITS                = 75, -- + Converted
        IN_THE_NAME_OF_SCIENCE          = 76, -- ±
        BEHIND_THE_SMILE                = 77,
        KNOCKING_ON_FORBIDDEN_DOORS     = 78, -- + Converted
        CONFESSIONS_OF_A_BELLMAKER      = 79, -- + Converted
        IN_SEARCH_OF_THE_TRUTH          = 80, -- + Converted
        UNINVITED_GUESTS                = 81,
        TANGO_WITH_A_TRACKER            = 82,
        REQUIEM_OF_SIN                  = 83,
        VW_OP_026_TAVNAZIAN_TERRORS     = 84,
        VW_OP_004_BIBIKI_BOMBARDMENT    = 85,
        BOMBS_AWAY                      = 96, -- + Converted
        MITHRAN_DELICACIES              = 97,
        GIVE_A_MOOGLE_A_BREAK           = 100, -- ±
        THE_MOOGLE_PICNIC               = 101, -- ±
        MOOGLES_IN_THE_WILD             = 102, -- ±
        MISSIONARY_MOBLIN               = 103, -- + Converted
        FOR_THE_BIRDS                   = 104,
        BETTER_THE_DEMON_YOU_KNOW       = 105,
        AN_UNDERSTANDING_OVERLORD       = 106,
        AN_AFFABLE_ADAMANTKING          = 107,
        A_MORAL_MANIFEST                = 108,
        A_GENEROUS_GENERAL              = 109,
        RECORDS_OF_EMINENCE             = 110,
        UNITY_CONCORD                   = 111,
    },

    -----------------------------------
    --  Outlands - 5
    -----------------------------------
    [xi.quest.area[xi.questLog.OUTLANDS]] =
    {
        -- Kazham (1-15)
        THE_FIREBLOOM_TREE              = 1,
        GREETINGS_TO_THE_GUARDIAN       = 2,  -- +
        A_QUESTION_OF_TASTE             = 3,
        EVERYONES_GRUDGING              = 4,
        YOU_CALL_THAT_A_KNIFE           = 6,
        MISSIONARY_MAN                  = 7,  -- ±
        GULLIBLES_TRAVELS               = 8,  -- +
        EVEN_MORE_GULLIBLES_TRAVELS     = 9,  -- +
        PERSONAL_HYGIENE                = 10, -- +
        THE_OPO_OPO_AND_I               = 11, -- +
        TRIAL_BY_FIRE                   = 12, -- ±
        CLOAK_AND_DAGGER                = 13, -- + Converted
        A_DISCERNING_EYE                = 14,
        TRIAL_SIZE_TRIAL_BY_FIRE        = 15, -- +

        -- Voidwatch (100-105)
        VOIDWATCH_OPS_BORDER_CROSSING   = 100,
        VW_OP_054_ELSHIMO_LIST          = 101,
        VW_OP_101_DETOUR_TO_ZEPWELL     = 102,
        VW_OP_115_LI_TELOR_VARIANT      = 103,
        SKYWARD_HO_VOIDWATCHER          = 104,

        -- Norg (128-149)
        THE_SAHAGINS_KEY                = 128, -- ±
        FORGE_YOUR_DESTINY              = 129, -- ± Converted
        BLACK_MARKET                    = 130,
        MAMA_MIA                        = 131,
        STOP_YOUR_WHINING               = 132, -- + Converted
        TRIAL_BY_WATER                  = 133, -- +
        EVERYONES_GRUDGE                = 134,
        SECRET_OF_THE_DAMP_SCROLL       = 135, -- ± Converted
        THE_SAHAGINS_STASH              = 136, -- + Converted
        ITS_NOT_YOUR_VAULT              = 137, -- +
        LIKE_A_SHINING_SUBLIGAR         = 138, -- +
        LIKE_A_SHINING_LEGGINGS         = 139, -- +
        THE_SACRED_KATANA               = 140, -- ± Converted
        YOMI_OKURI                      = 141, -- ± Converted
        A_THIEF_IN_NORG                 = 142, -- ± Converted
        TWENTY_IN_PIRATE_YEARS          = 143, -- ±
        I_LL_TAKE_THE_BIG_BOX           = 144, -- ±
        TRUE_WILL                       = 145, -- ±
        THE_POTENTIAL_WITHIN            = 146, -- + Converted
        BUGI_SODEN                      = 147, -- + Converted
        TRIAL_SIZE_TRIAL_BY_WATER       = 148, -- +
        AN_UNDYING_PLEDGE               = 149,

        -- Misc (160-165)
        WRATH_OF_THE_OPO_OPOS           = 160, -- ± Converted
        WANDERING_SOULS                 = 161, -- ± Converted
        SOUL_SEARCHING                  = 162, -- ± Converted
        DIVINE_MIGHT                    = 163, -- ±
        DIVINE_MIGHT_REPEAT             = 164, -- ±
        OPEN_SESAME                     = 165, -- ± Converted

        -- Rabao (192-201)
        DONT_FORGET_THE_ANTIDOTE        = 192, -- ±
        THE_MISSING_PIECE               = 193, -- ±
        TRIAL_BY_WIND                   = 194, -- ±
        THE_KUFTAL_TOUR                 = 195,
        THE_IMMORTAL_LU_SHANG           = 196, -- ±
        TRIAL_SIZE_TRIAL_BY_WIND        = 197, -- ±
        CHASING_DREAMS                  = 199, -- ± Converted       -- CoP Quest
        THE_SEARCH_FOR_GOLDMANE         = 200,            -- CoP Quest
        INDOMITABLE_SPIRIT              = 201, -- ±
    },

    -----------------------------------
    --  Aht Urhgan - 6
    -----------------------------------
    [xi.quest.area[xi.questLog.AHT_URHGAN]] =
    {
        KEEPING_NOTES                    = 0, -- + Converted
        ARTS_AND_CRAFTS                  = 1, -- + Converted
        OLDUUM                           = 2, -- + Converted
        GOT_IT_ALL                       = 3, -- + Converted
        GET_THE_PICTURE                  = 4,
        AN_EMPTY_VESSEL                  = 5, -- + Converted
        LUCK_OF_THE_DRAW                 = 6, -- + Converted
        NO_STRINGS_ATTACHED              = 7, -- +
        FINDING_FAULTS                   = 8,
        GIVE_PEACE_A_CHANCE              = 9, -- + Converted
        THE_ART_OF_WAR                   = 10,
        -- JP ENTRIES OR INVALID
        A_TASTE_OF_HONEY                 = 12, -- + Converted
        SUCH_SWEET_SORROW                = 13, -- + Converted
        FEAR_OF_THE_DARK_II              = 14, -- + Converted
        COOK_A_ROON                      = 15, -- + Converted
        THE_DIE_IS_CAST                  = 16,
        TWO_HORN_THE_SAVAGE              = 17,
        TOTOROONS_TREASURE_HUNT          = 18,
        WHAT_FRIENDS_ARE_FOR             = 19, -- + Converted
        ROCK_BOTTOM                      = 20, -- + Converted
        BEGINNINGS                       = 21, -- + Converted
        OMENS                            = 22, -- + Converted
        TRANSFORMATIONS                  = 23, -- + Converted
        EQUIPPED_FOR_ALL_OCCASIONS       = 24, -- + Converted
        NAVIGATING_THE_UNFRIENDLY_SEAS   = 25, -- +
        AGAINST_ALL_ODDS                 = 26,
        THE_WAYWARD_AUTOMATON            = 27,
        OPERATION_TEATIME                = 28,
        PUPPETMASTER_BLUES               = 29,
        MOMENT_OF_TRUTH                  = 30,
        THREE_MEN_AND_A_CLOSET           = 31, -- + Converted
        FIVE_SECONDS_OF_FAME             = 32,
        -- JP ENTRIES OR INVALID
        THE_BEAST_WITHIN                 = 40,
        BREAKING_THE_BONDS_OF_FATE       = 41,
        -- JP ENTRIES OR INVALID
        SAGA_OF_THE_SKYSERPENT           = 43, -- + Converted
        ODE_TO_THE_SERPENTS              = 44, -- + Converted
        WHEN_THE_BOW_BREAKS              = 45, -- + Converted
        FIST_OF_THE_PEOPLE               = 46, -- + Converted
        SOOTHING_WATERS                  = 47, -- + Converted
        -- JP ENTRIES OR INVALID
        THE_PRANKSTER                    = 60,
        DELIVERING_THE_GOODS             = 61, -- + Converted
        VANISHING_ACT                    = 62, -- + Converted
        STRIKING_A_BALANCE               = 63, -- + Converted
        NOT_MEANT_TO_BE                  = 64, -- + Converted
        LED_ASTRAY                       = 65, -- + Converted
        RAT_RACE                         = 66, -- + Converted
        THE_PRINCE_AND_THE_HOPPER        = 67, -- + Converted
        VW_OP_050_AHT_URGAN_ASSAULT      = 68,
        VW_OP_068_SUBTERRAINEAN_SKIRMISH = 69,
        AN_IMPERIAL_HEIST                = 70,
        DUTIES_TASKS_AND_DEEDS           = 71,
        FORGING_A_NEW_MYTH               = 72,
        COMING_FULL_CIRCLE               = 73,
        WAKING_THE_COLOSSUS              = 74,
        DIVINE_INTERFERANCE              = 75,
        THE_RIDER_COMETH                 = 76,
        UNWAVERING_RESOLVE               = 77,
        A_STYGIAN_PACT                   = 78,
        -- JP ENTRIES OR INVALID
        PROMOTION_PRIVATE_FIRST_CLASS    = 90, -- + Converted
        PROMOTION_SUPERIOR_PRIVATE       = 91, -- + Converted
        PROMOTION_LANCE_CORPORAL         = 92,
        PROMOTION_CORPORAL               = 93,
        PROMOTION_SERGEANT               = 94, -- + Converted
        PROMOTION_SERGEANT_MAJOR         = 95, -- + Converted
        PROMOTION_CHIEF_SERGEANT         = 96,
        PROMOTION_SECOND_LIEUTENANT      = 97,
        PROMOTION_FIRST_LIEUTENANT       = 98, -- + Converted
        PROMOTION_CAPTAIN                = 99,
        -- JP ENTRIES OR INVALID
        SCOUTING_THE_ASHU_TALIF          = 101,
        ROYAL_PAINTER_ESCORT             = 102,
        TARGETING_THE_CAPTAIN            = 103,
    },

    -----------------------------------
    --  Crystal War - 7
    -----------------------------------
    [xi.quest.area[xi.questLog.CRYSTAL_WAR]] =
    {
        LOST_IN_TRANSLOCATION            = 0,  -- + Converted
        MESSAGE_ON_THE_WINDS             = 1,  -- + Converted
        THE_WEEKLY_ADVENTURER            = 2,
        HEALING_HERBS                    = 3,
        REDEEMING_ROCKS                  = 4,
        THE_DAWN_OF_DELECTABILITY        = 5,  -- + Converted
        A_LITTLE_KNOWLEDGE               = 6,  -- + Converted
        THE_FIGHTING_FOURTH              = 7,
        SNAKE_ON_THE_PLAINS              = 8,  -- +
        STEAMED_RAMS                     = 9,  -- +
        SEEING_SPOTS                     = 10, -- + Converted
        THE_FLIPSIDE_OF_THINGS           = 11,
        BETTER_PART_OF_VALOR             = 12,
        FIRES_OF_DISCONTENT              = 13,
        HAMMERING_HEARTS                 = 14, -- + Converted
        GIFTS_OF_THE_GRIFFON             = 15, -- + Converted
        CLAWS_OF_THE_GRIFFON             = 16, -- + Converted
        THE_TIGRESS_STIRS                = 17, -- +
        THE_TIGRESS_STRIKES              = 18,
        LIGHT_IN_THE_DARKNESS            = 19, -- + Converted
        BURDEN_OF_SUSPICION              = 20,
        EVIL_AT_THE_INLET                = 21,
        THE_FUMBLING_FRIAR               = 22,
        REQUIEM_FOR_THE_DEPARTED         = 23,
        BOY_AND_THE_BEAST                = 24, -- + Converted
        WRATH_OF_THE_GRIFFON             = 25, -- + Converted
        THE_LOST_BOOK                    = 26, -- + Converted
        KNOT_QUITE_THERE                 = 27,
        A_MANIFEST_PROBLEM               = 28,
        BEANS_AHOY                       = 29, -- +
        BEAST_FROM_THE_EAST              = 30,
        THE_SWARM                        = 31,
        ON_SABBATICAL                    = 32,
        DOWNWARD_HELIX                   = 33,
        SEEING_BLOOD_RED                 = 34,
        STORM_ON_THE_HORIZON             = 35,
        FIRE_IN_THE_HOLE                 = 36,
        PERILS_OF_THE_GRIFFON            = 37, -- + Converted
        IN_A_HAZE_OF_GLORY               = 38, -- + Converted
        WHEN_ONE_MAN_IS_NOT_ENOUGH       = 39,
        A_FEAST_FOR_GNATS                = 40,
        SAY_IT_WITH_A_HANDBAG            = 41, -- Can be completed, but reward latent not implemented
        QUELLING_THE_STORM               = 42,
        HONOR_UNDER_FIRE                 = 43,
        THE_PRICE_OF_VALOR               = 44, -- + Converted
        BONDS_THAT_NEVER_DIE             = 45, -- + Converted
        THE_LONG_MARCH_NORTH             = 46,
        THE_FORBIDDEN_PATH               = 47,
        A_JEWELERS_LAMENT                = 48,
        BENEATH_THE_MASK                 = 49,
        WHAT_PRICE_LOYALTY               = 50,
        SONGBIRDS_IN_A_SNOWSTORM         = 51, -- + Converted
        BLOOD_OF_HEROES                  = 52, -- + Converted
        SINS_OF_THE_MOTHERS              = 53,
        HOWL_FROM_THE_HEAVENS            = 54,
        SUCCOR_TO_THE_SIDHE              = 55,
        THE_YOUNG_AND_THE_THREADLESS     = 56,
        SON_AND_FATHER                   = 57,
        THE_TRUTH_LIES_HID               = 58,
        BONDS_OF_MYTHRIL                 = 59,
        CHASING_SHADOWS                  = 60, -- + Converted
        FACE_OF_THE_FUTURE               = 61, -- + Converted
        MANIFEST_DESTINY                 = 62,
        AT_JOURNEYS_END                  = 63,
        HER_MEMORIES_HOMECOMING_QUEEN    = 64, -- + Converted
        HER_MEMORIES_OLD_BEAN            = 65, -- + Converted
        HER_MEMORIES_THE_FAUX_PAS        = 66, -- + Converted
        HER_MEMORIES_THE_GRAVE_RESOLVE   = 67, -- + Converted
        HER_MEMORIES_OPERATION_CUPID     = 68, -- + Converted
        HER_MEMORIES_CARNELIAN_FOOTFALLS = 69, -- + Converted
        HER_MEMORIES_AZURE_FOOTFALLS     = 70,
        HER_MEMORIES_VERDURE_FOOTFALLS   = 71,
        HER_MEMORIES_OF_MALIGN_MALADIES  = 72, -- + Converted
        CHAMPION_OF_THE_DAWN             = 73,
        THE_DAWN_ALSO_RISES              = 74,
        A_FORBIDDEN_REUNION              = 75,
        GUARDIAN_OF_THE_VOID             = 80,
        DRAFTED_BY_THE_DUCHY             = 81,
        BATTLE_ON_A_NEW_FRONT            = 82,
        VOIDWALKER_OP_126                = 83,
        A_CAIT_CALLS                     = 84,
        THE_TRUTH_IS_OUT_THERE           = 85,
        REDRAFTED_BY_THE_DUCHY           = 86,
        A_NEW_MENACE                     = 87,
        NO_REST_FOR_THE_WEARY            = 88,
        A_WORLD_IN_FLUX                  = 89,
        BETWEEN_A_ROCK_AND_RIFT          = 90,
        A_FAREWELL_TO_FELINES            = 91,
        THIRD_TOUR_OF_DUCHY              = 92,
        GLIMMER_OF_HOPE                  = 93,
        BRACE_FOR_THE_UNKNOWN            = 94,
        PROVENANCE                       = 95,
        CRYSTAL_GUARDIAN                 = 96,
        ENDINGS_AND_BEGINNINGS           = 97,
        AD_INFINITUM                     = 98,
    },

    -----------------------------------
    --  Abyssea - 8
    -----------------------------------
    [xi.quest.area[xi.questLog.ABYSSEA]] =
    {
        -- For some reason these did not match dat file order,
        -- had to adjust IDs >120 after using @addquest
        CATERING_CAPERS                 = 0,
        GIFT_OF_LIGHT                   = 1,
        FEAR_OF_THE_DARK_III            = 2,
        AN_EYE_FOR_REVENGE              = 3,
        UNBREAK_HIS_HEART               = 4,
        EXPLOSIVE_ENDEAVORS             = 5,
        THE_ANGLING_ARMORER             = 6,
        WATER_OF_LIFE                   = 7,
        OUT_OF_TOUCH                    = 8,
        LOST_MEMORIES                   = 9,
        HOPE_BLOOMS_ON_THE_BATTLEFIELD  = 10,
        OF_MALNOURISHED_MARTELLOS       = 11,
        ROSE_ON_THE_HEATH               = 12,
        FULL_OF_HIMSELF_ALCHEMIST       = 13,
        THE_WALKING_WOUNDED             = 14,
        SHADY_BUSINESS_REDUX            = 15,
        ADDLED_MIND_UNDYING_DREAMS      = 16,
        THE_SOUL_OF_THE_MATTER          = 17,
        SECRET_AGENT_MAN                = 18,
        PLAYING_PAPARAZZI               = 19,
        HIS_BOX_HIS_BELOVED             = 20,
        WEAPONS_NOT_WORRIES             = 21,
        CLEANSING_THE_CANYON            = 22,
        SAVORY_SALVATION                = 23,
        BRINGING_DOWN_THE_MOUNTAIN      = 24,
        A_STERLING_SPECIMEN             = 25,
        FOR_LOVE_OF_A_DAUGHTER          = 26,
        SISTERS_IN_CRIME                = 27,
        WHEN_GOOD_CARDIANS_GO_BAD       = 28,
        TANGLING_WITH_TONGUE_TWISTERS   = 29,
        A_WARD_TO_END_ALL_WARDS         = 30,
        THE_BOXWATCHERS_BEHEST          = 31,
        HIS_BRIDGE_HIS_BELOVED          = 32,
        BAD_COMMUNICATION               = 33,
        FAMILY_TIES                     = 34,
        AQUA_PURA                       = 35,
        AQUA_PURAGA                     = 36,
        WHITHER_THE_WHISKER             = 37,
        SCATTERED_SHELLS_SCATTERED_MIND = 38,
        WAYWARD_WARES                   = 39,
        LOOKING_FOR_LOOKOUTS            = 40,
        FLOWN_THE_COOP                  = 41,
        THREADBARE_TRIBULATIONS         = 42,
        AN_OFFER_YOU_CANT_REFUSE        = 43,
        SOMETHING_IN_THE_AIR            = 44,
        AN_ACRIDIDAEN_ANODYNE           = 45,
        HAZY_PROSPECTS                  = 46,
        FOR_WANT_OF_A_POT               = 47,
        MISSING_IN_ACTION               = 48,
        I_DREAM_OF_FLOWERS              = 49,
        DESTINY_ODYSSEY                 = 50,
        UNIDENTIFIED_RESEARCH_OBJECT    = 51,
        COOKBOOK_OF_HOPE_RESTORING      = 52,
        SMOKE_OVER_THE_COAST            = 53,
        SOIL_AND_GREEN                  = 54,
        DROPPING_THE_BOMB               = 55,
        WANTED_MEDICAL_SUPPLIES         = 56,
        VOICES_FROM_BEYOND              = 57,
        BENEVOLENCE_LOST                = 58,
        BRUGAIRES_AMBITION              = 59,
        CHOCOBO_PANIC                   = 60,
        THE_EGG_ENTHUSIAST              = 61,
        GETTING_LUCKY                   = 62,
        HER_FATHERS_LEGACY              = 63,
        THE_MYSTERIOUS_HEAD_PATROL      = 64,
        MASTER_MISSING_MASTER_MISSED    = 65,
        THE_PERILS_OF_KORORO            = 66,
        LET_THERE_BE_LIGHT              = 67,
        LOOK_OUT_BELOW                  = 68,
        HOME_HOME_ON_THE_RANGE          = 69,
        IMPERIAL_ESPIONAGE              = 70,
        IMPERIAL_ESPIONAGE_II           = 71,
        BOREAL_BLOSSOMS                 = 72,
        BROTHERS_IN_ARMS                = 73,
        SCOUTS_ASTRAY                   = 74,
        FROZEN_FLAME_REDUX              = 75,
        SLIP_SLIDIN_AWAY                = 76,
        CLASSROOMS_WITHOUT_BORDERS      = 77,
        THE_SECRET_INGREDIENT           = 78,
        HELP_NOT_WANTED                 = 79,
        THE_TITUS_TOUCH                 = 80,
        SLACKING_SUBORDINATES           = 81,
        MOTHERLY_LOVE                   = 82,
        LOOK_TO_THE_SKY                 = 83,
        THE_UNMARKED_TOMB               = 84,
        PROOF_OF_THE_LION               = 85,
        BRYGID_THE_STYLIST_STRIKES_BACK = 86,
        DOMINION_OP_01_ALTEPA           = 87,  -- + Converted
        DOMINION_OP_02_ALTEPA           = 88,  -- + Converted
        DOMINION_OP_03_ALTEPA           = 89,  -- + Converted
        DOMINION_OP_04_ALTEPA           = 90,  -- + Converted
        DOMINION_OP_05_ALTEPA           = 91,  -- + Converted
        DOMINION_OP_06_ALTEPA           = 92,  -- + Converted
        DOMINION_OP_07_ALTEPA           = 93,  -- + Converted
        DOMINION_OP_08_ALTEPA           = 94,  -- + Converted
        DOMINION_OP_09_ALTEPA           = 95,  -- + Converted
        DOMINION_OP_10_ALTEPA           = 96,  -- + Converted
        DOMINION_OP_11_ALTEPA           = 97,  -- + Converted
        DOMINION_OP_12_ALTEPA           = 98,  -- + Converted
        DOMINION_OP_13_ALTEPA           = 99,  -- + Converted
        DOMINION_OP_14_ALTEPA           = 100, -- + Converted
        DOMINION_OP_01_ULEGUERAND       = 101, -- + Converted
        DOMINION_OP_02_ULEGUERAND       = 102, -- + Converted
        DOMINION_OP_03_ULEGUERAND       = 103, -- + Converted
        DOMINION_OP_04_ULEGUERAND       = 104, -- + Converted
        DOMINION_OP_05_ULEGUERAND       = 105, -- + Converted
        DOMINION_OP_06_ULEGUERAND       = 106, -- + Converted
        DOMINION_OP_07_ULEGUERAND       = 107, -- + Converted
        DOMINION_OP_08_ULEGUERAND       = 108, -- + Converted
        DOMINION_OP_09_ULEGUERAND       = 109, -- + Converted
        DOMINION_OP_10_ULEGUERAND       = 110, -- + Converted
        DOMINION_OP_11_ULEGUERAND       = 111, -- + Converted
        DOMINION_OP_12_ULEGUERAND       = 112, -- + Converted
        DOMINION_OP_13_ULEGUERAND       = 113, -- + Converted
        DOMINION_OP_14_ULEGUERAND       = 114, -- + Converted
        DOMINION_OP_01_GRAUBERG         = 115, -- + Converted
        DOMINION_OP_02_GRAUBERG         = 116, -- + Converted
        DOMINION_OP_03_GRAUBERG         = 117, -- + Converted
        DOMINION_OP_04_GRAUBERG         = 118, -- + Converted
        DOMINION_OP_05_GRAUBERG         = 119, -- + Converted
        DOMINION_OP_06_GRAUBERG         = 120, -- + Converted
        DOMINION_OP_07_GRAUBERG         = 121, -- + Converted
        DOMINION_OP_08_GRAUBERG         = 122, -- + Converted
        DOMINION_OP_09_GRAUBERG         = 123, -- + Converted
        WARD_WARDEN_I_ATTOHWA           = 124,
        WARD_WARDEN_I_MISAREAUX         = 125,
        WARD_WARDEN_I_VUNKERL           = 126,
        WARD_WARDEN_II_ATTOHWA          = 127,
        WARD_WARDEN_II_MISAREAUX        = 128,
        WARD_WARDEN_II_VUNKERL          = 129,
        DESERT_RAIN_I_ATTOHWA           = 130,
        DESERT_RAIN_I_MISAREAUX         = 131,
        DESERT_RAIN_I_VUNKERL           = 132,
        DESERT_RAIN_II_ATTOHWA          = 133,
        DESERT_RAIN_II_MISAREAUX        = 134,
        DESERT_RAIN_II_VUNKERL          = 135,
        CRIMSON_CARPET_I_ATTOHWA        = 136,
        CRIMSON_CARPET_I_MISAREAUX      = 137,
        CRIMSON_CARPET_I_VUNKERL        = 138,
        CRIMSON_CARPET_II_ATTOHWA       = 139,
        CRIMSON_CARPET_II_MISAREAUX     = 140,
        CRIMSON_CARPET_II_VUNKERL       = 141,
        REFUEL_AND_REPLENISH_LA_THEINE  = 142,
        REFUEL_AND_REPLENISH_KONSCHTAT  = 143,
        REFUEL_AND_REPLENISH_TAHRONGI   = 144,
        REFUEL_AND_REPLENISH_ATTOHWA    = 145,
        REFUEL_AND_REPLENISH_MISAREAUX  = 146,
        REFUEL_AND_REPLENISH_VUNKERL    = 147,
        REFUEL_AND_REPLENISH_ALTEPA     = 148,
        REFUEL_AND_REPLENISH_ULEGUERAND = 149,
        REFUEL_AND_REPLENISH_GRAUBERG   = 150,
        A_MIGHTIER_MARTELLO_LA_THEINE   = 151,
        A_MIGHTIER_MARTELLO_KONSCHTAT   = 152,
        A_MIGHTIER_MARTELLO_TAHRONGI    = 153,
        A_MIGHTIER_MARTELLO_ATTOHWA     = 154,
        A_MIGHTIER_MARTELLO_MISAREAUX   = 155,
        A_MIGHTIER_MARTELLO_VUNKERL     = 156,
        A_MIGHTIER_MARTELLO_ALTEPA      = 157,
        A_MIGHTIER_MARTELLO_ULEGUERAND  = 158,
        A_MIGHTIER_MARTELLO_GRAUBERG    = 159,
        A_JOURNEY_BEGINS                = 160, -- +
        THE_TRUTH_BECKONS               = 161, -- +
        DAWN_OF_DEATH                   = 162,
        A_GOLDSTRUCK_GIGAS              = 163,
        TO_PASTE_A_PEISTE               = 164,
        MEGADRILE_MENACE                = 165,
        THE_FORBIDDEN_FRONTIER          = 166,
        FIRST_CONTACT                   = 167,
        AN_OFFICER_AND_A_PIRATE         = 168,
        HEART_OF_MADNESS                = 169,
        TENUOUS_EXISTENCE               = 170,
        CHAMPIONS_OF_ABYSSEA            = 171,
        THE_BEAST_OF_BASTORE            = 172,
        A_DELECTABLE_DEMON              = 173,
        A_FLUTTERY_FIEND                = 174,
        SCARS_OF_ABYSSEA                = 175,
        A_BEAKED_BLUSTERER              = 176,
        A_MAN_EATING_MITE               = 177,
        AN_ULCEROUS_URAGNITE            = 178,
        HEROES_OF_ABYSSEA               = 179,
        A_SEA_DOGS_SUMMONS              = 180,
        DEATH_AND_REBIRTH               = 181,
        EMISSARIES_OF_GOD               = 182,
        BENEATH_A_BLOOD_RED_SKY         = 183,
        THE_WYRM_GOD                    = 184,
        MEANWHILE_BACK_ON_ABYSSEA       = 185,
        A_MOONLIGHT_REQUITE             = 186,
        DOMINION_OP_10_GRAUBERG         = 187, -- + Converted
        DOMINION_OP_11_GRAUBERG         = 188, -- + Converted
        DOMINION_OP_12_GRAUBERG         = 189, -- + Converted
        DOMINION_OP_13_GRAUBERG         = 190, -- + Converted
        DOMINION_OP_14_GRAUBERG         = 191, -- + Converted
    },

    -----------------------------------
    --  Adoulin - 9
    -----------------------------------
    [xi.quest.area[xi.questLog.ADOULIN]] =
    {
        -- These also do not match the DAT file order, had
        -- discrepencies and swapped orders from the start.
        TWITHERYM_DUST                   = 0,
        TO_CATCH_A_PREDATOR              = 1,
        EMPTY_NEST                       = 2,
        DONT_CLAM_UP_ON_ME_NOW           = 5,
        HOP_TO_IT                        = 6,
        BOILING_OVER                     = 9,
        POISONING_THE_WELL               = 10,
        UNSULLIED_LANDS                  = 12,
        NO_RIME_LIKE_THE_PRESENT         = 16,
        A_GEOTHERMAL_EXPEDITION          = 18,
        ENDEAVORING_TO_AWAKEN            = 22,
        FORGING_NEW_BONDS                = 23,
        LEGACIES_LOST_AND_FOUND          = 24,
        DESTINYS_DEVICE                  = 25,
        GRANDDADDY_DEAREST               = 26,
        WAYWARD_WAYPOINTS                = 27,
        ONE_GOOD_TURN                    = 28,
        FAILURE_IS_NOT_AN_OPTION         = 29,
        ORDER_UP                         = 30,
        IT_NEVER_GOES_OUT_OF_STYLE       = 31,
        WATER_WATER_EVERYWHERE           = 32,
        DIRT_CHEAP                       = 33,
        FLOWER_POWER                     = 34,
        ELEMENTARY_MY_DEAR_SYLVIE        = 35,
        FOR_WHOM_THE_BELL_TOLLS          = 36,
        THE_BLOODLINE_OF_ZACARIAH        = 37,
        THE_COMMUNION                    = 38,
        FLAVORS_OF_OUR_LIVES             = 46, -- + Converted
        WESTERN_WAYPOINTS_HO             = 50,
        WESEASTERN_WAYPOINTS_HO          = 51,
        GRIND_TO_SAWDUST                 = 53,
        BREAKING_THE_ICE                 = 54, -- + Converted
        IM_ON_A_BOAT                     = 55, -- + Converted
        A_STONES_THROW_AWAY              = 56, -- + Converted
        HIDE_AND_GO_PEAK                 = 57, -- + Converted
        THE_WHOLE_PLACE_IS_ABUZZ         = 58,
        OROBON_APPETIT                   = 59,
        TALK_ABOUT_WRINKLY_SKIN          = 60,
        NO_LOVE_LOST                     = 61,
        DID_YOU_FEEL_THAT                = 62,
        DONT_EVER_LEAF_ME                = 70,
        KEEP_YOUR_BLOOMERS_ON_ERISA      = 71,
        SCAREDYCATS                      = 72,
        RAPTOR_RAPTURE                   = 73,
        EXOTIC_DELICACIES                = 74, -- +
        A_PIONEERS_BEST_IMAGINARY_FRIEND = 75, -- +
        HUNGER_STRIKES                   = 76, -- + Converted
        THE_OLD_MAN_AND_THE_HARPOON      = 77, -- +
        A_CERTAIN_SUBSTITUTE_PATROLMAN   = 78, -- + Converted
        IT_SETS_MY_HEART_AFLUTTER        = 79, -- + Converted
        TRANSPORTING                     = 82, -- + Converted
        THE_STARVING                     = 84, -- + Converted
        FERTILE_GROUND                   = 85,
        ALWAYS_MORE_QUOTH_THE_RAVENOUS   = 88, -- +
        MEGALOMANIAC                     = 89,
        THE_LONGEST_WAY_ROUND            = 91, -- + Converted
        A_GOOD_PAIR_OF_CROCS             = 93, -- + Converted
        CAFETERIA                        = 94,
        A_SHOT_IN_THE_DARK               = 96, -- + Converted
        OPEN_THE_FLOODGATES              = 100,
        NO_LAUGHING_MATTER               = 102,
        ALL_THE_WAY_TO_THE_BANK          = 103,
        TO_LAUGH_IS_TO_LOVE              = 104,
        A_BARREL_OF_LAUGHS               = 105,
        VEGETABLE_VEGETABLE_REVOLUTION   = 108,
        VEGETABLE_VEGETABLE_EVOLUTION    = 109,
        VEGETABLE_VEGETABLE_CRISIS       = 110,
        VEGETABLE_VEGETABLE_FRUSTRATION  = 111,
        A_THIRST_FOR_THE_AGES            = 114,
        A_THIRST_FOR_THE_EONS            = 115,
        A_THIRST_FOR_ETERNITY            = 116,
        A_THIRST_BEFORE_TIME             = 117,
        DANCES_WITH_LUOPANS              = 118,
        CHILDREN_OF_THE_RUNE             = 119,
        FLOWERS_FOR_SVENJA               = 120,
        THORN_IN_THE_SIDE                = 121,
        DO_NOT_GO_INTO_THE_LIGHT         = 122,
        VELKKOVERT_OPERATIONS            = 123,
        HYPOCRITICAL_OATH                = 124,
        THE_GOOD_THE_BAD_THE_CLEMENT     = 125,
        LERENES_LAMENT                   = 126, -- + Converted
        THE_SECRET_TO_SUCCESS            = 127,
        NO_MERCY_FOR_THE_WICKED          = 128,
        MISTRESS_OF_CEREMONIES           = 129,
        SAVED_BY_THE_BELL                = 131,
        QUIESCENCE                       = 132,
        SICK_AND_TIRED                   = 133,
        GEOMANCERRIFIC                   = 134,
        RUNE_FENCING_THE_NIGHT_AWAY      = 135,
        THE_WEATHERSPOON_INQUISITION     = 136,
        EYE_OF_THE_BEHOLDER              = 137,
        THE_CURIOUS_CASE_OF_MELVIEN      = 138,
        NOTSOCLEAN_BILL                  = 139,
        IN_THE_LAND_OF_THE_BLIND         = 140,
        THE_WEATHERSPOON_WAR             = 141,
        TREASURES_OF_THE_EARTH           = 142,
        EPIPHANY                         = 143,
    },

    -----------------------------------
    --  Coalition - 10
    -----------------------------------
    [xi.quest.area[xi.questLog.COALITION]] =
    {
        -- Also slightly incongruent with DAT file order
        PROCURE_CEIZAK_BATTLEGROUNDS    = 0,
        PROCURE_FORET_DE_HENNETIEL      = 1,
        PROCURE_MORIMAR_BASALT_FIELDS   = 2,
        PROCURE_YORCIA_WEALD            = 3,
        PROCURE_MARJAMI_RAVINE          = 4,
        PROCURE_KAMIHR_DRIFTS           = 5,
        PROCURE_CIRDAS_CAVERNS          = 6,
        PROCURE_OUTER_RAKAZNAR          = 7,
        CLEAR_CEIZAK_BATTLEGROUNDS      = 8,
        CLEAR_FORET_DE_HENNETIEL        = 9,
        CLEAR_MORIMAR_BASALT_FIELDS     = 10,
        CLEAR_YORCIA_WEALD              = 11,
        CLEAR_MARJAMI_RAVINE            = 12,
        CLEAR_KAMIHR_DRIFTS             = 13,
        CLEAR_CIRDAS_CAVERNS            = 14,
        CLEAR_OUTER_RAKAZNAR            = 15,
        PROVIDE_FORET_DE_HENNETIEL      = 16,
        PROVIDE_MORIMAR_BASALT_FIELDS   = 17,
        PROVIDE_YORCIA_WEALD            = 18,
        PROVIDE_MARJAMI_RAVINE          = 19,
        PROVIDE_KAMIHR_DRIFTS           = 20,
        DELIVER_FORET_DE_HENNETIEL      = 21,
        DELIVER_MORIMAR_BASALT_FIELDS   = 22,
        DELIVER_YORCIA_WEALD            = 23,
        DELIVER_MARJAMI_RAVINE          = 24,
        DELIVER_KAMIHR_DRIFTS           = 25,
        SUPPORT_CEIZAK_BATTLEGROUNDS    = 26,
        SUPPORT_FORET_DE_HENNETIEL      = 27,
        SUPPORT_MORIMAR_BASALT_FIELDS   = 28,
        SUPPORT_YORCIA_WEALD            = 29,
        SUPPORT_MARJAMI_RAVINE          = 30,
        SUPPORT_KAMIHR_DRIFTS           = 31,
        GATHER_RALA_WATERWAYS           = 32,
        GATHER_CEIZAK_BATTLEGROUNDS     = 33,
        GATHER_YAHSE_HUNTING_GROUNDS    = 34,
        GATHER_FORET_DE_HENNETIEL       = 35,
        GATHER_MORIMAR_BASALT_FIELDS    = 36,
        GATHER_YORCIA_WEALD             = 37,
        GATHER_MARJAMI_RAVINE           = 38,
        GATHER_KAMIHR_DRIFTS            = 39,
        GATHER_SIH_GATES                = 40,
        GATHER_MOH_GATES                = 41,
        GATHER_CIRDAS_CAVERNS           = 42,
        GATHER_DHO_GATES                = 43,
        GATHER_WOH_GATES                = 44,
        GATHER_OUTER_RAKAZNAR           = 45,
        GATHER_RAKAZNAR_INNER_COURT     = 46,
        -- GATHER                       = 47, -- Blank Gather: assignment
        SURVEY_CEIZAK_BATTLEGROUNDS     = 48,
        SURVEY_FORET_DE_HENNETIEL       = 49,
        SURVEY_MORIMAR_BASALT_FIELDS    = 50,
        SURVEY_YORCIA_WEALD             = 51,
        SURVEY_MARJAMI_RAVINE           = 52,
        SURVEY_KAMIHR_DRIFTS            = 53,
        SURVEY_SIH_GATES                = 54,
        SURVEY_CIRDAS_CAVERNS           = 55,
        SURVEY_DHO_GATES                = 56,
        ANALYZE_FORET_DE_HENNETIEL      = 57,
        ANALYZE_MORIMAR_BASALT_FIELDS   = 58,
        ANALYZE_YORCIA_WEALD            = 59,
        ANALYZE_MARJAMI_RAVINE          = 60,
        ANALYZE_KAMIHR_DRIFTS           = 61,
        ANALYZE_CIRDAS_CAVERNS          = 62,
        ANALYZE_OUTER_RAKAZNAR          = 63,
        PRESERVE_CEIZAK_BATTLEGROUNDS   = 64,
        PRESERVE_YAHSE_HUNTING_GROUNDS  = 65,
        PRESERVE_FORET_DE_HENNETIEL     = 66,
        PRESERVE_MORIMAR_BASALT_FIELDS  = 67,
        PRESERVE_YORCIA_WEALD           = 68,
        PRESERVE_MARJAMI_RAVINE         = 69,
        PRESERVE_KAMIHR_DRIFTS          = 70,
        PRESERVE_CIRDAS_CAVERNS         = 71,
        PRESERVE_OUTER_RAKAZNAR         = 72,
        PATROL_RALA_WATERWAYS           = 73,
        PATROL_SIH_GATES                = 74,
        PATROL_MOH_GATES                = 75,
        PATROL_CIRDAS_CAVERNS           = 76,
        PATROL_DHO_GATES                = 77,
        PATROL_WOH_GATES                = 78,
        PATROL_OUTER_RAKAZNAR           = 79,
        RECOVER_CEIZAK_BATTLEGROUNDS    = 80,
        RECOVER_FORET_DE_HENNETIEL      = 81,
        RECOVER_MORIMAR_BASALT_FIELDS   = 82,
        RECOVER_YORCIA_WEALD            = 83,
        RECOVER_MARJAMI_RAVINE          = 84,
        RECOVER_KAMIHR_DRIFTS           = 85,
        RESEARCH_RALA_WATERWAYS         = 86,
        RESEARCH_CEIZAK_BATTLEGROUNDS   = 87,
        RESEARCH_FORET_DE_HENNETIEL     = 88,
        RESEARCH_MORIMAR_BASALT_FIELDS  = 89,
        RESEARCH_YORCIA_WEALD           = 90,
        RESEARCH_MARJAMI_RAVINE         = 91,
        RESEARCH_KAMIHR_DRIFTS          = 92,
        BOOST_FORET_DE_HENNETIEL        = 93,
        BOOST_MARJAMI_RAVINE            = 94,
        BOOST_KAMIHR_DRIFTS             = 95,
    }
}

local function getVarPrefix(areaId, questId)
    return string.format('Quest[%d][%d]', areaId, questId)
end

-- Interaction Framework Helper Functions
xi.quest.incrementVar = function(player, areaId, questId, name, value)
    return player:incrementCharVar(getVarPrefix(areaId, questId) .. name, value)
end

xi.quest.getVar = function(player, areaId, questId, name)
    return player:getVar(getVarPrefix(areaId, questId) .. name)
end

xi.quest.setVar = function(player, areaId, questId, name, value, expiry)
    return player:setVar(getVarPrefix(areaId, questId) .. name, value, expiry)
end

xi.quest.setVarExpiration = function(player, areaId, questId, name, expiry)
    return player:setCharVarExpiration(getVarPrefix(areaId, questId) .. name, expiry)
end

xi.quest.getLocalVar = function(player, areaId, questId, name)
    return player:getLocalVar(getVarPrefix(areaId, questId) .. name)
end

xi.quest.setLocalVar = function(player, areaId, questId, name, value)
    return player:setLocalVar(getVarPrefix(areaId, questId) .. name, value)
end

xi.quest.getMustZone = function(player, areaId, questId)
    return player:getLocalVar(getVarPrefix(areaId, questId) .. 'mustZone') == 1 and true or false
end

xi.quest.setMustZone = function(player, areaId, questId)
    player:setLocalVar(getVarPrefix(areaId, questId) .. 'mustZone', 1)
end
