-----------------------------------
-- Chocobo Raising - Constants & Lookups
-----------------------------------
require('scripts/globals/hobbies/chocobo_raising/settings')
-----------------------------------
xi = xi or {}
xi.chocoboRaising = xi.chocoboRaising or {}

-----------------------------------
-- Constants
-----------------------------------
-- Held conditions sit in bits 0-13.
xi.chocoboRaising.conditionMask = 0x3FFF

-- Cures fed today sit in bits 16 up until the next rollover; bit 15 marks one as pending.
xi.chocoboRaising.pendingCureShift = 16
xi.chocoboRaising.pendingCureFlag  = 15

-- Set by a forced feed; the next rollover reads and clears it.
xi.chocoboRaising.forcedFeedFlag = 30

-- Guess: affection points per care plan arrow.
xi.chocoboRaising.affectionPerPlanArrow = 2

-- Finish option of "Request documentation" that asks for a chococard.
xi.chocoboRaising.documentChococard = 239

xi.chocoboRaising.maxHunger        = 255
xi.chocoboRaising.statPerFoodArrow = 2

-- Lethe Consomme and Potage can take several feedings to make a chocobo forget.
xi.chocoboRaising.forgetChance = 25

-----------------------------------
-- Tables
-----------------------------------
-- What the pure model asks applyEffects to do to the player; each effect is { kind, value, value }.
---@enum xi.chocoboRaising.effect
xi.chocoboRaising.effect =
{
    ADD_KEY_ITEM         = 'addKeyItem',
    DEL_KEY_ITEM         = 'delKeyItem',
    SET_CHAR_VAR         = 'setCharVar',
    SET_LOCAL_VAR        = 'setLocalVar',
    ADD_GIL              = 'addGil',
    SET_HANDKERCHIEF     = 'setHandkerchief',
    SET_WHISTLE_PROGRESS = 'setWhistleProgress',
    SET_USER_FLAG        = 'setUserFlag',
}

-- TODO: Remove the duplication for walk CSs
xi.chocoboRaising.csidTable =
{
    -- { intro csid, main csid, trading csid, rejection csid, chicks owner csid, short walk csid, medium walk csid, long walk csid, watch csid, debug }
    [xi.zone.SOUTHERN_SAN_DORIA] = { 817, 823, 826, 831, 852, 298, 299, 300, 304, 862 }, -- Hantileon
    [xi.zone.BASTOK_MINES      ] = { 508, 509, 512, 515, 542, 554, 555, 556, 560, 551 }, -- Zopago
    [xi.zone.WINDURST_WOODS    ] = { 741, 742, 745, 748, 766, 810, 811, 812, 816, 773 }, -- Pulonono
}

xi.chocoboRaising.raisingLocation =
{
    [xi.zone.SOUTHERN_SAN_DORIA] = 1,
    [xi.zone.BASTOK_MINES      ] = 2,
    [xi.zone.WINDURST_WOODS    ] = 3,
}

xi.chocoboRaising.shortWalkLocation =
{
    [1] = xi.zone.WEST_RONFAURE,
    [2] = xi.zone.NORTH_GUSTABERG,
    [3] = xi.zone.EAST_SARUTABARUTA,
}

xi.chocoboRaising.mediumWalkLocation =
{
    [1] = xi.zone.LA_THEINE_PLATEAU,
    [2] = xi.zone.KONSCHTAT_HIGHLANDS,
    [3] = xi.zone.TAHRONGI_CANYON,
}

xi.chocoboRaising.longWalkLocation =
{
    [1] = xi.zone.JUGNER_FOREST,
    [2] = xi.zone.PASHHOW_MARSHLANDS,
    [3] = xi.zone.MERIPHATAUD_MOUNTAINS,
}

---@enum xi.chocoboRaising.stage
xi.chocoboRaising.stage =
{
    EGG        = 1,
    CHICK      = 2,
    ADOLESCENT = 3,
    ADULT_1    = 4,
    ADULT_2    = 5,
    ADULT_3    = 6,
    ADULT_4    = 7, -- Triggers immediate retirement
}

