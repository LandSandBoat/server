require("scripts/globals/keyitems")
require("scripts/globals/log_ids")
require("scripts/globals/zone")

tpz = tpz or {}
tpz.mission = tpz.mission or {}

tpz.mission.log_id =
{
    SANDORIA    =  0,
    BASTOK      =  1,
    WINDURST    =  2,
    ZILART      =  3,
    TOAU        =  4,
    WOTG        =  5,
    COP         =  6,
    ASSAULT     =  7,
    CAMPAIGN    =  8,
    ACP         =  9,
    AMK         = 10,
    ASA         = 11,
    SOA         = 12,
    ROV         = 13,
}

tpz.mission.area =
{
    [tpz.mission.log_id.SANDORIA]    = 'sandoria',
    [tpz.mission.log_id.BASTOK]      = 'bastok',
    [tpz.mission.log_id.WINDURST]    = 'windurst',
    [tpz.mission.log_id.ZILART]      = 'zilart',
    [tpz.mission.log_id.TOAU]        = 'toau',
    [tpz.mission.log_id.WOTG]        = 'wotg',
    [tpz.mission.log_id.COP]         = 'cop',
    [tpz.mission.log_id.ASSAULT]     = 'assault',
    [tpz.mission.log_id.CAMPAIGN]    = 'campaign',
    [tpz.mission.log_id.ACP]         = 'acp',
    [tpz.mission.log_id.AMK]         = 'amk',
    [tpz.mission.log_id.ASA]         = 'asa',
    [tpz.mission.log_id.SOA]         = 'soa',
    [tpz.mission.log_id.ROV]         = 'rov',
}

tpz.mission.logEx =
{
    -- Chains of Promathia
    SANDORIA   = 0,
    WINDURST   = 1,
    LOUVERANCE = 2,
    TENZEN     = 3,
    ULMIA      = 4,
}

