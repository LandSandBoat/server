-----------------------------------
-- Chocobo Raising - Constants & Lookups
-----------------------------------
xi = xi or {}
xi.chocoboRaising = xi.chocoboRaising or {}

-- TODO: Remove the duplication for walk CSs
xi.chocoboRaising.csidTable =
{
    -- { intro csid, main csid, trading csid, rejection csid, chicks owner csid, short walk csid, medium walk csid, long walk csid, watch csid, debug }
    [xi.zone.SOUTHERN_SAN_DORIA] = { 817, 823, 826, 831, 852, 298, 299, 300, 304, 862 }, -- Hantileon
    [xi.zone.BASTOK_MINES]       = { 508, 509, 512, 515, 542, 554, 555, 556, 560, 558 }, -- Zopago
    [xi.zone.WINDURST_WOODS]     = { 741, 742, 745, 748, 766, 810, 811, 812, 816, 773 }, -- Pulonono
}

xi.chocoboRaising.raisingLocation =
{
    [xi.zone.SOUTHERN_SAN_DORIA] = 1,
    [xi.zone.BASTOK_MINES]       = 2,
    [xi.zone.WINDURST_WOODS]     = 3,
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

xi.chocoboRaising.stage =
{
    EGG        = 1,
    CHICK      = 2,
    ADOLESCENT = 3,
    ADULT_1    = 4,
    ADULT_2    = 5,
    ADULT_3    = 6,
    ADULT_4    = 7, -- Retired, will trigger immediate retirement
}

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

-- TODO: Combine carePlanData with this cutscenes table, so cutscenes have associated
--     : stat changes that can be looked up and applied.
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

    -- AGEING:
    EGG_HATCHING          = 33,
    CHICK_TO_ADOLESCENT   = 34,
    ADOLESCENT_TO_ADULT_1 = 35, -- (Chocobo Whistle start/reminder?) Your chocobo has finally grown large enough to ride?
    ADULT_1_TO_ADULT_2    = 36,
    ADULT_2_TO_ADULT_3    = 37,
    ADULT_3_TO_ADULT_4    = 38,

    -- OTHER:
    RAN_AWAY_1               = 39, -- I couldn't take care of Chocobo because it ran away...
    BLANK_1                  = 40, -- TODO: [Returns to menu?]
    GIVES_ITEM               = 41, -- (Player) gives the chocobo (x).
    HAPPY_TO_SEE_YOU         = 48, -- Chocobo looks happy to see you.
    BLANK_2                  = 49, -- TODO: [Returns to menu?]
    INTERESTED_IN_YOUR_STORY = 50, -- (Story menu) Chocobo seems interested in your story.
    HANGS_HEAD_IN_SHAME      = 51, -- Chocobo hangs its head in shame.
    COMPETE_WITH_OTHERS      = 52, -- (Local chocobo race)
    HAVENT_SEEN_YOU          = 53, -- (White handkerchief cancel) I haven't seen you around lately, so I gave the chick something myself to help it sleep better.
    THAT_SHOULD_BE_ENOUGH    = 54, -- That should be enough! Hand over the {White Handkerchief} now. (white handkerchief end)
    CHOCOBO_WHISTLE_START    = 55, -- (Chocobo Whistle start/reminder?) Your chocobo has finally grown large enough to ride?
    BLANK_3                  = 56, -- TODO: [Returns to menu?]
    BLANK_4                  = 57, -- TODO: [Returns to menu?]
    IS_INJURED               = 58, -- Chocobo is injured, but I am sure it would heal quickly if we had a {clump of Gausebit wildgrass}.
    UNDER_THE_WEATHER        = 59, -- Chocobo seems to be a bit under the weather. A {clump of Tokopekko wildgrass} should fix it right up, though.
    HAS_STOMACHACHE          = 60, -- Chocobo seems to have a stomachache. Are you giving it a proper diet?
    SEEMS_LONELY             = 61, -- Chocobo seems lonely. You should venture out together sometime.
    PRETTY_PERKY             = 62, -- Chocobo seems pretty perky lately! It should be responsive to anything you give it now.
    SLEEPING_SOUNDLY         = 63, -- Chocobo is sleeping soundly right now, so you should not disturb it.
    IS_VERY_ILL              = 64, -- Chocobo is very ill. We need a {clump of Tokopekko wildgrass} to help it.
    REALLY_BORED             = 65, -- Chocobo seems bored and restless! You should have it compete against other chocobos sometime.
    BEHAVING_SPOILED         = 66, -- Chocobo has been behaving quite spoiled as of late.
    RUN_AWAY_2               = 67, -- I am terribly sorry, but Chocobo has run away. Someone was supposed to be taking care of it... I think it just wanted attention, though... It should come back if we wait a while.
    BLANK_5                  = 68, -- TODO: [Soft locks the CS?]
    CRYING_AT_NIGHT          = 69, -- (White handkerchief start) Lately, Chocobo has been crying loud enough at night to wake the dead!
    FULL_OF_ENERGY           = 70, -- Chocobo is so full of energy today! Now's your chance to get in some rigorous physical training!
    BRIGHT_AND_FOCUSED       = 71, -- Chocobo seems unusually bright and focused today! Now's your chance to get in some rigorous mental training!
    INJURY_HAS_HEALED_TRADE  = 72, -- TODO: (can't trigger from Scold menu, only through trades?) Injury has healed
    INJURY_HAS_HEALED        = 73, -- Chocobo's injury has completely healed
    ILLNESS_HAS_HEALED       = 74, -- Chocobo's illness has completely healed.
    STRONGER_STOMACH         = 75, -- Chocobo seems to have a stronger stomach these days.
    NO_LONGER_LONERY         = 76, -- Chocobo no longer seems lonely.
    CALMED_DOWN              = 77, -- Chocobo seems to have had its fill and has calmed down.
    WAKING_UP_EVERY_MORNING  = 78, -- Chocobo has been waking up every morning as of late.
    FEVER_GONE_DOWN          = 79, -- Chocobo's fever has gone down.
    SEEMS_HAPPIER            = 80, -- Chocobo seems to have more zest for life nowadays!
    MORE_RESPONSIVE          = 81, -- Chocobo has become more responsive to commands lately.
    CHOCOBO_IS_BACK          = 82, -- Chocobo is back, and I am pleased to say it seems to be fine.
    WAS_IN_LOVE              = 83, -- It seems that Chocobo was in love, but it is feeling better now and its appetite has returned.
    WHITE_HANDKERCHIEF_END   = 84, -- (White handkerchief end) Thanks to the {white handerchief}, Chocobo has been sleeping soundly at night.
    BURNED_PHYSICAL_ENERGY   = 85, -- Chocobo has burned through that excess energy and calmed down a little.
    BURNED_MENTAL_ENERGY     = 86, -- Chocobo has burned through that excess mental energy and calmed down a little.
}

xi.chocoboRaising.getCutsceneWithOffset = function(player, cutscene)
    -- Each cutscene needs this offset added to them before they can be used,
    -- depending on the zone
    local cutsceneOffsets =
    {
        [xi.zone.SOUTHERN_SAN_DORIA] = 256,
        [xi.zone.BASTOK_MINES]       = 512,
        [xi.zone.WINDURST_WOODS]     = 768,
    }

    return cutscene + cutsceneOffsets[player:getZoneID()]
end

-- These act as multipliers for adding per-rank bonuses to things.
-- F gives base + (0 * bonus)
-- SS gives base + (7 * bonus)
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

xi.chocoboRaising.skillRankBoundaries =
{
    F_POOR                = 31,
    E_SUBSTANDARD         = 63,
    D_A_BIT_DEFICIENT     = 95,
    C_AVERAGE             = 127,
    B_BETTER_THAN_AVERAGE = 159,
    A_IMPRESSIVE          = 191,
    S_OUTSTANDING         = 223,
    SS_FIRST_CLASS        = 255,
}

xi.chocoboRaising.numberToRank = function(skill)
    local rank = xi.chocoboRaising.skillRanks.F_POOR

    for idx, boundary in ipairs(xi.chocoboRaising.skillRankBoundaries) do
        if skill >= boundary and xi.chocoboRaising.skillRanks[idx] > rank then
            rank = xi.chocoboRaising.skillRanks[idx]
        end
    end

    return rank
end

xi.chocoboRaising.affectionToAffectionRank = function(affection)
    local rank = xi.chocoboRaising.affectionRank.DOESNT_CARE

    for idx, boundary in ipairs(xi.chocoboRaising.skillRankBoundaries) do
        if affection >= boundary and xi.chocoboRaising.skillRanks[idx] > rank then
            rank = xi.chocoboRaising.affectionRank[idx]
        end
    end

    return rank
end

xi.chocoboRaising.getPlayerRidingSpeedAndTime = function(player)
    local baseSpeed = xi.chocoboRaising.ridingSpeedBase
    local baseTime  = xi.chocoboRaising.ridingTimeBase

    -- TODO: This should be looking up your registered chocobo, not your
    --     : current raising chocobo.
    local chocoState = player:getChocoboRaisingInfo()

    if chocoState == nil then
        -- TODO: Log
        return baseSpeed, baseTime
    end

    local strRank  = xi.chocoboRaising.numberToRank(chocoState.strength)
    local endRank  = xi.chocoboRaising.numberToRank(chocoState.endurance)
    local outSpeed = utils.clamp(baseSpeed + (strRank * xi.chocoboRaising.ridingSpeedPerRank), 0, xi.chocoboRaising.ridingSpeedCap)
    local outTime  = utils.clamp(baseTime + (endRank * xi.chocoboRaising.ridingTimePerRank), 0, xi.chocoboRaising.ridingTimeCap)

    return outSpeed, outTime
end

-- NOTE: These are animation effects, so you can use warp etc.
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

xi.chocoboRaising.conditions =
{
    -- Negative
    ILL      = 0,
    VERY_ILL = 1,
    SICK     = 2,
    INJURED  = 3,
    SPOILED  = 4,
    BORED    = 5,
    LOVESICK = 6,
    RUN_AWAY = 7,

    -- Positive
    HIGH_SPIRITS       = 8,
    PERKY              = 9,
    EXTREMELY_HAPPY    = 10,
    FULL_OF_ENERGY_1   = 11,
    FULL_OF_ENERGY_2   = 12,
    BRIGHT_AND_FOCUSED = 13,
}

xi.chocoboRaising.hasCondition = function(chocoState)
    return chocoState.conditions > 0
end

xi.chocoboRaising.getCondition = function(chocoState, condition)
    return utils.mask.getBit(chocoState.conditions, condition)
end

xi.chocoboRaising.setCondition = function(chocoState, condition, value)
    chocoState.conditions = utils.mask.setBit(chocoState.conditions, condition, value)
end

xi.chocoboRaising.conditionsHealedByItems =
{
    [xi.chocoboRaising.conditions.ILL] =
    {
        xi.item.CLUMP_OF_TOKOPEKKO_WILDGRASS,
        xi.item.CELERITY_SALAD,
    },
    [xi.chocoboRaising.conditions.VERY_ILL] =
    {
        xi.item.CLUMP_OF_TOKOPEKKO_WILDGRASS,
        xi.item.CELERITY_SALAD,
    },
    [xi.chocoboRaising.conditions.SICK] =
    {
        xi.item.CLUMP_OF_GARIDAV_WILDGRASS,
        xi.item.CELERITY_SALAD,
    },
    [xi.chocoboRaising.conditions.INJURED] =
    {
        xi.item.CLUMP_OF_GAUSEBIT_WILDGRASS,
        xi.item.CELERITY_SALAD,
    },
    [xi.chocoboRaising.conditions.SPOILED] =
    {
        xi.item.CELERITY_SALAD,
    },
    [xi.chocoboRaising.conditions.BORED] =
    {
        xi.item.CELERITY_SALAD,
    },
    [xi.chocoboRaising.conditions.LOVESICK] =
    {
        xi.item.CELERITY_SALAD,
    },
}
utils.unused(xi.chocoboRaising.conditionsHealedByItems)

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

-- http://www.playonline.com/pcd/update/ff11us/20060822VOL2B1/table03en.jpg
-- minor: 1, moderate: 5, major: 10
-- strength, endurance, discernment, receptivity, affection, energy, payment
xi.chocoboRaising.carePlanData =
{
    [xi.chocoboRaising.carePlans.BASIC_CARE              ] = {  1,  1,  1,  1,  -1,  -1, nil },
    [xi.chocoboRaising.carePlans.RESTING                 ] = {  0,  0,  0,  0,   0,   1, nil },
    [xi.chocoboRaising.carePlans.TAKING_A_WALK           ] = {  1,  1, -1, -1,  -1,  -1, nil },
    [xi.chocoboRaising.carePlans.LISTENING_TO_MUSIC      ] = { -1, -1,  1,  1,  -1,  -1, nil },
    [xi.chocoboRaising.carePlans.EXERCISING_ALONE        ] = {  1,  0, -1, -1,  -1,  -1, nil },
    [xi.chocoboRaising.carePlans.EXCERCISING_IN_A_GROUP  ] = {  0,  1, -1, -1,  -1,  -1, nil },
    [xi.chocoboRaising.carePlans.PLAYING_WITH_CHILDREN   ] = { -1, -1,  1,  0,  -1,  -1, nil },
    [xi.chocoboRaising.carePlans.PLAYING_WITH_CHOCOBOS   ] = { -1, -1,  0,  1,  -1,  -1, nil },
    [xi.chocoboRaising.carePlans.CARRYING_PACKAGES       ] = {  5,  5, -5, -5, -10,  -5, 100 },
    [xi.chocoboRaising.carePlans.EXHIBITING_TO_THE_PUBLIC] = { -5, -5,  5,  5, -10,  -5, 100 },
    [xi.chocoboRaising.carePlans.DELIVERING_MESSAGES     ] = { 10,  0,  0, -5, -10, -10, 100 },
    [xi.chocoboRaising.carePlans.DIGGING_FOR_TREASURE    ] = {  0, -5, 10,  0, -10, -10, 100 },
    [xi.chocoboRaising.carePlans.ACTING_IN_A_PLAY        ] = { -5,  0,  0, 10, -10, -10, 100 },
}

xi.chocoboRaising.validFoods =
{
--  [itemId]                                = { hunger, affection, energy, strength, endurance, discernment, receptivity, randomAttribute, glow }
    [xi.item.BUNCH_OF_GYSAHL_GREENS]       = { 25, 10,   0, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.RED    },
    [xi.item.BUNCH_OF_SHARUG_GREENS]       = { 25, 10,   0, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.RED    },
    [xi.item.BUNCH_OF_AZOUPH_GREENS]       = { 25, 10,   0, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.RED    },
    [xi.item.CARROT_PASTE]                 = { 25, 10,   0, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.RED    },
    [xi.item.HERB_PASTE]                   = { 25, 10,   0, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.RED    },
    [xi.item.VEGETABLE_PASTE]              = { 25, 10,   0, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.RED    },
    [xi.item.WORM_PASTE]                   = { 25, 10,   0, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.RED    },
    [xi.item.VOMP_CARROT]                  = { 25, 10,   0, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.RED    },
    [xi.item.SAN_DORIAN_CARROT]            = { 25, 10,   0, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.RED    },
    [xi.item.ZEGHAM_CARROT]                = { 25, 10,   0, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.BLUE   },
    [xi.item.CLUMP_OF_GAUSEBIT_WILDGRASS]  = { 25, 10,   0, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.YELLOW },
    [xi.item.CLUMP_OF_GARIDAV_WILDGRASS]   = { 25, 10,   0, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.YELLOW },
    [xi.item.CLUMP_OF_TOKOPEKKO_WILDGRASS] = { 25, 10,   0, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.YELLOW },
    [xi.item.CHOCOLIXIR]                   = { 50,  0, 100, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.YELLOW },
    [xi.item.HI_CHOCOLIXIR]                = { 25,  0, 100, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.YELLOW },
    [xi.item.CHOCOTONIC]                   = { 25, 10,   0, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.YELLOW },
    [xi.item.CUPID_WORM]                   = { 25, 10,   0, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.BLUE   },
    [xi.item.GREGARIOUS_WORM]              = { 25, 10,   0, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.YELLOW },
    [xi.item.PARASITE_WORM]                = { 25, 10,   0, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.BLUE   },
    [xi.item.TORNADO_SALAD]                = { 25, 10,   0, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.GREEN  },
    [xi.item.CELERITY_SALAD]               = { 25, 10,   0, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.GREEN  },
    [xi.item.LETHE_POTAGE]                 = { 25, 10,   0, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.GREEN  },
    [xi.item.LETHE_CONSOMME]               = { 25, 10,   0, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.GREEN  },
    [xi.item.LA_THEINE_MILLET]             = { 25, 10,   0, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.GREEN  },
--  [xi.item.SCROLL_OF_INSTANT_WARP]       = { 0, 0, 0, 0, 0, 0, 0, 0, xi.chocoboRaising.glow.WARP },
}

-- Items that can be found on a walk in a certain area
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

xi.chocoboRaising.packStats1 = function(chocoState)
    return bit.lshift(xi.chocoboRaising.numberToRank(chocoState.strength),  0) +
        bit.lshift(xi.chocoboRaising.numberToRank(chocoState.endurance),    8) +
        bit.lshift(xi.chocoboRaising.numberToRank(chocoState.discernment), 16) +
        bit.lshift(xi.chocoboRaising.numberToRank(chocoState.receptivity), 24)
end

xi.chocoboRaising.packStats2 = function(chocoState)
    -- TODO: Do these need to be packed into ranks too?
    return bit.lshift(chocoState.affection,  0) +
        bit.lshift(chocoState.energy,        8) +
        bit.lshift(chocoState.satisfaction, 16)
end

xi.chocoboRaising.getWeatherInZone = function(zoneId)
    local zone = GetZone(zoneId)

    if not zone then
        print('ChocoboRaising: Failed to get Zone object for weather information. \
            Is the target zone on another executable?')
        return xi.weather.NONE
    end

    return zone:getWeather()
end

-- If stage = [1] and age >= [2], play CS: [3] and set stage to [4].
xi.chocoboRaising.ageBoundaries =
{
    { xi.chocoboRaising.stage.EGG,        xi.chocoboRaising.daysToChick,      xi.chocoboRaising.cutscenes.EGG_HATCHING,          xi.chocoboRaising.stage.CHICK },
    { xi.chocoboRaising.stage.CHICK,      xi.chocoboRaising.daysToAdolescent, xi.chocoboRaising.cutscenes.CHICK_TO_ADOLESCENT,   xi.chocoboRaising.stage.ADOLESCENT },
    { xi.chocoboRaising.stage.ADOLESCENT, xi.chocoboRaising.daysToAdult1,     xi.chocoboRaising.cutscenes.ADOLESCENT_TO_ADULT_1, xi.chocoboRaising.stage.ADULT_1 },
    { xi.chocoboRaising.stage.ADULT_1,    xi.chocoboRaising.daysToAdult2,     xi.chocoboRaising.cutscenes.ADULT_1_TO_ADULT_2,    xi.chocoboRaising.stage.ADULT_2 },
    { xi.chocoboRaising.stage.ADULT_2,    xi.chocoboRaising.daysToAdult3,     xi.chocoboRaising.cutscenes.ADULT_2_TO_ADULT_3,    xi.chocoboRaising.stage.ADULT_3 },
    { xi.chocoboRaising.stage.ADULT_3,    xi.chocoboRaising.daysToAdult4,     xi.chocoboRaising.cutscenes.ADULT_3_TO_ADULT_4,    xi.chocoboRaising.stage.ADULT_4 },
}

xi.chocoboRaising.ageToStage = function(age)
    for _, entry in ipairs(xi.chocoboRaising.ageBoundaries) do
        if age <= entry[2] then
            return entry[1]
        end
    end

    return xi.chocoboRaising.stage.ADULT_4
end
