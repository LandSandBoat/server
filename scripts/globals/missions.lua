require("scripts/globals/keyitems")
require("scripts/globals/utils")
require("scripts/globals/zone")

xi = xi or {}
xi.mission = xi.mission or {}

xi.mission.log_id =
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

xi.mission.area =
{
    [xi.mission.log_id.SANDORIA]    = 'sandoria',
    [xi.mission.log_id.BASTOK]      = 'bastok',
    [xi.mission.log_id.WINDURST]    = 'windurst',
    [xi.mission.log_id.ZILART]      = 'zilart',
    [xi.mission.log_id.TOAU]        = 'toau',
    [xi.mission.log_id.WOTG]        = 'wotg',
    [xi.mission.log_id.COP]         = 'cop',
    [xi.mission.log_id.ASSAULT]     = 'assault',
    [xi.mission.log_id.CAMPAIGN]    = 'campaign',
    [xi.mission.log_id.ACP]         = 'acp',
    [xi.mission.log_id.AMK]         = 'amk',
    [xi.mission.log_id.ASA]         = 'asa',
    [xi.mission.log_id.SOA]         = 'soa',
    [xi.mission.log_id.ROV]         = 'rov',
}

xi.mission.status =
{
    COP =
    {
        SANDORIA   = 0,
        WINDURST   = 1,
        LOUVERANCE = 2,
        TENZEN     = 3,
        ULMIA      = 4,
        PROMY      = 5,
        CID        = 6,
        RUBIOUS    = 7,
    },
}