tpz.mission.id =
{
    -----------------------------------
    --  All Nations
    -----------------------------------
    ['nation'] =
    {
        MAGICITE    = 13,
        ARCHLICH    = 14,
        SHADOW_LORD = 15,
        NONE        = 65535,
    },

    -----------------------------------
    --  San d'Oria (0)
    -----------------------------------
    [tpz.mission.area[tpz.mission.log_id.SANDORIA]] =
    {
        SMASH_THE_ORCISH_SCOUTS = 0,  -- ± --
        BAT_HUNT                = 1,  -- ± --
        SAVE_THE_CHILDREN       = 2,  -- ± --
        THE_RESCUE_DRILL        = 3,  -- ± --
        THE_DAVOI_REPORT        = 4,  -- ± --
        JOURNEY_ABROAD          = 5,  -- ± --
        JOURNEY_TO_BASTOK       = 6,  -- ± --
        JOURNEY_TO_WINDURST     = 7,  -- ± --
        JOURNEY_TO_BASTOK2      = 8,  -- ± --
        JOURNEY_TO_WINDURST2    = 9,  -- ± --
        INFILTRATE_DAVOI        = 10, -- ± --
        THE_CRYSTAL_SPRING      = 11, -- ± --
        APPOINTMENT_TO_JEUNO    = 12, -- ± --
        MAGICITE                = 13, -- ± --
        THE_RUINS_OF_FEI_YIN    = 14, -- ± --
        THE_SHADOW_LORD         = 15, -- ± --
        LEAUTE_S_LAST_WISHES    = 16, -- ± --
        RANPERRE_S_FINAL_REST   = 17, -- ± --
        PRESTIGE_OF_THE_PAPSQUE = 18, -- ± --
        THE_SECRET_WEAPON       = 19, -- ± --
        COMING_OF_AGE           = 20, -- ± --
        LIGHTBRINGER            = 21, -- ± --
        BREAKING_BARRIERS       = 22, -- ± --
        THE_HEIR_TO_THE_LIGHT   = 23,
        NONE                    = 65535,
    },

    -----------------------------------
    --  Bastok (1)
    -----------------------------------
    [tpz.mission.area[tpz.mission.log_id.BASTOK]] =
    {
        THE_ZERUHN_REPORT         = 0,  -- ± --
        GEOLOGICAL_SURVEY         = 1,  -- ± --
        FETICHISM                 = 2,  -- ± --
        THE_CRYSTAL_LINE          = 3,  -- ± --
        WADING_BEASTS             = 4,  -- ± --
        THE_EMISSARY              = 5,  -- ± --
        THE_EMISSARY_SANDORIA     = 6,  -- ± --
        THE_EMISSARY_WINDURST     = 7,  -- ± --
        THE_EMISSARY_SANDORIA2    = 8,  -- ± --
        THE_EMISSARY_WINDURST2    = 9,  -- ± --
        THE_FOUR_MUSKETEERS       = 10, -- ± --
        TO_THE_FORSAKEN_MINES     = 11, -- ± --
        JEUNO                     = 12, -- ± --
        MAGICITE                  = 13, -- ± --
        DARKNESS_RISING           = 14, -- ± --
        XARCABARD_LAND_OF_TRUTHS  = 15, -- ± --
        RETURN_OF_THE_TALEKEEPER  = 16, -- ± --
        THE_PIRATE_S_COVE         = 17, -- ± --
        THE_FINAL_IMAGE           = 18, -- ± --
        ON_MY_WAY                 = 19,
        THE_CHAINS_THAT_BIND_US   = 20,
        ENTER_THE_TALEKEEPER      = 21,
        THE_SALT_OF_THE_EARTH     = 22,
        WHERE_TWO_PATHS_CONVERGE  = 23,
        NONE                      = 65535,
    },

    -----------------------------------
    --  Windurst (2)
    -----------------------------------
    [tpz.mission.area[tpz.mission.log_id.WINDURST]] =
    {
        THE_HORUTOTO_RUINS_EXPERIMENT = 0,  -- ± --
        THE_HEART_OF_THE_MATTER       = 1,  -- ± --
        THE_PRICE_OF_PEACE            = 2,  -- ± --
        LOST_FOR_WORDS                = 3,  -- ± --
        A_TESTING_TIME                = 4,  -- ± --
        THE_THREE_KINGDOMS            = 5,  -- ± --
        THE_THREE_KINGDOMS_SANDORIA   = 6,  -- ± --
        THE_THREE_KINGDOMS_BASTOK     = 7,  -- ± --
        THE_THREE_KINGDOMS_SANDORIA2  = 8,  -- ± --
        THE_THREE_KINGDOMS_BASTOK2    = 9,  -- ± --
        TO_EACH_HIS_OWN_RIGHT         = 10, -- ± --
        WRITTEN_IN_THE_STARS          = 11, -- ± --
        A_NEW_JOURNEY                 = 12, -- ± --
        MAGICITE                      = 13, -- ± --
        THE_FINAL_SEAL                = 14, -- ± --
        THE_SHADOW_AWAITS             = 15, -- ± --
        FULL_MOON_FOUNTAIN            = 16, -- ± --
        SAINTLY_INVITATION            = 17, -- ± --
        THE_SIXTH_MINISTRY            = 18, -- ± --
        AWAKENING_OF_THE_GODS         = 19, -- ± --
        VAIN                          = 20,
        THE_JESTER_WHO_D_BE_KING      = 21,
        DOLL_OF_THE_DEAD              = 22,
        MOON_READING                  = 23,
        NONE                          = 65535,
    },

    -----------------------------------
    --  Zilart Missions (3)
    -----------------------------------
    [tpz.mission.area[tpz.mission.log_id.ZILART]] =
    {
        THE_NEW_FRONTIER              = 0,  -- ± --
        WELCOME_TNORG                 = 4,  -- ± --
        KAZAMS_CHIEFTAINESS           = 6,  -- ± --
        THE_TEMPLE_OF_UGGALEPIH       = 8,  -- ± --
        HEADSTONE_PILGRIMAGE          = 10, -- ± --
        THROUGH_THE_QUICKSAND_CAVES   = 12, -- ± --
        THE_CHAMBER_OF_ORACLES        = 14, -- ± --
        RETURN_TO_DELKFUTTS_TOWER     = 16, -- ± --
        ROMAEVE                       = 18, -- ± --
        THE_TEMPLE_OF_DESOLATION      = 20, -- ± --
        THE_HALL_OF_THE_GODS          = 22, -- ± --
        THE_MITHRA_AND_THE_CRYSTAL    = 23, -- ± --
        THE_GATE_OF_THE_GODS          = 24, -- ± --
        ARK_ANGELS                    = 26, -- ± --
        THE_SEALED_SHRINE             = 27, -- ± --
        THE_CELESTIAL_NEXUS           = 28,
        AWAKENING                     = 30,
        THE_LAST_VERSE                = 31,
        NONE                          = 65535,
    },

    -----------------------------------
    --  Promathia Missions (6)
    -----------------------------------
    [tpz.mission.area[tpz.mission.log_id.COP]] =
    {
        ANCIENT_FLAMES_BECKON            = 101,  -- Category
        THE_RITES_OF_LIFE                = 110,  -- ± --
        BELOW_THE_ARKS                   = 118,  -- ± --
        THE_MOTHERCRYSTALS               = 128,  -- ± --
        -- THE_ISLE_OF_FORGOTTEN_SAINTS  =     -- Category
        AN_INVITATION_WEST               = 138,  -- ± --
        THE_LOST_CITY                    = 218, -- ± --
        DISTANT_BELIEFS                  = 228, -- ± --
        AN_ETERNAL_MELODY                = 238, -- ± --
        ANCIENT_VOWS                     = 248, -- ± --
        A_TRANSIENT_DREAM                = 257, -- Category
        THE_CALL_OF_THE_WYRMKING         = 258, -- ± --
        A_VESSEL_WITHOUT_A_CAPTAIN       = 318, -- ± --
        THE_ROAD_FORKS                   = 325, -- ± --
        -- EMERALD_WATERS                =     -- Sub-category
        -- VICISSITUDES                  =     -- ± --
        DESCENDANTS_OF_A_LINE_LOST       = 335, -- ± --
        -- LOUVERANCE                    =     -- ± --
        -- MEMORIES_OF_A_MAIDEN          =     -- Sub-category
        COMEDY_OF_ERRORS_ACT_I           = 341, -- ± --
        -- COMEDY_OF_ERRORS_ACT_II       =     -- ± --
        -- EXIT_STAGE_LEFT               =     -- ± --
        TENDING_AGED_WOUNDS              = 350, -- ± --
        DARKNESS_NAMED                   = 358, -- ± --
        -- THE_CRADLES_OF_CHILDREN_LOST  =     -- Category
        SHELTERING_DOUBT                 = 368, -- ± --
        THE_SAVAGE                       = 418, -- ± --
        THE_SECRETS_OF_WORSHIP           = 428, -- ± --
        SLANDEROUS_UTTERINGS             = 438, -- ± --
        -- THE_RETURN_HOME               =     -- Category
        THE_ENDURING_TUMULT_OF_WAR       = 448, -- ± --
        DESIRES_OF_EMPTINESS             = 518, -- ± --
        THREE_PATHS                      = 530, -- ± --
        -- PAST_SINS                     =     -- ± --
        -- SOUTHERN_LEGEND               =     -- ± --
        PARTNERS_WITHOUT_FAME            = 543, -- ± --
        -- A_CENTURY_OF_HARDSHIP         =     -- ± --
        -- DEPARTURES                    =     -- ± --
        -- THE_PURSUIT_OF_PARADISE       =     -- ± --
        SPIRAL                           = 552, -- ± --
        -- BRANDED                       =     -- ± --
        -- PRIDE_AND_HONOR               =     -- ± --
        -- AND_THE_COMPASS_GUIDES        =     -- ± --
        WHERE_MESSENGERS_GATHER          = 560, -- ± --
        -- ENTANGLEMENT                  =     -- ± --
        -- HEAD_WIND                     =     -- ± --
        FLAMES_FOR_THE_DEAD              = 568, -- ± --
        -- ECHOES_OF_TIME                =     -- ± --   -- Category
        FOR_WHOM_THE_VERSE_IS_SUNG       = 578, -- ± --
        A_PLACE_TO_RETURN                = 618, -- ± --
        MORE_QUESTIONS_THAN_ANSWERS      = 628, -- ± --
        ONE_TO_BE_FEARED                 = 638, -- ± --
        -- IN_THE_LIGHT_OF_THE_CRYSTAL   =     -- ± --   -- Category
        CHAINS_AND_BONDS                 = 648, -- ± --
        FLAMES_IN_THE_DARKNESS           = 718, -- ± --
        FIRE_IN_THE_EYES_OF_MEN          = 728, -- ± --
        CALM_BEFORE_THE_STORM            = 738, -- ± --
        THE_WARRIOR_S_PATH               = 748, -- ± --
        EMPTINESS_BLEEDS                 = 758, -- ± ---- Category
        GARDEN_OF_ANTIQUITY              = 800, -- ± --
        A_FATE_DECIDED                   = 818, -- ± --
        WHEN_ANGELS_FALL                 = 828, -- ± --
        DAWN                             = 840, -- ± --
        THE_LAST_VERSE                   = 850,
    },

    -----------------------------------
    --  Aht Urhgan Missions (4)
    -----------------------------------
    [tpz.mission.area[tpz.mission.log_id.TOAU]] =
    {
        LAND_OF_SACRED_SERPENTS = 0,
        IMMORTAL_SENTRIES       = 1,
        PRESIDENT_SALAHEEM      = 2,
        KNIGHT_OF_GOLD          = 3,
        CONFESSIONS_OF_ROYALTY  = 4,
        EASTERLY_WINDS          = 5,
        WESTERLY_WINDS          = 6,
        A_MERCENARY_LIFE        = 7,
        UNDERSEA_SCOUTING       = 8,
        ASTRAL_WAVES            = 9,
        IMPERIAL_SCHEMES        = 10,
        ROYAL_PUPPETEER         = 11,
        LOST_KINGDOM            = 12,
        THE_DOLPHIN_CREST       = 13,
        THE_BLACK_COFFIN        = 14,
        GHOSTS_OF_THE_PAST      = 15,
        GUESTS_OF_THE_EMPIRE    = 16,
        PASSING_GLORY           = 17,
        SWEETS_FOR_THE_SOUL     = 18,
        TEAHOUSE_TUMULT         = 19,
        FINDERS_KEEPERS         = 20,
        SHIELD_OF_DIPLOMACY     = 21,
        SOCIAL_GRACES           = 22,
        FOILED_AMBITION         = 23,
        PLAYING_THE_PART        = 24,
        SEAL_OF_THE_SERPENT     = 25,
        MISPLACED_NOBILITY      = 26,
        BASTION_OF_KNOWLEDGE    = 27,
        PUPPET_IN_PERIL         = 28,
        PREVALENCE_OF_PIRATES   = 29,
        SHADES_OF_VENGEANCE     = 30,
        IN_THE_BLOOD            = 31,
        SENTINELS_HONOR         = 32,
        TESTING_THE_WATERS      = 33,
        LEGACY_OF_THE_LOST      = 34,
        GAZE_OF_THE_SABOTEUR    = 35,
        PATH_OF_BLOOD           = 36,
        STIRRINGS_OF_WAR        = 37,
        ALLIED_RUMBLINGS        = 38,
        UNRAVELING_REASON       = 39,
        LIGHT_OF_JUDGMENT       = 40,
        PATH_OF_DARKNESS        = 41,
        FANGS_OF_THE_LION       = 42,
        NASHMEIRAS_PLEA         = 43,
        RAGNAROK                = 44,
        IMPERIAL_CORONATION     = 45,
        THE_EMPRESS_CROWNED     = 46,
        ETERNAL_MERCENARY       = 47,
    },

    -----------------------------------
    --  Wings of the Goddess (5)
    -----------------------------------
    [tpz.mission.area[tpz.mission.log_id.WOTG]] =
    {
        CAVERNOUS_MAWS             = 0,
        BACK_TO_THE_BEGINNING      = 1,
        CAIT_SITH                  = 2,
        THE_QUEEN_OF_THE_DANCE     = 3,
        WHILE_THE_CAT_IS_AWAY      = 4,
        A_TIMESWEPT_BUTTERFLY      = 5,
        PURPLE_THE_NEW_BLACK       = 6,
        IN_THE_NAME_OF_THE_FATHER  = 7,
        DANCERS_IN_DISTRESS        = 8,
        DAUGHTER_OF_A_KNIGHT       = 9,
        A_SPOONFUL_OF_SUGAR        = 10,
        AFFAIRS_OF_STATE           = 11,
        BORNE_BY_THE_WIND          = 12,
        A_NATION_ON_THE_BRINK      = 13,
        CROSSROADS_OF_TIME         = 14,
        SANDSWEPT_MEMORIES         = 15,
        NORTHLAND_EXPOSURE         = 16,
        TRAITOR_IN_THE_MIDST       = 17,
        BETRAYAL_AT_BEAUCEDINE     = 18,
        ON_THIN_ICE                = 19,
        PROOF_OF_VALOR             = 20,
        A_SANGUINARY_PRELUDE       = 21,
        DUNGEONS_AND_DANCERS       = 22,
        DISTORTER_OF_TIME          = 23,
        THE_WILL_OF_THE_WORLD      = 24,
        FATE_IN_HAZE               = 25,
        THE_SCENT_OF_BATTLE        = 26,
        ANOTHER_WORLD              = 27,
        A_HAWK_IN_REPOSE           = 28,
        THE_BATTLE_OF_XARCABARD    = 29,
        PRELUDE_TO_A_STORM         = 30,
        STORM_S_CRESCENDO          = 31,
        INTO_THE_BEAST_S_MAW       = 32,
        THE_HUNTER_ENSNARED        = 33,
        FLIGHT_OF_THE_LION         = 34,
        FALL_OF_THE_HAWK           = 35,
        DARKNESS_DESCENDS          = 36,
        ADIEU__LILISETTE           = 37,
        BY_THE_FADING_LIGHT        = 38,
        EDGE_OF_EXISTENCE          = 39,
        HER_MEMORIES               = 40,
        FORGET_ME_NOT              = 41,
        PILLAR_OF_HOPE             = 42,
        GLIMMER_OF_LIFE            = 43,
        TIME_SLIPS_AWAY            = 44,
        WHEN_WILLS_COLLIDE         = 45,
        WHISPERS_OF_DAWN           = 46,
        A_DREAMY_INTERLUDE         = 47,
        CAIT_IN_THE_WOODS          = 48,
        FORK_IN_THE_ROAD           = 49,
        MAIDEN_OF_THE_DUSK         = 50,
        WHERE_IT_ALL_BEGAN         = 51,
        A_TOKEN_OF_TROTH           = 52,
        LEST_WE_FORGET             = 53,
    },

    -----------------------------------
    --  A Crystalline Prophecy (9)
    -----------------------------------
    [tpz.mission.area[tpz.mission.log_id.ACP]] =
    {
        A_CRYSTALLINE_PROPHECY        = 0, -- ± --
        THE_ECHO_AWAKENS              = 1, -- ± --
        GATHERER_OF_LIGHT_I           = 2, -- ± --
        GATHERER_OF_LIGHT_II          = 3,
        THOSE_WHO_LURK_IN_SHADOWS_I   = 4, -- ± --
        THOSE_WHO_LURK_IN_SHADOWS_II  = 5, -- ± --
        THOSE_WHO_LURK_IN_SHADOWS_III = 6, -- ± --
        REMEMBER_ME_IN_YOUR_DREAMS    = 7, -- ± --
        BORN_OF_HER_NIGHTMARES        = 8, -- ± --
        BANISHING_THE_ECHO            = 9,
        ODE_OF_LIFE_BESTOWING         = 10,
        A_CRYSTALLINE_PROPHECY_FIN    = 11,
    },

    -----------------------------------
    --  A Moogle Kupo d'Etat (10)
    -----------------------------------
    [tpz.mission.area[tpz.mission.log_id.AMK]] =
    {
        A_MOOGLE_KUPO_DETAT                 = 0,  -- ± --
        DRENCHED_IT_BEGAN_WITH_A_RAINDROP   = 1,  -- ± --
        HASTEN_IN_A_JAM_IN_JEUNO            = 2,  -- ± --
        WELCOME_TO_MY_DECREPIT_DOMICILE     = 3,  -- ± --
        CURSES_A_HORRIFICALLY_HARROWING_HEX = 4,  -- ± --
        AN_ERRAND_THE_PROFESSORS_PRICE      = 5,
        SHOCK_ARRANT_ABUSE_OF_AUTHORITY     = 6,
        LENDER_BEWARE_READ_THE_FINE_PRINT   = 7,
        RESCUE_A_MOOGLES_LABOR_OF_LOVE      = 8,
        ROAR_A_CAT_BURGLAR_BARES_HER_FANGS  = 9,
        RELIEF_A_TRIUMPHANT_RETURN          = 10,
        JOY_SUMMONED_TO_A_FABULOUS_FETE     = 11,
        A_CHALLENGE_YOU_COULD_BE_A_WINNER   = 12,
        SMASH_A_MALEVOLENT_MENACE           = 13,
        A_MOOGLE_KUPO_DETAT_FIN             = 14,
    },

    -----------------------------------
    --  A Shantotto Ascension (11)
    -----------------------------------
    [tpz.mission.area[tpz.mission.log_id.ASA]] =
    {
        A_SHANTOTTO_ASCENSION       = 0, -- ± --
        BURGEONING_DREAD            = 1, -- ± --
        THAT_WHICH_CURDLES_BLOOD    = 2, -- ± --
        SUGAR_COATED_DIRECTIVE      = 3, -- ± --
        ENEMY_OF_THE_EMPIRE_I       = 4,
        ENEMY_OF_THE_EMPIRE_II      = 5,
        SUGAR_COATED_SUBTERFUGE     = 6,
        SHANTOTTO_IN_CHAINS         = 7,
        FOUNTAIN_OF_TROUBLE         = 8,
        BATTARU_ROYALE              = 9,
        ROMANCING_THE_CLONE         = 10,
        SISTERS_IN_ARMS             = 11,
        PROJECT_SHANTOTTOFICATION   = 12,
        AN_UNEASY_PEACE             = 13,
        A_SHANTOTTO_ASCENSION_FIN   = 14,
    },

    -----------------------------------
    --  Seekers of Adoulin (12)
    -----------------------------------
    [tpz.mission.area[tpz.mission.log_id.SOA]] =
    {
        -- THE_SACRED_CITY_OF_ADOULIN   =  -- Category
        RUMORS_FROM_THE_WEST            = 0,   -- ± --
        THE_GEOMAGNETRON                = 1,   -- ± --
        ONWARD_TO_ADOULIN               = 3,   -- ± --
        HEARTWINGS_AND_THE_KINDHEARTED  = 5,   -- ± --
        PIONEER_REGISTRATION            = 6,   -- ± --
        LIFE_ON_THE_FRONTIER            = 7,   -- ± --
        MEETING_OF_THE_MINDS            = 8,   -- ± --
        ARCIELA_APPEARS_AGAIN           = 9,   -- ± --
        -- THE_ANCIENT_PACT             =  -- Category
        BUILDING_PROSPECTS              = 11,
        THE_LIGHT_SHINING_IN_YOUR_EYES  = 12,
        THE_HEIRLOOM                    = 13,
        AN_AIMLESS_JOURNEY              = 14,
        ORTHARSYNE                      = 15,
        IN_THE_PRESENCE_OF_ROYALTY      = 16,
        THE_TWIN_WORLD_TREES            = 17,
        HONOR_AND_AUDACITY              = 18,
        THE_WATERGARDEN_COLISEUM        = 19,
        FRICTION_AND_FISSURES           = 20,
        THE_CELENNIA_MEMORIAL_LIBRARY   = 21,
        FOR_WHOM_DO_WE_TOIL             = 23,
        AIMING_FOR_YGNAS                = 26,
        CALAMITY_IN_THE_KITCHEN         = 27,
        ARCIELAS_PROMISE                = 29,
        PREDATOR_AND_PREY               = 30,
        BEHIND_THE_SLUICES              = 31,
        THE_LEAFKIN_MONARCH             = 34,
        YGGDRASIL                       = 35,
        -- SHADOWS_UPON_ADOULIN         =  -- Category
        RETURN_OF_THE_EXORCIST          = 37,
        THE_MERCILESS_ONE               = 38,
        A_CURSE_FROM_THE_PAST           = 39,
        THE_PURGATION                   = 40,
        THE_KEY                         = 41,
        THE_PRINCESSS_DILEMMA           = 42,
        DARK_CLOUDS_AHEAD               = 43,
        THE_SMALLEST_OF_FAVORS          = 44,
        SUMMONED_BY_SPIRITS             = 45,
        EVIL_ENTITIES                   = 46,
        ADOULIN_CALLING                 = 47,
        THE_DISAPPEARANCE_OF_NYLINE     = 48,
        SHARED_CONSCIOUSNESS            = 49,
        CLEAR_SKIES                     = 50,
        THE_MAN_IN_BLACK                = 51,
        TO_THE_VICTOR                   = 52,
        AN_EXTRAORDINARY_GENTLEMAN      = 53,
        THE_ORDERS_TREASURES            = 55,
        AUGUSTS_HEIRLOOM                = 56,
        BEAUTY_AND_THE_BEAST            = 57,
        WILDCAT_WITH_A_GOLD_PELT        = 58,
        IN_SEARCH_OF_ARCIELA            = 59,
        LOOKING_FOR_LEADS               = 61,
        DRIFTING_NORTHWEST              = 62,
        KUMHAU_THE_FLASHFROST_NAAKUAL   = 63,
        SOUL_SIPHON                     = 66,
        STONEWALLED                     = 67,
        SALVATION                       = 69,
        GLIMMER_OF_PORTENT              = 70,
        -- THE_SERPENTINE_LABYRINTH     =  -- Category
        INTO_THE_FIRE                   = 71,
        MELVIEN_DE_MALECROIX            = 72,
        COURIER_CATASTROPHE             = 73,
        DONE_AND_DELIVERED              = 74,
        MINISTERIAL_WHISPERS            = 75,
        A_DAY_IN_THE_LIFE_OF_A_PIONEER  = 76,
        LIGHTING_THE_WAY                = 77,
        SAJJAKA                         = 78,
        STUDYING_UP                     = 79,
        A_VOW_OF_TRUTH                  = 80,
        DARRCUILN                       = 81,
        THE_GATES                       = 82,
        MORIMAR                         = 84,
        A_NEW_FORCE_ARISES              = 85,
        THE_SACRED_SAPLING              = 86,
        TREE_GRAFTING                   = 87,
        A_SHROUDED_CANOPY               = 88,
        LEAFALLIA                       = 89,
        ROSULATIAS_PROMISE              = 90,
        THE_LIGHTSLAND                  = 91,
        THE_LIGHT_OF_DAWN_COMES         = 92,
        CRIES_FROM_THE_DEEP             = 93,
        SEEDS_OF_DOUBT                  = 94,
        THE_TOMATOES_OF_WRATH           = 95,
        A_GRAVE_MISTAKE                 = 96,
        AN_EMERGENCY_CONVOCATION        = 98,
        BALAMOR_THE_DEATHBORNE_XOL      = 99,
        ANAGNORISIS                     = 100,
        JUST_THE_THING                  = 101,
        SUGARCOATED_SALVATION           = 102,
        ARCIELAS_RESOLVE                = 103,
        BALAMORS_RUSE                   = 104,
        THE_CHARLATAN                   = 105,
        ROYAL_BLESSINGS                 = 107,
        -- HADES                        =  -- Category
        ARBOREAL_RUMORS                 = 108,
        ARCIELAS_MISSIVE                = 109,
        HEROES_UNITE                    = 110,
        A_PORTENT_MOST_OMINOUS          = 111,
        YGGDRASIL_BECKONS               = 112,
        RETURNING_TO_THE_TREES          = 113,
        THE_KEY_TO_THE_TURRIS           = 114,
        TEODORS_SUMMONS                 = 116,
        THE_SEVENTH_GUARDIAN            = 117,
        WATERY_GRAVE                    = 118,
        BLOOD_FOR_BLOOD                 = 120,
        RECKONING                       = 121,
        ABOMINATION                     = 123,
        UNDYING_LIGHT                   = 125,
        THE_LIGHT_WITHIN                = 129,
        -- FIN                          = 130,
    },

    -----------------------------------
    --  Rhapsodies of Vana Diel (13)
    -----------------------------------
    [tpz.mission.area[tpz.mission.log_id.ROV]] =
    {
        RHAPSODIES_OF_VANADIEL          = 0,   -- ± --
        -- CREATION_AND_REBIRTH         =  -- Category
        RESONACE                        = 2,   -- ± --
        EMISSARY_FROM_THE_SEAS          = 3,   -- ± --
        SET_FREE                        = 4,   -- ± --
        THE_BEGINNING                   = 6,   -- ± --
        FLAMES_OF_PRAYER                = 10,  -- ± --
        THE_PATH_UNTRAVELED             = 12,  -- ± --
        AT_THE_HEAVENS_DOOR             = 18,  -- ± --
        THE_LIONS_ROAR                  = 20,  -- ± --
        EDDIES_OF_DESPAIR_I             = 22,  -- ± --
        A_LAND_AFTER_TIME               = 26,  -- ± --
        FATES_CALL                      = 28,  -- ± --
        WHAT_LIES_BEYOND                = 30,  -- ± --
        THE_TIES_THAT_BIND              = 32,  -- ± --
        IMPURITY                        = 34,  -- ± --
        THE_LOST_AVATAR                 = 36,  -- ± --
        VOLTO_OSCURO                    = 40,  -- ± --
        RING_MY_BELL                    = 42,  -- ± --
        -- REVITALIZATION               =  -- Category
        SPIRITS_AWOKEN                  = 44,
        CRASHING_WAVES                  = 46,
        CALL_TO_SERVE                   = 48,
        NUMBERING_DAYS                  = 50,
        INESCAPABLE_BINDS               = 52,
        DESERT_WINDS                    = 54,
        EVER_FORWARD                    = 56,
        THE_ENDLESS_SKY                 = 60,
        APHMAUS_LIGHT                   = 62,
        REUNITED                        = 64,
        TAKE_WING                       = 66,
        PRIME_NUMBER                    = 68,
        FROM_THE_RUINS                  = 70,
        CAUTERIZE                       = 72,
        UNCERTAIN_DESTINATIONS          = 78,
        GANGED_UP_ON                    = 80,
        SACRIFICE                       = 83,
        SOMBER_DREAMS                   = 86,
        OF_LIGHT_AND_DARKNESS           = 92,
        TEMPORARY_FAREWELLS             = 94,
        BRUSHING_UP                     = 96,
        KEEP_ON_GIVING                  = 98,
        PAST_IMPERFECT                  = 100,
        THE_CURSED_TEMPLE               = 102,
        WISDOM_OF_OUR_FOREFATHERS       = 103,
        WHERE_DIVINITIES_COLLIDE        = 104,
        VISIONS_OF_DREAD                = 106,
        TO_THE_SKIES                    = 108,
        ESCHA_RUAUN                     = 110,
        THE_DECISIVE_HEROINE            = 114,
        FALL_FROM_GRACE                 = 116,
        BANISHING_THE_DARKNESS          = 118,
        OVER_THE_RAINBOW                = 120,
        CACOPHONOUS_DISCORD             = 122,
        EDDIES_OF_DESPAIR_II            = 124,
        PRETENDER_TO_THE_THRONE         = 126,
        BANISHED                        = 130,
        CALL_OF_THE_VOID                = 132,
        BOTH_PATHS_TAKEN                = 136,
        THE_MAN_BEHIND_THE_MASK         = 142,
        UNCERTAIN_FUTURES               = 144,
        -- RECKONING                    =  -- Category
        DARKNESS_BECKONS                = 146,
        THE_BREWING_STORM               = 150,
        THE_RIVER_RUNS_RED              = 152,
        THE_CRUCIBLE                    = 154,
        FORWARD_THINKING                = 155,
        TEARS_OF_THE_GENERALS           = 156,
        WHAT_HE_LEFT_BEHIND             = 158,
        GONE_BUT_NOT_FORGOTTEN          = 160,
        AUGUST_ARTIFACTS                = 161,
        SOLEMNITY                       = 162,
        EYES_ON_YOU                     = 164,
        EXPLORING_THE_RUINS             = 166,
        BECOME_SOMETHING_MORE           = 170,
        UNSHAKABLE_NIGHTMARES           = 172,
        WHAT_REMAINS_OF_HOPE            = 174,
        DEATH_CARES_NOT                 = 178,
        NO_TIME_LIKE_THE_FUTURE         = 180,
        SIN                             = 184,
        PENANCE                         = 188,
        VESSEL_OF_LIGHT                 = 190,
        THE_LIFESTREAM_OF_REISENJIMA    = 192,
        FROM_WEST_TO_EAST               = 194,
        GOOD_THINGS_COME_IN_THREES      = 196,
        TACKLING_THE_PROBLEM            = 198,
        WAY_TO_DIVINITY                 = 200,
        THE_WINDS_OF_TIME               = 202,
        CALM_AFTER_THE_STORM            = 206,
        NARY_A_CLOUD_IN_SIGHT           = 210,
        AN_UNENDING_SONG                = 212,
        A_DEEP_SLEEP                    = 216,
        GUARDIANS                       = 218,
        IROHA_IN_DISTRESS               = 220,
        ABSOLUTE_TRUST                  = 222,
        THE_ORBS_RADIANCE               = 224,
        A_RHAPSODY_FOR_THE_AGES         = 226,
    },
    [tpz.mission.area[tpz.mission.log_id.ASSAULT]] = {},
    [tpz.mission.area[tpz.mission.log_id.CAMPAIGN]] = {},
}