-- TODO: Merge carePlanData into this table so each cutscene carries its stat changes.
---@enum xi.chocoboRaising.cutscenes
xi.chocoboRaising.cutscenes =
{
    -- EGG ONWARDS:
    REPORT_BASIC_CARE = 0,

    -- CHICK ONWARDS:
    REPORT_REST            = 1,
    REPORT_TAKE_A_WALK     = 2,
    REPORT_LISTEN_TO_MUSIC = 3,

    -- ADOLESCENT ONWARDS:
    REPORT_EXERCISE_ALONE         = 4,
    REPORT_EXERCISE_IN_A_GROUP    = 5,
    REPORT_INTERACT_WITH_CHILDREN = 6,
    REPORT_INTERACT_WITH_CHOCOBOS = 7,
    REPORT_CARRY_PACKAGES         = 8,
    REPORT_EXHIBIT_TO_THE_PUBLIC  = 9,

    -- ADULT ONWARDS:
    REPORT_DELIVER_MESSAGES = 10,
    REPORT_DIG_FOR_TREASURE = 11,
    REPORT_ACT_IN_A_PLAY    = 12,

    -- CARE ACTIONS:
    GO_ON_A_WALK_SHORT   = 42,
    GO_ON_A_WALK_REGULAR = 43,
    GO_ON_A_WALK_LONG    = 44,

    -- AGEING:
    EGG_HATCHING          = 33,
    CHICK_TO_ADOLESCENT   = 34,
    ADOLESCENT_TO_ADULT_1 = 35,
    ADULT_1_TO_ADULT_2    = 36,
    ADULT_2_TO_ADULT_3    = 37,
    ADULT_3_TO_ADULT_4    = 38,

    -- OTHER:
    RAN_AWAY_1               = 39,
    BLANK_1                  = 40, -- TODO: Confirm this returns to the menu
    GIVES_ITEM               = 41,
    HAPPY_TO_SEE_YOU         = 48,
    BLANK_2                  = 49, -- TODO: Confirm this returns to the menu
    INTERESTED_IN_YOUR_STORY = 50, -- Story menu
    HANGS_HEAD_IN_SHAME      = 51,
    COMPETE_WITH_OTHERS      = 52, -- Local chocobo race
    HAVENT_SEEN_YOU          = 53, -- White handkerchief cancel
    THAT_SHOULD_BE_ENOUGH    = 54, -- Asks for the white handkerchief back
    CHOCOBO_WHISTLE_START    = 55, -- TODO: Confirm whether this starts the whistle quest or reminds
    WHISTLE_REWARD           = 56,
    BLANK_4                  = 57, -- TODO: Confirm this returns to the menu
    IS_INJURED               = 58,
    UNDER_THE_WEATHER        = 59,
    HAS_STOMACHACHE          = 60,
    SEEMS_LONELY             = 61,
    PRETTY_PERKY             = 62,
    SLEEPING_SOUNDLY         = 63,
    IS_VERY_ILL              = 64,
    REALLY_BORED             = 65,
    BEHAVING_SPOILED         = 66,
    RUN_AWAY_2               = 67,
    IN_LOVE                  = 68,
    CRYING_AT_NIGHT          = 69, -- White handkerchief start
    FULL_OF_ENERGY           = 70,
    BRIGHT_AND_FOCUSED       = 71,
    INJURY_HAS_HEALED_TRADE  = 72, -- TODO: Confirm this plays only through trades, not the Scold menu
    INJURY_HAS_HEALED        = 73,
    ILLNESS_HAS_HEALED       = 74,
    STRONGER_STOMACH         = 75,
    NO_LONGER_LONERY         = 76,
    CALMED_DOWN              = 77,
    WAKING_UP_EVERY_MORNING  = 78,
    FEVER_GONE_DOWN          = 79,
    SEEMS_HAPPIER            = 80,
    MORE_RESPONSIVE          = 81,
    CHOCOBO_IS_BACK          = 82,
    WAS_IN_LOVE              = 83,
    WHITE_HANDKERCHIEF_END   = 84,
    BURNED_PHYSICAL_ENERGY   = 85,
    BURNED_MENTAL_ENERGY     = 86,
}

---@enum xi.chocoboRaising.affectionRank
xi.chocoboRaising.affectionRank =
{
    DOESNT_CARE       = 0,
    CAN_ENDURE        = 1,
    SLIGHTLY_ENJOY    = 2,
    LIKES             = 3,
    LIKES_PRETTY_WELL = 4,
    LIKES_A_LOT       = 5,
    ALL_THE_TIME      = 6,
    PARENT            = 7,
}

---@enum xi.chocoboRaising.hunger
xi.chocoboRaising.hunger =
{
    STARVING        = 0,
    QUITE_HUNGRY    = 1,
    A_LITTLE_HUNGRY = 2,
    AVERAGE_1       = 3,
    AVERAGE_2       = 4,
    ALMOST_FULL     = 5,
    QUITE_FULL      = 6,
    COMPLETELY_FULL = 7,
}
utils.unused(xi.chocoboRaising.hunger)

-- Multipliers for per-rank bonuses: F adds none, SS adds seven.
---@enum xi.chocoboRaising.skillRanks
xi.chocoboRaising.skillRanks =
{
    F_POOR                = 0,
    E_SUBSTANDARD         = 1,
    D_A_BIT_DEFICIENT     = 2,
    C_AVERAGE             = 3,
    B_BETTER_THAN_AVERAGE = 4,
    A_IMPRESSIVE          = 5,
    S_OUTSTANDING         = 6,
    SS_FIRST_CLASS        = 7,
}