xi.mission.id =
{
    -----------------------------------
    --  All Nations
    -----------------------------------
    ['nation'] =
    {
        RANK2       = 6,
        MAGICITE    = 13,
        ARCHLICH    = 14,
        SHADOW_LORD = 15,
        NONE        = 65535,
    },

    -----------------------------------
    --  San d'Oria - Interaction Framework (0)
    -----------------------------------
    [xi.mission.area[xi.mission.log_id.SANDORIA]] =
    {
        SMASH_THE_ORCISH_SCOUTS = 0,
        BAT_HUNT                = 1,
        SAVE_THE_CHILDREN       = 2,
        THE_RESCUE_DRILL        = 3,
        THE_DAVOI_REPORT        = 4,
        JOURNEY_ABROAD          = 5,
        JOURNEY_TO_BASTOK       = 6,
        JOURNEY_TO_WINDURST     = 7,
        JOURNEY_TO_BASTOK2      = 8,
        JOURNEY_TO_WINDURST2    = 9,
        INFILTRATE_DAVOI        = 10,
        THE_CRYSTAL_SPRING      = 11,
        APPOINTMENT_TO_JEUNO    = 12,
        MAGICITE                = 13,
        THE_RUINS_OF_FEI_YIN    = 14,
        THE_SHADOW_LORD         = 15,
        LEAUTES_LAST_WISHES     = 16,
        RANPERRES_FINAL_REST    = 17,
        PRESTIGE_OF_THE_PAPSQUE = 18,
        THE_SECRET_WEAPON       = 19,
        COMING_OF_AGE           = 20,
        LIGHTBRINGER            = 21,
        BREAKING_BARRIERS       = 22,
        THE_HEIR_TO_THE_LIGHT   = 23,
        NONE                    = 65535,
    },

    -----------------------------------
    --  Bastok - Interaction Framework (1)
    -----------------------------------
    [xi.mission.area[xi.mission.log_id.BASTOK]] =
    {
        THE_ZERUHN_REPORT         = 0,
        GEOLOGICAL_SURVEY         = 1,
        FETICHISM                 = 2,
        THE_CRYSTAL_LINE          = 3,
        WADING_BEASTS             = 4,
        THE_EMISSARY              = 5,
        THE_EMISSARY_SANDORIA     = 6,
        THE_EMISSARY_WINDURST     = 7,
        THE_EMISSARY_SANDORIA2    = 8,
        THE_EMISSARY_WINDURST2    = 9,
        THE_FOUR_MUSKETEERS       = 10,
        TO_THE_FORSAKEN_MINES     = 11,
        JEUNO                     = 12,
        MAGICITE                  = 13,
        DARKNESS_RISING           = 14,
        XARCABARD_LAND_OF_TRUTHS  = 15,
        RETURN_OF_THE_TALEKEEPER  = 16,
        THE_PIRATES_COVE          = 17,
        THE_FINAL_IMAGE           = 18,
        ON_MY_WAY                 = 19,
        THE_CHAINS_THAT_BIND_US   = 20,
        ENTER_THE_TALEKEEPER      = 21,
        THE_SALT_OF_THE_EARTH     = 22,
        WHERE_TWO_PATHS_CONVERGE  = 23,
        NONE                      = 65535,
    },

    -----------------------------------
    --  Windurst - Interaction Framework (2)
    -----------------------------------
    [xi.mission.area[xi.mission.log_id.WINDURST]] =
    {
        THE_HORUTOTO_RUINS_EXPERIMENT = 0,
        THE_HEART_OF_THE_MATTER       = 1,
        THE_PRICE_OF_PEACE            = 2,
        LOST_FOR_WORDS                = 3,
        A_TESTING_TIME                = 4,
        THE_THREE_KINGDOMS            = 5,
        THE_THREE_KINGDOMS_SANDORIA   = 6,
        THE_THREE_KINGDOMS_BASTOK     = 7,
        THE_THREE_KINGDOMS_SANDORIA2  = 8,
        THE_THREE_KINGDOMS_BASTOK2    = 9,
        TO_EACH_HIS_OWN_RIGHT         = 10,
        WRITTEN_IN_THE_STARS          = 11,
        A_NEW_JOURNEY                 = 12,
        MAGICITE                      = 13,
        THE_FINAL_SEAL                = 14,
        THE_SHADOW_AWAITS             = 15,
        FULL_MOON_FOUNTAIN            = 16,
        SAINTLY_INVITATION            = 17,
        THE_SIXTH_MINISTRY            = 18,
        AWAKENING_OF_THE_GODS         = 19,
        VAIN                          = 20,
        THE_JESTER_WHOD_BE_KING       = 21,
        DOLL_OF_THE_DEAD              = 22,
        MOON_READING                  = 23,
        NONE                          = 65535,
    },

    -----------------------------------
    --  Zilart Missions (3)
    -----------------------------------
    [xi.mission.area[xi.mission.log_id.ZILART]] =
    {
        THE_NEW_FRONTIER              = 0,  -- ±
        WELCOME_TNORG                 = 4,  -- ±
        KAZHAMS_CHIEFTAINESS          = 6,  -- ±
        THE_TEMPLE_OF_UGGALEPIH       = 8,  -- ±
        HEADSTONE_PILGRIMAGE          = 10, -- ±
        THROUGH_THE_QUICKSAND_CAVES   = 12, -- ±
        THE_CHAMBER_OF_ORACLES        = 14, -- ±
        RETURN_TO_DELKFUTTS_TOWER     = 16, -- ±
        ROMAEVE                       = 18, -- ±
        THE_TEMPLE_OF_DESOLATION      = 20, -- ±
        THE_HALL_OF_THE_GODS          = 22, -- ±
        THE_MITHRA_AND_THE_CRYSTAL    = 23, -- ±
        THE_GATE_OF_THE_GODS          = 24, -- ±
        ARK_ANGELS                    = 26, -- ±
        THE_SEALED_SHRINE             = 27, -- ±
        THE_CELESTIAL_NEXUS           = 28, -- ±
        AWAKENING                     = 30, -- ±
        THE_LAST_VERSE                = 31,
        NONE                          = 65535,
    },

    -----------------------------------
    --  Promathia Missions (6)
    -----------------------------------
    [xi.mission.area[xi.mission.log_id.COP]] =
    {
        ANCIENT_FLAMES_BECKON            = 101,  -- Category
        THE_RITES_OF_LIFE                = 110,  -- ±
        BELOW_THE_ARKS                   = 118,  -- ±
        THE_MOTHERCRYSTALS               = 128,  -- ±
        -- THE_ISLE_OF_FORGOTTEN_SAINTS  =     -- Category
        AN_INVITATION_WEST               = 138,  -- ±
        THE_LOST_CITY                    = 218, -- ±
        DISTANT_BELIEFS                  = 228, -- ±
        AN_ETERNAL_MELODY                = 238, -- ±
        ANCIENT_VOWS                     = 248, -- ±
        A_TRANSIENT_DREAM                = 257, -- Category
        THE_CALL_OF_THE_WYRMKING         = 258, -- ±
        A_VESSEL_WITHOUT_A_CAPTAIN       = 318, -- ±
        THE_ROAD_FORKS                   = 325, -- ±
        -- EMERALD_WATERS                =     -- Sub-category
        -- VICISSITUDES                  =     -- ±
        DESCENDANTS_OF_A_LINE_LOST       = 335, -- ±
        -- LOUVERANCE                    =     -- ±
        -- MEMORIES_OF_A_MAIDEN          =     -- Sub-category
        COMEDY_OF_ERRORS_ACT_I           = 341, -- ±
        -- COMEDY_OF_ERRORS_ACT_II       =     -- ±
        -- EXIT_STAGE_LEFT               =     -- ±
        TENDING_AGED_WOUNDS              = 350, -- ±
        DARKNESS_NAMED                   = 358, -- ±
        -- THE_CRADLES_OF_CHILDREN_LOST  =     -- Category
        SHELTERING_DOUBT                 = 368, -- ±
        THE_SAVAGE                       = 418, -- ±
        THE_SECRETS_OF_WORSHIP           = 428, -- ±
        SLANDEROUS_UTTERINGS             = 438, -- ±
        -- THE_RETURN_HOME               =     -- Category
        THE_ENDURING_TUMULT_OF_WAR       = 448, -- ±
        DESIRES_OF_EMPTINESS             = 518, -- ±
        THREE_PATHS                      = 530, -- ±
        -- PAST_SINS                     =     -- ±
        -- SOUTHERN_LEGEND               =     -- ±
        PARTNERS_WITHOUT_FAME            = 543, -- ±
        -- A_CENTURY_OF_HARDSHIP         =     -- ±
        -- DEPARTURES                    =     -- ±
        -- THE_PURSUIT_OF_PARADISE       =     -- ±
        SPIRAL                           = 552, -- ±
        -- BRANDED                       =     -- ±
        -- PRIDE_AND_HONOR               =     -- ±
        -- AND_THE_COMPASS_GUIDES        =     -- ±
        WHERE_MESSENGERS_GATHER          = 560, -- ±
        -- ENTANGLEMENT                  =     -- ±
        -- HEAD_WIND                     =     -- ±
        FLAMES_FOR_THE_DEAD              = 568, -- ±
        -- ECHOES_OF_TIME                =     -- ± --   -- Category
        FOR_WHOM_THE_VERSE_IS_SUNG       = 578, -- ±
        A_PLACE_TO_RETURN                = 618, -- ±
        MORE_QUESTIONS_THAN_ANSWERS      = 628, -- ±
        ONE_TO_BE_FEARED                 = 638, -- ±
        -- IN_THE_LIGHT_OF_THE_CRYSTAL   =     -- ± --   -- Category
        CHAINS_AND_BONDS                 = 648, -- ±
        FLAMES_IN_THE_DARKNESS           = 718, -- ±
        FIRE_IN_THE_EYES_OF_MEN          = 728, -- ±
        CALM_BEFORE_THE_STORM            = 738, -- ±
        THE_WARRIORS_PATH                = 748, -- ±
        EMPTINESS_BLEEDS                 = 758, -- ± ---- Category
        GARDEN_OF_ANTIQUITY              = 800, -- ±
        A_FATE_DECIDED                   = 818, -- ±
        WHEN_ANGELS_FALL                 = 828, -- ±
        DAWN                             = 840, -- ±
        THE_LAST_VERSE                   = 850,
    },

    -----------------------------------
    --  Aht Urhgan Missions (4)
    -----------------------------------
    [xi.mission.area[xi.mission.log_id.TOAU]] =
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
    [xi.mission.area[xi.mission.log_id.WOTG]] =
    {
        CAVERNOUS_MAWS             = 0,  -- ±
        BACK_TO_THE_BEGINNING      = 1,  -- ±
        CAIT_SITH                  = 2,  -- ±
        THE_QUEEN_OF_THE_DANCE     = 3,  -- ±
        WHILE_THE_CAT_IS_AWAY      = 4,  -- ±
        A_TIMESWEPT_BUTTERFLY      = 5,  -- ±
        PURPLE_THE_NEW_BLACK       = 6,  -- ±
        IN_THE_NAME_OF_THE_FATHER  = 7,  -- ±
        DANCERS_IN_DISTRESS        = 8,  -- ±
        DAUGHTER_OF_A_KNIGHT       = 9,  -- ±
        A_SPOONFUL_OF_SUGAR        = 10, -- ±
        AFFAIRS_OF_STATE           = 11, -- ±
        BORNE_BY_THE_WIND          = 12, -- ±
        A_NATION_ON_THE_BRINK      = 13, -- ±
        CROSSROADS_OF_TIME         = 14, -- ±
        SANDSWEPT_MEMORIES         = 15, -- ±
        NORTHLAND_EXPOSURE         = 16, -- ±
        TRAITOR_IN_THE_MIDST       = 17, -- ±
        BETRAYAL_AT_BEAUCEDINE     = 18, -- ±
        ON_THIN_ICE                = 19, -- ±
        PROOF_OF_VALOR             = 20, -- ±
        A_SANGUINARY_PRELUDE       = 21, -- ±
        DUNGEONS_AND_DANCERS       = 22, -- ±
        DISTORTER_OF_TIME          = 23, -- ±
        THE_WILL_OF_THE_WORLD      = 24, -- ±
        FATE_IN_HAZE               = 25, -- ±
        THE_SCENT_OF_BATTLE        = 26, -- ±
        ANOTHER_WORLD              = 27, -- ±
        A_HAWK_IN_REPOSE           = 28, -- ±
        THE_BATTLE_OF_XARCABARD    = 29, -- ±
        PRELUDE_TO_A_STORM         = 30, -- ±
        STORMS_CRESCENDO           = 31, -- ±
        INTO_THE_BEASTS_MAW        = 32, -- ±
        THE_HUNTER_ENSNARED        = 33, -- ±
        FLIGHT_OF_THE_LION         = 34, -- ±
        FALL_OF_THE_HAWK           = 35, -- ±
        DARKNESS_DESCENDS          = 36, -- ±
        ADIEU_LILISETTE            = 37, -- ±
        BY_THE_FADING_LIGHT        = 38, -- ±
        EDGE_OF_EXISTENCE          = 39, -- ±
        HER_MEMORIES               = 40, -- ±
        FORGET_ME_NOT              = 41, -- ±
        PILLAR_OF_HOPE             = 42, -- ±
        GLIMMER_OF_LIFE            = 43, -- ±
        TIME_SLIPS_AWAY            = 44, -- ±
        WHEN_WILLS_COLLIDE         = 45, -- ±
        WHISPERS_OF_DAWN           = 46, -- ±
        A_DREAMY_INTERLUDE         = 47, -- ±
        CAIT_IN_THE_WOODS          = 48, -- ±
        FORK_IN_THE_ROAD           = 49, -- ±
        MAIDEN_OF_THE_DUSK         = 50, -- ±
        WHERE_IT_ALL_BEGAN         = 51, -- ±
        A_TOKEN_OF_TROTH           = 52, -- ±
        LEST_WE_FORGET             = 53, -- ±
    },

    -----------------------------------
    --  A Crystalline Prophecy (9)
    -----------------------------------
    [xi.mission.area[xi.mission.log_id.ACP]] =
    {
        A_CRYSTALLINE_PROPHECY        = 0, -- ±
        THE_ECHO_AWAKENS              = 1, -- ±
        GATHERER_OF_LIGHT_I           = 2, -- ±
        GATHERER_OF_LIGHT_II          = 3,
        THOSE_WHO_LURK_IN_SHADOWS_I   = 4, -- ±
        THOSE_WHO_LURK_IN_SHADOWS_II  = 5, -- ±
        THOSE_WHO_LURK_IN_SHADOWS_III = 6, -- ±
        REMEMBER_ME_IN_YOUR_DREAMS    = 7, -- ±
        BORN_OF_HER_NIGHTMARES        = 8, -- ±
        BANISHING_THE_ECHO            = 9,
        ODE_OF_LIFE_BESTOWING         = 10,
        A_CRYSTALLINE_PROPHECY_FIN    = 11,
    },

    -----------------------------------
    --  A Moogle Kupo d'Etat (10)
    -----------------------------------
    [xi.mission.area[xi.mission.log_id.AMK]] =
    {
        A_MOOGLE_KUPO_DETAT                 = 0,  -- ±
        DRENCHED_IT_BEGAN_WITH_A_RAINDROP   = 1,  -- ±
        HASTEN_IN_A_JAM_IN_JEUNO            = 2,  -- ±
        WELCOME_TO_MY_DECREPIT_DOMICILE     = 3,  -- ±
        CURSES_A_HORRIFICALLY_HARROWING_HEX = 4,  -- ±
        AN_ERRAND_THE_PROFESSORS_PRICE      = 5,  -- ±
        SHOCK_ARRANT_ABUSE_OF_AUTHORITY     = 6,  -- ±
        LENDER_BEWARE_READ_THE_FINE_PRINT   = 7,  -- ±
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
    [xi.mission.area[xi.mission.log_id.ASA]] =
    {
        A_SHANTOTTO_ASCENSION       = 0, -- ±
        BURGEONING_DREAD            = 1, -- ±
        THAT_WHICH_CURDLES_BLOOD    = 2, -- ±
        SUGAR_COATED_DIRECTIVE      = 3, -- ±
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
    [xi.mission.area[xi.mission.log_id.SOA]] =
    {
        -- THE_SACRED_CITY_OF_ADOULIN   =  -- Category
        RUMORS_FROM_THE_WEST            = 0,   -- ±
        THE_GEOMAGNETRON                = 1,   -- ±
        ONWARD_TO_ADOULIN               = 3,   -- ±
        HEARTWINGS_AND_THE_KINDHEARTED  = 5,   -- ±
        PIONEER_REGISTRATION            = 6,   -- ±
        LIFE_ON_THE_FRONTIER            = 7,   -- ±
        MEETING_OF_THE_MINDS            = 8,   -- ±
        ARCIELA_APPEARS_AGAIN           = 9,   -- ±
        -- THE_ANCIENT_PACT             =  -- Category
        BUDDING_PROSPECTS               = 11,  -- ±
        THE_LIGHT_SHINING_IN_YOUR_EYES  = 12,  -- ±
        THE_HEIRLOOM                    = 13,  -- ±
        AN_AIMLESS_JOURNEY              = 14,  -- ±
        ORTHARSYNE                      = 15,  -- ±
        IN_THE_PRESENCE_OF_ROYALTY      = 16,  -- ±
        THE_TWIN_WORLD_TREES            = 17,  -- ±
        HONOR_AND_AUDACITY              = 18,  -- ±
        THE_WATERGARDEN_COLISEUM        = 19,  -- ±
        FRICTION_AND_FISSURES           = 20,  -- ±
        THE_CELENNIA_MEMORIAL_LIBRARY   = 21,  -- ±
        FOR_WHOM_DO_WE_TOIL             = 23,  -- ±
        AIMING_FOR_YGNAS                = 26,  -- ±
        CALAMITY_IN_THE_KITCHEN         = 27,  -- ±
        ARCIELAS_PROMISE                = 29,  -- ±
        PREDATOR_AND_PREY               = 30,  -- ±
        BEHIND_THE_SLUICES              = 31,  -- ±
        THE_LEAFKIN_MONARCH             = 34,  -- ±
        YGGDRASIL                       = 35,  -- ±
        -- SHADOWS_UPON_ADOULIN         =  -- Category
        RETURN_OF_THE_EXORCIST          = 37,  -- ±
        THE_MERCILESS_ONE               = 38,  -- ±
        A_CURSE_FROM_THE_PAST           = 39,  -- ±
        THE_PURGATION                   = 40,  -- ±
        THE_KEY                         = 41,  -- ±
        THE_PRINCESSS_DILEMMA           = 42,  -- ±
        DARK_CLOUDS_AHEAD               = 43,  -- ±
        THE_SMALLEST_OF_FAVORS          = 44,  -- ±
        SUMMONED_BY_SPIRITS             = 45,  -- ±
        EVIL_ENTITIES                   = 46,  -- ±
        ADOULIN_CALLING                 = 47,  -- ±
        THE_DISAPPEARANCE_OF_NYLINE     = 48,  -- ±
        SHARED_CONSCIOUSNESS            = 49,  -- ±
        CLEAR_SKIES                     = 50,  -- ±
        THE_MAN_IN_BLACK                = 51,  -- ±
        TO_THE_VICTOR                   = 52,  -- ±
        AN_EXTRAORDINARY_GENTLEMAN      = 53,  -- ±
        THE_ORDERS_TREASURES            = 55,  -- ±
        AUGUSTS_HEIRLOOM                = 56,  -- ±
        BEAUTY_AND_THE_BEAST            = 57,  -- ±
        WILDCAT_WITH_A_GOLD_PELT        = 58,  -- ±
        IN_SEARCH_OF_ARCIELA            = 59,  -- ±
        LOOKING_FOR_LEADS               = 61,  -- ±
        DRIFTING_NORTHWEST              = 62,  -- ±
        KUMHAU_THE_FLASHFROST_NAAKUAL   = 63,  -- ±
        SOUL_SIPHON                     = 66,  -- ±
        STONEWALLED                     = 67,  -- ±
        SALVATION                       = 69,  -- ±
        GLIMMER_OF_PORTENT              = 70,  -- ±
        -- THE_SERPENTINE_LABYRINTH     =  -- Category
        INTO_THE_FIRE                   = 71,  -- ±
        MELVIEN_DE_MALECROIX            = 72,  -- ±
        COURIER_CATASTROPHE             = 73,  -- ±
        DONE_AND_DELIVERED              = 74,  -- ±
        MINISTERIAL_WHISPERS            = 75,  -- ±
        A_DAY_IN_THE_LIFE_OF_A_PIONEER  = 76,  -- ±
        LIGHTING_THE_WAY                = 77,  -- ±
        SAJJAKA                         = 78,  -- ±
        STUDYING_UP                     = 79,  -- ±
        A_VOW_OF_TRUTH                  = 80,  -- ±
        DARRCUILN                       = 81,  -- ±
        THE_GATES                       = 82,  -- ±
        MORIMAR                         = 84,  -- ±
        A_NEW_FORCE_ARISES              = 85,  -- ±
        THE_SACRED_SAPLING              = 86,  -- ±
        TREE_GRAFTING                   = 87,  -- ±
        A_SHROUDED_CANOPY               = 88,  -- ±
        LEAFALLIA                       = 89,  -- ±
        ROSULATIAS_PROMISE              = 90,  -- ±
        THE_LIGHTSLAND                  = 91,  -- ±
        THE_LIGHT_OF_DAWN_COMES         = 92,  -- ±
        CRIES_FROM_THE_DEEP             = 93,  -- ±
        SEEDS_OF_DOUBT                  = 94,  -- ±
        THE_TOMATOES_OF_WRATH           = 95,  -- ±
        A_GRAVE_MISTAKE                 = 96,  -- ±
        AN_EMERGENCY_CONVOCATION        = 98,  -- ±
        BALAMOR_THE_DEATHBORNE_XOL      = 99,  -- ±
        ANAGNORISIS                     = 100, -- ±
        JUST_THE_THING                  = 101, -- ±
        SUGARCOATED_SALVATION           = 102, -- ±
        ARCIELAS_RESOLVE                = 103, -- ±
        BALAMORS_RUSE                   = 104, -- ±
        THE_CHARLATAN                   = 105, -- ±
        ROYAL_BLESSINGS                 = 107, -- ±
        -- HADES                        =  -- Category
        ARBOREAL_RUMORS                 = 108, -- ±
        ARCIELAS_MISSIVE                = 109, -- ±
        HEROES_UNITE                    = 110, -- ±
        A_PORTENT_MOST_OMINOUS          = 111, -- ±
        YGGDRASIL_BECKONS               = 112, -- ±
        RETURNING_TO_THE_TREES          = 113, -- ±
        THE_KEY_TO_THE_TURRIS           = 114, -- ±
        TEODORS_SUMMONS                 = 116, -- ±
        THE_SEVENTH_GUARDIAN            = 117, -- ±
        WATERY_GRAVE                    = 118, -- ±
        BLOOD_FOR_BLOOD                 = 120, -- ±
        RECKONING                       = 121, -- ±
        ABOMINATION                     = 123, -- ±
        UNDYING_LIGHT                   = 125, -- ±
        THE_LIGHT_WITHIN                = 129, -- ±
        -- FIN                          = 130,
    },

    -----------------------------------
    --  Rhapsodies of Vana Diel (13)
    -----------------------------------
    [xi.mission.area[xi.mission.log_id.ROV]] =
    {
        RHAPSODIES_OF_VANADIEL          = 0,   -- ±
        -- CREATION_AND_REBIRTH         =  -- Category
        RESONACE                        = 2,   -- ±
        EMISSARY_FROM_THE_SEAS          = 3,   -- ±
        SET_FREE                        = 4,   -- ±
        THE_BEGINNING                   = 6,   -- ±
        FLAMES_OF_PRAYER                = 10,  -- ±
        THE_PATH_UNTRAVELED             = 12,  -- ±
        AT_THE_HEAVENS_DOOR             = 18,  -- ±
        THE_LIONS_ROAR                  = 20,  -- ±
        EDDIES_OF_DESPAIR_I             = 22,  -- ±
        A_LAND_AFTER_TIME               = 26,  -- ±
        FATES_CALL                      = 28,  -- ±
        WHAT_LIES_BEYOND                = 30,  -- ±
        THE_TIES_THAT_BIND              = 32,  -- ±
        IMPURITY                        = 34,  -- ±
        THE_LOST_AVATAR                 = 36,  -- ±
        VOLTO_OSCURO                    = 40,  -- ±
        RING_MY_BELL                    = 42,  -- ±
        -- REVITALIZATION               =  -- Category
        SPIRITS_AWOKEN                  = 44,  -- ±
        CRASHING_WAVES                  = 46,  -- ±
        CALL_TO_SERVE                   = 48,  -- ±
        NUMBERING_DAYS                  = 50,  -- ±
        INESCAPABLE_BINDS               = 52,  -- ±
        DESERT_WINDS                    = 54,  -- ±
        EVER_FORWARD                    = 56,  -- ±
        THE_ENDLESS_SKY                 = 60,  -- ±
        APHMAUS_LIGHT                   = 62,  -- ±
        REUNITED                        = 64,  -- ±
        TAKE_WING                       = 66,  -- ±
        PRIME_NUMBER                    = 68,  -- ±
        FROM_THE_RUINS                  = 70,  -- ±
        CAUTERIZE                       = 72,  -- ±
        UNCERTAIN_DESTINATIONS          = 78,  -- ±
        GANGED_UP_ON                    = 80,  -- ±
        SACRIFICE                       = 83,  -- ±
        SOMBER_DREAMS                   = 86,  -- ±
        OF_LIGHT_AND_DARKNESS           = 92,  -- ±
        TEMPORARY_FAREWELLS             = 94,  -- ±
        BRUSHING_UP                     = 96,  -- ±
        KEEP_ON_GIVING                  = 98,  -- ±
        PAST_IMPERFECT                  = 100, -- ±
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
    [xi.mission.area[xi.mission.log_id.CAMPAIGN]] = {},
}

-- Campaign IDs deliberately left out of mission table
-- due to their nature not being the same as other missions,
-- and to allow the content the freedom to develop systems
-- that are more specifically catered to it.

-----------------------------------
--  Campaign (8)
-----------------------------------
-- None yet!

local function rankPointMath(rank)
    return 0.372 * rank^2 - 1.62 * rank + 6.2
end

xi.mission.getMissionRankPoints = function(player, missionID)
    local crystals = 0

    if     missionID ==  3 then crystals = 9
    elseif missionID ==  4 then crystals = 17
    elseif missionID ==  5 then crystals = 42
    elseif missionID == 10 then crystals = 12                    -- 1 stack needed to unlock
    elseif missionID == 11 then crystals = 30                    -- 2.5 stacks needed to unlock (2 stacks of crystals + 3.1 rank points corresponding to half a stack)
    elseif missionID == 12 then crystals = 48                    -- 4 stacks to unlock (3.5 stacks + 3.1 rank points corresponding to half a stack)
    elseif missionID == 13 then crystals = 36                    -- 3 stacks to unlock
    -- 5.1 starts directly after Magicite, no crystals needed
    elseif missionID == 15 then crystals = 44                    -- Mission unlocks at 50% rank bar ~= 44 crystals using the present formula.
    elseif missionID == 16 then crystals = 36                    -- 3 stacks to unlock
    elseif missionID == 17 then crystals = 93                    -- 3 additional stacks to unlock + 3 original stacks + 21 from mission 6.1
    elseif missionID == 18 then crystals = 45                    -- 45 needed, from http://wiki.ffxiclopedia.org/wiki/The_Final_Image
    elseif missionID == 19 then crystals = 119                    -- 4 additional stacks needed, plus mission reward of 26
    elseif missionID == 20 then crystals = 57                    -- 4 3/4 stacks needed
    elseif missionID == 21 then crystals = 148                    -- 5 additional stacks needed, plus mission reward of 31,
    elseif missionID == 22 then crystals = 96                    -- 8 stacks needed (higher value chosen so final rank bar requirement is closer to 90%)
    elseif missionID == 23 then crystals = 228                    -- Additional 8 stacks needed, plus mission reward of 36 (87% rank bar)
    else
        crystals = 0
    end

    local pointsNeeded = 1024 * (crystals - 0.25) / (3 * rankPointMath(player:getRank(player:getNation())))

    if player:getRankPoints() >= pointsNeeded then
        return true
    end

    return false
end

-- Tables identifying the nature of a mission by nation (0 = Not Repeatable, 1 = Repeatable, 2 = Do Not Add)
-- Certain missions do not apply to the gate guard, such as Rank 4; Do Not Add is used for this.
-- For 3 Nations missions (ID#5) sub-missions are not included in this mask.
local missionType =
{
    -- Required Rank             :   1  1  1  2  2  2  2  2  2  2  3  3  3  4  5  5  6  6  7  7  8  8  9  9
    [xi.mission.log_id.SANDORIA] = { 1, 1, 1, 0, 1, 0, 2, 2, 2, 2, 1, 1, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
    [xi.mission.log_id.BASTOK]   = { 2, 0, 1, 0, 1, 0, 2, 2, 2, 2, 0, 1, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
    [xi.mission.log_id.WINDURST] = { 2, 0, 0, 0, 1, 0, 2, 2, 2, 2, 0, 1, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
}

local function getRequiredRank(missionId)
    local requiredRank = 0

    if
        missionId <= 2
    then
        requiredRank = math.floor(missionId / 3) + 1
    elseif missionId >= 10 and missionId <= 12 then
        requiredRank = 3
    elseif missionId == 13 then
        requiredRank = 4
    elseif missionId >= 14 then
        requiredRank = math.floor((missionId - 14) / 2) + 5
    else
        requiredRank = 2
    end

    return requiredRank
end

xi.mission.getMissionMask = function(player)
    local nation = player:getNation()
    local rank = player:getRank(nation)

    local lastRequiredMission = -1
    local firstMission = 0
    local repeatMission = 0

    for k, v in pairs(missionType[nation]) do
        local missionId = k - 1

        -- All repeatable missions are skippable as well, so track the required
        -- missions, and only add to mask if rank and required are met
        if
            missionId >= lastRequiredMission and
            (
                rank > getRequiredRank(missionId) or
                (
                    rank == getRequiredRank(missionId) and
                    xi.mission.getMissionRankPoints(player, missionId)
                )
            )
            and
            (
                lastRequiredMission < 0 or
                player:hasCompletedMission(nation, lastRequiredMission)
            )
        then
            if v == 0 then
                if
                    not player:hasCompletedMission(nation, missionId)
                then
                    firstMission = utils.mask.setBit(firstMission, missionId, true)
                    lastRequiredMission = missionId
                end
            elseif v == 1 then
                repeatMission = utils.mask.setBit(repeatMission, missionId, true)
            end
        else
            break
        end
    end

    local missionMask = 0
    if
        player:getCurrentMission(nation) == xi.mission.id.nation.NONE and
        rank == 5 and
        not player:hasCompletedMission(nation, xi.mission.id.nation.ARCHLICH) and
        player:getMissionStatus(nation) == 8
    then
        -- Only one option is available when selecting M5-1 as required from a gate guard.  Since the mission isn't set,
        -- Use previous logic to require missionStatus of 8, but no mission set (instead of ARCHLICH)
        -- NOTE: For some reason, previous implementation starts with status this high.  This should change in the future.
        missionMask = utils.MAX_INT32 - 16384
    else
        missionMask = utils.MAX_INT32 - repeatMission - firstMission
    end

    return missionMask, repeatMission
end

-- Interaction Framework Helper Functions
local function getVarPrefix(areaId, questId)
    return string.format("Mission[%d][%d]", areaId, questId)
end

xi.mission.incrementVar = function(player, areaId, questId, name, value)
    return player:incrementCharVar(getVarPrefix(areaId, questId) .. name, value)
end

xi.mission.getVar = function(player, areaId, questId, name)
    return player:getVar(getVarPrefix(areaId, questId) .. name)
end

xi.mission.setVar = function(player, areaId, questId, name, value)
    return player:setVar(getVarPrefix(areaId, questId) .. name, value)
end

xi.mission.getLocalVar = function(player, areaId, questId, name)
    return player:getLocalVar(getVarPrefix(areaId, questId) .. name)
end

xi.mission.setLocalVar = function(player, areaId, questId, name, value)
    return player:setLocalVar(getVarPrefix(areaId, questId) .. name, value)
end

xi.mission.getMustZone = function(player, areaId, questId)
    return player:getLocalVar(getVarPrefix(areaId, questId) .. "mustZone") == 1 and true or false
end

xi.mission.setMustZone = function(player, areaId, questId)
    player:setLocalVar(getVarPrefix(areaId, questId) .. "mustZone", 1)
end