-- Assault and Campaign IDs deliberately left out of mission table
-- due to their nature not being the same as other missions,
-- and to allow the content the freedom to develop systems
-- that are more specifically catered to it.

-----------------------------------
--  Assault (7)
-----------------------------------

LEUJAOAM_CLEANSING                = 1 -- ± --
ORICHALCUM_SURVEY                 = 2
ESCORT_PROFESSOR_CHANOIX          = 3
SHANARHA_GRASS_CONSERVATION       = 4
COUNTING_SHEEP                    = 5
SUPPLIES_RECOVERY                 = 6
AZURE_EXPERIMENTS                 = 7
IMPERIAL_CODE                     = 8
RED_VERSUS_BLUE                   = 9
BLOODY_RONDO                      = 10
IMPERIAL_AGENT_RESCUE             = 11
PREEMPTIVE_STRIKE                 = 12 -- ± --
SAGELORD_ELIMINATION              = 13
BREAKING_MORALE                   = 14
THE_DOUBLE_AGENT                  = 15
IMPERIAL_TREASURE_RETRIEVAL       = 16
BLITZKRIEG                        = 17
MARIDS_IN_THE_MIST                = 18
AZURE_AILMENTS                    = 19
THE_SUSANOO_SHUFFLE               = 20
EXCAVATION_DUTY                   = 21 --+
LEBROS_SUPPLIES                   = 22
TROLL_FUGITIVES                   = 23 --+
EVADE_AND_ESCAPE                  = 24
SIEGEMASTER_ASSASSINATION         = 25
APKALLU_BREEDING                  = 26
WAMOURA_FARM_RAID                 = 27
EGG_CONSERVATION                  = 28
OPERATION__BLACK_PEARL            = 29
BETTER_THAN_ONE                   = 30
SEAGULL_GROUNDED                  = 31
REQUIEM                           = 32 -- ± --
SAVING_PRIVATE_RYAAF              = 33
SHOOTING_DOWN_THE_BARON           = 34
BUILDING_BRIDGES                  = 35
STOP_THE_BLOODSHED                = 36
DEFUSE_THE_THREAT                 = 37
OPERATION__SNAKE_EYES             = 38
WAKE_THE_PUPPET                   = 39
THE_PRICE_IS_RIGHT                = 40
GOLDEN_SALVAGE                    = 41 -- ± --
LAMIA_NO_13                       = 42
EXTERMINATION                     = 43 -- ± --
DEMOLITION_DUTY                   = 44
SEARAT_SALVATION                  = 45
APKALLU_SEIZURE                   = 46
LOST_AND_FOUND                    = 47
DESERTER                          = 48
DESPERATELY_SEEKING_CEPHALOPODS   = 49
BELLEROPHON_S_BLISS               = 50
NYZUL_ISLE_INVESTIGATION          = 51
NYZUL_ISLE_UNCHARTED_AREA_SURVEY  = 52