-- Bit positions in the condition mask.
---@enum xi.chocoboRaising.conditions
xi.chocoboRaising.conditions =
{
    INJURED            = 0,
    SICK               = 1, -- Minor illness
    STOMACHACHE        = 2,
    LONELY             = 3,
    HIGH_SPIRITS       = 4, -- Happiness
    SLEEPING           = 5, -- Laziness
    VERY_ILL           = 6, -- Serious illness
    BORED              = 7, -- Confusion
    SPOILED            = 8,
    RUN_AWAY           = 9,
    LOVESICK           = 10,
    CRYING_AT_NIGHT    = 11,
    FULL_OF_ENERGY     = 12, -- Vitality
    BRIGHT_AND_FOCUSED = 13, -- Intelligence
}

---@enum xi.chocoboRaising.carePlans
xi.chocoboRaising.carePlans =
{
    BASIC_CARE               = 0,
    RESTING                  = 1,
    TAKING_A_WALK            = 2,
    LISTENING_TO_MUSIC       = 3,
    EXERCISING_ALONE         = 4,
    EXCERCISING_IN_A_GROUP   = 5,
    PLAYING_WITH_CHILDREN    = 6,
    PLAYING_WITH_CHOCOBOS    = 7,
    CARRYING_PACKAGES        = 8,
    EXHIBITING_TO_THE_PUBLIC = 9,
    DELIVERING_MESSAGES      = 10,
    DIGGING_FOR_TREASURE     = 11,
    ACTING_IN_A_PLAY         = 12,
}

---@enum xi.chocoboRaising.carePlanStats
xi.chocoboRaising.carePlanStats =
{
    STRENGTH    = 1,
    ENDURANCE   = 2,
    DISCERNMENT = 3,
    RECEPTIVITY = 4,
    AFFECTION   = 5,
    ENERGY      = 6,
}

xi.chocoboRaising.carePlanStatNames =
{
    [xi.chocoboRaising.carePlanStats.STRENGTH   ] = 'Strength',
    [xi.chocoboRaising.carePlanStats.ENDURANCE  ] = 'Endurance',
    [xi.chocoboRaising.carePlanStats.DISCERNMENT] = 'Discernment',
    [xi.chocoboRaising.carePlanStats.RECEPTIVITY] = 'Receptivity',
    [xi.chocoboRaising.carePlanStats.AFFECTION  ] = 'Affection',
    [xi.chocoboRaising.carePlanStats.ENERGY     ] = 'Energy',
}

-- stats and affection are in arrows. pay is gil for a good day, then a poor day.
-- energy is the next-day cost; poorEnergy is the extra cost of a poor day.
---@type table<xi.chocoboRaising.carePlans, ChocoboCarePlanData>
xi.chocoboRaising.carePlanData =
{
    [xi.chocoboRaising.carePlans.BASIC_CARE              ] = { stats = {  1,  1,  1,  1 }, affection = -1, energy =  2, poorEnergy = 0, difficulty = 1, successStats = { 'affection' } },
    [xi.chocoboRaising.carePlans.RESTING                 ] = { stats = {  0,  0,  0,  0 }, affection =  1, energy =  0, poorEnergy = 0, difficulty = 1, successStats = { 'endurance' } },
    [xi.chocoboRaising.carePlans.TAKING_A_WALK           ] = { stats = {  2,  2, -1, -1 }, affection = -2, energy =  3, poorEnergy = 0, difficulty = 2, successStats = { 'strength', 'endurance' } },
    [xi.chocoboRaising.carePlans.LISTENING_TO_MUSIC      ] = { stats = { -1, -1,  2,  2 }, affection = -2, energy =  3, poorEnergy = 0, difficulty = 2, successStats = { 'discernment', 'receptivity' } },
    [xi.chocoboRaising.carePlans.EXERCISING_ALONE        ] = { stats = {  2,  0, -2, -1 }, affection = -3, energy =  4, poorEnergy = 0, difficulty = 2, successStats = { 'strength' } },
    [xi.chocoboRaising.carePlans.EXCERCISING_IN_A_GROUP  ] = { stats = {  0,  2, -1, -2 }, affection = -3, energy =  4, poorEnergy = 0, difficulty = 3, successStats = { 'endurance' } },
    [xi.chocoboRaising.carePlans.PLAYING_WITH_CHILDREN   ] = { stats = { -2, -1,  2,  0 }, affection = -3, energy =  4, poorEnergy = 0, difficulty = 2, successStats = { 'discernment' } },
    [xi.chocoboRaising.carePlans.PLAYING_WITH_CHOCOBOS   ] = { stats = { -1, -2,  0,  2 }, affection = -3, energy =  4, poorEnergy = 0, difficulty = 3, successStats = { 'receptivity' } },
    [xi.chocoboRaising.carePlans.CARRYING_PACKAGES       ] = { stats = {  3,  3, -3, -3 }, affection = -3, energy = 13, poorEnergy = 3, difficulty = 4, successStats = { 'endurance', 'strength' },       pay = { 200, 100 } },
    [xi.chocoboRaising.carePlans.EXHIBITING_TO_THE_PUBLIC] = { stats = { -3, -3,  3,  3 }, affection = -4, energy = 13, poorEnergy = 3, difficulty = 4, successStats = { 'discernment', 'receptivity' }, pay = { 200, 100 } },
    [xi.chocoboRaising.carePlans.DELIVERING_MESSAGES     ] = { stats = {  4,  0,  0, -3 }, affection = -5, energy = 26, poorEnergy = 6, difficulty = 5, successStats = { 'strength', 'discernment' },    pay = { 400, 200 } },
    [xi.chocoboRaising.carePlans.DIGGING_FOR_TREASURE    ] = { stats = {  0, -3,  4,  0 }, affection = -5, energy = 26, poorEnergy = 6, difficulty = 5, successStats = { 'discernment', 'strength' },    pay = { 400, 200 } },
    [xi.chocoboRaising.carePlans.ACTING_IN_A_PLAY        ] = { stats = { -3,  0,  0,  4 }, affection = -5, energy = 26, poorEnergy = 6, difficulty = 5, successStats = { 'receptivity', 'discernment' }, pay = { 400, 200 } },
}

-- Guess: minimum and maximum raw stat points, rolled per arrow.
xi.chocoboRaising.statPerPlanArrow = { 2, 3 }

-- Cost in clear weather (none or sunshine), then in other weather. The action needs the second
-- amount even when the sky is clear.
xi.chocoboRaising.careActionEnergy =
{
    [xi.chocoboRaising.cutscenes.GO_ON_A_WALK_SHORT      ] = { 24, 30 },
    [xi.chocoboRaising.cutscenes.GO_ON_A_WALK_REGULAR    ] = { 32, 40 },
    [xi.chocoboRaising.cutscenes.GO_ON_A_WALK_LONG       ] = { 38, 48 },
    [xi.chocoboRaising.cutscenes.HAPPY_TO_SEE_YOU        ] = {  3,  4 },
    [xi.chocoboRaising.cutscenes.INTERESTED_IN_YOUR_STORY] = { 11, 14 },
    [xi.chocoboRaising.cutscenes.HANGS_HEAD_IN_SHAME     ] = { 16, 20 },
    [xi.chocoboRaising.cutscenes.COMPETE_WITH_OTHERS     ] = { 27, 34 },
}

-- The plaque a retired chocobo leaves, by colour.
xi.chocoboRaising.plaques =
{
    [xi.chocoboRaising.color.YELLOW] = xi.item.YELLOW_VCS_PLAQUE,
    [xi.chocoboRaising.color.BLACK ] = xi.item.BLACK_VCS_PLAQUE,
    [xi.chocoboRaising.color.BLUE  ] = xi.item.BLUE_VCS_PLAQUE,
    [xi.chocoboRaising.color.RED   ] = xi.item.RED_VCS_PLAQUE,
    [xi.chocoboRaising.color.GREEN ] = xi.item.GREEN_VCS_PLAQUE,
}

-- Eating order when several items are traded.
---@enum xi.chocoboRaising.foodCategory
xi.chocoboRaising.foodCategory =
{
    CURE   = 1,
    ELIXIR = 2,
    STAT   = 3,
    FOOD   = 4,
}

-- Animation ids, so any animation such as WARP works.
---@enum xi.chocoboRaising.glow
xi.chocoboRaising.glow =
{
    NONE       = 0,
    WARP       = 80,
    RED        = 96,
    BLUE       = 97,
    YELLOW     = 98,
    GREEN      = 99,
    LIGHT_BLUE = 100,
}

local food    = xi.chocoboRaising.foodCategory
local glow    = xi.chocoboRaising.glow
local cond    = xi.chocoboRaising.conditions
local illness = { cond.SICK, cond.VERY_ILL }
local allBad  = { cond.INJURED, cond.SICK, cond.STOMACHACHE, cond.LONELY, cond.VERY_ILL, cond.BORED, cond.SPOILED, cond.LOVESICK }

-- Guessed or fitted chances, in percent per rollover unless noted.
xi.chocoboRaising.odds =
{
    happyHatch        = 90, -- Chick days 5 and 6
    happyChick        = 20,
    happyAdolescent   = 10,
    crying            = 15, -- Days 8 to 14 while the handkerchief is out
    sickChick         = 5,
    sick              = 10,
    sickWorsens       = 21, -- About 40% of illnesses turn serious
    injuredPaidPlan   = 6,
    stomachacheForced = 10,
    lonely            = 25, -- Adults at affection rank 0
    runAway           = 4,  -- Affection rank 0
    boredAdolescent   = 10,
    boredAdult        = 21,
    lovesick          = 8,  -- From day 43
    spoiled           = 1,
    afterHappy        = 3,  -- Each of vitality and intelligence, the day after happiness
    foodStat          = 15, -- Per item eaten
}

local odds = xi.chocoboRaising.odds

-- Guessed chance each rollover that a held condition ends.
xi.chocoboRaising.conditionEndOdds =
{
    [cond.INJURED           ] = 33,
    [cond.SICK              ] = 40,
    [cond.STOMACHACHE       ] = 65,
    [cond.LONELY            ] = 33,
    [cond.HIGH_SPIRITS      ] = 50,
    [cond.SLEEPING          ] = 100,
    [cond.VERY_ILL          ] = 33,
    [cond.BORED             ] = 25,
    [cond.SPOILED           ] = 100,
    [cond.RUN_AWAY          ] = 100,
    [cond.LOVESICK          ] = 50,
    [cond.CRYING_AT_NIGHT   ] = 100,
    [cond.FULL_OF_ENERGY    ] = 50,
    [cond.BRIGHT_AND_FOCUSED] = 50,
}