-----------------------------------
--  Campaign (8)
-----------------------------------
-- None yet!

function rankPointMath(rank)
    return 0.372*rank^2 - 1.62*rank + 6.2
end

function getMissionRankPoints(player, missionID)
    if     (missionID ==  3) then crystals = 9
    elseif (missionID ==  4) then crystals = 17
    elseif (missionID ==  5) then crystals = 42
    elseif (missionID == 10) then crystals = 12                    -- 1 stack needed to unlock
    elseif (missionID == 11) then crystals = 30                    -- 2.5 stacks needed to unlock (2 stacks of crystals + 3.1 rank points corresponding to half a stack)
    elseif (missionID == 12) then crystals = 48                    -- 4 stacks to unlock (3.5 stacks + 3.1 rank points corresponding to half a stack)
    elseif (missionID == 13) then crystals = 36                    -- 3 stacks to unlock
    -- 5.1 starts directly after Magicite, no crystals needed
    elseif (missionID == 15) then crystals = 44                    -- Mission unlocks at 50% rank bar ~= 44 crystals using the present formula.
    elseif (missionID == 16) then crystals = 36                    -- 3 stacks to unlock
    elseif (missionID == 17) then crystals = 93                    -- 3 additional stacks to unlock + 3 original stacks + 21 from mission 6.1
    elseif (missionID == 18) then crystals = 45                    -- 45 needed, from http://wiki.ffxiclopedia.org/wiki/The_Final_Image
    elseif (missionID == 19) then crystals = 119                    -- 4 additional stacks needed, plus mission reward of 26
    elseif (missionID == 20) then crystals = 57                    -- 4 3/4 stacks needed
    elseif (missionID == 21) then crystals = 148                    -- 5 additional stacks needed, plus mission reward of 31,
    elseif (missionID == 22) then crystals = 96                    -- 8 stacks needed (higher value chosen so final rank bar requirement is closer to 90%)
    elseif (missionID == 23) then crystals = 228                    -- Additional 8 stacks needed, plus mission reward of 36 (87% rank bar)
    end

    points_needed = 1024 * (crystals-.25) / (3*rankPointMath(player:getRank()))

    if (player:getRankPoints() >= points_needed) then
        return 1
    else
        return 0
    end
end