-- Hunger and affection are raw points, 32 to a rank. Stats are arrows of STR, END, DSC and RCP.
---@type table<xi.item, ChocoboFood>
xi.chocoboRaising.validFoods =
{
    [xi.item.BUNCH_OF_SHARUG_GREENS      ] = { category = food.FOOD,   hunger =  64, affection =   8, glow = glow.RED,    randomStat = { stats = { 1, 2 }, chance = odds.foodStat } },
    [xi.item.BUNCH_OF_GYSAHL_GREENS      ] = { category = food.FOOD,   hunger = 104, affection =   8, glow = glow.RED },
    [xi.item.BUNCH_OF_AZOUPH_GREENS      ] = { category = food.FOOD,   hunger = 128, affection =  24, glow = glow.RED,    randomStat = { stats = { 3, 4 }, chance = odds.foodStat } },
    [xi.item.CLUMP_OF_GAUSEBIT_WILDGRASS ] = { category = food.CURE,   hunger =  16, affection =   8, glow = glow.YELLOW, cures = { cond.INJURED } },
    [xi.item.CLUMP_OF_TOKOPEKKO_WILDGRASS] = { category = food.CURE,   hunger =  16, affection =   8, glow = glow.YELLOW, cures = illness },
    [xi.item.CLUMP_OF_GARIDAV_WILDGRASS  ] = { category = food.CURE,   hunger =  16, affection =   8, glow = glow.YELLOW, cures = { cond.STOMACHACHE } },
    [xi.item.VOMP_CARROT                 ] = { category = food.STAT,   hunger =  96, affection =   8, glow = glow.RED,    stats = {  1,  1, -1, -1 } },
    [xi.item.ZEGHAM_CARROT               ] = { category = food.STAT,   hunger =  96, affection =   8, glow = glow.BLUE,   stats = { -1, -1,  1,  1 } },
    [xi.item.SAN_DORIAN_CARROT           ] = { category = food.STAT,   hunger =  96, affection =   8, glow = glow.RED,    randomStat = { stats = { 1, 2, 3, 4 }, chance = odds.foodStat } },
    [xi.item.CUPID_WORM                  ] = { category = food.STAT,   hunger =  80, affection = 120, glow = glow.BLUE,   stats = { -1, -1,  0,  0 } },
    [xi.item.PARASITE_WORM               ] = { category = food.STAT,   hunger =  64, affection =   0, glow = glow.BLUE,   rerollGene = true, randomStat = { stats = { 1, 2, 3, 4 }, chance = 100, lowers = true } },
    [xi.item.GREGARIOUS_WORM             ] = { category = food.STAT,   hunger = 224, affection =   0, glow = glow.YELLOW, energy = 20, stats = { 0, 0, -1, -1 } },
    [xi.item.CHOCOLIXIR                  ] = { category = food.ELIXIR, hunger = 128, affection =   0, glow = glow.YELLOW, energy = 100 },
    [xi.item.HI_CHOCOLIXIR               ] = { category = food.ELIXIR, hunger =  96, affection =   0, glow = glow.YELLOW, energy = 100 },
    [xi.item.CELERITY_SALAD              ] = { category = food.CURE,   hunger =  96, affection =   0, glow = glow.GREEN,  cures = allBad },
    [xi.item.TORNADO_SALAD               ] = { category = food.CURE,   hunger =  64, affection =   0, glow = glow.GREEN,  cures = allBad },
    -- Only the tonic is used when traded with other items.
    [xi.item.CHOCOTONIC                  ] = { category = food.CURE,   hunger =  32, affection = -48, glow = glow.YELLOW, wakes = true, alone = true },
    [xi.item.VEGETABLE_PASTE             ] = { category = food.FOOD,   hunger =  16, affection =   0, glow = glow.RED,    chick = { hunger = 64, affection = 16 } },
    [xi.item.HERB_PASTE                  ] = { category = food.FOOD,   hunger =  32, affection = -48, glow = glow.RED,    chick = { hunger = 64, affection = 16, cures = { cond.STOMACHACHE, cond.SICK, cond.VERY_ILL, cond.INJURED } } },
    [xi.item.CARROT_PASTE                ] = { category = food.FOOD,   hunger =  64, affection =  24, glow = glow.RED,    chick = { hunger = 160, affection = 8 }, randomStat = { stats = { 1, 2, 3, 4 }, chance = 100, eitherWay = true } },
    [xi.item.WORM_PASTE                  ] = { category = food.FOOD,   hunger =  32, affection =   0, glow = glow.RED,    chick = { hunger = 128, affection = 24, randomStat = { stats = { 1, 2, 3, 4 }, chance = 100, lowers = true } } },
    [xi.item.LETHE_CONSOMME              ] = { category = food.STAT,   hunger =  64, affection =   8, glow = glow.GREEN,  forgetsAbility = true },
    [xi.item.LETHE_POTAGE                ] = { category = food.STAT,   hunger =  64, affection =   8, glow = glow.GREEN,  forgetsAbility = true },
}

-- Rest has a chance to cure these.
xi.chocoboRaising.badConditions = allBad

xi.chocoboRaising.walkItems =
{
    -- Short Walk: Sandoria
    [xi.zone.WEST_RONFAURE] =
    {
        xi.item.BEASTCOIN,
        xi.item.BRONZE_AXE,
        xi.item.RONFAURE_CHESTNUT,
        xi.item.FLINT_STONE,
        xi.item.CLUMP_OF_GARIDAV_WILDGRASS,
        xi.item.GOBLIN_MASK,
        xi.item.LITTLE_WORM,
        xi.item.PEBBLE,
        xi.item.SILVER_BEASTCOIN,
        xi.item.CLUMP_OF_TOKOPEKKO_WILDGRASS,
        xi.item.BAG_OF_WILDGRASS_SEEDS,
    },
    -- Short Walk: Bastok
    [xi.zone.NORTH_GUSTABERG] =
    {
        xi.item.BEASTCOIN,
        xi.item.FLINT_STONE,
        xi.item.CLUMP_OF_GARIDAV_WILDGRASS,
        xi.item.GOBLIN_MASK,
        xi.item.LITTLE_WORM,
        xi.item.EAR_OF_MILLIONCORN,
        xi.item.PEBBLE,
        xi.item.QUADAV_BACKPLATE,
        xi.item.SILVER_BEASTCOIN,
        xi.item.CLUMP_OF_TOKOPEKKO_WILDGRASS,
        xi.item.BAG_OF_WILDGRASS_SEEDS,
    },
    -- Short Walk: Windurst
    [xi.zone.EAST_SARUTABARUTA] =
    {
        xi.item.BEASTCOIN,
        xi.item.FLINT_STONE,
        xi.item.CLUMP_OF_GARIDAV_WILDGRASS,
        xi.item.GOBLIN_MASK,
        xi.item.GOBLIN_HELM,
        xi.item.LITTLE_WORM,
        xi.item.PEBBLE,
        xi.item.PIECE_OF_ROTTEN_MEAT,
        xi.item.SILVER_BEASTCOIN,
        xi.item.BOX_OF_TARUTARU_RICE,
        xi.item.CLUMP_OF_TOKOPEKKO_WILDGRASS,
        xi.item.BAG_OF_WILDGRASS_SEEDS,
        xi.item.YAGUDO_BEAD_NECKLACE,
    },
    -- Medium Walk: Sandoria
    [xi.zone.LA_THEINE_PLATEAU] =
    {
        xi.item.BEASTCOIN,
        xi.item.CRAB_SHELL,
        xi.item.CUPID_WORM,
        xi.item.CHUNK_OF_DARKSTEEL_ORE,
        xi.item.CLUMP_OF_GARIDAV_WILDGRASS,
        xi.item.GOBLIN_ARMOR,
        xi.item.LILAC,
        xi.item.PEBBLE,
        xi.item.SILVER_BEASTCOIN,
        xi.item.CLUMP_OF_TOKOPEKKO_WILDGRASS,
        xi.item.ZEGHAM_CARROT,
        xi.item.MYTHRIL_BEASTCOIN,
    },
    -- Medium Walk: Bastok
    [xi.zone.KONSCHTAT_HIGHLANDS] =
    {
        xi.item.BEASTCOIN,
        xi.item.CUPID_WORM,
        xi.item.CLUMP_OF_GARIDAV_WILDGRASS,
        xi.item.GOBLIN_ARMOR,
        xi.item.GOBLIN_HELM,
        xi.item.PEBBLE,
        xi.item.CHUNK_OF_DARKSTEEL_ORE,
        xi.item.CHUNK_OF_PLATINUM_ORE,
        xi.item.RAIN_LILY,
        xi.item.SHEEP_TOOTH,
        xi.item.SILVER_BEASTCOIN,
        xi.item.CLUMP_OF_TOKOPEKKO_WILDGRASS,
        xi.item.VOMP_CARROT,
        xi.item.ZEGHAM_CARROT,
    },
    -- Medium Walk: Windurst
    [xi.zone.TAHRONGI_CANYON] =
    {
        xi.item.AMARYLLIS,
        xi.item.BEASTCOIN,
        xi.item.CHICKEN_BONE,
        xi.item.CUPID_WORM,
        xi.item.CHUNK_OF_DARKSTEEL_ORE,
        xi.item.CLUMP_OF_GARIDAV_WILDGRASS,
        xi.item.GOBLIN_ARMOR,
        xi.item.PEBBLE,
        xi.item.CHUNK_OF_PLATINUM_ORE,
        xi.item.SILVER_BEASTCOIN,
        xi.item.VOMP_CARROT,
        xi.item.ZEGHAM_CARROT,
        xi.item.BAG_OF_TREE_CUTTINGS,
    },
    -- Long Walk: Sandoria
    [xi.zone.JUGNER_FOREST] =
    {
        xi.item.CHUNK_OF_ADAMAN_ORE,
        xi.item.GOBLIN_HELM,
        xi.item.GOLD_BEASTCOIN,
        xi.item.GREGARIOUS_WORM,
        xi.item.MYTHRIL_BEASTCOIN,
        xi.item.OLIVE_FLOWER,
        xi.item.CHUNK_OF_ORICHALCUM_ORE,
        xi.item.PEBBLE,
        xi.item.PIECE_OF_ROTTEN_MEAT,
        xi.item.SILVER_BEASTCOIN,
        xi.item.BAG_OF_TREE_CUTTINGS,
        xi.item.BAG_OF_WILDGRASS_SEEDS,
    },
    -- Long Walk: Bastok
    [xi.zone.PASHHOW_MARSHLANDS] =
    {
        xi.item.CHUNK_OF_ADAMAN_ORE,
        xi.item.CATTLEYA,
        xi.item.GOBLIN_HELM,
        xi.item.GREGARIOUS_WORM,
        xi.item.MYTHRIL_BEASTCOIN,
        xi.item.CHUNK_OF_ORICHALCUM_ORE,
        xi.item.PEBBLE,
        xi.item.PIECE_OF_ROTTEN_MEAT,
        xi.item.SILVER_BEASTCOIN,
        xi.item.BAG_OF_TREE_CUTTINGS,
    },
    -- Long Walk: Windurst
    [xi.zone.MERIPHATAUD_MOUNTAINS] =
    {
        xi.item.CHUNK_OF_ADAMAN_ORE,
        xi.item.CASABLANCA,
        xi.item.GOBLIN_HELM,
        xi.item.GOLD_BEASTCOIN,
        xi.item.GREGARIOUS_WORM,
        xi.item.MYTHRIL_BEASTCOIN,
        xi.item.PEBBLE,
        xi.item.PIECE_OF_ROTTEN_MEAT,
        xi.item.SILVER_BEASTCOIN,
        xi.item.BAG_OF_TREE_CUTTINGS,
        xi.item.CHUNK_OF_ORICHALCUM_ORE,
    },
}