function getMissionMask(player)
    rank = player:getRank()
    nation = player:getNation()  -- 0 = San d'Oria  1 = Bastok  2 = Windurst
    mission_status =  player:getCurrentMission(nation)

    first_mission = 0
    repeat_mission = 0

    if (nation == tpz.nation.WINDURST) then
        if (rank >= 1) then
            if (player:hasCompletedMission(WINDURST, tpz.mission.id.windurst.THE_HORUTOTO_RUINS_EXPERIMENT) == false) then
                -- 1-1 NOTE: This mission will not be listed in the Mission List for Windurst
                --first_mission = first_mission + 1
            end
            if (player:hasCompletedMission(WINDURST, tpz.mission.id.windurst.THE_HEART_OF_THE_MATTER) == false) then
                -- 1-2 NOTE: This mission will not be listed in the Mission List for Windurst
                --first_mission = first_mission + 2
            end
            if (player:hasCompletedMission(WINDURST, tpz.mission.id.windurst.THE_PRICE_OF_PEACE) == false) then
                -- 1-3 NOTE: This mission will not be listed in the Mission List for Windurst
                --first_mission = first_mission + 4
            end
        end
        if (rank >= 2) then
            -- 2-1
            if (player:hasCompletedMission(WINDURST, tpz.mission.id.windurst.LOST_FOR_WORDS) == false and getMissionRankPoints(player, 3) == 1) then
                first_mission = first_mission + 8
            else
                if (player:hasCompletedMission(WINDURST, tpz.mission.id.windurst.LOST_FOR_WORDS) and (rank > 2 or getMissionRankPoints(player, 4) == 1)) then
                    -- 2-2 Repeatable
                    repeat_mission = repeat_mission + 16
                end
                if (player:hasCompletedMission(WINDURST, tpz.mission.id.windurst.THE_THREE_KINGDOMS) == false and getMissionRankPoints(player, 5) == 1) then
                    -- 2-3
                    first_mission = first_mission + 32
                end
            end
        end
        if (rank >= 3) then
            -- 3-1
            if (player:hasCompletedMission(WINDURST, tpz.mission.id.windurst.TO_EACH_HIS_OWN_RIGHT) == false and getMissionRankPoints(player, 10) == 1) then
                first_mission = first_mission + 1024
            else
                if (player:hasCompletedMission(WINDURST, tpz.mission.id.windurst.WRITTEN_IN_THE_STARS) == true and getMissionRankPoints(player, 11) == 1) then
                    -- 3-2 Repeatable & Skippable
                    repeat_mission = repeat_mission + 2048
                elseif (rank > 3 or getMissionRankPoints(player, 11) == 1) then
                    -- 3-2 Repeatable & Skippable
                    repeat_mission = repeat_mission + 2048
                end
                if (player:hasCompletedMission(WINDURST, tpz.mission.id.windurst.A_NEW_JOURNEY) == false and getMissionRankPoints(player, 12) == 1) then
                    -- 3-3
                    first_mission = first_mission + 4096
                end
            end
        end
        if (rank == 4) then
            -- The mission is triggered by the Ambassador in Jeuno
            -- first_mission = first_mission + 8192
        end
        if (rank == 5) then
            if (player:hasCompletedMission(WINDURST, tpz.mission.id.windurst.THE_FINAL_SEAL) == false and getMissionRankPoints(player, 0) == 1 and mission_status == 0) then
                first_mission = first_mission + 16384
            end
            if (player:hasCompletedMission(WINDURST, tpz.mission.id.windurst.THE_FINAL_SEAL) and player:hasCompletedMission(WINDURST, tpz.mission.id.windurst.THE_SHADOW_AWAITS) == false and getMissionRankPoints(player, 15) == 1) then
                -- 5-2
                first_mission = first_mission + 32768
            end
        end
        if (rank == 6) then
            if (player:hasCompletedMission(WINDURST, tpz.mission.id.windurst.FULL_MOON_FOUNTAIN) == false and getMissionRankPoints(player, 16) == 1) then
                -- 6-1
                first_mission = first_mission + 65536
            elseif (player:hasCompletedMission(WINDURST, tpz.mission.id.windurst.SAINTLY_INVITATION) == false and getMissionRankPoints(player, 17) == 1) then
                -- 6-2
                first_mission = first_mission + 131072
            end
        end
        if (rank == 7) then
            if (player:hasCompletedMission(WINDURST, tpz.mission.id.windurst.THE_SIXTH_MINISTRY) == false and getMissionRankPoints(player, 18) == 1) then
                -- 7-1
                first_mission = first_mission + 262144
            elseif (player:hasCompletedMission(WINDURST, tpz.mission.id.windurst.AWAKENING_OF_THE_GODS) == false and getMissionRankPoints(player, 19) == 1) then
                -- 7-2
                first_mission = first_mission + 524288
            end
        end
        if (rank == 8) then
            if (player:hasCompletedMission(WINDURST, tpz.mission.id.windurst.VAIN) == false and getMissionRankPoints(player, 20) == 1) then
                -- 8-1
                first_mission = first_mission + 1048576
            elseif (player:hasCompletedMission(WINDURST, tpz.mission.id.windurst.THE_JESTER_WHO_D_BE_KING) == false and getMissionRankPoints(player, 21) == 1) then
                -- 8-2
                first_mission = first_mission + 2097152
            end
        end
        if (rank == 9) then
            if (player:hasCompletedMission(WINDURST, tpz.mission.id.windurst.DOLL_OF_THE_DEAD) == false and getMissionRankPoints(player, 22) == 1) then
                -- 9-1
                first_mission = first_mission + 4194304
            elseif (player:hasCompletedMission(WINDURST, tpz.mission.id.windurst.MOON_READING) == false and getMissionRankPoints(player, 23) == 1) then
                -- 9-2
                first_mission = first_mission + 8388608
            end
        end
    elseif (nation == tpz.nation.SANDORIA) then
        if (rank >= 1) then
            if (player:hasCompletedMission(SANDORIA, tpz.mission.id.sandoria.SMASH_THE_ORCISH_SCOUTS) == false) then -- The first mission is repeatable in San d'Oria
                -- 1-1
                repeat_mission = repeat_mission + 1
            elseif (player:hasCompletedMission(SANDORIA, tpz.mission.id.sandoria.BAT_HUNT) == false) then
                -- 1-2 If we completed 1-1, we can start and repeat this mission
                repeat_mission = repeat_mission + 2 + 1
            elseif (player:hasCompletedMission(SANDORIA, tpz.mission.id.sandoria.SAVE_THE_CHILDREN) == false) then
                -- 1-3 If we completed 1-2, we can start and repeat this mission
                repeat_mission = repeat_mission + 4 + 2 + 1
            else
                repeat_mission = repeat_mission + 4 + 2 + 1
            end
        end
        if (rank >= 2) then
            -- 2-1
            if (player:hasCompletedMission(SANDORIA, tpz.mission.id.sandoria.THE_RESCUE_DRILL) == false and getMissionRankPoints(player, 3) == 1) then
                first_mission = first_mission + 8
            else
                if (rank > 2 or getMissionRankPoints(player, 4) == 1) then
                    -- 2-2 Repeatable & Skippable
                    repeat_mission = repeat_mission + 16
                end
                if (player:hasCompletedMission(SANDORIA, tpz.mission.id.sandoria.JOURNEY_ABROAD) == false and getMissionRankPoints(player, 5) == 1) then
                    -- 2-3
                    first_mission = first_mission + 32
                end
            end
        end
        if (rank >= 3) then
            if (rank > 3 or getMissionRankPoints(player, 10) == 1) then
                -- 3-1
                repeat_mission = repeat_mission + 1024
            end
            if (player:hasCompletedMission(SANDORIA, tpz.mission.id.sandoria.INFILTRATE_DAVOI) == true and getMissionRankPoints(player, 11) == 1) then
                -- 3-2 Repeatable & Skippable
                repeat_mission = repeat_mission + 2048
            end
            if (player:hasCompletedMission(SANDORIA, tpz.mission.id.sandoria.APPOINTMENT_TO_JEUNO) == false and getMissionRankPoints(player, 12) == 1) then
                -- 3-3
                first_mission = first_mission + 4096
            end
        end
        if (rank == 4) then
            -- The mission is triggered by the Ambassador in Jeuno
            -- first_mission = first_mission + 8192
        end
        if (rank == 5) then
            if (player:hasCompletedMission(SANDORIA, tpz.mission.id.sandoria.THE_RUINS_OF_FEI_YIN) == false and player:hasKeyItem(tpz.ki.MESSAGE_TO_JEUNO_SANDORIA) == false) then
                first_mission = first_mission + 16384
            end
            if (player:hasCompletedMission(SANDORIA, tpz.mission.id.sandoria.THE_SHADOW_LORD) == false and player:hasCompletedMission(SANDORIA, tpz.mission.id.sandoria.THE_RUINS_OF_FEI_YIN) and getMissionRankPoints(player, 15) == 1) then
                -- 5-2
                first_mission = first_mission + 32768
            end
        end
        if (rank == 6) then
            if (player:hasCompletedMission(SANDORIA, tpz.mission.id.sandoria.LEAUTE_S_LAST_WISHES) == false and getMissionRankPoints(player, 16) == 1) then
                -- 6-1
                first_mission = first_mission + 65536
            elseif (player:hasCompletedMission(SANDORIA, tpz.mission.id.sandoria.RANPERRE_S_FINAL_REST) == false and getMissionRankPoints(player, 17) == 1) then
                -- 6-2
                first_mission = first_mission + 131072
            end
        end
        if (rank == 7) then
            if (player:hasCompletedMission(SANDORIA, tpz.mission.id.sandoria.PRESTIGE_OF_THE_PAPSQUE) == false and getMissionRankPoints(player, 18) == 1) then
                -- 7-1
                first_mission = first_mission + 262144
            elseif (player:hasCompletedMission(SANDORIA, tpz.mission.id.sandoria.THE_SECRET_WEAPON) == false and getMissionRankPoints(player, 19) == 1) then
                -- 7-2
                first_mission = first_mission + 524288
            end
        end
        if (rank == 8) then
            if (player:hasCompletedMission(SANDORIA, tpz.mission.id.sandoria.COMING_OF_AGE) == false and getMissionRankPoints(player, 20) == 1) then
                -- 8-1
                first_mission = first_mission + 1048576
            elseif (player:hasCompletedMission(SANDORIA, tpz.mission.id.sandoria.LIGHTBRINGER) == false and getMissionRankPoints(player, 21) == 1 and player:getCharVar("Mission8-1Completed") == 1) then
                -- 8-2
                first_mission = first_mission + 2097152
            end
        end
        if (rank == 9) then
            if (player:hasCompletedMission(SANDORIA, tpz.mission.id.sandoria.BREAKING_BARRIERS) == false and getMissionRankPoints(player, 22) == 1) then
                -- 9-1
                first_mission = first_mission + 4194304
            elseif (player:hasCompletedMission(SANDORIA, tpz.mission.id.sandoria.BREAKING_BARRIERS) == false and getMissionRankPoints(player, 22) == 1 and player:getCharVar("Cutscenes_8-2") == 2) then
                -- 9-2
                first_mission = first_mission + 8388608

    elseif (player:hasCompletedMission(SANDORIA, tpz.mission.id.sandoria.THE_HEIR_TO_THE_LIGHT) == false and getMissionRankPoints(player, 23) == 1) then
                -- 9-2
                first_mission = first_mission + 8388608

            end
        end
    elseif (nation == tpz.nation.BASTOK) then
        if (rank >= 1) then
            if (player:hasCompletedMission(BASTOK, tpz.mission.id.bastok.THE_ZERUHN_REPORT) == false) then
                -- 1-1 NOTE: This mission will not be listed in the Mission List for Bastok
                --first_mission = first_mission + 1
            end
            if (player:hasCompletedMission(BASTOK, tpz.mission.id.bastok.GEOLOGICAL_SURVEY) == false) then
                -- 1-2 NOTE: This mission will not be listed in the Mission List for Bastok
                first_mission = first_mission + 2
            end
            if (player:hasCompletedMission(BASTOK, tpz.mission.id.bastok.GEOLOGICAL_SURVEY) == true) then
                -- 1-3
                repeat_mission = repeat_mission + 4
            end
        end
        if (rank >= 2) then
            -- 2-1
            if (player:hasCompletedMission(BASTOK, tpz.mission.id.bastok.THE_CRYSTAL_LINE) == false and getMissionRankPoints(player, 3) == 1) then
                first_mission = first_mission + 8
            else
                if (rank > 2 or getMissionRankPoints(player, 4) == 1) then
                    -- 2-2 Repeatable
                    repeat_mission = repeat_mission + 16
                end
                if (player:hasCompletedMission(BASTOK, tpz.mission.id.bastok.THE_EMISSARY) == false and getMissionRankPoints(player, 5) == 1) then
                    -- 2-3
                    first_mission = first_mission + 32
                end
            end
        end
        if (rank >= 3) then
            -- 3-1
            if (player:hasCompletedMission(BASTOK, tpz.mission.id.bastok.THE_FOUR_MUSKETEERS) == false and getMissionRankPoints(player, 10) == 1) then
                first_mission = first_mission + 1024
            else
                if (rank > 3 or getMissionRankPoints(player, 11) == 1) then
                    -- 3-2 Repeatable & Skippable
                    repeat_mission = repeat_mission + 2048
                end
                if (player:hasCompletedMission(BASTOK, tpz.mission.id.bastok.JEUNO) == false and getMissionRankPoints(player, 12) == 1) then
                    -- 3-3
                    first_mission = first_mission + 4096
                end
            end
        end
        if (rank == 4) then
            -- The mission is triggered by the Ambassador in Jeuno
            -- first_mission = first_mission + 8192
        end
        if (rank == 5) then
            if (player:hasCompletedMission(BASTOK, tpz.mission.id.bastok.DARKNESS_RISING) == false and getMissionRankPoints(player, 0) == 1 and mission_status == 0) then
                first_mission = first_mission + 16384
            end
            if (player:hasCompletedMission(BASTOK, tpz.mission.id.bastok.DARKNESS_RISING) and player:hasCompletedMission(BASTOK, tpz.mission.id.bastok.XARCABARD_LAND_OF_TRUTHS) == false and getMissionRankPoints(player, 15) == 1) then
                -- 5-2
                first_mission = first_mission + 32768
            end
        end
        if (rank == 6) then
            if (player:hasCompletedMission(BASTOK, tpz.mission.id.bastok.RETURN_OF_THE_TALEKEEPER) == false and getMissionRankPoints(player, 16) == 1) then
                -- 6-1
                first_mission = first_mission + 65536
            elseif (player:hasCompletedMission(BASTOK, tpz.mission.id.bastok.THE_PIRATE_S_COVE) == false and getMissionRankPoints(player, 17) == 1) then
                -- 6-2
                first_mission = first_mission + 131072
            end
        end
        if (rank == 7) then
            if (player:hasCompletedMission(BASTOK, tpz.mission.id.bastok.THE_FINAL_IMAGE) == false and getMissionRankPoints(player, 18) == 1) then
                -- 7-1
                first_mission = first_mission + 262144
            elseif (player:hasCompletedMission(BASTOK, tpz.mission.id.bastok.ON_MY_WAY) == false and getMissionRankPoints(player, 19) == 1) then
                -- 7-2
                first_mission = first_mission + 524288
            end
        end
        if (rank == 8) then
            if (player:hasCompletedMission(BASTOK, tpz.mission.id.bastok.THE_CHAINS_THAT_BIND_US) == false and getMissionRankPoints(player, 20) == 1) then
                -- 8-1
                first_mission = first_mission + 1048576
            elseif (player:hasCompletedMission(BASTOK, tpz.mission.id.bastok.ENTER_THE_TALEKEEPER) == false and getMissionRankPoints(player, 21) == 1) then
                -- 8-2
                first_mission = first_mission + 2097152
            end
        end
        if (rank == 9) then
            if (player:hasCompletedMission(BASTOK, tpz.mission.id.bastok.THE_SALT_OF_THE_EARTH) == false and getMissionRankPoints(player, 22) == 1) then
                -- 9-1
                first_mission = first_mission + 4194304
            elseif (player:hasCompletedMission(BASTOK, tpz.mission.id.bastok.WHERE_TWO_PATHS_CONVERGE) == false and getMissionRankPoints(player, 23) == 1) then
                -- 9-2
                first_mission = first_mission + 8388608
            end
        end
    end

    if (player:getCurrentMission(nation) == tpz.mission.id.sandoria.THE_RUINS_OF_FEI_YIN and player:getCharVar("MissionStatus") == 8) then
        mission_mask = 2147483647 - 16384
    else
        mission_mask = 2147483647 - repeat_mission - first_mission -- 2^31 -1 - ..
    end

    return mission_mask, repeat_mission