-----------------------------------
-- Specs
-----------------------------------
---@class ChocoboCarePlanData
---@field stats        integer[]
---@field affection    integer
---@field energy       integer
---@field poorEnergy   integer
---@field difficulty   integer
---@field successStats string[]
---@field pay          integer[]?

---@class ChocoboFood
---@field category       xi.chocoboRaising.foodCategory
---@field hunger         integer
---@field affection      integer
---@field glow           xi.chocoboRaising.glow
---@field stats          integer[]?
---@field randomStat     { stats: integer[], chance: integer, eitherWay: boolean?, lowers: boolean? }?
---@field cures          xi.chocoboRaising.conditions[]?
---@field chick          { hunger: integer, affection: integer, cures: xi.chocoboRaising.conditions[]?, randomStat: table? }?
---@field energy         integer?
---@field rerollGene     boolean?
---@field wakes          boolean?
---@field alone          boolean?
---@field forgetsAbility boolean?

---@alias ChocoboEffect { [1]: xi.chocoboRaising.effect, [2]: any, [3]: any }

-----------------------------------
-- Global Functions
-----------------------------------
---@param player CBaseEntity
---@param cutscene xi.chocoboRaising.cutscenes
---@return integer
xi.chocoboRaising.getCutsceneWithOffset = function(player, cutscene)
    local cutsceneOffsets =
    {
        [xi.zone.SOUTHERN_SAN_DORIA] = 256,
        [xi.zone.BASTOK_MINES      ] = 512,
        [xi.zone.WINDURST_WOODS    ] = 768,
    }

    return cutscene + cutsceneOffsets[player:getZoneID()]
end

---@param skill integer
---@return xi.chocoboRaising.skillRanks
xi.chocoboRaising.numberToRank = function(skill)
    return math.min(math.floor(skill / 32), xi.chocoboRaising.skillRanks.SS_FIRST_CLASS)
end

---@param affection integer
---@return xi.chocoboRaising.affectionRank
xi.chocoboRaising.affectionToAffectionRank = function(affection)
    return math.min(math.floor(affection / 32), xi.chocoboRaising.affectionRank.PARENT)
end

-- Approximate: energy 62 shows rank 5, where this gives 4.
---@param energy integer
---@return integer
xi.chocoboRaising.energyToRank = function(energy)
    return math.min(math.floor(energy * 2 / 25), 7)
end

---@param chocoState table
---@return boolean
xi.chocoboRaising.hasCondition = function(chocoState)
    return bit.band(chocoState.conditions, xi.chocoboRaising.conditionMask) > 0
end