end

function getMissionOffset(player, guard, pMission, MissionStatus)

    offset = 0 cs = 0 params = {0, 0, 0, 0, 0, 0, 0, 0}
    nation = player:getNation()

    if (nation == tpz.nation.SANDORIA) then

            if (guard == 1) then GuardCS = {1022, 1021, 1025, 1004, 1024, 1005, 1006, 1028, 1029, 1012, 1031}
        elseif (guard == 2) then GuardCS = {2022, 2021, 2025, 2004, 2024, 2005, 2006, 2028, 2029, 2012, 2031}
        end

        switch (pMission) : caseof {
            [0] = function (x) offset = 0 end, -- Mission 1-1
            [1] = function (x) if (MissionStatus == 2) then cs = GuardCS[1] else cs = GuardCS[2] end end, -- Mission 1-2 (1) after check tombstone
            [2] = function (x) if (MissionStatus == 0) then cs = GuardCS[3] -- Mission 1-3 before Battlefield
                           elseif (MissionStatus == 4 and player:hasCompletedMission(0, 2) == false) then cs = GuardCS[4] -- Mission 1-3 after Battlefield
                           elseif (MissionStatus == 4) then cs = GuardCS[5] else offset = 24 end end, -- Mission 1-3 after Battlefield (Finish Quest)
            [3] = function (x) if (MissionStatus == 11) then cs = GuardCS[6] else offset = 36 end end,
            [4] = function (x) if (MissionStatus == 3 and player:hasCompletedMission(0, 4)) then cs = GuardCS[7]
                           elseif (MissionStatus == 3) then cs = GuardCS[8] params = {0, 0, 0, 44} else offset = 44 end end,
            [5] = function (x) if (MissionStatus == 0) then offset = 50 else offset = 51 end end,
            [10] = function (x) if (MissionStatus == 0) then cs = GuardCS[9]
                            elseif (MissionStatus == 4) then offset = 55
                            elseif (MissionStatus == 5) then offset = 60
                            elseif (MissionStatus == 10) then cs = GuardCS[10] end end,
            [11] = function (x) if (MissionStatus == 0) then offset = 68
                            elseif (MissionStatus == 2) then cs = GuardCS[11] end end,
            [12] = function (x) if (MissionStatus == 0) then offset = 74 end end,
            [14] = function (x) if (MissionStatus == 0) then cs = 61 end end,
        }
        return cs, params, offset

    elseif (nation == tpz.nation.BASTOK) then

        switch (pMission) : caseof {
            [0] = function (x) offset = 0 end,
            [1] = function (x) offset = 3 end,
            [2] = function (x) offset = 6 end,
            [3] = function (x) offset = 19 end,
            [4] = function (x) offset = 21 end,
            [5] = function (x) offset = 23 end,
            [10] = function (x) offset = 27 end,
            [11] = function (x) offset = 30 end,
            [12] = function (x) offset = 35 end,
            [14] = function (x) cs = 1007 end,
            [15] = function (x) offset = 39 end,
            [16] = function (x) offset = 0 end,
            [17] = function (x) offset = 3 end,
            [18] = function (x) offset = 5 end,
            [19] = function (x) offset = 7 end,
            [20] = function (x) offset = 10 end,
            [21] = function (x) offset = 12 end,
            [22] = function (x) offset = 14 end,
            [23] = function (x) offset = 19 end,
        }
        return cs, params, offset

    elseif (nation == tpz.nation.WINDURST) then

            if (guard == 1) then GuardCS = {127, 136, 150, 154, 160, 473, 177}
        elseif (guard == 2) then GuardCS = {123, 131, 310, 148, 156, 177, 215}
        elseif (guard == 3) then GuardCS = {89, 105, 110, 114, 120, 133, 138}
        elseif (guard == 4) then GuardCS = {99, 107, 112, 116, 122, 127, 134}
        end

        switch (pMission) : caseof {
            [0] = function (x) cs = GuardCS[1] end,
            [1] = function (x) cs = GuardCS[2] end,
            [2] = function (x) if (MissionStatus <= 2) then cs = GuardCS[3] else cs = GuardCS[4] end end,
            [3] = function (x) cs = GuardCS[5] end,
            [4] = function (x) cs = GuardCS[6] end,
            [5] = function (x) cs = GuardCS[7] end,
        }
        return cs, params, offset
    end

end

function finishMissionTimeline(player, guard, csid, option)

    nation = player:getNation()

    -- To prevent the cs conflict, use the 1st and 2nd for guard and 3/4 for npc
    -- missionid, {Guard1CS, option}, {Guard2CS, option}, {NPC1 CS, option}, {NPC2 CS, option}, {{function, value}, ...},
    --  1: player:addMission(nation, mission)
    --  2: player:messageSpecial(YOU_ACCEPT_THE_MISSION)
    --  3: player:setCharVar(variablename, value)
    --  4: player:tradeComplete()
    --  5: player:addRankPoints(number)
    --  6: player:setRankPoints(0)
    --  7: player:addPoint(player:getNation(), number) player:messageSpecial(YOUVE_EARNED_CONQUEST_POINTS)
    --  8: player:addGil(GIL_RATE*number) player:messageSpecial(GIL_OBTAINED, GIL_RATE*number)
    --  9: player:delKeyItem(number)
    -- 10: player:addKeyItem(number) player:messageSpecial(KEYITEM_OBTAINED, number)
    -- 11: player:setRank(number)
    -- 12: player:completeMission(nation, mission)
    -- 13: player:addTitle(number)
    -- 14: player:setCharVar("MissionStatus", value)

    if (nation == tpz.nation.SANDORIA) then
        if ((csid == 1009 or csid == 2009) and option ~= 1073741824 and option ~= 31) then
            if (option > 100) then
                badoption = {101, 1, 102, 2, 104, 4, 110, 10, 111, 11}
                for op = 1, #badoption, 2 do
                    if (option == badoption[op]) then
                    timeline = {badoption[op+1], {1009, badoption[op]}, {2009, badoption[op]}, {0, 0}, {0, 0}, {{1}, {2}}} end
                end
            elseif (option == 14) then
                timeline = {option, {1009, option}, {2009, option}, {0, 0}, {0, 0}, {{1}, {2}, {3, "MissionStatus", 9}}}
            else
                timeline = {option, {1009, option}, {2009, option}, {0, 0}, {0, 0}, {{1}, {2}}}
            end
        else
            timeline =
            {
                 -- MissionID, {Guard#1 DialogID, option}, {Guard#2 DialogID, option}, {NPC#1 DialogID, option}, {NPC#2 DialogID, option}, {function list}
                 0, {1000, 0}, {2000, 0}, {0, 0},        {0, 0}, {{1}, {2}},                                                     -- MISSION 1-1 (First Mission [START])
                 0, {1020, 0}, {2020, 0}, {0, 0},        {0, 0}, {{4}, {5, 150}, {12}, {14, 0}},                                     -- MISSION 1-1
                 0, {1002, 0}, {2002, 0}, {0, 0},        {0, 0}, {{4}, {5, 150}, {12}},                                            -- MISSION 1-1 [Repeat]
                 1, {1023, 0}, {2023, 0}, {0, 0},        {0, 0}, {{4}, {14, 0}, {5, 200}, {12}},                                     -- MISSION 1-2
                 1, {1003, 0}, {2003, 0}, {0, 0},        {0, 0}, {{4}, {14, 0}, {5, 200}, {12}},                                    -- MISSION 1-2 [Repeat]
                 2, {1004, 0}, {2004, 0}, {0, 0},        {0, 0}, {{11, 2}, {3, "OptionalCSforSTC", 1}, {14, 0}, {6}, {8, 1000}, {12}},     -- MISSION 1-3
                 2, {1024, 0}, {2024, 0}, {0, 0},        {0, 0}, {{14, 0}, {5, 250}, {12}},                                        -- MISSION 1-3 [Repeat]
                 3, {1005, 0}, {2005, 0}, {0, 0},        {0, 0}, {{9, 65}, {14, 0}, {5, 300}, {12}},                                 -- MISSION 2-1
                 4, {0, 0},      {0, 0},     {695, 0}, {0, 0}, {{9, 44}, {14, 0}, {5, 350}, {12}},                                 -- MISSION 2-2 (Papal Chambers)
                 5, {0, 0},      {0, 0},     {507, 0}, {0, 0}, {{10, 35}, {6}, {13, 207}, {8, 3000}, {11, 3}, {9, 29}, {14, 0}, {12}},     -- MISSION 2-3 (Halver)
                10, {0, 0},      {0, 0},     {554, 0}, {0, 0}, {{9, 237}, {14, 0}, {5, 400}, {12}},                                 -- MISSION 3-1 (Prince Trion (door))
                10, {1012, 0}, {2012, 0}, {0, 0},        {0, 0}, {{14, 0}, {5, 300}, {12}},                                         -- MISSION 3-1 (Guard)[Repeat]
                11, {1030, 0}, {2030, 0}, {0, 0},        {0, 0}, {{4}, {14, 2}},                                                 -- MISSION 3-2 (dialog with the guard after trade)
                11, {0, 0},      {0, 0},     {556, 0}, {0, 0}, {{14, 0}, {5, 400}, {12}},                                         -- MISSION 3-2 (Chalvatot)
                11, {1013, 0}, {2013, 0}, {0, 0},        {0, 0}, {{4}, {14, 0}, {5, 400}, {12}},                                     -- MISSION 3-2 (Guard)[Repeat]
                12, {0, 0},      {0, 0},     {39, 0}, {0, 0}, {{11, 4}, {14, 0}, {6}, {8, 5000}, {12}},                             -- MISSION 3-3 (Finish (Nelcabrit))
                13, {0, 0},      {0, 0},     {36, 0}, {0, 0}, {{11, 5}, {14, 0}, {13, 212}, {10, 69}, {6}, {8, 10000}, {12}, {1, 14}},     -- MISSION 4-1 (Finish (Nelcabrit))
                14, {0, 0},      {0, 0},     {533, 0}, {0, 0}, {{10, 72}, {14, 10}},                                             -- MISSION 5-1 (Finish (Halver))
                14, {0, 0},      {0, 0},     {534, 0}, {0, 0}, {{9, 73}, {5, 400}, {14, 0}, {13, 10}, {12}},                         -- MISSION 5-1 (Finish (Halver))
                15, {0, 0},      {0, 0},     {548, 0}, {0, 0}, {{11, 6}, {14, 5}},                                                -- MISSION 5-2 (Finish 1st Part (Halver))
                15, {0, 0},      {0, 0},     {61, 0}, {0, 0}, {{14, 0}, {9, 74}, {8, 20000}, {6}, {12}},                             -- MISSION 5-2 (Finish 2nd Part (Trion in Great Hall))
                16, {0, 0},      {0, 0},     {111, 0}, {0, 0}, {{14, 0}, {9, 268}, {10, 270}, {12}},                                 -- MISSION 6-1 (Finish (Chalvatot))
                17, {1034, 0}, {1033, 0}, {0, 0}, {0, 0}, {{14, 0}, {11, 7}, {8, 40000}, {6}, {12}},                                -- MISSION 6-2 (Finish (Guard))
                18, {0, 0},      {0, 0},     {7, 0}, {0, 0}, {{14, 1}},                                                     -- MISSION 7-1 (setCharVar("MissionStatus", 1) (Door: Papal Chambers))
                18, {0, 0},      {0, 0},     {8, 0}, {0, 0}, {{14, 0}, {9, 283}, {5, 1000}, {12}},                                 -- MISSION 7-1 (Finish (Door: Papal Chambers))
                19, {1044, 0}, {1043, 0}, {0, 0}, {0, 0}, {{14, 0}, {6}, {3, "SecretWeaponStatus", 0}, {9, 284}, {11, 8}, {8, 60000}, {12}}, -- MISSION 7-2 (Finish)
                20, {0, 0},      {0, 0},     {102, 0}, {0, 0}, {{14, 0}, {9, 288}, {5, 800}, {12}},                                    -- MISSION 8-1 (Finish)
                21, {0, 0},     {0, 0},     {104, 0}, {0, 0}, {{14, 0}, {9, 284}, {11, 9}, {8, 80000}, {6}, {12}},                    -- MISSION 8-2 (Finish (Door: Great Hall))
                22, {0, 0},      {0, 0},     {76, 0}, {0, 0}, {{14, 0}, {9, 481}, {9, 482}, {9, 483}, {5, 900}, {12}}                    -- MISSION 9-1 (Finish (Door: Great Hall))
                --[[0, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0},
                0, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0}, ]]--
            }
        end
    elseif (nation == tpz.nation.BASTOK) then
        if (csid == 1001 and option ~= 1073741824 and option ~= 31) then
            timeline = {option, {1001, option}, {0, 0}, {0, 0}, {0, 0}, {{1}, {2}}}
        else
            timeline =
            {
                 0, {1000, 0}, {0, 0}, {0, 0}, {0, 0}, {{1}, {2}},                                                                 -- MISSION 1-1 (First Mission [START])
                 1, {504, 0}, {0, 0}, {0, 0}, {0, 0}, {{9, 4}, {12}},                                                             -- MISSION 1-2 (Finish Mission)
                 2, {1008, 0}, {0, 0}, {0, 0}, {0, 0}, {{4}, {11, 2}, {8, 1000}, {12}},                                             -- MISSION 1-3
                 2, {1005, 0}, {0, 0}, {0, 0}, {0, 0}, {{4}, {8, 1000}, {5, 200}, {12}},                                              -- MISSION 1-3 [Repeat]
                 3, {712, 0}, {0, 0}, {0, 0}, {0, 0}, {{9, 12}, {14, 0}, {5, 200}, {12}},                                             -- MISSION 2-1 (Finish (Ayame))
                 4, {372, 0}, {0, 0}, {0, 0}, {0, 0}, {{4}, {5, 250}, {12}},                                                     -- MISSION 2-2 (Finish (Alois))
                 4, {373, 0}, {0, 0}, {0, 0}, {0, 0}, {{4}, {5, 250}, {12}},                                                     -- MISSION 2-2 (Finish (Alois)) [Repeat]
                 5, {714, 0}, {0, 0}, {0, 0}, {0, 0}, {{10, 35}, {6}, {13, 207}, {8, 3000}, {11, 3}, {9, 29}, {14, 0}, {12}},                 -- MISSION 2-3 (Finish (Naji))
                10, {11, 0}, {0, 0}, {0, 0}, {0, 0}, {{14, 0}, {5, 350}, {12}},                                                     -- MISSION 3-1 (Pashhow Marshlands Zone)
                11, {1010, 0}, {0, 0}, {0, 0}, {0, 0}, {{4}, {5, 400}, {12}},                                                     -- MISSION 3-2
                11, {1006, 0}, {0, 0}, {0, 0}, {0, 0}, {{4}, {5, 400}, {12}},                                                     -- MISSION 3-2 [Repeat]
                12, {38, 0}, {0, 0}, {0, 0}, {0, 0}, {{11, 4}, {14, 0}, {6}, {8, 5000}, {12}},                                         -- MISSION 3-3 (Finish (Goggehn))
                13, {35, 0}, {0, 0}, {0, 0}, {0, 0}, {{11, 5}, {14, 0}, {13, 212}, {10, 70}, {6}, {8, 10000}, {12}, {1, 14}},             -- MISSION 4-1 (Finish (Goggehn))
                14, {722, 0}, {0, 0}, {0, 0}, {0, 0}, {{14, 0}, {9, 73}, {5, 600}, {12}},                                             -- MISSION 5-1 (Finish (Naji))
                15, {603, 0}, {0, 0}, {0, 0}, {0, 0}, {{11, 6}, {14, 0}, {9, 74}, {8, 20000}, {6}, {12}},                                 -- MISSION 5-2 (Finish (Karst))
                16, {182, 0}, {0, 0}, {0, 0}, {0, 0}, {{14, 0}, {9, 266}, {5, 650}, {12}},                                             -- MISSION 6-1 (Finish (Tall Mountain))
                17, {762, 0}, {0, 0}, {0, 0}, {0, 0}, {{14, 0}, {6}, {11, 7}, {8, 40000}, {12}},                                     -- MISSION 6-2 (Finish (Naji))
                18, {764, 0}, {0, 0}, {0, 0}, {0, 0}, {{14, 0}, {9, 289}, {5, 700}, {12}},                                             -- MISSION 7-1 (Finish (Cid))
                19, {766, 0}, {0, 0}, {0, 0}, {0, 0}, {{14, 0}, {6}, {11, 8}, {8, 60000}, {3, "OptionalCSforOMW", 1}, {12}},             -- MISSION 7-2 (Finish (Karst))
                20, {768, 0}, {0, 0}, {0, 0}, {0, 0}, {{14, 0}, {5, 1133}, {12}},                                                 -- MISSION 8-1 (Finish (Iron Eater))
                21, {176, 0}, {0, 0}, {0, 0}, {0, 0}, {{14, 0}, {6}, {11, 9}, {9, 293}, {8, 80000}, {12}},                                     -- MISSION 8-2 (Finish (Bastok Mines))
            }
        end
    elseif (nation == tpz.nation.WINDURST) then
        guardlist = {114, 111, 78, 93}
        if (csid == guardlist[guard] and option ~= 1073741824 and option ~= 31) then
            timeline = {option, {guardlist[guard], option}, {guardlist[guard], option}, {guardlist[guard], option}, {guardlist[guard], option}, {{1}, {2}}}
        else
            timeline =
            {
                 0, {121, 1}, {118, 1}, {83, 1}, {96, 1}, {{1}, {2}},                                                 -- MISSION 1-1 (First Mission [START])
                 0, {94, 0}, {0, 0},     {0, 0},        {0, 0},       {{14, 0}, {5, 150}, {9, 28}, {12}},                             -- MISSION 1-1 (Finish (Hakkuru-Rinkuru))
                 1, {132, 1}, {130, 1}, {104, 1}, {106, 1}, {{1}, {2}},                                                 -- MISSION 1-2 [START]
                 1, {143, 0}, {0, 0},     {0, 0},        {0, 0},       {{14, 0}, {5, 200}, {12}},                                     -- MISSION 1-2 (Finish (Apururu)) [WITHOUT ORB]
                 1, {145, 0}, {0, 0},     {0, 0},        {0, 0},       {{14, 0}, {5, 250}, {12}},                                     -- MISSION 1-2 (Finish (Apururu)) [WITH ORB]
                 2, {149, 2}, {135, 2}, {109, 2}, {111, 2}, {{1}, {2}},                                                 -- MISSION 1-3 [START]
                 2, {154, 0}, {148, 0}, {114, 0}, {116, 0}, {{11, 2}, {14, 0}, {5, 300}, {8, 1000}, {12}},                     -- MISSION 1-3
                 3, {168, 0}, {0, 0},     {0, 0},        {0, 0},       {{14, 0}, {5, 350}, {12}},                                     -- MISSION 2-1 (Finish (Tosuka-Porika))
                 4, {201, 0}, {0, 0},     {0, 0},        {0, 0},       {{14, 0}, {9, 38}, {5, 400}, {12}},                             -- MISSION 2-2 (Finish (Moreno-Toeno)) (+35 mob killed)
                 4, {206, 0}, {0, 0},     {0, 0},        {0, 0},       {{14, 0}, {9, 38}, {5, 400}, {12}},                             -- MISSION 2-2 (Finish (Moreno-Toeno)) (+35 mob killed) [Repeat]
                 4, {200, 0}, {0, 0},     {0, 0},        {0, 0},       {{14, 0}, {9, 38}, {5, 250}, {12}},                             -- MISSION 2-2 (Finish (Moreno-Toeno)) (30-34 mob killed)
                 4, {209, 0}, {0, 0},     {0, 0},        {0, 0},       {{14, 0}, {9, 38}, {5, 250}, {12}},                             -- MISSION 2-2 (Finish (Moreno-Toeno)) (30-34 mob killed) [Repeat]
                 5, {101, 0}, {0, 0},     {0, 0},        {0, 0},       {{10, 35}, {6}, {13, 207}, {8, 3000}, {11, 3}, {9, 29}, {14, 0}, {12}}, -- MISSION 2-3 (Finish (Kupipi))
                10, {0, 0},      {114, 0}, {0, 0},        {0, 0},       {{5, 450}, {14, 0}, {12}},                                     -- MISSION 3-1 (Finish (Rhy Epocan))
                11, {135, 0}, {0, 0},     {0, 0},        {0, 0},       {{5, 500}, {14, 0}, {12}},                                     -- MISSION 3-2 (Finish (Zubaba))
                11, {151, 0}, {0, 0},     {0, 0},        {0, 0},       {{5, 400}, {14, 0}, {12}},                                    -- MISSION 3-2 (Finish (Zubaba)) [Repeat]
                12, {40, 0}, {0, 0},     {0, 0},        {0, 0},       {{11, 4}, {9, 30}, {14, 0}, {6}, {8, 5000}, {12}},                 -- MISSION 3-3 (Finish (Ambassador's door))
                13, {37, 0}, {0, 0},     {0, 0},        {0, 0},       {{11, 5}, {14, 0}, {13, 212}, {10, 71}, {6}, {8, 10000}, {12}},     -- MISSION 4-1 (Finish (Pakh Jatalfih))
                14, {192, 0}, {0, 0},     {0, 0},        {0, 0},       {{14, 0}, {9, 73}, {5, 600}, {12}},                             -- MISSION 5-1 (Finish (Star Sibyl))
                15, {216, 0}, {0, 0},     {0, 0},        {0, 0},       {{11, 6}, {14, 0}, {9, 74}, {8, 20000}, {6}, {12}},                 -- MISSION 5-2 (Finish (Star Sibyl))
                16, {0, 0},      {0, 0},     {50, 0}, {0, 0},       {{14, 0}, {5, 650}, {0, 0}, {0, 0}, {0, 0}, {12}},                    -- MISSION 6-1 (Finish (Zone: Full Moon Fountain))
                17, {0, 0},      {0, 0},     {312, 0}, {0, 0},       {{14, 0}, {11, 7}, {8, 40000}, {6}, {0, 0}, {12}},                -- MISSION 6-2 (Finish (Star Sibyl))
                18, {0, 0},      {0, 0},     {724, 0}, {0, 0},       {{14, 0}, {5, 700}, {10, 251}, {0, 0}, {0, 0}, {12}},                -- MISSION 7-1 (Finish (Tosuka-Porika))
                19, {0, 0},      {0, 0},     {742, 0}, {0, 0},       {{14, 0}, {11, 8}, {8, 60000}, {6}, {0, 0}, {12}},                    -- MISSION 7-2 (Finish (Leepe-Hoppe))
                20, {0, 0},      {0, 0},     {758, 0}, {0, 0},       {{14, 0}, {5, 750}, {0, 0}, {0}, {0, 0}, {12}},                    -- MISSION 8-1 (Finish (Morno-Toeno))
                21, {0, 0},      {0, 0},     {609, 0}, {0, 0},       {{14, 0}, {11, 9}, {8, 80000}, {6}, {0, 0}, {12}},                    -- MISSION 8-2 (Finish (Apururu))
                22, {0, 0},     {0, 0},     {61, 0}, {0, 0},     {{14, 0}, {5, 800}, {13, 293}, {0}, {0, 0}, {12}},                    -- MISSION 9-1 (Finish (Zone: Full Moon Fountain))
                23, {0, 0},      {0, 0},     {407, 0}, {0, 0},       {{13, 294}, {11, 10}, {8, 100000}, {6}, {0, 0}, {12}}                    -- MISSION 9-2 (Finish (Vestal Chamber))
            }
        end
    end

    for cs = 1, #timeline, 6 do
        if (csid == timeline[cs + guard][1] and option == timeline[cs + guard][2]) then
            for nb = 1, #timeline[cs + 5], 1 do
                messList = timeline[cs + 5][nb]

                switch (messList[1]) : caseof {
                    [1] = function (x) if (messList[2] ~= nil) then player:addMission(nation, messList[2]) else player:addMission(nation, timeline[cs]) end end,
                    [2] = function (x) player:messageSpecial(zones[player:getZoneID()].text.YOU_ACCEPT_THE_MISSION) end,
                    [3] = function (x) player:setCharVar(messList[2], messList[3]) end,
                    [4] = function (x) player:tradeComplete() end,
                    [5] = function (x) if ((player:getRankPoints() + messList[2]) > 4000) then player:setRankPoints(4000) else player:addRankPoints(messList[2]) end end,
                    [6] = function (x) player:setRankPoints(0) end,
                    [7] = function (x) player:addCP(messList[2]) player:messageSpecial(zones[player:getZoneID()].text.YOUVE_EARNED_CONQUEST_POINTS) end,
                    [8] = function (x) player:addGil(GIL_RATE*messList[2]) player:messageSpecial(zones[player:getZoneID()].text.GIL_OBTAINED, GIL_RATE*messList[2]) end,
                    [9] = function (x) player:delKeyItem(messList[2]) end,
                    [10] = function (x) player:addKeyItem(messList[2]) player:messageSpecial(zones[player:getZoneID()].text.KEYITEM_OBTAINED, messList[2]) end,
                    [11] = function (x) player:setRank(messList[2]) end,
                    [12] = function (x) player:completeMission(nation, timeline[cs]) end,
                    [13] = function (x) player:addTitle(messList[2]) end,
                    [14] = function (x) player:setCharVar("MissionStatus", messList[2]) end,
                }
            end
        end
    end

end