---@param chocoState table
---@param condition xi.chocoboRaising.conditions
---@return boolean
xi.chocoboRaising.getCondition = function(chocoState, condition)
    return utils.mask.getBit(chocoState.conditions, condition)
end

---@param chocoState table
---@param condition xi.chocoboRaising.conditions
---@param value boolean
---@return nil
xi.chocoboRaising.setCondition = function(chocoState, condition, value)
    chocoState.conditions = utils.mask.setBit(chocoState.conditions, condition, value)
end

-- Cures a held condition at the next rollover.
---@param chocoState table
---@param condition xi.chocoboRaising.conditions
---@return nil
xi.chocoboRaising.addPendingCure = function(chocoState, condition)
    if not xi.chocoboRaising.getCondition(chocoState, condition) then
        return
    end

    chocoState.conditions = bit.bor(
        chocoState.conditions,
        bit.lshift(1, xi.chocoboRaising.pendingCureShift + condition),
        bit.lshift(1, xi.chocoboRaising.pendingCureFlag)
    )
end

-- High rolls succeed, so the lowest roll never does.
---@param percent integer
---@return boolean
xi.chocoboRaising.rolls = function(percent)
    return math.randomInt(1, 100) > 100 - percent
end

-- A new chocobo is named Chocobo Chocobo until the player or the trainer names it.
---@param chocoState table
---@return boolean
xi.chocoboRaising.isNamed = function(chocoState)
    return chocoState.first_name ~= 'Chocobo' or chocoState.last_name ~= 'Chocobo'
end

-- Full, first and last name, as the client expects them.
---@param chocoState table
---@return string
---@return string
---@return string
xi.chocoboRaising.nameStrings = function(chocoState)
    if not xi.chocoboRaising.isNamed(chocoState) then
        return 'Chocobo', 'Chocobo', ''
    end

    return string.format('%s%s', chocoState.first_name, chocoState.last_name), chocoState.first_name, chocoState.last_name
end

---@param chocoState table
---@return integer
xi.chocoboRaising.packStats1 = function(chocoState)
    return bit.lshift(xi.chocoboRaising.numberToRank(chocoState.strength),  0) +
        bit.lshift(xi.chocoboRaising.numberToRank(chocoState.endurance),    8) +
        bit.lshift(xi.chocoboRaising.numberToRank(chocoState.discernment), 16) +
        bit.lshift(xi.chocoboRaising.numberToRank(chocoState.receptivity), 24)
end

-- Raw values: the trainer's debug print shows them unranked.
---@param chocoState table
---@return integer
xi.chocoboRaising.packStats2 = function(chocoState)
    return bit.lshift(chocoState.affection,  0) +
        bit.lshift(chocoState.energy,        8) +
        bit.lshift(chocoState.satisfaction, 16)
end

---@param zoneId xi.zone
---@return xi.weather
xi.chocoboRaising.getWeatherInZone = function(zoneId)
    local zone = GetZone(zoneId)

    if not zone then
        print('ChocoboRaising: no zone object for the weather. Is the zone on another process?')
        return xi.weather.NONE
    end

    return zone:getWeather()
end

-- Rows { stage, last day, growth cutscene, next stage }. Built on each call so a changed setting takes effect.
---@return table[]
xi.chocoboRaising.ageBoundaries = function()
    local stage     = xi.chocoboRaising.stage
    local cutscenes = xi.chocoboRaising.cutscenes

    local rows =
    {
        { stage.EGG,        xi.chocoboRaising.daysToChick,      cutscenes.EGG_HATCHING,          stage.CHICK      },
        { stage.CHICK,      xi.chocoboRaising.daysToAdolescent, cutscenes.CHICK_TO_ADOLESCENT,   stage.ADOLESCENT },
        { stage.ADOLESCENT, xi.chocoboRaising.daysToAdult1,     cutscenes.ADOLESCENT_TO_ADULT_1, stage.ADULT_1    },
        { stage.ADULT_1,    xi.chocoboRaising.daysToAdult2,     cutscenes.ADULT_1_TO_ADULT_2,    stage.ADULT_2    },
        { stage.ADULT_2,    xi.chocoboRaising.daysToAdult3,     cutscenes.ADULT_2_TO_ADULT_3,    stage.ADULT_3    },
    }

    if not xi.chocoboRaising.disableRetirement then
        table.insert(rows, { stage.ADULT_3, xi.chocoboRaising.daysToAdult4, cutscenes.ADULT_3_TO_ADULT_4, stage.ADULT_4 })
    end

    return rows
end

-- The report header carries days in 10 bits, so an ageing chocobo stops there.
---@return integer
xi.chocoboRaising.lastDay = function()
    if xi.chocoboRaising.disableRetirement then
        return 1023
    end

    return xi.chocoboRaising.daysToAdult4
end

---@param age integer
---@return xi.chocoboRaising.stage
xi.chocoboRaising.ageToStage = function(age)
    local rows = xi.chocoboRaising.ageBoundaries()
    for _, entry in ipairs(rows) do
        if age <= entry[2] then
            return entry[1]
        end
    end

    return rows[#rows][4]
end
